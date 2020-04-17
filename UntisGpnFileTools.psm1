$UntisGpnFile = ''
$UntisGpnFileContent = ''

function Get-UntisGpnFile {
    if($script:UntisGpnFile -eq '') {
        throw "No Gpn file selected! Please use Open-UntisGpnFile first!"
    }
    return $script:UntisGpnFile
}

function Get-UntisGpnFileContent {
    if($script:UntisGpnFile -eq '') {
        throw "No Gpn file selected! Please use Open-UntisGpnFile first!"
    }
    return $script:UntisGpnFileContent
}

function Close-UntisGpnFile {
    $script:UntisGpnFile = ''
    $script:UntisGpnFileContent = ''
    Write-Output "[$script:UntisGpnFile] unloaded..."
}

function Open-UntisGpnFile {
    Param(
        [Parameter(Mandatory=$true)]
        [System.IO.FileInfo]
        $Path
    )

    $script:UntisGpnFile = $Path

    # Powershell (>= 6.0) ondersteunt GetEncoding(1252)
    $iswinps = ($null, 'Desktop') -contains $PSVersionTable.PSEdition
    if (!$iswinps) {
        $encoding = [System.Text.Encoding]::GetEncoding(1252)
    }
    else {
        $encoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Default
    }

    $script:UntisGpnFileContent = Get-Content $script:UntisGpnFile -Encoding $encoding
    Write-Output "[$script:UntisGpnFile] loaded..."
}

# Alle onderstaande functies maken GEEN gebruik van (globale/script) variabelen

function Get-UntisPeriodes {
    $re = '^0P\s+,"?(?<afkorting>[^,"]*)"?,(?<volledig>[^,"]*)"?,"?(?<van>[^,"]*)"?,"?(?<tem>[^,"]*)"?,"?(?<moederperiode>[^,"]*)"?,"?(?<vlaggen>[^,"]*),.+$'
    $all = @()
    
    Get-UntisGpnFileContent | ForEach-Object { 
        if($_ -match $re) { 
            $Matches.Remove(0)
            $o = New-Object -TypeName PSObject -Property $Matches
            $o.van = ConvertFrom-UntisDate($o.van)
            $o.tem = ConvertFrom-UntisDate($o.tem)
            if($Matches.vlaggen.Contains('A')) {
                $o | Add-Member -MemberType NoteProperty -Name isActief -Value $true
            } else {
                $o | Add-Member -MemberType NoteProperty -Name isActief -Value $false
            }
            $all += $o
        }
    }
    return $all
}

function Get-UntisKlassen {
    $re_klassen = '^00K\s+,"?(?<afkorting>[^,"]*)"?,"?(?<volledig>[^,"]*)"?,+.*$'
    $klassen = @()
    Get-UntisGpnFileContent | ForEach-Object { 
        if($_ -match $re_klassen) { 
            $Matches.Remove(0)
            $o = New-Object -TypeName PSObject -Property $Matches
            $klassen += $o
        }
    }
    return $klassen
}

function Get-UntisDocenten {
    $content = Get-UntisGpnFileContent
    $re = '^00L\s+,"?(?<afkorting>[^,"]*)"?,"?(?<volledig>[^,"]*)"?,+.*$'
    $all = @()
    $content | ForEach-Object { 
        if($_ -match $re) { 
            $Matches.Remove(0)
            $o = New-Object -TypeName PSObject -Property $Matches
            $all += $o
        }
    }
    return $all
}

function Get-UntisActiviteiten {
    $re = '(?sm)^(^0W.*?$)\n?(^Wk.*?$)?\n?(^Wl.*?$)?\n?(^Wa.*?$)?'

    $all = @()
    
    $result = (Get-Content -Raw (Get-UntisGpnFile)) | Select-String -pattern $re -AllMatches
    foreach($m in $result.Matches) {
        $o = New-Object -TypeName PSObject
        $m.Groups | Select -Skip 1 | ForEach-Object {
            if($_ -match '^0W') {
                $cols = $_ -split ','
                $o | Add-Member -MemberType NoteProperty -Name nummer -Value $cols[1]
                $o | Add-Member -MemberType NoteProperty -Name startdatum -Value (ConvertFrom-UntisDate($cols[4]))
                $o | Add-Member -MemberType NoteProperty -Name einddatum -Value (ConvertFrom-UntisDate($cols[5]))
                $o | Add-Member -MemberType NoteProperty -Name reden -Value $cols[6].Trim('"')
                $o | Add-Member -MemberType NoteProperty -Name tekst -Value $cols[7].Trim('"')
                $o | Add-Member -MemberType NoteProperty -Name startuur -Value $cols[8]
                $o | Add-Member -MemberType NoteProperty -Name einduur -Value $cols[9]
                $o | Add-Member -MemberType NoteProperty -Name onderwerp -Value $cols[10].Trim('"')
            } elseif($_ -match '^Wk ') {
                $klassen = @()
                $cols = $_ -split ','
                $cols | Select -Skip 2 | % {
                    $klassen += $_.Trim()
                }
                $o | Add-Member -MemberType NoteProperty -Name klassen -Value $klassen
            } elseif($_ -match '^Wl ') {
                $leerkrachten = @()
                $cols = $_ -split ','
                $cols | Select -Skip 2 | % {
                    $leerkrachten += $_.Trim()
                }
                $o | Add-Member -MemberType NoteProperty -Name leerkrachten -Value $leerkrachten
            } elseif($_ -match '^Wa ') {
                $absent_ids = @()
                $cols = $_ -split ','
                $cols | Select -Skip 2 | % {
                    $absent_ids += $_
                }
                $o | Add-Member -MemberType NoteProperty -Name absent_ids -Value $absent_ids
            }
        }
        $all += $o
    }
    return $all
}

# helper functions

function ConvertFrom-UntisDate {
    param($d)
    return [datetime]::parseexact($d, 'yyyyMMdd', $null)
}

Export-ModuleMember -Function Get-UntisGpnFile
Export-ModuleMember -Function Get-UntisGpnFileContent
Export-ModuleMember -Function Close-UntisGpnFile
Export-ModuleMember -Function Open-UntisGpnFile
Export-ModuleMember -Function Get-UntisPeriodes
Export-ModuleMember -Function Get-UntisKlassen
Export-ModuleMember -Function Get-UntisDocenten
Export-ModuleMember -Function Get-UntisActiviteiten

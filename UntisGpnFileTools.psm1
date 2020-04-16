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
    Write-Output "[($script:UntisGpnFile).Name] unloaded..."
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
    Write-Output "[($script:UntisGpnFile).Name] loaded..."
}

# Alle onderstaande functies maken GEEN gebruik van (globale/script) variabelen

function Get-UntisPeriodes {
    $re = '^0P\s+,"?(?<afkorting>[^,"]*)"?,(?<volledig>[^,"]*)"?,"?(?<van>[^,"]*)"?,"?(?<tem>[^,"]*)"?,"?(?<moederperiode>[^,"]*)"?,"?(?<vlaggen>[^,"]*),.+$'
    $all = @()
    
    Get-UntisGpnFileContent | ForEach-Object { 
        if($_ -match $re) { 
            $Matches.Remove(0)
            $o = New-Object -TypeName PSObject -Property $Matches
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

Export-ModuleMember -Function Get-UntisGpnFile
Export-ModuleMember -Function Get-UntisGpnFileContent
Export-ModuleMember -Function Close-UntisGpnFile
Export-ModuleMember -Function Open-UntisGpnFile
Export-ModuleMember -Function Get-UntisPeriodes
Export-ModuleMember -Function Get-UntisKlassen
Export-ModuleMember -Function Get-UntisDocenten

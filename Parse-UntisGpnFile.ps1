Param(
    [Parameter(Mandatory=$true)]
    [System.IO.FileInfo]
    $Path = "./demo-files/be_gy1_Hantal.GPN"
)

# Powershell (>= 6.0) ondersteunt GetEncoding(1252)
$iswinps = ($null, 'Desktop') -contains $PSVersionTable.PSEdition
if (!$iswinps) {
    $encoding = [System.Text.Encoding]::GetEncoding(1252)
}
else {
    $encoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Default
}

$content = Get-Content $Path -Encoding $encoding

# klassen
function Get-UntisKlassen {
    $re_klassen = '^00K\s+,"?(?<afkorting>[^,"]*)"?,"?(?<volledig>[^,"]*)"?,+.*$'
    $klassen = @()
    $content | ForEach-Object { 
        if($_ -match $re_klassen) { 
            $Matches.Remove(0)
            $o = New-Object -TypeName PSObject -Property $Matches
            $klassen += $o
        }
    }
    return $klassen
}

function Get-UntisDocenten {
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

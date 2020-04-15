
$gpn_file = "./demo-files/be_gy1_Hantal.GPN"

$content = Get-Content $gpn_file

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

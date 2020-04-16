Import-Module ./UntisGpnFileTools.psm1

Describe 'UntisGpnFileTools module-scope stuff' {
    AfterEach {
        Close-UntisGpnFile
    }
    It "must open and close files correctly" {
        { Get-UntisGpnFile } | Should -Throw
        { Get-UntisGpnFileContent } | Should -Throw
        Open-UntisGpnFile -Path ./demo-files/be_gy1_Hantal.GPN
        Get-UntisGpnFile | Should -BeOfType System.IO.FileInfo
        (Get-UntisGpnFile).Name | Should -Be 'be_gy1_Hantal.GPN'
        Get-UntisGpnFileContent | Should -HaveCount 26640
        Close-UntisGpnFile
        { Get-UntisGpnFile } | Should -Throw
        { Get-UntisGpnFileContent } | Should -Throw
        { Get-UntisKlassen } | Should -Throw
        { Get-UntisDocenten } | Should -Throw
        Open-UntisGpnFile -Path ./demo-files/be_uv1_Nijverheidsschool.gpn
        (Get-UntisGpnFile).Name | Should -Be 'be_uv1_Nijverheidsschool.gpn'
        Get-UntisGpnFileContent | Should -HaveCount 41482
    }
}

Describe 'Get-UntisKlassen' {
    Context "Demo GPN file [be_gy1_Hantal.GPN]" {
        BeforeAll {
            Open-UntisGpnFile -Path ./demo-files/be_gy1_Hantal.GPN 
        }
        AfterAll {
            Close-UntisGpnFile
        }
        It "moet alle 56 klassen returnen" {
            $alle_klassen = Get-UntisKlassen
            $alle_klassen.Count | Should -Be 56
        }
        It "moet als eerste klas 1BMA returnen" {
            $eerste_klas = Get-UntisKlassen | Select-Object -First 1
            $eerste_klas.afkorting | Should -Be '1BMA'
            $eerste_klas.volledig | Should -Be 'Accountancy-Talen & Fiscaliteit'
        }
        It "moet 1 klas zonder volledige naam bevatten (STVMK)" {
            $klas_zonder_volledige_naam = Get-UntisKlassen | Where-Object volledig -eq ""
            $klas_zonder_volledige_naam.Count | Should -Be 1
            $klas_zonder_volledige_naam.afkorting | Should -Be 'STVMK'
        }
        It "moet deeltekens correct parsen (2IMA)" {
            $klas2IMA = Get-UntisKlassen | Where-Object afkorting -eq 2IMA
            $klas2IMA.volledig | Should -Be "Immobiliën- en Verzekeringswezen"
        }
    }
}

Describe 'Get-UntisDocenten' {
    Context "Demo GPN file [be_gy1_Hantal.GPN]" {
        BeforeAll {
            Open-UntisGpnFile -Path ./demo-files/be_gy1_Hantal.GPN 
        }
        AfterAll {
            Close-UntisGpnFile
        }
        It "moet alle 97 docenten return" {
            $alle_docenten = Get-UntisDocenten
            $alle_docenten.Count | Should -Be 97
        }
    }
}

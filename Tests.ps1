Remove-Module UntisGpnFileTools -ErrorAction SilentlyContinue
Import-Module ./UntisGpnFileTools.psm1


# Helper functions

function Get-UntisDataFromExport {
    param($Path, $Type)
    $filename = switch($Type) {
        'timetables' { 'GPU001.TXT' }
        'lessons' { 'GPU002.TXT'} 
        'classes' { 'GPU003.TXT' }
        'teachers' { 'GPU004.TXT' }
        'rooms' { 'GPU005.TXT' }
        'subjects' { 'GPU006.TXT' }
        'departments' { 'GPU007.TXT' }
        'teacher_qualifications' { 'GPU008.TXT' }
        'break_supervisors' { 'GPU009.TXT' }
        'students' { 'GPU010.TXT' }
        'periods' { 'GPU011.TXT' }
        'absence_reasons' { 'GPU012.TXT' }
        'absences' { 'GPU013.TXT' }
        'substitutions' { 'GPU014.TXT' }
        'course_choices' { 'GPU015.TXT' }
        'time_requests' { 'GPU016.TXT' }
        'exams' { 'GPU017.TXT' }
        'breaks' { 'GPU018.TXT' }
        'lessons_sequences' { 'GPU019.TXT' }
        'reductions' { 'GPU020.TXT' }
        'reduction_reasons' { 'GPU021.TXT' }
    }

    # Powershell (>= 6.0) ondersteunt GetEncoding(1252)
    $iswinps = ($null, 'Desktop') -contains $PSVersionTable.PSEdition
    if (!$iswinps) {
        $encoding = [System.Text.Encoding]::GetEncoding(1252)
    }
    else {
        $encoding = [Microsoft.PowerShell.Commands.FileSystemCmdletProviderEncoding]::Default
    }

    $nr_of_columns = ((Get-Content "$Path/$filename" -Encoding $encoding | Select-Object -First 1).Split(',') | Measure-Object).Count
    $colnames = 0..$nr_of_columns | Foreach-Object { "col$_"}
    switch($Type) {
        'timetables' {
            $colnames[0] = 'lescode'
            $colnames[1] = 'klas'
            $colnames[2] = 'leerkracht'
            $colnames[3] = 'vakcode'
            $colnames[4] = 'lokaal'
            $colnames[5] = 'dag'
            $colnames[6] = 'uur'
            #$colnames[7] = ''
            #$colnames[8] = ''
            break
        }
        'lessons' { 
            break
        } 
        'classes' {
            $colnames[0] = 'klas_afkorting'
            $colnames[1] = 'klas_volledig'
            #$colnames[2] = ''
            $colnames[3] = 'lokaal'
            #$colnames[4] = ''
            #$colnames[5] = ''
            #$colnames[6] = ''
            #$colnames[7] = ''
            #$colnames[8] = ''
            #$colnames[9] = ''
            #$colnames[10] = ''
            #$colnames[11] = ''
            #$colnames[12] = ''
            #$colnames[13] = ''
            #$colnames[14] = ''
            #$colnames[15] = ''
            $colnames[16] = 'middagpauze_start'
            $colnames[17] = 'middagpauze_stop'
            #$colnames[18] = ''
            #$colnames[19] = ''
            #$colnames[20] = ''
            #$colnames[20] = ''
            #$colnames[21] = ''
            #$colnames[22] = ''
            #$colnames[23] = ''
            #$colnames[24] = ''
            #$colnames[25] = ''
            #$colnames[26] = ''
            #$colnames[27] = 'unknown_number'
            #$colnames[28] = ''
            #$colnames[29] = ''
            #$colnames[30] = ''
            #$colnames[31] = 'unknown_number2'
            #$colnames[32] = ''
            break
         }
        'teachers' { 
            $colnames[0] = 'afkorting'
            $colnames[1] = 'volledige_naam'
            #$colnames[2] = ''
            #$colnames[3] = ''
            #$colnames[4] = ''
            #$colnames[5] = ''
            #$colnames[6] = ''
            #$colnames[7] = ''
            #$colnames[8] = ''
            #$colnames[9] = ''
            #$colnames[10] = ''
            #$colnames[11] = ''
            #$colnames[12] = ''
            #$colnames[13] = ''
            #$colnames[14] = ''
            #$colnames[15] = ''
            #$colnames[16] = ''
            #$colnames[17] = ''
            #$colnames[18] = ''
            #$colnames[19] = ''
            #$colnames[20] = ''
            #$colnames[20] = ''
            #$colnames[21] = ''
            #$colnames[22] = ''
            #$colnames[23] = ''
            #$colnames[24] = ''
            #$colnames[25] = ''
            #$colnames[26] = ''
            #$colnames[27] = ''
            #$colnames[28] = ''
            #$colnames[29] = ''
            #$colnames[30] = ''
            #$colnames[31] = ''
            #$colnames[32] = ''
            #$colnames[33] = ''
            #$colnames[34] = ''
            #$colnames[35] = ''
            #$colnames[36] = ''
            #$colnames[37] = ''
            #$colnames[38] = ''
            #$colnames[39] = ''
            #$colnames[40] = ''
            #$colnames[41] = ''
            #$colnames[42] = ''
            #$colnames[43] = ''
            #$colnames[44] = ''
            break
         }
        'rooms' { 
            break
         }
        'subjects' {
            $colnames[0] = 'vakcode'
            $colnames[1] = 'volledige_naam'
            $colnames[2] = 'tekst'
            $colnames[3] = 'lokaal'
            $colnames[4] = 'middaguren'
            $colnames[5] = 'alias'
            #$colnames[6] = ''
            #$colnames[7] = ''
            #$colnames[8] = ''
            #$colnames[9] = ''
            #$colnames[10] = ''
            #$colnames[11] = ''
            #$colnames[12] = ''
            #$colnames[13] = ''
            #$colnames[14] = ''
            #$colnames[15] = ''
            #$colnames[16] = ''
            #$colnames[17] = ''
            #$colnames[18] = ''
            #$colnames[19] = ''
            #$colnames[20] = ''
            $colnames[20] = 'verkorte_naam'
            #$colnames[21] = ''
            #$colnames[22] = ''
            break
         }
        'departments' { 
            break
         }
        'teacher_qualifications' { 
            break
         }
        'break_supervisors' { 
            break
         }
        'students' { 
            break
         }
        'periods' { 
            break
         }
        'absence_reasons' { 
            break
         }
        'absences' { 
            $colnames[0] = 'id'
            $colnames[1] = 'onderwerp_type'
            $colnames[2] = 'onderwerp'
            $colnames[3] = 'datum_van'
            $colnames[4] = 'datum_tem'
            $colnames[5] = 'lesuur_van'
            $colnames[6] = 'lesuur_tem'
            #$colnames[7] = ''
            $colnames[8] = 'omschrijving'
            #$colnames[9] = ''
            break
         }
         'substitutions' { 
            $colnames[0] = 'id'
            $colnames[1] = 'datum'
            $colnames[2] = 'lesuur'
            $colnames[3] = 'absentievolgnummer'
            #$colnames[4] = ''
            $colnames[5] = 'leerkracht_tevervangen'
            $colnames[6] = 'leerkracht_vervanger'
            $colnames[7] = 'vak'
            #$colnames[8] = ''
            #$colnames[9] = ''
            #$colnames[10] = ''
            $colnames[11] = 'lokaal'
            $colnames[12] = 'lokaal2'
            #$colnames[13] = ''
            $colnames[14] = 'klassen'
            $colnames[15] = 'reden'
            $colnames[16] = 'opdracht'
            #$colnames[17] = ''
            $colnames[18] = 'klassen2'
            #$colnames[19] = ''
            $colnames[20] = 'tijdstip_toegevoegd'
            #$colnames[21] = ''
            break
          }
        'course_choices' { 
            break
         }
        'time_requests' { 
            break
         }
        'exams' { 
            break
         }
        'breaks' { 
            break
         }
        'lessons_sequences' { 
            break
         }
        'reductions' { 
            break
         }
        'reduction_reasons' { 
            break
         }
    }
    $data = Get-Content "$Path/$filename" -Encoding $encoding | ConvertFrom-Csv -Header $colnames
    return $data
}



# Tests

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
        { Get-UntisPeriodes } | Should -Throw
        { Get-UntisActiviteiten } | Should -Throw
        Open-UntisGpnFile -Path ./demo-files/be_uv1_Nijverheidsschool.gpn
        (Get-UntisGpnFile).Name | Should -Be 'be_uv1_Nijverheidsschool.gpn'
        Get-UntisGpnFileContent | Should -HaveCount 41482
    }
}

Describe 'Get-UntisPeriodes' {
    Context "Demo GPN file [be_gy1_Hantal.GPN]" {
        BeforeAll {
            Open-UntisGpnFile -Path ./demo-files/be_gy1_Hantal.GPN 
        }
        AfterAll {
            Close-UntisGpnFile
        }
        It "geeft de juiste aantallen periodes terug" {
            $periodes = Get-UntisPeriodes
            $periodes | Should -HaveCount 2
        }
        It "geeft afkorting en volledige naam eerste periode terug" {
            $periodes = Get-UntisPeriodes
            $periodes[0].afkorting | Should -Be "1ste semester"
            $periodes[0].volledig | Should -Be "1ste semester"
        }
        It "geeft moederperiode terug" {
            $periodes = Get-UntisPeriodes
            $periodes[1].moederperiode | Should -Be "1ste semester"
        }
        It "geef de juiste start- en einddata terug" {
            [datetime]$expected_van = '2009-07-27'
            [datetime]$expected_tem = '2010-07-02'
            $periodes = Get-UntisPeriodes
            $periodes[0].van | Should -BeOfType System.DateTime
            $periodes[0].tem | Should -BeOfType System.DateTime
            $periodes[0].van | Should -Be $expected_van
            $periodes[0].tem | Should -Be $expected_tem
        }
        It "geeft de actieve periode terug" {
            $periodes = Get-UntisPeriodes
            $periodes[0].isActief | Should -Be $true
            $periodes[1].isActief | Should -Be $false
        }
        It "geef de juiste nummer v.d. periode terug" {
            $periodes = Get-UntisPeriodes
            $periodes[0].nummer | Should -Be 1
            $periodes[1].nummer | Should -Be 2
        }
    }
    Context "Demo GPN file [be_uv1_Nijverheidsschool.gpn]" {
        BeforeAll {
            Open-UntisGpnFile -Path ./demo-files/be_uv1_Nijverheidsschool.gpn
        }
        AfterAll {
            Close-UntisGpnFile
        }
        It "geeft de juiste aantallen periodes terug" {
            $periodes = Get-UntisPeriodes
            $periodes | Should -HaveCount 3
        }
        It "geeft afkorting en volledige naam eerste periode terug" {
            $periodes = Get-UntisPeriodes
            $periodes[0].afkorting | Should -Be "Lesjaar"
            $periodes[0].volledig | Should -Be "Heel lesjaar"
        }
        It "geeft moederperiode terug" {
            $periodes = Get-UntisPeriodes
            $periodes[2].moederperiode | Should -Be "Lesjaar"
        }
        It "geef de juiste start- en einddata terug" {
            [datetime]$expected_van = '2009-09-01'
            [datetime]$expected_tem = '2010-06-30'
            $periodes = Get-UntisPeriodes
            $periodes[0].van | Should -BeOfType System.DateTime
            $periodes[0].tem | Should -BeOfType System.DateTime
            $periodes[0].van | Should -Be $expected_van
            $periodes[0].tem | Should -Be $expected_tem
        }
        It "geeft de actieve periode terug" {
            $periodes = Get-UntisPeriodes
            $periodes[0].isActief | Should -Be $false
            $periodes[1].isActief | Should -Be $false
            $periodes[2].isActief | Should -Be $true
        }
        It "geef de juiste nummer v.d. periode terug" {
            $periodes = Get-UntisPeriodes
            $periodes[0].nummer | Should -Be 1
            $periodes[1].nummer | Should -Be 2
            $periodes[2].nummer | Should -Be 3
        }
    }
}

Describe 'Get-UntisKlassen' {
    Context "Demo GPN file [be_gy1_Hantal.GPN] met handmatige data" {
        BeforeAll {
            Open-UntisGpnFile -Path ./demo-files/be_gy1_Hantal.GPN 
        }
        AfterAll {
            Close-UntisGpnFile
        }
        It "moet alle 56 klassen returnen van alle periodes" {
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
    Context "Demo GPN files vergelijken met export-data periode 1" {
        $export_data_folders = @(
            @{Path = "./demo-files/testdata_be_gy1_Hantal"},
            @{Path = "./demo-files/testdata_be_uv1_Nijverheidsschool"}
        )
        BeforeAll {
            Open-UntisGpnFile -Path ./demo-files/be_gy1_Hantal.GPN
        }
        AfterAll {
            Close-UntisGpnFile
        }
        It "moet elke docent returnen die ook in '<Path>' voor periode 1 aanwezig is" -TestCases $export_data_folders {
            param($Path)
            $expected_teachers = Get-UntisDataFromExport -Path $Path -Type Teachers
            $alle_docenten = Get-UntisDocenten #-Periode 1 #TODO
            $expected_teachers | Foreach-Object {
                $alle_docenten.afkorting | Should -Contain $_.afkorting
            }
            $alle_docenten | Foreach-Object {
                $expected_teachers.afkorting | Should -Contain $_.afkorting
            }
        }
    }
}

Describe 'Get-UntisActiviteiten' {
    Context "Demo GPN file [be_uv1_Nijverheidsschool.gpn]" {
        BeforeAll {
            Open-UntisGpnFile -Path ./demo-files/be_uv1_Nijverheidsschool.gpn
        }
        AfterAll {
            Close-UntisGpnFile
        }
        It "geeft het juiste aantal activiteiten terug" {
            $expected = Get-UntisActiviteiten
            $expected | Should -HaveCount 104
        }
        It "geeft de juiste values voor alle properties van de eerste activiteit" {
            $expected = Get-UntisActiviteiten | Select-Object -First 1
            $expected.nummer | Should -Be 179
            $expected.startdatum | Should -BeOfType System.DateTime
            $expected.einddatum | Should -BeOfType System.DateTime
            $expected.startdatum | Should -Be ([datetime]'2010-05-07')
            $expected.einddatum | Should -Be ([datetime]'2010-05-07')
            $expected.reden | Should -Be "SB"
            $expected.tekst | Should -Be "Moskee Genk+Zutendaal"
            $expected.startuur | Should -Be 1845
            $expected.einduur | Should -Be 9
            $expected.onderwerp | Should -Be ''
            $expected.klassen | Should -Be @('B2BA','B2BB','B2BC')
            $expected.leerkrachten | Should -Be @('VLOB','Van6','VGIE','Geen','va')
            $expected.absent_ids | Should -Be @(2814,2813,2812,2815,2816,2817,2818,2819)
        }
    }
}


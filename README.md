# UntisGpnFileTools
Powershell regex-based parser-module for Untis' GPN-files

## How to run

Import the module (choose one):

    Import-Module ./UntisGpnFileTools
    Import-Module ./UntisGpnFileTools.psm1

The module is now loaded:

    Get-Module

All available commands can be shown:

    Get-Command -Module UntisGpnFileTools

To start using it, you have to supply the path to an Untis file:

    Open-UntisGpnFile -Path ./demo-files/be_gy1_Hantal.GPN

Now you can execute the different functions succesfully:

    Get-UntisKlassen
    Get-UntisDocenten

**Optionally** you can close the current GPN-file, before opening a new one:

    Close-UntisGpnFile

To remove the module from memory (can be important during manual testing after code is changed):

    Remove-Module UntisGpnFileTools

The `UntisGpnFileTools.psm1`-file can also be copied into one of the paths in `$Env:PSModulePath` for easier importing.

## How to test
Have Pester installed (see below for Windows 10)

    Install-Module Pester

Run Tests

    ./Tests.ps1

Note that the tests require the demo-GPN-files to be present.
Similar tests can be written for personal GPN-files.

## Pester on Windows 10
On Windows 10, Pester 3.4.0 is installed by default.
This script requires Pester >4.0.

You can install it only for the current user (side-by-side), just to be safe:

    Install-Module Pester -Scope CurrentUser -Force -SkipPublisherCheck
    Import-Module Pester

Check version numbers of different Pester-modules:

    Get-Module Pester -ListAvailable

To uninstall `Pester`, start a new Powershell-session (and close all others)

    Uninstall-Module Pester
    Uninstall-Module Pester -RequiredVersion 4.10.2

Sometimes uninstalling modules throws 'in use'-errors. These things are good to know:
- Powershell-modules are usually auto-imported depending on the
`$PSModuleAutoLoadingPreference`, which can be set to `none` in your `$profile`
- `powershell -NoProfile -Command "Uninstall-Module Pester"` starts a clean Powershell
without loading the `$profile` to try to uninstall the module.

## TODO
First focus is to be able to export **classes**, **teachers** and **subjects**
to be used for scripting Microsoft Teams (names, channels, membership).

DONE :warning:
- Refactored to a module instead of a script
- `Get-UntisKlassen` returns all classes from all periods
- `Get-UntisDocenten` returns all teachers from all periods
- `Get-UntisPeriodes` returns all periods (and shows which one was active when GPN-file was last saved)
- Better tests with data from exports
- `Get-UntisActiviteiten` returns all activities
- `Get-Periodes` (and other functions) return real (typed) DateTime-objects

TODO :construction: (with estimated difficulty):

- :star: Make all tests work on Windows 10 / Windows Server 2016
- :star: :star: :star: Make the tools period-aware
- :star: `Get-UntisVakken`
- :star: :star: Only do raw parsing or also logic (e.g. `Get-UntisLeerkrachten -Klas $klasnaam`)?
- :star: :star: :star: `Get-UntisLesrooster`
- ...

Suggested workflow:
- add tests
    - for each bug/encountered problem
    - for new functionality
- fix tests

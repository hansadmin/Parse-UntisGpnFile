# Parse-UntisGpnFile
Powershell regex-based parser for Untis' GPN-files

## How to run
Dot source `Parse-UntisGpnFile.ps1`

    . ./Parse-UntisGpnFile.ps1 -Path ./demo-files/be_gy1_Hantal.GPN

Execute `Get-UntisKlassen`

    Get-UntisKlassen

## How to test
Have Pester installed (see below for Windows 10)

    Install-Module Pester

Run Tests

    ./Parse-UntisGpnFile.Tests.ps1


## Pester on Windows 10
On Windows 10, Pester 3.4.0 is installed by default.
This script require Pester >4.0.

You can install it only for the current user (side-by-side), just to be safe:

    Install-Module Pester -Scope CurrentUser -Force -SkipPublisherCheck
    Import-Module Pester

Check version numbers of different Pester-modules:

    Get-Module Pester -ListAvailable

To remove `Pester`, start a new Powershell-session (and close all others)

    Uninstall-Module Pester
    Uninstall-Module Pester -RequiredVersion 4.10.2

Sometimes removing modules throws 'in use'-errors. These things are good to know:
- Powershell-modules are usually auto-imported depending on the
`$PSModuleAutoLoadingPreference`, which can be set to `none` in your `$profile`
- `powershell -NoProfile -Command "Uninstall-Module Pester"` starts a clean Powershell
without loading the `$profile` to try to uninstall the module.


## TODO
First focus is to be able to export **classes**, **teachers** and **subjects**
to be used for scripting Microsoft Teams (names, channels, membership).

Done :warning:
- `Get-UntisKlassen`
- parameterize: `. ./Parse-UntisGpnFile -Path xyz.gpn`

TODO :construction: (with estimated difficulty):

- :star: `Get-UntisVakken`
- :star: `Get-UntisLeerkrachten` / `Get-UntisDocenten`
- :star: :star: Only do raw parsing or also logic (e.g. `Get-UntisLeerkrachten -Klas $klasnaam`)?
- :star: :star: :star: `Get-UntisLesrooster`
- ...

Suggested workflow:
- add tests
    - for each bug/encountered problem
    - for new functionality
- fix tests

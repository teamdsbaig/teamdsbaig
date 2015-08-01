@echo off

title Auto Depiction maker

:Main
cls
echo Make sure you have a working internet connection!
echo.
echo.
echo [Home ^> ... ]
echo AutoDepic, choose your option
echo.
echo 1. Create Depiction
echo 2. About
echo 3. Auto-create packages.BZIP2
echo 4. EXIT
echo.

:: Get option input
set /p option= [Option]: %=%
if "%option%"=="" goto Main
if "%option%"== "1" goto cdepic1
if "%option%"== "2" goto about
if "%option%"== "3" goto launchbz2
if "%option%"== "4" goto exit
::-----------------------------------------------------------------------------------------------------------------------------------
:about

cls
echo [Home ^> About]
echo.
echo Written by: Saadat Baig --part of TeamDSBaig
echo    Twitter: @ds_baig
echo Build date: July 28, 2015
echo.
pause
goto Main
::-----------------------------------------------------------------------------------------------------------------------------------
:launchbz2

cls
echo.
echo Launching auto-BZIP2-maker
start AutoBZIP2.bat
echo.
echo.
echo Press enter to enter Main menu
pause
goto Main
::-----------------------------------------------------------------------------------------------------------------------------------
:exit
exit
::-----------------------------------------------------------------------------------------------------------------------------------
:cdepic1

cls
echo [Home ^> create Depiction][Status: Setting up directories...]
echo [Stage 1/8]
echo.
echo Enter your GitHub Repo directory.
echo CAUTION- you need a folder named: depictions
echo.
set /p repoDir= [GitHub Repo]: %=%
cls
goto cdepic3
::-----------------------------------------------------------------------------------------------------------------------------------
:cdepic2

echo [Home ^> create Depiction][Status: Setting up directories...]
echo [Stage 3/8]
echo.
echo Setting up directories...
echo.
cd %repoDir%\depictions
mkdir %packageDir%
cd %packageDir%
ping localhost -n 2 >nul
cls
goto packageFirmware
::-----------------------------------------------------------------------------------------------------------------------------------
:cdepic3

echo [Home ^> create Depiction][Status: Gathering info]
echo [Stage 2/8]
echo.
echo Enter your package name, Normal Package name and Version of the Package
echo.
echo Example--        Package name: com.yourcompany.yourapp
echo Example-- Normal package name: Your App
echo Example--             Version: 1.0
echo.
set /p packageDir= [package name]: %=%
set /p packageName= [Normal Package name]: %=%
set /p packageVersion= [Package Version]: %=%
cls
goto cdepic2
::-----------------------------------------------------------------------------------------------------------------------------------
:packageFirmware

echo [Home ^> create Depiction][Status: Gathering info]
echo [Stage 4/8]
echo.
echo Enter compatible firmware.
echo This can be left emptyfor overall iOS compatability
echo.
set /p minFirmware= [Minimal Firmware Version]: %=%
cls
goto packageDependencies
::-----------------------------------------------------------------------------------------------------------------------------------
:packageDependencies

echo [Home ^> create Depiction][Status: Gathering info]
echo [Stage 5/8]
echo.
echo Enter package dependencies. Use Bundle IDs. 
echo Example: winterboard = Winterboard
echo If not sure, enter mobilesubstrate
echo.
set /p packageDependencies= [Bundle ID]: %=%
cls
goto packageChangelog
::-----------------------------------------------------------------------------------------------------------------------------------
:packageChangelog

echo [Home ^> create Depiction][Status: Gathering info]
echo [Stage 6/8]
echo.
echo Enter package changelog.
echo.
set /p packageChangelog1= [ChangelogLine1]: %=%
cls
goto packageDescription
::-----------------------------------------------------------------------------------------------------------------------------------
:packageDescription

echo [Home ^> create Depiction][Status: Gathering info]
echo [Stage 7/8]
echo.
echo Enter package description.
echo.
set /p packageDescription1= [DescriptionLine1]: %=%
set /p packageDescription2= [DescriptionLine2]: %=%
cls
goto packageScreenshot
::-----------------------------------------------------------------------------------------------------------------------------------
:packageScreenshot

echo [Home ^> create Depiction][Status: Gathering info]
echo [Stage 8/8]
echo.
echo Enter package screenshot Description and Name
echo.
echo CAUTION: remember to add .PNG to the name!
echo CAUTION: Entered screenshot name must match the last part of package name
echo.
echo e.g.: com.teamdsbaig.heartslider8  ----screenshotname: heartslider8.PNG
echo.
set /p screenDesc= [Screenshot Description]: %=%
set /p screens1= [Screenshot name]: %=%
cls
goto packageWriteI
::-----------------------------------------------------------------------------------------------------------------------------------
:packageWriteI

echo [Home ^> create Depiction][Status: Preparing assets...]
echo.
echo Downloading XML resources...

:: Download XML resources
powershell -Command (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/teamdsbaig/teamdsbaig.github.io/master/Xres/BaseInfo.xml?dl=1', 'info.xml')

cls
echo [Home ^> create Depiction][Status: Setting up package name]
echo.
echo Writing depiction InfoXML...
echo.
:: Replace Package name with PackageName and add Package Version
powershell -Command "(gc info.xml) -replace 'BundleString', '%packageDir%' | Out-File info.xml"
powershell -Command "(gc info.xml) -replace 'BundleVersionString', '%packageVersion%' | Out-File info.xml"

cls
echo [Home ^> create Depiction][Status: Setting up package firmware compatibility]
echo.
echo Writing depiction infoXML...
echo.
:: Replace firmware version
powershell -Command "(gc info.xml) -replace 'MinimumString', '%minFirmware%' | Out-File info.xml"

cls
echo [Home ^> create Depiction][Status: Setting up package description]
echo.
echo Writing depiction infoXML...
echo.
:: Replace Descriptions
powershell -Command "(gc info.xml) -replace 'DescString1', '%packageDescription1%' | Out-File info.xml"
powershell -Command "(gc info.xml) -replace 'DescString2', '%packageDescription2%' | Out-File info.xml"

cls
echo [Home ^> create Depiction][Status: Setting up package dependencies]
echo.
echo Writing depiction infoXML...
echo.
:: Replace Dependencies
powershell -Command "(gc info.xml) -replace 'DependencyString', '%packageDependencies%' | Out-File info.xml"

cls
echo [Home ^> create Depiction][Status: Setting up package changelog]
echo.
echo Writing depiction infoXML...
echo.
:: Replace Changelog
powershell -Command "(gc info.xml) -replace 'ChangelogString1', '%packageChangelog1%' | Out-File info.xml"

cls
echo [Home ^> create Depiction][Status: Setting up Screenshots...]
echo.
echo Writing depiction infoXML...
echo.
:: Write Screenshots desc and file name
powershell -Command "(gc info.xml) -replace 'ScreenshotDescString1', '%screenDesc%' | Out-File info.xml"
powershell -Command "(gc info.xml) -replace 'ScreenName', '%screens1%' | Out-File info.xml"

cls
echo [Home ^> create Depiction][Status: Complete]
echo.
echo Successfully wrote depictions!
echo.
echo continueing to create auto-changelog...
echo.
pause
ping localhost -n 2 >nul
cls
goto cchangelog
::-----------------------------------------------------------------------------------------------------------------------------------
:cchangelog

echo [Home ^> create Depiction][Status: Creating changelog...]
echo.
echo Downloading resources...

:: Download XML resource...
powershell -Command (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/teamdsbaig/teamdsbaig.github.io/master/Xres/BaseChangelog.xml?dl=1', 'changelog.xml')

cls
echo [Home ^> create Depiction][Status: Creating changelog...]
echo.
echo Writing depiction InfoXML...
echo.
:: Write Package Version and Changelog
powershell -Command "(gc info.xml) -replace 'VersionString', '%packageVersion%' | Out-File info.xml"
powershell -Command "(gc info.xml) -replace 'ChangeString', '%packageChangelog1%' | Out-File info.xml"

cls
echo [Home ^> create Depiction][Status: Complete]
echo.
echo Successfully wrote depictions and corresponding Changelog!
echo.
echo.
pause
ping localhost -n 2 >nul
cls
goto Main
::-----------------------------------------------------------------------------------------------------------------------------------
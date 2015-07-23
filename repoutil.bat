@echo off

title Decimation's CyRepo Utilities

:Main
cls
echo [Home ^> ... ]
echo Welcome to CyRepo Utilities
echo.
echo 1. New package entry
echo 2. About
echo.

:: Get option input
set /p option= [Option]: %=%
if "%option%"=="" goto Main
if "%option%"== "1" goto packageEntry1
if "%option%"== "2" goto about

::-----------------------------------------------------------------------------------------------------------------------------------
:about

cls
echo [Home ^> About]
echo.
echo Written by: Decimation
echo Twitter: @dec1mati0n
echo Reddit: /u/_Decimation
echo Build date: July 6, 2015
echo.
pause
goto Main
::-----------------------------------------------------------------------------------------------------------------------------------
:packageEntry1

cls
echo [Home ^> Package Entry][Status: Gathering info]
echo [Stage 1/7]
echo.
echo Enter your GitHub Repo directory.
echo.
set /p repoDir= [GitHub Repo]: %=%
cls
goto packageEntry2
::-----------------------------------------------------------------------------------------------------------------------------------
:packageEntry2

echo [Home ^> Package Entry][Status: Gathering info]
echo [Stage 2/7]
echo.
echo Enter your package name. (deb file)
echo Example: com.decimation.packagename
echo.
set /p packageName= [Package name]: %=%
set /p normalPackageName= [Normal package name]: %=%
cls
goto packageEntry3
::-----------------------------------------------------------------------------------------------------------------------------------
:packageEntry3

echo [Home ^> Package Entry][Status: Gathering info]
echo [Stage 3/7]
echo.
echo Preparing depiction HTML...
echo.
cd %repoDir%\Depic
mkdir %packageName%
cd %packageName%
ping localhost -n 2 >nul
cls
goto packageEntryFirmware
::-----------------------------------------------------------------------------------------------------------------------------------
:packageEntryFirmware

echo [Home ^> Package Entry][Status: Gathering info]
echo [Stage 4/7]
echo.
echo Enter compatible firmware. Description will be the description used in depiction.
echo.
set /p minFirmware= [Minimal]: %=%
set /p maxFirmware= [Maximum]: %=%
set /p firmwareDesc= [Description]: %=%
cls
goto packageDependencies
::-----------------------------------------------------------------------------------------------------------------------------------
:packageDependencies

echo [Home ^> Package Entry][Status: Gathering info]
echo [Stage 5/7]
echo.
echo Enter package dependencies. Use Bundle IDs. 
echo Example: winterboard = Winterboard
echo.
set /p packageDependencies= [Bundle ID]: %=%
cls
goto packageChangelog
::-----------------------------------------------------------------------------------------------------------------------------------
:packageChangelog

echo [Home ^> Package Entry][Status: Gathering info]
echo [Stage 6/7]
echo.
echo Enter package changelog.
echo.
set /p packageChangelog= [Changelog]: %=%
cls
goto packageDescription
::-----------------------------------------------------------------------------------------------------------------------------------
:packageDescription

echo [Home ^> Package Entry][Status: Gathering info]
echo [Stage 7/7]
echo.
echo Enter package description.
echo.
set /p packageDescription= [Description]: %=%
cls
goto packageWriteI
::-----------------------------------------------------------------------------------------------------------------------------------
:packageWriteI

echo [Home ^> Package Entry][Status: Preparing assets...]
echo.
echo Downloading HTML resources...

:: Download HTML resources
powershell -Command (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/Decimation/CyRepoUtilities/master/HyperIndex.html?dl=1', 'index.html')

cls
echo [Home ^> Package Entry][Status: Setting up package name]
echo.
echo Writing depiction HTML...
echo.
:: Replace Package name with normalPackageName
powershell -Command "(gc index.html) -replace 'Package', '%normalPackageName%' | Out-File index.html"

cls
echo [Home ^> Package Entry][Status: Setting up package firmware compatibility]
echo.
echo Writing depiction HTML...
echo.
:: Replace firmware versions
powershell -Command "(gc index.html) -replace 'XMinX', '%minFirmware%' | Out-File index.html"
powershell -Command "(gc index.html) -replace 'XMaxX', '%maxFirmware%' | Out-File index.html"
powershell -Command "(gc index.html) -replace 'SupportString', '%firmwareDesc%' | Out-File index.html"

cls
echo [Home ^> Package Entry][Status: Setting up package description]
echo.
echo Writing depiction HTML...
echo.
:: Replace Description
powershell -Command "(gc index.html) -replace 'DescriptionString', '%packageDescription%' | Out-File index.html"

cls
echo [Home ^> Package Entry][Status: Setting up package dependencies]
echo.
echo Writing depiction HTML...
echo.
:: Replace Dependencies
powershell -Command "(gc index.html) -replace 'DependenciesString', '%packageDependencies%' | Out-File index.html"

cls
echo [Home ^> Package Entry][Status: Setting up package changelog]
echo.
echo Writing depiction HTML...
echo.
:: Replace Changelog
powershell -Command "(gc index.html) -replace 'ChangelogString', '%packageChangelog%' | Out-File index.html"

cls
echo [Home ^> Package Entry][Status: Complete]
echo.
echo Successfully wrote depictions!
ping localhost -n 2 >nul
cls
goto packageIndex

::-----------------------------------------------------------------------------------------------------------------------------------
:packageIndex
echo [Home ^> Package Entry][Status: Indexing package]
echo [Step 0/15]
echo.
echo Setting up Packages control file...
cd %repoDir%


cls
echo [Home ^> Package Entry][Status: Indexing package]
echo [Step 1/15]
echo.
echo Setting up Packages control file...
echo Package: %packagename >> Packages


cls
echo [Home ^> Package Entry][Status: Indexing package]
echo [Step 2/15]
echo.
echo Setting up Packages control file...
echo Version: %packageVer% >> Packages


cls
echo [Home ^> Package Entry][Status: Indexing package]
echo [Step 3/15]
echo.
echo Setting up Packages control file...
echo Architecture: iphoneos-arm >> Packages


cls
echo [Home ^> Package Entry][Status: Indexing package]
echo [Step 4/15]
echo.
echo Setting up Packages control file...
echo.
echo set /p packageMaintainer= [Package Maintainer]: %=%
echo Maintainer: %packageMaintainer% >> Packages


cls
echo [Home ^> Package Entry][Status: Indexing package]
echo [Step 5/15]
echo.
echo Setting up Packages control file...
echo Depends: %packageDependencies% >> Packages


cls
echo [Home ^> Package Entry][Status: Indexing package]
echo [Step 6/15]
echo.
echo Setting up Packages control file...
echo Filename: debs//%packagename%.deb >> Packages

cls
echo [Home ^> Package Entry][Status: Indexing package]
echo [Step 7/15]
echo.
echo Setting up Packages control file...
echo Size: >> Packages
:: Need to make the package size analyzer more efficient...
cd debs
:: CD to debs folder so PowerShell can read deb file size
powershell -Command "(Get-Item '%packagename%.deb').length | Add-Content %repoDir%\test.txt"
::cd C:\temp\
::set /p packageSize=<packageSize.txt
::echo Size: %packageSize% >> Packages

pause

exit


echo MD5sum:

echo SHA1:

echo SHA256:

echo Section: Themes (Messages)

echo Description: Vertical slashes for Messages.

echo Author: Read Stanton (Decimation) <decimation001@gmail.com>

echo Depiction: http://decimation.github.io/Depic/com.decimation.slashes/index.html

echo Name: Slashes for Messages
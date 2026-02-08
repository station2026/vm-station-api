@echo off
setlocal enabledelayedexpansion

:: ===================================================================
::  update.bat - HTTP API URL Updater
::
::  This script pulls the latest ngrok HTTP URL from Git and
::  saves it to a local config file for easy access.
:: ===================================================================

set "LOG_FILE=%USERPROFILE%\.vm-station-api\connected_info.log"
set "CONFIG_FILE=%USERPROFILE%\.vm-station-api\api_url.txt"

echo ===================================================================
echo  VM Station API - HTTP URL Update Script
echo ===================================================================
echo.

echo INFO: Pulling latest connection info from Git...
cd %USERPROFILE%\.vm-station-api
git pull
if %ERRORLEVEL% neq 0 (
    echo WARNING: Git pull failed. Using existing local file.
)
echo.

echo INFO: Checking for log file at %LOG_FILE%...
if not exist "%LOG_FILE%" (
    echo ERROR: The log file was not found!
    goto :ERROR_AND_PAUSE
)
for %%A in ("%LOG_FILE%") do set "FILE_SIZE=%%~zA"
if %FILE_SIZE%==0 (
    echo ERROR: The log file is empty.
    goto :ERROR_AND_PAUSE
)
echo SUCCESS: Log file found and is not empty.
echo.

echo INFO: Reading HTTP API URL...
set /p API_URL=<%LOG_FILE%

if not defined API_URL (
    echo ERROR: Could not read the API URL.
    goto :ERROR_AND_PAUSE
)

echo SUCCESS: API URL retrieved:
echo.
echo   %API_URL%
echo.

:: Save the URL to a config file for easy reference
echo %API_URL% > "%CONFIG_FILE%"
echo INFO: URL saved to %CONFIG_FILE%
echo.

:: Copy to clipboard if clip.exe is available
echo %API_URL% | clip 2>nul
if %ERRORLEVEL% equ 0 (
    echo SUCCESS: URL copied to clipboard!
) else (
    echo INFO: Clipboard copy not available.
)
echo.

goto :SUCCESS

:SUCCESS
echo ===================================================================
echo.
echo  SUCCESS: Script finished!
echo.
echo  API URL: %API_URL%
echo.
echo  You can now use this URL to access your HTTP API.
echo.
goto :END

:ERROR_AND_PAUSE
echo.
echo ===================================================================
echo.
echo  AN ERROR OCCURRED. Please review the messages above.
echo.
pause

:END
exit /b 0

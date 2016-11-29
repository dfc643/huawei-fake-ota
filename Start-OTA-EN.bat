@echo off
mode con cols=80 lines=25
color fd
cls
title Huawei Fake OTA Server

REM ========================================
REM     GETTING LOCAL NETWORK IP ADDRESS
REM ========================================
FOR /F "tokens=4 delims= " %%i in ('route print ^| find " 0.0.0.0"') do set localIp=%%i

REM ========================================
REM         PRINT HELP INFORMATION
REM ========================================
:HwOUC_Main_Menu
cls
echo ©³©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©·
echo ©§¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡©§
echo ©§¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡©§
echo ©§¡¡¡¡¡¡¡¡¡¡¡¡ ¡¡  ¡¡ Welcome to: Huawei Fake OTA Server¡¡¡¡¡¡ ¡¡ ¡¡¡¡¡¡¡¡¡¡©§
echo ©§¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡©§
echo ©§¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡©§
echo ©Ä©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©¤©Ì
echo ©§¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡©§
echo ©§¡¡Disclaimer: The software is based on Huawei OTA data simulation         ©§
echo ©§¡¡Copyright: OTA-related data copyright belongs to Huawei all.            ©§
echo ©§¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡©§
echo ©Ä©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©Ì
echo ©§¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡©§
echo ©§¡¡¡¡* How to use and help *¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡   ¡¡¡¡     ¡¡ ©§
echo ©§¡¡¡¡1. Please connect your phone and computer to the same router.¡¡¡¡¡¡   ©§
echo ©§¡¡¡¡2. Please turn off your firewall or allow them.                       ©§
echo ©§¡¡¡¡3. Rename firmware to update.zip and copy to this software root folder©§
echo ©§¡¡¡¡4. Then follow the prompts.                                           ©§
echo ©§¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡©§
echo ©Ä©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©¬©Ì
echo ©§¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡ ¡¡¡¡Enter number and press Enter: [1] Continue  [2] Quit ©§
echo ©»©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¥©¿
echo.
set /p keydown="Choice:> "
if "%keydown%"=="1" goto :HwOUC_Server_Startup
if "%keydown%"=="2" goto :HwOUC_Server_Stop_and_Exit
echo [ERR] Invalid choice, will return after 3 seconds and try again.
ping 127.1 -n 2 >NUL
goto HwOUC_Main_Menu

:HwOUC_Server_Startup
cls
echo ================================================================================
echo                               Huawei Fake OTA Server
echo.
echo ================================================================================
echo Please follow the steps, press Enter to complete each step to continue:
echo -----------------------------------------------
echo.
set /p wait=[1] Put precheck-script and update.zip to this tool root folder 
set /p wait=[2] Change your phone DNS server to: %localIp% 
set /p currentVer=[3] Enter the version number update (eg. CHM-TL00C00B551): 
set /p ruok=[4] Check and confirm your step (type "emui" and Enter to confirm): 
echo.
echo.
if "%ruok%"=="emui" goto :Hw_Server_IAmOk
echo.
echo [ERR] User aborted, will return after 3 seconds.
ping 127.1 -n 3 >NUL
goto :HwOUC_Main_Menu
exit

:Hw_Server_IAmOk
echo In progress, please wait ...
echo -----------------------------------------------
echo.
echo [1] Clearing cache ...
call %~dp0\usr\clean.bat
ping 127.1 -n 2 >NUL

echo [2] Generating OTA files from templates ...
%~dp0\usr\iconvsed\iconv -f utf-8 -t gb2312 %~dp0\full\template\HwOUC_Response.json > %~dp0\full\HwOUC_Response.json.gb2312
%~dp0\usr\iconvsed\iconv -f utf-8 -t gb2312 %~dp0\full\template\changelog.xml > %~dp0\full\changelog.xml.gb2312
%~dp0\usr\iconvsed\sed -i "s/hwouc_dest_version/%currentVer%/g" %~dp0\full\HwOUC_Response.json.gb2312
%~dp0\usr\iconvsed\sed -i "s/hwouc_dest_version/%currentVer%/g" %~dp0\full\changelog.xml.gb2312
%~dp0\usr\iconvsed\iconv -t utf-8 -f gb2312 %~dp0\full\HwOUC_Response.json.gb2312 > %~dp0\full\HwOUC_Response.json
%~dp0\usr\iconvsed\iconv -t utf-8 -f gb2312 %~dp0\full\changelog.xml.gb2312 > %~dp0\full\changelog.xml
ping 127.1 -n 2 >NUL

echo [3] Moving firmware to OTA server ...
move /y %~dp0\precheck-script %~dp0\full\ >nul 2>nul
move /y %~dp0\update.zip %~dp0\full\ >nul 2>nul

echo [4] Generating and saving MD5 of firmware ...
for /f "delims=" %%t in ('%~dp0\usr\md5 -n %~dp0\full\changelog.xml') do set changelog_md5=%%t
for /f "delims=" %%a in ('dir /b /s %~dp0\full\changelog.xml') do set /a "changelog_size+=%%~za"
for /f "delims=" %%t in ('%~dp0\usr\md5 -n %~dp0\full\precheck-script') do set precheck_md5=%%t
for /f "delims=" %%a in ('dir /b /s %~dp0\full\precheck-script') do set /a "precheck_size+=%%~za"
for /f "delims=" %%t in ('%~dp0\usr\md5 -n %~dp0\full\update.zip') do set update_md5=%%t
for /f "delims=" %%a in ('dir /b /s %~dp0\full\update.zip') do set /a "update_size+=%%~za"
%~dp0\usr\iconvsed\iconv -f utf-8 -t gb2312 %~dp0\full\template\filelist.xml > %~dp0\full\filelist.xml.gb2312
%~dp0\usr\iconvsed\sed -i "s/hwouc_changelog_md5/%changelog_md5%/g" %~dp0\full\filelist.xml.gb2312
%~dp0\usr\iconvsed\sed -i "s/hwouc_changelog_size/%changelog_size%/g" %~dp0\full\filelist.xml.gb2312
%~dp0\usr\iconvsed\sed -i "s/hwouc_precheck_md5/%precheck_md5%/g" %~dp0\full\filelist.xml.gb2312
%~dp0\usr\iconvsed\sed -i "s/hwouc_precheck_size/%precheck_size%/g" %~dp0\full\filelist.xml.gb2312
%~dp0\usr\iconvsed\sed -i "s/hwouc_update_md5/%update_md5%/g" %~dp0\full\filelist.xml.gb2312
%~dp0\usr\iconvsed\sed -i "s/hwouc_update_size/%update_size%/g" %~dp0\full\filelist.xml.gb2312
%~dp0\usr\iconvsed\iconv -t utf-8 -f gb2312 %~dp0\full\filelist.xml.gb2312 > %~dp0\full\filelist.xml

echo [5] Cleaning temporary file ...
del %~dp0\full\*.gb2312 /f /q >nul 2>nul
del %~dp0\????????? /f /q >nul 2>nul
ping 127.1 -n 2 >NUL

echo [6] Starting OTA server ...
REM ========================================
REM      STARTING UP HTTP SERVER ENGINE
REM ========================================
set webroot=%~dp0
cd %~dp0\usr\httpd\conf
echo server {                                 >  localhost.vhost
echo     listen 80;                           >> localhost.vhost
echo     server_name  query.hicloud.com;      >> localhost.vhost
echo     charset utf-8;                       >> localhost.vhost
echo     location / {                         >> localhost.vhost
echo         root   %webroot:\=\\%;           >> localhost.vhost
echo         error_page 405 = $uri;           >> localhost.vhost
echo         rewrite "^/sp_ard_common\/v2\/Check.action(.*)"  /full/HwOUC_Response.json last; >> localhost.vhost
echo     }                                    >> localhost.vhost
echo }                                        >> localhost.vhost
cd %~dp0\usr\httpd
%~dp0\usr\hide nginx-hwouc

REM ========================================
REM        STARTING UP DNS SERVICE
REM ========================================
cd %~dp0\usr\named
echo [{                                       >  rules.cfg
echo    "Pattern": "^query\\.hicloud\\.com$", >> rules.cfg
echo    "Address": "%localIp%"                >> rules.cfg
echo }]                                       >> rules.cfg
%~dp0\usr\hide DNSAgent.exe

ping 127.1 -n 5 >NUL
echo [7] OTA has started successfully!
ping 127.1 -n 2 >NUL
goto :HwOUC_Server_Waiting
exit

:HwOUC_Server_Waiting
cls
echo ================================================================================
echo                               Huawei Fake OTA Server
echo.
echo ================================================================================
echo IMPORTANT! upgrading in progress, DONOT close this window will cause failed.
echo --------------------------------------------------------------------------------
set /p ruok=Type "exit" and press Enter to exit: 
if "%ruok%"=="exit" goto :HwOUC_Server_Stop_and_Exit
goto :HwOUC_Server_Waiting

:HwOUC_Server_Stop_and_Exit
echo.
echo.
echo.
echo Exiting, DONOT close window
echo -----------------------------------------------
echo.
echo [1] Cleaning temporary file ...
call %~dp0\usr\clean.bat
del %~dp0\full\*.gb2312 /f /q >nul 2>nul
del %~dp0\full\*.xml /f /q >nul 2>nul
del %~dp0\full\*.json /f /q >nul 2>nul
del %~dp0\????????? /f /q >nul 2>nul
ping 127.1 -n 2 >NUL

echo [2] Resotring firmware files ...
move /y %~dp0\full\update.zip %~dp0\ >nul 2>nul
move /y %~dp0\full\precheck-script %~dp0\ >nul 2>nul

echo [3] OTA has been stopped, press any key to exit.
pause >nul 2>nul
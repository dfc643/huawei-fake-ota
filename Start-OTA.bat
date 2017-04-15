@echo off
mode con cols=80 lines=25
cls

REM *** IF YOU CANNOT GET CORRECTLY IP ADDRESS PLEASE DELETE LINE 12 AND MODIFY LINE 7 ***
REM *** 如果你无法获取到正确的 IP 地址请删除第 12 行然后修改第 7 行 ***
SET localIp=192.168.1.200

REM ========================================
REM     GETTING LOCAL NETWORK IP ADDRESS
REM ========================================
FOR /F "tokens=4 delims= " %%i in ('route print ^| find " 0.0.0.0"') do set localIp=%%i

cd %~dp0\runtime
::start /b mapache.exe
taskkill /f /im HwFakeOta.exe
start /b bin\HwFakeOta.exe
ping 127.0.0.1 -n 2 >nul
start /NORMAL iexplore http://127.0.0.1/guide

REM ========================================
REM        STARTING UP DNS SERVICE
REM ========================================
cd %~dp0\runtime\named
echo [{                                       >  rules.cfg
echo    "Pattern": "^query\\.hicloud\\.com$", >> rules.cfg
echo    "Address": "%localIp%"                >> rules.cfg
echo }]                                       >> rules.cfg
DNSAgent.exe

ping 127.0.0.1 -n 3 >nul

taskkill /f /im HwFakeOta.exe
taskkill /f /im DNSAgent.exe
exit
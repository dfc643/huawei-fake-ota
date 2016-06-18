@echo off
mode con cols=80 lines=25
color fd
cls
title 华为终端 OTA 模拟服务器

REM ========================================
REM     GETTING LOCAL NETWORK IP ADDRESS
REM ========================================
FOR /F "tokens=4 delims= " %%i in ('route print ^| find " 0.0.0.0"') do set localIp=%%i

REM ========================================
REM         PRINT HELP INFORMATION
REM ========================================
:HwOUC_Main_Menu
cls
echo ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
echo ┃　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　┃
echo ┃　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　┃
echo ┃　　　　　　 　　 欢迎使用：华为终端 OTA 升级模拟服务器　　　 　　　　　　┃
echo ┃　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　┃
echo ┃　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　┃
echo ┠─────────────────────────────────────┨
echo ┃　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　┃
echo ┃　免责声明：本软件基于华为 OTA 数据模拟，使用中出现任何问题请自行解决。   ┃
echo ┃　版权声明：本软件集成的软件均为开源软件，软件相关数据版权属于华为所有。  ┃
echo ┃　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　┃
echo ┠┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┨
echo ┃　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　┃
echo ┃　　【使用方法与帮助】　　　　　　　　　　　　　　　　　　　　　　     　 ┃
echo ┃　　1. 请先将手机与电脑连接到同一个网络（路由器）中。　　　　         　　┃
echo ┃　　2. 如果您的电脑中安装有防火墙软件，建议关闭或者允许本软件联网。       ┃
echo ┃　　3. 将泄露版升级包复制到本软件根目录当中，并命名为 update.zip　文件。  ┃
echo ┃　　4. 在接下来的界面中请按照提示进行操作。                               ┃
echo ┃　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　┃
echo ┠┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┨
echo ┃　　　　　　　　　　　　　   　请输入相应数字并按回车: [1] 继续  [2] 退出 ┃
echo ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
echo.
set /p keydown="请输入相应数字并按回车:> "
if "%keydown%"=="1" goto :HwOUC_Server_Startup
if "%keydown%"=="2" goto :HwOUC_Server_Stop_and_Exit
echo 【错误】 您的操作有误，将在 3 秒后返回重试。
ping 127.1 -n 2 >NUL
goto HwOUC_Main_Menu

:HwOUC_Server_Startup
cls
echo ================================================================================
echo                          华为终端 OTA 升级模拟服务器
echo.
echo ================================================================================
echo 请根据下面提示逐步操作，每步完成请按回车继续：
echo -----------------------------------------------
echo.
set /p wait=[1] 请将 precheck-script 与 update.zip 放在本目录 
set /p wait=[2] 请将您手机的 DNS 服务器地址设置为：%localIp% 
set /p currentVer=[3] 请输入您即将升级的版本（如 CHM-TL00C00B551）：
set /p ruok=[4] 请确认以上两条信息正确无误（输入 emui 回车确认）：
echo.
echo.
if "%ruok%"=="emui" goto :Hw_Server_IAmOk
echo.
echo 【错误】 您输入的确认信息不是 emui，您已放弃操作，3 秒后返回主界面。
ping 127.1 -n 3 >NUL
goto :HwOUC_Main_Menu
exit

:Hw_Server_IAmOk
echo 程序正在开始启动，请耐心等待启动完成
echo -----------------------------------------------
echo.
echo [1] 正在清空程序以前历史记录 ...
call %~dp0\usr\clean.bat
ping 127.1 -n 2 >NUL

echo [2] 从模板生成 OTA 升级信息文件 ...
%~dp0\usr\iconvsed\iconv -f utf-8 -t gb2312 %~dp0\full\template\HwOUC_Response.json > %~dp0\full\HwOUC_Response.json.gb2312
%~dp0\usr\iconvsed\iconv -f utf-8 -t gb2312 %~dp0\full\template\changelog.xml > %~dp0\full\changelog.xml.gb2312
%~dp0\usr\iconvsed\sed -i "s/hwouc_dest_version/%currentVer%/g" %~dp0\full\HwOUC_Response.json.gb2312
%~dp0\usr\iconvsed\sed -i "s/hwouc_dest_version/%currentVer%/g" %~dp0\full\changelog.xml.gb2312
%~dp0\usr\iconvsed\iconv -t utf-8 -f gb2312 %~dp0\full\HwOUC_Response.json.gb2312 > %~dp0\full\HwOUC_Response.json
%~dp0\usr\iconvsed\iconv -t utf-8 -f gb2312 %~dp0\full\changelog.xml.gb2312 > %~dp0\full\changelog.xml
ping 127.1 -n 2 >NUL

echo [3] 正在移动相关文件 ...
move /y %~dp0\precheck-script %~dp0\full\ >nul 2>nul
move /y %~dp0\update.zip %~dp0\full\ >nul 2>nul

echo [4] 正在计算文件 MD5 校验码并保存 ...
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

echo [5] 正在清理产生的临时文件 ...
del %~dp0\full\*.gb2312 /f /q >nul 2>nul
del %~dp0\????????? /f /q >nul 2>nul
ping 127.1 -n 2 >NUL

echo [6] 正在启动相关服务 ...
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
echo [7] OTA 服务器启动完成!
ping 127.1 -n 2 >NUL
goto :HwOUC_Server_Waiting
exit

:HwOUC_Server_Waiting
cls
echo ================================================================================
echo                          华为终端 OTA 升级模拟服务器
echo.
echo ================================================================================
echo 重要信息：当前 OTA 升级服务器正在运行，请勿关闭窗口，否则可能引起系统更新失败！
echo --------------------------------------------------------------------------------
set /p ruok=若要退出请输入 exit 并回车：
if "%ruok%"=="exit" goto :HwOUC_Server_Stop_and_Exit
goto :HwOUC_Server_Waiting

:HwOUC_Server_Stop_and_Exit
echo.
echo.
echo.
echo 程序正在准备退出，请勿中途关闭本窗口！
echo -----------------------------------------------
echo.
echo [1] 正在关闭并情况临时文件 ...
call %~dp0\usr\clean.bat
del %~dp0\full\*.gb2312 /f /q >nul 2>nul
del %~dp0\full\*.xml /f /q >nul 2>nul
del %~dp0\full\*.json /f /q >nul 2>nul
del %~dp0\????????? /f /q >nul 2>nul
ping 127.1 -n 2 >NUL

echo [2] 正在还原 ROM 文件 ...
move /y %~dp0\full\update.zip %~dp0\ >nul 2>nul
move /y %~dp0\full\precheck-script %~dp0\ >nul 2>nul

echo [3] OTA 服务器已经成功关闭，请按任意键退出
pause >nul 2>nul
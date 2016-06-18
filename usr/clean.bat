@echo off
taskkill /f /im nginx-hwouc.exe >nul 2>nul
taskkill /f /im DNSAgent.exe >nul 2>nul
del %~dp0\httpd\logs\* /s /q /f >nul 2>nul
del %~dp0\httpd\conf\localhost.vhost /s /q /f >nul 2>nul
del %~dp0\named\rules.cfg /s /q /f >nul 2>nul
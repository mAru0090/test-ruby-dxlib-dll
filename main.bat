@echo off
setlocal
set PATH=%~dp0system\bin;%PATH%
set NERI_EXECUTABLE=%~0
cd /d "%~dp0"
if %~x0 == .exe ( shift )
ruby.exe -rneri  --disable-did_you_mean -e "# coding:utf-8" -e "load File.expand_path('system/' + [109,97,105,110,46,114,98].pack('U*'))"  %1 %2 %3 %4 %5 %6 %7 %8 %9
echo.
pause
endlocal

@echo off
setlocal
set "COREEXT=.\system\lib\ruby\3.3.0\rubygems\core_ext\"
if not exist "%COREEXT%" (
	mkdir %COREEXT%
)
xcopy "E:\windows\dev-tools\Ruby33-x64\lib\ruby\3.3.0\rubygems\core_ext\" %COREEXT%  /E /I /H /Y
neri main.rb dxlib_const_variables.rb dxlib_ffi.rb dxlib.rb
endlocal

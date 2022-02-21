SET PLATFORM=Win32
SET CONFIG=Debug

IF NOT "%1"=="" SET PLATFORM=%1
IF NOT "%2"=="" SET CONFIG=%2

msbuild -p:Platform=%PLATFORM% -p:Configuration=%CONFIG%
if errorlevel 1 exit /b errorlevel

call TestAll.cmd %PLATFORM% %CONFIG%

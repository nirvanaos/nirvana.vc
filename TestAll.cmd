SET PLATFORM=Win32
SET CONFIG=Debug

IF NOT "%1"=="" SET PLATFORM=%1
IF NOT "%2"=="" SET CONFIG=%2

%PLATFORM%\%CONFIG%\TestLibrary.exe --gtest_output=xml:TestLibrary.%PLATFORM%.%CONFIG%.xml
%PLATFORM%\%CONFIG%\TestORB.exe --gtest_output=xml:TestORB.%PLATFORM%.%CONFIG%.xml
%PLATFORM%\%CONFIG%\TestSTL.exe --gtest_output=xml:TestSTL.%PLATFORM%.%CONFIG%.xml
%PLATFORM%\%CONFIG%\TestWindowsAPI.exe --gtest_output=xml:TestWindowsAPI.%PLATFORM%.%CONFIG%.xml
%PLATFORM%\%CONFIG%\TestWindows.exe --gtest_output=xml:TestWindows.%PLATFORM%.%CONFIG%.xml
%PLATFORM%\%CONFIG%\TestCore.exe --gtest_output=xml:TestCore.%PLATFORM%.%CONFIG%.xml
%PLATFORM%\%CONFIG%\Nirvana.exe -s TestProcess.nex --gtest_catch_exceptions=0 --gtest_output=xml:TestProcess.%PLATFORM%.%CONFIG%.xml

SET PLATFORM=Win32
SET CONFIG=Debug

IF NOT "%1"=="" SET PLATFORM=%1
IF NOT "%2"=="" SET CONFIG=%2
IF NOT "%3"=="" SET CONFIG=%2 %3

cd "%PLATFORM%\%CONFIG%"
TestLibrary.exe "--gtest_output=xml:..\..\TestLibrary.%PLATFORM%.%CONFIG%.xml"
TestORB.exe "--gtest_output=xml:..\..\TestORB.%PLATFORM%.%CONFIG%.xml"
TestSTL.exe "--gtest_output=xml:..\..\TestSTL.%PLATFORM%.%CONFIG%.xml"
TestWindowsAPI.exe "--gtest_output=xml:..\..\TestWindowsAPI.%PLATFORM%.%CONFIG%.xml"
TestWindows.exe "--gtest_output=xml:..\..\TestWindows.%PLATFORM%.%CONFIG%.xml"
TestCore.exe "--gtest_output=xml:..\..\TestCore.%PLATFORM%.%CONFIG%.xml"
Nirvana.exe -s TestProcess.nex --gtest_catch_exceptions=0 "--gtest_output=xml:..\..\TestProcess.%PLATFORM%.%CONFIG%.xml"
cd ..\..

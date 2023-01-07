SET PLATFORM=Win32
SET CONFIG=Debug

IF NOT "%1"=="" SET PLATFORM=%1
IF NOT "%2"=="" SET CONFIG=%2
IF NOT "%3"=="" SET CONFIG=%2 %3

echo Count of processors: %NUMBER_OF_PROCESSORS%
echo on

cd "%PLATFORM%\%CONFIG%"
TestLibrary.exe "--gtest_output=xml:..\..\TestLibrary.%PLATFORM%.%CONFIG%.xml"
TestORB.exe "--gtest_output=xml:..\..\TestORB.%PLATFORM%.%CONFIG%.xml"
TestSTL.exe "--gtest_output=xml:..\..\TestSTL.%PLATFORM%.%CONFIG%.xml"
TestWindowsAPI.exe "--gtest_output=xml:..\..\TestWindowsAPI.%PLATFORM%.%CONFIG%.xml"
TestWindows.exe "--gtest_output=xml:..\..\TestWindows.%PLATFORM%.%CONFIG%.xml"
rem TestCore.exe "--gtest_output=xml:..\..\TestCore.%PLATFORM%.%CONFIG%.xml"

start "" /b "..\..\x64\%CONFIG%\Nirvana.exe" -s

ping -n 1 127.0.0.1

time /t
Nirvana.exe TestProcess.nex --gtest_catch_exceptions=0 "--gtest_output=xml:..\..\TestProcess.%PLATFORM%.%CONFIG%.xml"
time /t
Nirvana.exe TestSystem.nex --gtest_catch_exceptions=0 "--gtest_output=xml:..\..\TestSystem.%PLATFORM%.%CONFIG%.xml"
time /t
Nirvana.exe TestFixed.nex --gtest_catch_exceptions=0 "--gtest_output=xml:..\..\TestFixed.%PLATFORM%.%CONFIG%.xml"
time /t
Nirvana.exe -d
cd ..\..

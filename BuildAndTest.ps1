if ($args.count -ge 1) {
	$platform = $args[0]
} else {
	$platform = "x64"
}
if ($args.count -ge 1) {
	$config = $args[1]
} else {
	$config = "Debug 2022"
}

msbuild -p:Platform="$platform" -p:Configuration="$config"

cd "$platform\\$config"

#.\TestLibrary.exe "--gtest_output=xml:..\..\TestLibrary.$platform.$config.xml"
#.\TestORB.exe "--gtest_output=xml:..\..\TestORB.$platform.$config.xml"
#.\TestSTL.exe "--gtest_output=xml:..\..\TestSTL.$platform.$config.xml"
#.\TestWindowsAPI.exe "--gtest_output=xml:..\..\TestWindowsAPI.$platform.$config.xml"
#.\TestWindows.exe "--gtest_output=xml:..\..\TestWindows.$platform.$config.xml"
#.\TestCore.exe "--gtest_output=xml:..\..\TestCore.$platform.$config.xml"

Start-Process -FilePath "..\..\x64\$config\Nirvana.exe" -ArgumentList "-s"
Start-Sleep -Seconds 1

Start-Process -Wait -FilePath ".\Nirvana.exe" -ArgumentList "TestProcess.nex --gtest_catch_exceptions=0 `"--gtest_output=xml:..\..\TestProcess.$platform.$config.xml`""
Start-Process -Wait -FilePath ".\Nirvana.exe" -ArgumentList "TestSystem.nex --gtest_catch_exceptions=0 `"--gtest_output=xml:..\..\TestSystem.$platform.$config.xml`""
Start-Process -Wait -FilePath ".\Nirvana.exe" -ArgumentList "TestFixed.nex --gtest_catch_exceptions=0 `"--gtest_output=xml:..\..\TestFixed.$platform.$config.xml`""

Start-Process -Wait -FilePath ".\Nirvana.exe" -ArgumentList "-d"

cd ..\..

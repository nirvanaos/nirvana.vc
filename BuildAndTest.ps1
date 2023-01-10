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

Write-Host "=== Start tests. Processor count:"(Get-ComputerInfo).CsNumberOfLogicalProcessors

cd "$platform\\$config"

$test_result="..\..\test-results\$platform.$config"

.\TestLibrary.exe "--gtest_output=xml:$test_result.TestLibrary.xml"
.\TestORB.exe "--gtest_output=xml:$test_result.TestORB.xml"
.\TestSTL.exe "--gtest_output=xml:$test_result.TestSTL.xml"
.\TestWindowsAPI.exe "--gtest_output=xml:$test_result.TestWindowsAPI.xml"
.\TestWindows.exe "--gtest_output=xml:$test_result.TestWindows.xml"
#.\TestCore.exe "--gtest_output=xml:$test_result.TestCore.xml"

Start-Process -NoNewWindow -FilePath "..\..\x64\$config\Nirvana.exe" -ArgumentList "-s"
Start-Sleep -Seconds 2

Start-Process -Wait -NoNewWindow -FilePath ".\Nirvana.exe" -ArgumentList "TestProcess.nex --gtest_catch_exceptions=0 `"--gtest_output=xml:$test_result.TestProcess.xml`""
Start-Process -Wait -NoNewWindow -FilePath ".\Nirvana.exe" -ArgumentList "TestSystem.nex --gtest_catch_exceptions=0 `"--gtest_output=xml:$test_result.TestSystem.xml`""
Start-Process -Wait -NoNewWindow -FilePath ".\Nirvana.exe" -ArgumentList "TestFixed.nex --gtest_catch_exceptions=0 `"--gtest_output=xml:$test_result.TestFixed.xml`""

Start-Process -Wait -NoNewWindow -FilePath ".\Nirvana.exe" -ArgumentList "-d"

cd ..\..

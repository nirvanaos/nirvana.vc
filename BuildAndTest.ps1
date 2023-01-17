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

$ErrorActionPreference = "Stop"

msbuild -p:Platform="$platform" -p:Configuration="$config"

Write-Host "=== Start tests. Processor count:"(Get-ComputerInfo).CsNumberOfLogicalProcessors

cd "$platform\\$config"

$test_result="..\..\test-results\$platform.$config"

#.\TestLibrary.exe "--gtest_output=xml:$test_result.TestLibrary.xml"
#.\TestORB.exe "--gtest_output=xml:$test_result.TestORB.xml"
#.\TestSTL.exe "--gtest_output=xml:$test_result.TestSTL.xml"
#.\TestWindowsAPI.exe "--gtest_output=xml:$test_result.TestWindowsAPI.xml"
#.\TestWindows.exe "--gtest_output=xml:$test_result.TestWindows.xml"
#.\TestCore.exe "--gtest_output=xml:$test_result.TestCore.xml"

$appdata = [Environment]::GetFolderPath('CommonApplicationData')

Write-Host "Start Nirvana"
$sysdomain = (Start-Process -NoNewWindow -PassThru -FilePath "..\..\x64\$config\Nirvana.exe" -ArgumentList "-s")
$handle = $sysdomain.Handle # Hold process handle
Write-Host "System domain id:"$sysdomain.Id

$started = $false
for ($i = 0; $i -lt 4; $i++) {
	Start-Sleep -Seconds 1
	if (Test-Path "$appdata\Nirvana\Nirvana\sysdomainid") {
		$started = (Get-Item "$appdata\Nirvana\Nirvana\sysdomainid").length -eq 4
		if ($started)
		{
			break;
		}
	}
}
if ($started) {
	Write-Host "Nirvana started"
} else {
	Write-Host "Nirvana start failed"
	Exit
}

Start-Process -Wait -NoNewWindow -FilePath ".\Nirvana.exe" -ArgumentList "TestProcess.nex --gtest_catch_exceptions=0 `"--gtest_output=xml:$test_result.TestProcess.xml`""
#Start-Process -Wait -NoNewWindow -FilePath ".\Nirvana.exe" -ArgumentList "TestSystem.nex --gtest_catch_exceptions=0 `"--gtest_output=xml:$test_result.TestSystem.xml`""
#Start-Process -Wait -NoNewWindow -FilePath ".\Nirvana.exe" -ArgumentList "TestFixed.nex --gtest_catch_exceptions=0 `"--gtest_output=xml:$test_result.TestFixed.xml`""

Write-Host "Stop Nirvana"
Start-Process -Wait -NoNewWindow -FilePath ".\Nirvana.exe" -ArgumentList "-d"

cd ..\..

$sysdomain.WaitForExit()
Write-Host "System domain exit code:" $sysdomain.ExitCode

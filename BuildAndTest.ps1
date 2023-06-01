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

msbuild -m -p:Platform="$platform" -p:Configuration="$config"

Write-Host "=== Start tests. Processor count:"(Get-ComputerInfo).CsNumberOfLogicalProcessors

cd "$platform\\$config"

$test_result="..\..\test-results\$platform.$config"

.\TestLibrary.exe "--gtest_output=xml:$test_result.TestLibrary.xml"
.\TestORB.exe "--gtest_output=xml:$test_result.TestORB.xml"
.\TestSTL.exe "--gtest_output=xml:$test_result.TestSTL.xml"
.\TestWindowsAPI.exe "--gtest_output=xml:$test_result.TestWindowsAPI.xml"
.\TestWindows.exe "--gtest_output=xml:$test_result.TestWindows.xml"
.\TestCore.exe "--gtest_output=xml:$test_result.TestCore.xml"

$appdata = [Environment]::GetFolderPath('CommonApplicationData') + "\Nirvana\Nirvana"

if (($platform -eq "Win32") -and -not ($config -like "* LLVM")) {
	$system_path = "..\..\x64\$config"
} else {
	$system_path = "."
}
Write-Host "Start Nirvana from "$system_path
$sysdomain = (Start-Process -NoNewWindow -PassThru -FilePath $system_path"\Nirvana.exe" -ArgumentList "-s")
$handle = $sysdomain.Handle # Hold process handle
Write-Host "System domain id:"$sysdomain.Id

$started = $false
for ($i = 0; $i -lt 4; $i++) {
	Start-Sleep -Seconds 1
	if (Test-Path "$appdata\sysdomainid") {
		$started = (Get-Item "$appdata\sysdomainid").length -eq 4
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

Start-Process -Wait -NoNewWindow -FilePath ".\Nirvana.exe" -ArgumentList "TestProcess.nex `"--gtest_output=xml:$test_result.TestProcess.xml`""
Start-Process -Wait -NoNewWindow -FilePath ".\Nirvana.exe" -ArgumentList "TestSystem.nex `"--gtest_output=xml:$test_result.TestSystem.xml`""
Start-Process -Wait -NoNewWindow -FilePath ".\Nirvana.exe" -ArgumentList "TestFixed.nex `"--gtest_output=xml:$test_result.TestFixed.xml`""

Write-Host "Stop Nirvana"
Start-Process -Wait -NoNewWindow -FilePath ".\Nirvana.exe" -ArgumentList "-d"

cd ..\..

if ($sysdomain.WaitForExit(1000)) {
	Write-Host "System domain exit code:" $sysdomain.ExitCode
} else {
	Write-Host "Nirvana has not exited, kill"
	$sysdomain.Kill()
	Write-Host "Killed"
}

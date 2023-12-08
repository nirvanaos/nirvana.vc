if ($args.count -ge 1) {
	$platform = $args[0]
} else {
	$platform = "x64"
}
if ($args.count -ge 2) {
	$config = $args[1]
} else {
	$config = "Debug 2022"
}

$ErrorActionPreference = "Stop"

Write-Host "=== Start tests. Processor count:"(Get-ComputerInfo).CsNumberOfLogicalProcessors

$test_result=$PSScriptRoot + "\test-results\$platform.$config"

$appdata = [Environment]::GetFolderPath('CommonApplicationData') + "\Nirvana\Nirvana"

if (($platform -eq "Win32") -and -not ($config -like "* LLVM")) {
	cd "x64\\$config\\x86"
	$system_path = ".."
} else {
	cd "$platform\\$config"
	$system_path = "."
}
Write-Host "Start Nirvana from "$system_path
$sysdomain = (Start-Process -NoNewWindow -PassThru -FilePath $system_path"\Nirvana.exe" -WorkingDirectory $system_path -ArgumentList "-s")
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

cd $PSScriptRoot

if ($sysdomain.WaitForExit(1000)) {
	Write-Host "System domain exit code:" $sysdomain.ExitCode
} else {
	Write-Host "Nirvana has not exited, kill"
	$sysdomain.Kill()
	Write-Host "Killed"
}

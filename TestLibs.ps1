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

cd "$platform\\$config"

$test_result="..\..\test-results\$platform.$config"

.\TestLibrary.exe "--gtest_output=xml:$test_result.TestLibrary.xml"
.\TestORB.exe "--gtest_output=xml:$test_result.TestORB.xml"
.\TestSTL.exe "--gtest_output=xml:$test_result.TestSTL.xml"
.\TestWindowsAPI.exe "--gtest_output=xml:$test_result.TestWindowsAPI.xml"
.\TestWindows.exe "--gtest_output=xml:$test_result.TestWindows.xml"

cd ..\..

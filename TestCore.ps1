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

msbuild -m -p:Platform="$platform" -p:Configuration="$config" -target:Core\TestCore

cd "$platform\\$config"

$test_result="..\..\test-results\$platform.$config"

.\TestCore.exe "--gtest_output=xml:$test_result.TestCore.xml"

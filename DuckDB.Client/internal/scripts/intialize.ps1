# Commands run on module import go here
# E.g. Argument Completers could be placed here

if ($PSVersionTable.Major -lt 6 -or $IsWindows) {
	if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') {
		$dllPath = Join-Path -Path $script:ModuleRoot -ChildPath 'bin/win-arm64/DuckDB.NET.Data.dll'
	}
	else {
		$dllPath = Join-Path -Path $script:ModuleRoot -ChildPath 'bin/win-x64/DuckDB.NET.Data.dll'
	}
}
elseif ($IsMacOS) {
	$dllPath = Join-Path -Path $script:ModuleRoot -ChildPath 'bin/osx/DuckDB.NET.Data.dll'
}
else {
	if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') {
		$dllPath = Join-Path -Path $script:ModuleRoot -ChildPath 'bin/win-arm64/DuckDB.NET.Data.dll'
	}
	else {
		$dllPath = Join-Path -Path $script:ModuleRoot -ChildPath 'bin/win-x64/DuckDB.NET.Data.dll'
	}
}
Add-Type -Path $dllPath
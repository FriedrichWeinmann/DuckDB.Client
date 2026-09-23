function New-DuckDBConnection {
	<#
		.SYNOPSIS
			Creates a connection to a DuckDB database.

		.DESCRIPTION
			Creates a DuckDB connection for each supplied database path and returns the connections without opening them.
			Use the returned connections to run queries against in-memory or file-based DuckDB databases.

			For example, run queries/commands using the .Query(<string>) method.

		.PARAMETER Path
			The path to each DuckDB database file to connect to. Specify ':memory:' to create an in-memory database.

			Defaults to: :memory:

		.EXAMPLE
			PS C:\> $connection = New-DuckDBConnection -Path 'C:\Data\sales.duckdb'

			Creates and returns a connection to the DuckDB database stored at C:\Data\sales.duckdb.
	#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
	[OutputType([DuckDB.NET.Data.DuckDBConnection])]
	[CmdletBinding()]
	param (
		[string[]]
		$Path = ':memory:'
	)

	process {
		foreach ($entry in $Path) {
			try { [DuckDB.NET.Data.DuckDBConnection]::new("Data Source=$entry") }
			catch { Write-Error -ErrorRecord $_ }
		}
	}
}
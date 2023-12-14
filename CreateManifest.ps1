# FUNCTION: CreateManifest.
# PURPOSE: Create the manifest file for a PowerShell module.
# EXAMPLE: CreateManifest $ModulePath
# INPUTS: The path to the file for which you wish to generate a manifest.
# RETURN: A new manifest file.

function CreateManifest{

	param(
 		[Parameter(Mandatory=$true,HelpMessage="The PowerShell module for which you wish to generate a manifest file.")][Alias("m")][string]$ModulePath
 	)

	$Manifest =@{
		Path = "$ModulePath.psd1"
		RootModule = "$($(get-item $ModulePath).Name).psm1"
		ModuleVersion = $Config.Version
		Author = $Config.Author
		CompanyName = $Config.CompanyName
		Copyright = "$(get-date -f yyyy) $Config.Copyright"
		FunctionsToExport = $(select-string -path $ModulePath -pattern "export-modulemember -function ")
		Description = $(select-string -path $ModulePath -pattern ".DESCRIPTION ")
		HelpInfoURI = $Config.HelpInfoUri
	}

	New-ModuleManifest @Manifest
}
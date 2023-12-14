# FUNCTION: GetModuleInstallationDirectory.
# PURPOSE: Fetch the path for PowerShell module installation.
# EXAMPLE: GetModuleInstallationDirectory
# INPUTS: None.
# RETURN: The Windows filepath for PowerShell module installation.

function GetModuleInstallationDirectory{

	try{
		$InstallationDirectory = $($env:PSModulePath -split ';' -like "*WindowsPowerShell\v1.0\Modules\*")
	}
	catch{
		return $false
	}

	return $InstallationDirectory
}
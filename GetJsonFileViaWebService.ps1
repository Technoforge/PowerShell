# FUNCTION: GetJsonFileViaWebService.
# PURPOSE: Fetch a Json file via web service request with TLS 1.2 security.
# EXAMPLE: GetJsonFileViaWebService $FileLocation
# INPUTS: A file location over the internet or intranet.
# RETURN: A Json file as an object.

function GetJsonFileViaWebService{

	# The parameter should be the location of a Json file over the intranet/internet.
	param(
		[Parameter(Mandatory=$true, ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName="JsonFileLocation", HelpMessage="This should be a JSON file location over some network via https, example https://my.network.com/myfile.json.")][Alias("url", "uri", "u", "l")][string]$FileLocation
	)

	try{
		[Net.ServicePointManaager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
		$JsonFile = invoke-webrequest $FileLocation | ConvertFrom-Json
	}
	catch{
		return $false
	}

	return $JsonFile
}
# FUNCTION: GetJsonFileContent.
# PURPOSE: Load a Json file and return the contents.
# EXAMPLE: GetJsonFileContent .\TestFile.json
# INPUTS: A string which is a filepath.
# RETURN: The contents of the Json file.

function GetJsonFileContent{
	# Function parameters:
	# Filepath or f: The path to the Json file to use.

	param(
		[Parameter(Mandatory=$true, Position=0, ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName="JsonFile", HelpMessage="The filepath to the Json file you want to use.")][Alias("f")][string]$FilePath
	)

	# Import the Json file.
	try{
		$JsonFileContents = (get-content -raw $FilePath | convertfrom-json)
	}
	catch{
		return $false
	}

	# Example of how to reference each object.
	#foreach($Object in $JsonFileContents){
	# write-host "Field name: $($Object.Name)"
	# write-host "Field type: $($Object.Type)"
	# write-host "Field length: $($Object.Length)"
	#}
	#Or:
	#$JsonFileContents.Item(0)
	#$JsonFileContents.Item(1)
	#$JsonFileContents.Item(2)

	return $JsonFileContents
}
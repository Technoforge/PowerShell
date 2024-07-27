# FUNCTION: CheckCertificatesExpiration.
# PURPOSE: Obtain a list of certificates which will expire within the next N days.
# EXAMPLE: CheckCertificatesExpiration -d 60
# INPUTS: An integer indicating the number of days ahead to check.
# RETURN: A list of certificates which will expire within the next 60 days.


function CheckCertificatesExpiration{

    param(
		[Parameter(Mandatory=$true, 
                    Position=0, 
                    ValueFromPipeline, 
                    ValueFromPipelineByPropertyName, 
                    ParameterSetName="CertificateExpiration", 
                    HelpMessage="The number of days ahead to check, eg the next 50 days."
                    )]
        [Alias("d")]
        [int]$Days
	)

	# Get the certificates data.
	try{
        Get-ChildItem -path cert:\LocalMachine\My | 
        Select-Object NotAfter, friendlyName, Subject, Thumbprint | 
        where { $_.notafter -le (get-date).AddDays($Days) -AND $_.notafter -gt (get-date)} | 
        sort-object NotAfter
	}
	catch{
		return $false
	}


}

#Example use:
CheckCertificatesExpiration -d 50000
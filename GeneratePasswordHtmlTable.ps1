# FUNCTION: GeneratePasswordHtmlTable.
# PURPOSE: Create an HTML page with a table of random characters for setting and memorising your password. You just think of some keyword, then map that keyword against the table characters to obtain a password.
# EXAMPLE: GeneratePasswordHtmlTable $PasswordLength
# INPUTS: The length (integer) of the password or passphrase.
# RETURN: A new HTML OutputFile with a table of jumbled characters.

function GeneratePasswordHtmlTable{

	param(
 		[Parameter(Mandatory=$true,HelpMessage="The PowerShell module for which you wish to generate a manifest OutputFile  .")][Alias("m")][int]$PasswordLength
 	)

	$PasswordLength   = 14
	$OutputFile = "$(get-date -f yyyy-MM-dd-HH-mm-ss).html"
	$Style = 'style="border: 1px solid black;"'

	try{
		$HtmlTop = '<html><head><style>table{text-align: center; width: 90%; margin-left: auto; margin-right: auto;}table,tr,th,td{border:1px black solid;}tr:nth-of-type(odd){background-color: #cccccc;}tr:nth-of-type(even){background-color: #eeeeee;}</style></head><body><h1>Password characters table</h2><p>Use your keyword to select each character of your password in numerical order.</p><table><tr><th>&nbsp;</th><th>A</th><th>B</th><th>C</th><th>D</th><th>E</th><th>F</th><th>G</th><th>H</th><th>I</th><th>J</th><th>K</th><th>L</th><th>M</th><th>N</th><th>O</th><th>P</th><th>Q</th><th>R</th><th>S</th><th>T</th><th>U</th><th>V</th><th>W</th><th>X</th><th>Y</th><th>Z</th></tr>'

		add-content -path $OutputFile -value $HtmlTop  

		for($i = 1; $i -le $PasswordLength; $i++){
			add-content -path $OutputFile -value "<tr><td><strong>$i</strong></td>"
			for($j = 1; $j -le 26; $j++){
				$RandomString = "abcdefghijkmnopqrstuvwxyzABCEFGHJKLMNPQRSTUVWXYZ23456789!@#$%^&*()_+-=[]{}|\;:<>,./?".ToCharArray() | Get-Random -Count 1
				add-content -path $OutputFile -value "<td>$RandomString</td>"
	    		}
	    		add-content -path $OutputFile   -value "</tr>"
		}

		$HtmlBottom = '</table></body></html>'
		add-content -path $OutputFile -value $HtmlBottom 
	}
	catch{
		return $false
	}
}

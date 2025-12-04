# SCRIPT: Diffie-Hellman-example.ps1
# PURPOSE: Demonstrate an understanding of the Diffie-Hellman key exchange.

##########################################################################################################

# GLOBAL VARIABLES
$Throttle = 21
$Player1name = "Megatron"
$Player2name = "Starscream"

$PrimeP = 0       # Shared large prime
$GeneratorG = 0   # Shared generator
$PrivateA = 0     # Player1 private key
$PrivateB = 0     # Player2 private key
$PublicA = 0      # Player1 public value
$PublicB = 0      # Player2 public value
$Secret1 = 0      # Megatron’s derived shared key
$Secret2 = 0      # Starscream’s derived shared key

##########################################################################################################
# PRIME CHECK FUNCTION

function Check-If-Number-Is-Prime {
    param([int]$CandidateInteger)

    if ($CandidateInteger -lt 2) { return $false }

    for ($i = 2; $i -le [math]::Sqrt($CandidateInteger); $i++) {
        if ($CandidateInteger % $i -eq 0) {
            return $false
        }
    }
    return $true
}

##########################################################################################################
# PRIME GENERATOR FUNCTION

function Generate-Prime-Number {
    param(
        [int]$Min,
        [int]$Max
    )

    if ($Min -lt 2 -or $Min -ge $Max) {
        throw "Min must be >=2 and < Max."
    }

    do {
        $Candidate = Get-Random -Minimum $Min -Maximum $Max
    } while (-not (Check-If-Number-Is-Prime $Candidate))

    return $Candidate
}

##########################################################################################################
# RANDOM INTEGER FUNCTION

function Generate-Random-Integer {
    param(
        [int]$Min,
        [int]$Max
    )
    if ($Min -lt 1) { throw "Min must be >= 1." }
    if ($Max -le $Min) { throw "Max must be > Min." }

    return (Get-Random -Minimum $Min -Maximum $Max)
}

##########################################################################################################
# MAIN – DIFFIE HELLMAN DEMO

Write-Host "`n Diffie-Hellman exchange demo`n"

# 1. Generate prime modulus p
$PrimeP = Generate-Prime-Number -Min 11 -Max $Throttle
Write-Host "Shared prime modulus p = $PrimeP"

# 2. Generate generator g (just a small random number for demo)
$GeneratorG = Generate-Random-Integer -Min 2 -Max ($PrimeP - 1)
Write-Host "Shared generator g = $GeneratorG"

# 3. Generate private keys
$PrivateA = Generate-Random-Integer -Min 2 -Max $Throttle
$PrivateB = Generate-Random-Integer -Min 2 -Max $Throttle
Write-Host "`nPrivate keys:"
Write-Host "  $Player1name private key a = $PrivateA"
Write-Host "  $Player2name private key b = $PrivateB"

# 4. Generate public keys A = g^a mod p, B = g^b mod p
$PublicA = [System.Numerics.BigInteger]::ModPow($GeneratorG, $PrivateA, $PrimeP)
$PublicB = [System.Numerics.BigInteger]::ModPow($GeneratorG, $PrivateB, $PrimeP)

Write-Host "`nPublic values exchanged:"
Write-Host "  $Player1name sends A = $PublicA"
Write-Host "  $Player2name sends B = $PublicB"

# 5. Compute shared secret
$Secret1 = [System.Numerics.BigInteger]::ModPow($PublicB, $PrivateA, $PrimeP)
$Secret2 = [System.Numerics.BigInteger]::ModPow($PublicA, $PrivateB, $PrimeP)

Write-Host "`nShared secret computation:"
Write-Host "  $Player1name computes s1 = $Secret1"
Write-Host "  $Player2name computes s2 = $Secret2"

Write-Host "`nFinal result:"
if ($Secret1 -eq $Secret2) {
    Write-Host "Shared secret MATCHES: $Secret1"
} else {
    Write-Host "ERROR — secrets do NOT match!"
}

Write-Host "`n"

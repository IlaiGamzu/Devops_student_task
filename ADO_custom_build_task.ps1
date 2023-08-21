param(
    [string]$ValueFromPipeline_1,
    [string]$ValueFromPipeline_2,
    [string]$ValueFromPipeline_3
)

# Diagnostic output
Write-Host "ValueFromPipeline_1 is: $ValueFromPipeline_1"
Write-Host "ValueFromPipeline_2 is: $ValueFromPipeline_2"
Write-Host "ValueFromPipeline_3 is: $ValueFromPipeline_3"

# Path to the AssemblyInfo.cs file
$assemblyInfoPath = Get-ChildItem "$PSScriptRoot\sort_list.AssemblyInfo.cs"

# Read the content of AssemblyInfo.cs
$content = Get-Content -Path $assemblyInfoPath
Write-Host "The content is :" $content

# Simplified regex patterns to match attributes
$pattern_des = '\[assembly: System\.Reflection\.AssemblyTitleAttribute\(".*?"\)\]'
$pattern_com = '\[assembly: System\.Reflection\.AssemblyCompanyAttribute\(".*?"\)\]'
$pattern_pro = '\[assembly: System\.Reflection\.AssemblyProductAttribute\(".*?"\)\]'
$pattern_ver = '\[assembly: System\.Reflection\.AssemblyVersionAttribute\("(\d+\.\d+\.\d+\.)(\d+)"\)\]'
#$pattern_ver_file  = '\[assembly: System\.Reflection\.AssemblyFileVersionAttribute\("(\d+\.\d+\.\d+\.)(\d+)"\)\]'
$pattern_test = '\[assembly: System\.Reflection\.AssemblyFileVersionAttribute\("(\d+)\.(\d+)\.(\d+)\.(\d+)"\)\]'


# Process each line from the file
$newContent = foreach ($line in $content) {
    Write-Host "Processing line: $line"
    
    switch ($true) {
        { $line -match $pattern_des } {
            '[assembly: System.Reflection.AssemblyTitleAttribute("{0}")]' -f $ValueFromPipeline_1
        }
        { $line -match $pattern_com } {
            '[assembly: System.Reflection.AssemblyCompanyAttribute("{0}")]' -f $ValueFromPipeline_2
        }
        { $line -match $pattern_pro } {
            '[assembly: System.Reflection.AssemblyProductAttribute("{0}")]' -f $ValueFromPipeline_3
        }
        { $line -match $pattern_ver } {
            
            $digit_not_changes = $matches[1]
            $lastDigit = [int]$matches[2] + 1
            $newVersion = "${digit_not_changes}$lastDigit"
            ('[assembly: System.Reflection.AssemblyVersionAttribute("{0}")]' -f $newVersion)
        }
        { $line -match $pattern_test } {
            # Check if the match happened
            Write-Host "Matched the line: $line"

            #$testLine = '[assembly: System.Reflection.AssemblyFileVersionAttribute("1.0.0.0")]'
            #if($testLine -match $pattern_test) {
                #Write-Host "Full match: $matches[0]"
                #Write-Host "First number: $matches[1]"
                #Write-Host "Second number: $matches[2]"
                #Write-Host "Third number: $matches[3]"
                #Write-Host "Fourth number: $matches[4]"
            #} else {
                #Write-Host "No match found!"
            #}
            $all=$matches[0]
            $firstPart = $matches[1]
            $secondPart = $matches[2]
            $thirdPart = $matches[3]
            $fourthPart = $matches[4]

            Write-Host "First number: $firstPart"
            Write-Host "Second number: $secondPart"
            Write-Host "Third number: $thirdPart"
            Write-Host "Fourth number: $fourthPart"

            #$baseVersion = $matches[1]
            #$lastDigit = [int]$matches[2] + 1
            #$newVersion = "${baseVersion}${lastDigit}"
            #$updatedLine = $line -replace "$baseVersion$matches[2]", $newVersion      
        }
        default { $line }
    }
}

# Save the modified content back to AssemblyInfo.cs
$newContent | Set-Content -Path $assemblyInfoPath

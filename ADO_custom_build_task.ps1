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

# Simplified regex patterns to match attributes
$pattern_des = '\[assembly: System\.Reflection\.AssemblyTitleAttribute\(".*?"\)\]'
$pattern_com = '\[assembly: System\.Reflection\.AssemblyCompanyAttribute\(".*?"\)\]'
$pattern_pro = '\[assembly: System\.Reflection\.AssemblyProductAttribute\(".*?"\)\]'
$pattern_ver = '\[assembly: System\.Reflection\.AssemblyVersionAttribute\("(\d+\.\d+\.\d+\.)\d+"\)\]'
$pattern_ver_file = '\[assembly: System\.Reflection\.AssemblyFileVersionAttribute\("(\d+\.\d+\.\d+\.)\d+"\)\]'

# Process each line from the file
$newContent = foreach ($line in $content) {
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
            '[assembly: System.Reflection.AssemblyVersionAttribute("{0}{1}")]' -f $digit_not_changes, $lastDigit
        }
        { $line -match $pattern_ver_file } {
            $digit_not_changes = $matches[1]
            $lastDigit = [int]$matches[2] + 1
            '[assembly: System.Reflection.AssemblyFileVersionAttribute("{0}{1}")]' -f $digit_not_changes, $lastDigit
        }
        default { $line }
    }
}

# Save the modified content back to AssemblyInfo.cs
$newContent | Set-Content -Path $assemblyInfoPath

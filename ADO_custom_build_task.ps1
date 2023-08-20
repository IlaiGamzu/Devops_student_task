# Path to the AssemblyInfo.cs file
#$assemblyInfoPath = "C:\C#_PROGRAM\Devops student task IAI\custom_student_task\copy_project_of_assemblyinfo.cs"
$assemblyInfoPath = $env:X = Get-Content -Path "$(Build.SourcesDirectory)\sort_list.AssemblyInfo.cs"

# Read the content of AssemblyInfo.cs
$content = Get-Content -Path $assemblyInfoPath
#$x_version=Get-Content -Path "$(Build.SourcesDirectory)\num_of_version.txt"
#$Version = "1.0.0.$x_version"
#$newValue = [int]$x_version + 1
#$newValueAsString = $newValue.ToString()
#Set-Content -Path "$(Build.SourcesDirectory)\num_of_version.txt" -value $newValueAsString
# Value to replace with from pipeline
param(
    [string]$ValueFromPipeline_1,
    [string]$ValueFromPipeline_2,
    [string]$ValueFromPipeline_3
)

# Define regex patterns to match AssemblyDescription and AssemblyCompany attributes
$pattern_des = '(\[assembly: System.Reflection.AssemblyTitleAttribute\("")]|(\[assembly: System.Reflection.AssemblyTitleAttribute\(")([^"]*)("\)\])'
$pattern_com = '(\[assembly: System.Reflection.AssemblyCompanyAttribute\("")]|(\[assembly: [assembly: System.Reflection.AssemblyCompanyAttribute\(")([^"]*)("\)\])'
$pattern_pro = '(\[assembly: System.Reflection.AssemblyProductAttribute\("")|(\[assembly: System.Reflection.AssemblyProductAttribute\(")([^"]*)("\)\])'
$pattern_ver = '(\[assembly: System.Reflection.AssemblyVersionAttribute\(")(\d+\.\d+\.\d+\.)(\d+)("\)\])'
$pattern_ver_file = '(\[assembly: System.Reflection.AssemblyFileVersionAttribute\(")(\d+\.\d+\.\d+\.)(\d+)("\)\])'
# Process each line from the file
$newContent = foreach ($line in $content) {
    if ($line -match $pattern_des) {
        $newLine_1 = $line -replace $pattern_des, ('[assembly: System.Reflection.AssemblyTitleAttribute("{0}")]' -f $ValueFromPipeline_1)
        $newLine_1
    }
    elseif ($line -match $pattern_com) {
        $newLine_2 = $line -replace $pattern_com, ('[assembly: System.Reflection.AssemblyCompanyAttribute("{0}")]' -f $ValueFromPipeline_2)
        $newLine_2
    }
    elseif ($line -match $pattern_pro) {
        $newLine_2 = $line -replace $pattern_pro, ('[assembly: System.Reflection.AssemblyProductAttribute("{0}")]' -f $ValueFromPipeline_3)
        $newLine_2
    }
    elseif($line -match $pattern_ver){
        $majorMinorBuild = $matches[2]
        $lastDigit = [int]$matches[3] + 1
        $newVersion = "${majorMinorBuild}$lastDigit"
        $newLine = $line -replace $pattern_ver, ('[assembly: System.Reflection.AssemblyVersionAttribute("{0}")]' -f $newVersion)
        $newLine
    }
    elseif($line -match $pattern_ver_file){
        $majorMinorBuild = $matches[2]
        $lastDigit = [int]$matches[3] + 1
        $newVersion = "${majorMinorBuild}$lastDigit"
        $newLine = $line -replace $pattern_ver_file, ('[assembly: System.Reflection.AssemblyFileVersionAttribute("{0}")]' -f $newVersion)
        $newLine
    }
    else {
        $line
    }
}

# Save the modified content back to AssemblyInfo.cs
$newContent | Set-Content -Path $assemblyInfoPath


# Get the directory where the script is located
$scriptDirectory = $PSScriptRoot

# Define the relative path to the AssemblyInfo.cs file
$assemblyInfoPattern = "AssemblyInfo.*.cs"
$directories = Get-ChildItem -Path $scriptDirectory -Recurse -Include $assemblyInfoPattern -Directory

foreach ($directory in $directories) {
    $assemblyInfoFiles = Get-ChildItem -Path $directory.FullName -Recurse -Include $assemblyInfoPattern
    foreach ($file in $assemblyInfoFiles) {
        $content = Get-Content -Path $file.FullName

        # Define regex patterns to match attributes
        $pattern_des = '(\[assembly: AssemblyDescription\("")|(\[assembly: AssemblyDescription\(")([^"]*)("\)\])'
        $pattern_com = '(\[assembly: AssemblyCompany\("")|(\[assembly: AssemblyCompany\(")([^"]*)("\)\])'
        $pattern_pro = '(\[assembly: AssemblyProduct\("")|(\[assembly: AssemblyCompany\(")([^"]*)("\)\])'
        $pattern_ver = '(\[assembly: AssemblyVersion\(")(\d+\.\d+\.\d+\.)(\d+)("\)\])'
        $pattern_ver_file = '(\[assembly: AssemblyFileVersion\(")(\d+\.\d+\.\d+\.)(\d+)("\)\])'

        $newContent = $content

        if ($content -match $pattern_des) {
            $newContent = $newContent -replace $pattern_des, ('[assembly: AssemblyDescription("{0}")]' -f $ValueFromPipeline_1)
        }
        
        if ($content -match $pattern_com) {
            $newContent = $newContent -replace $pattern_com, ('[assembly: AssemblyCompany("{0}")]' -f $ValueFromPipeline_2)
        }
        
        if ($content -match $pattern_pro) {
            $newContent = $newContent -replace $pattern_pro, ('[assembly: AssemblyProduct("{0}")]' -f $ValueFromPipeline_3)
        }
        
        if ($content -match $pattern_ver) {
            $majorMinorBuild = $matches[2]
            $lastDigit = [int]$matches[3] + 1
            $newVersion = "${majorMinorBuild}$lastDigit"
            $newContent = $newContent -replace $pattern_ver, ('[assembly: AssemblyVersion("{0}")]' -f $newVersion)
        }
        
        if ($content -match $pattern_ver_file) {
            $majorMinorBuild = $matches[2]
            $lastDigit = [int]$matches[3] + 1
            $newVersion = "${majorMinorBuild}$lastDigit"
            $newContent = $newContent -replace $pattern_ver_file, ('[assembly: AssemblyFileVersion("{0}")]' -f $newVersion)
        }

        $newContent | Set-Content -Path $file.FullName
    }
}

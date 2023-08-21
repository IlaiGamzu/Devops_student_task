# Devops_student_task

This project will expose my student task.


# CS Code:

The purpose: Sort lists of names from two files and put the result in sol_file. I used ArrayList to take the two contents of two files and sort them. The result will show in file_sol, a new list of names of the sort by alpha- beit. The result will output on screen.


# Custom Task:

I used ADO_custom_build_task.ps1 file to implement the mission. The ADO_custom_build_task.ps1 works that it moves on all assembly info of the files and change the details. 

In which iteration the assembly info will change by the next patterns:

$pattern_des = '\[assembly: System\.Reflection\.AssemblyTitleAttribute\(".*?"\)\]'

$pattern_com = '\[assembly: System\.Reflection\.AssemblyCompanyAttribute\(".*?"\)\]'

$pattern_pro = '\[assembly: System\.Reflection\.AssemblyProductAttribute\(".*?"\)\]'

$pattern_ver = '\[assembly: System\.Reflection\.AssemblyVersionAttribute\("(\d+\.\d+\.\d+\.)(\d+)"\)\]'

$pattern_ver_file = '\[assembly: System\.Reflection\.AssemblyFileVersionAttribute\("(\d+)\.(\d+)\.(\d+)\.(\d+)"\)\]'

The three first patterns I got from the task "Assembly-Info-NetCore@3", and the version number I got from the file num_of_version that in each run the number raise by one.


# Yaml Pipeline

The Yaml Pipeline get the source of files: sort_list.cs and ADO_custom_build_task.ps1 code and run them.

I use in the next tasks:

PowerShell@2- run power shell script of ADO_custom_build_task.ps1.

DotNetCoreCLI@2- run cs code that sort lists.

-scripts: that copy the result of cs code and custom task to a new files.

PublishBuildArtifacts@1- publish the result of cs code in file_sol.txt and the binary of ADO_custom_build_task.ps1 .


# Export pipeline- the result of task

The logs of pipeline in a zip file: logs_450.zip

The result of cs code the sort list and the binary code of custom task are in this folder


# The binary code

The logs of my pipeline publish the binary code of ADO_custom_build_task.ps1 file.

I upload this file to my repo: ADO_custom_build_task_base64.txt

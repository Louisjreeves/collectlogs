# collectlogs
Collectlogs with shacollector batch file GUI for log collecting 




## collectlogs

 How To Use: 
      From PowerShell as admin execute the following and follow the prompts:
```Powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;Invoke-Expression('$module="collectlogs";$repo="PowershellScripts"'+(new-object System.net.webclient).DownloadString('https://raw.githubusercontent.com/Louisjreeves/collectlogs/main/downcollect.ps1'));downcollect.ps1
```

# This Tool collects logs from single servers.   
![Collectgui1](https://github.com/Louisjreeves/collectlogs/assets/79279019/d63bf51e-7c76-41b0-ad4b-47d120502415)



# The second screen here is special in that the last field can be Empty for simple trace: Custom to choose custom test for special commands. 

Traces that make User Perfom collectors will accept an interaval. 

![2gui2](https://github.com/Louisjreeves/collectlogs/assets/79279019/bd8ae72c-d8ec-4357-86df-e2ffb765477c)


By the time you confirm your command, this application closes and you are getting direct feedback from the application. 

OUtput.txt will show you feedback from the actual applicaiton. 


Logs will stop themselves when done. 


#### USER GUIDE 

Perfmon Event Trace Guide
Saturday, July 22, 2023
8:53 AM
 
Thank you for purchasing Collect logs powered by shacollector.bat!
 
 
Basic Rules 
 
1.	Use the Simplest trace possible. Start and then go back in 30 minutes and stop is recommended. 
2.	Logs end up in C:\MSLOG when done
3.	Many Logs end up in $PSSCRIPTROOT\Start or Stop - Example c:\%username%\Downloads\Collectlogs\Start
4.	Logs are circular to 8192 mb.
5.	The output.txt in the root of the script folder will tell you status if you need it. 
6.	Som trace collections won't disappear until the server is rebooted. 
7.	Some logs are in the STOP and START logs on the root where the script is run. 
8.	If you stop logs collection and it was not running it will collect a log set. 
9.	You should always enter something in the last column (second form)  but it should be the empty space- selected not default
10.	Collectors self-delete when done. Check perfmon to make sure 
11.	Nothing happens in real time! Let the process finish and run the stop if needed by running the script again. Should not be needed. 
 
 
 
 
 
 
 
Perfmon Collectors
 
Since this is an automation tool, there are some things you need to know about what this tool does. 
 
The majority of this product is driven from perfmon log collectors. 
 
They May not show up as user created so it may be hard to find out what you have just enabled. 
 
The First Page has a method to check and kill running event collectors, but it's important to know where these events are being enabled. 
 
 
By using perfmon.exe, the collectors can be seen and adjusted. See Figure 1. 
 
 
 
 
 
Connect to a remote computer by running MMC. And add remove Perfmon. Then chose  
 
 
 
 
 
 
You will quickly find that the event trace sessions may or may not be hard to stop and delete. 
Over the course of many support engineers. Logging may be turned on and left on. 
 
This could be a performance issue on its own, over time. 
 
Examples of collection cleanup are memorialized in sources and methods below: Appendix A.
This is a list of the various collections going on with a windows system 
 
 
 
 
 
 
 
 
Appendix A.
# Clear Perfmon Traces
$perfmonSessions = Get-WinEvent -ListLog * -ErrorAction SilentlyContinue | Where-Object { $_.IsEnabled -and $_.LogType -eq 'Perfmon' }
$perfmonSessions | ForEach-Object { Disable-WinEvent -LogName $_.LogName }
# Optionally, check if the Perfmon sessions are disabled (optional)
#$disabledPerfmonSessions = Get-WinEvent -ListLog * -ErrorAction SilentlyContinue | Where-Object { $_.LogType -eq 'Perfmon' }
$disabledPerfmonSessions = Get-WinEvent -ListLog * -ErrorAction SilentlyContinue | Where-Object { $_.IsEnabled -and $_.LogType -eq 'Perfmon' }
$disabledPerfmonSessions
 
 
# Stop all running Event Trace Sessions
$runningSessions = Get-EtwTraceSession *
$runningSessions | Stop-EtwTraceSession -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
 
 
# Disable windows event logs wevtutil.exe
$a = (Get-WinEvent -ListLog * -Force).LogName
foreach ($b in $a) {wevtutil.exe sl "$logName" /e:false}
 Get-WinEvent -LogName "$logName"
 
 
Disable logman traces 
 
# Get a list of all running event trace sessions
$runningSessions = logman query -ets | Select-String -Pattern "Running\s*$" | ForEach-Object { $_.ToString().Trim() }
 
# Stop each running event trace session
$runningSessions | ForEach-Object {
    $sessionName = $_.Split()[0]
    logman stop "$sessionName"
}
 
# Disable each event trace session
$runningSessions | ForEach-Object {
    $sessionName = $_.Split()[0]
    logman update "$sessionName" -ets -state DISABLE
}
 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DiagTrack-Listener" /v "Start" /t REG_DWORD /d "0" /f
reg add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v "Start" /t REG_DWORD /d "0" /f
 
 
 
Default logman tracing 
 
 
 
 

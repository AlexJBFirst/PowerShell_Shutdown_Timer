# Windows PowerShell timer with GUI

Hello, everyone,  
I'd like to present my little creation to your attention:  
A GUI for Windows shutdown timer in PowerShell language, thanks to which you can turn off your PC after a certain time by setting everything in a convenient interface with an accuracy of one minute.  
And, of course, a graphical interface in a "dark mode" or a "dark theme", call it what you want!  
## Prerequisites:

You must have a policy set up that allows scripts to run, to check your PowerShell policy, enter the command in your terminal with a PowerShell interpreter:  
>Get-ExecutionPolicy  
>![image](https://github.com/AlexJBFirst/PowerShell_Timer/assets/155481723/95d0195f-2578-4a85-90f7-4e03dc30bea4)  

If the policy is set to "Restricted", you need to change it to one that allows scripts to run.  
To do this, you can use the "RemoteSigned" policy, to set this policy, run PowerShell as administrator and run the following command:  
>Set-ExecutionPolicy RemoteSigned  
>![image](https://github.com/AlexJBFirst/PowerShell_Timer/assets/155481723/2657d142-9937-4217-bff7-1c42b464807b)  

or  
>Set-ExecutionPolicy RemoteSigned -Force  
>![image](https://github.com/AlexJBFirst/PowerShell_Timer/assets/155481723/41368f6a-ac42-46af-8342-ad2473e6f850)  

Make sure that the policy is installed:  
>Get-ExecutionPolicy  
>![image](https://github.com/AlexJBFirst/PowerShell_Timer/assets/155481723/d9f5cc52-7973-4355-a350-7fc79e202557)  

If you managed to set the scripting policy to "RemoteSigned", then we can move on to the next step, but if you still have problems, I advise you to read more about the policies from the official Microsoft website:  
>https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.4  

## Running the script in different ways

The easiest way is to run our script from the PowerShell command shell as follows:  
>D:\Scripts\PowerShellTimer.ps1  
>![image](https://github.com/AlexJBFirst/PowerShell_Timer/assets/155481723/7ecbb7ca-1f71-4d8c-80a9-425788514fd6)  

Or in the case when we have spaces in the directories where our script is saved:  
>& 'D:\Scripts\PowerShellTimer.ps1'  
>![image](https://github.com/AlexJBFirst/PowerShell_Timer/assets/155481723/6d325332-ab2c-4c55-bbd0-5783089b5fe6)  

But this is not convenient.   
"OldStyle" bat scripts allowed using the .bat\\.cmd extension to run our scripts with a double click, let's do the same, but for PowerShell.  
To do this, we need to:  
1) Save our PowerShell script in some directory, for example, I will use the Scripts directory on drive D;  
2) Create a shortcut to our script;  
3) Modify the shortcut of our script as follows:  
By clicking on "Properties" in the context menu of our shortcut, in the "Object" field, change its content to the following  
>Powershell -WindowStyle hidden -file "D:\Scripts\PowerShellTimer.ps1"  
>![image](https://github.com/AlexJBFirst/PowerShell_Timer/assets/155481723/2bd86005-4733-4620-aba8-b05b7b52ef84)  

### Where:  
***PowerShell - command line interpreter  
-WindowStyle hidden - used to make the powershell window hide in the system tray when the script is launched  
-file "D:\Scripts\PowerShellTimer.ps1" - In quotes, set the full path to the script***  

The working directory does not metter;  

4) Apply the changes to the shortcut and check that everything works by double-clicking on the created shortcut and make sure that the GUI of the timer appears.  

## The GUI of the timer

Below are the pictures of the timer  

>Main Window  
![image](https://github.com/AlexJBFirst/PowerShell_Timer/assets/155481723/5051da77-dcce-44df-bfe1-0a8c778a02ef)  
>Timer Set  
![image](https://github.com/AlexJBFirst/PowerShell_Timer/assets/155481723/0c7e1bb9-a2af-43bf-9b4b-e917a9ca9e1b)  
>Timer Value  
![image](https://github.com/AlexJBFirst/PowerShell_Timer/assets/155481723/7adc5176-baa6-423c-94eb-fceef0ed6a1d)  
>Precise timer Value  
![image](https://github.com/AlexJBFirst/PowerShell_Timer/assets/155481723/41537522-64f2-4663-92c3-9e69f6dea8dc)  
>Timer Cancel  
![image](https://github.com/AlexJBFirst/PowerShell_Timer/assets/155481723/d3966afe-14f4-4beb-b881-891ba7b2ad90)  
>Shutting down the computer because the timer is set to 0
![image](https://github.com/AlexJBFirst/PowerShell_Timer/assets/155481723/ef946ce9-6177-459b-8f33-f9ed1489b8ad)  

Enjoy!  

If you want to support me, I have a link to BuyMeaCoffee  
>https://www.buymeacoffee.com/alexwight4w

Or QR code:  
>![bmc_qr](https://github.com/AlexJBFirst/PowerShell_Timer/assets/155481723/d98916df-d0ab-4701-956f-4a64f468104b)  

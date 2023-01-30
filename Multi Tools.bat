@echo off
:start
echo.
echo ========================== Task Automation ==========================
echo.
echo 1 - Repair Tool
echo     - Repair disk, system files and system images
echo.
echo 2 - Defragment Disk
echo     - Display and defragment disk drive
echo.
echo 3 - Driver Update
echo     - Update all driver to the latest version
echo.
echo 4 - Quit
echo.
set /p input="Option: "
IF "%input%"=="1" (
	goto :repair
)ELSE IF "%input%"=="2" (
	goto :dfg
)ELSE IF "%input%"=="3" (
	goto :upd
)ELSE IF "%input%"=="4" (
	exit
)
:repair
echo.
echo ============================ Repair Tool ============================
echo.
echo 1 - Disk Repair 
echo     - Scan and repair corrupted files in disk
echo.
echo 2 - System Repair 
echo     - Scan and repair damaged system files
echo.
echo 3 - System Image Scan
echo     - Scan and determine system image health
echo.
echo 4 - System Image Repair
echo     - Repair and restore system image health
echo.
echo 5 - Main Menu
echo.
set /p input2="Choose an action: "
IF "%input2%"=="1" (
	goto :tool1
)  ELSE IF "%input2%"=="2" (
	goto :tool2
)  ELSE IF "%input2%"=="3" (
	goto :tool3
)  ELSE IF "%input2%"=="4" (
	goto :tool4
)  ELSE IF "%input2%"=="5" (
	goto :start
)


:tool1 
echo.
echo ============================ Disk Repair =============================
echo.
wmic logicaldisk get name
echo 0 - Main Menu
echo.
echo Disk containing operating system may not be available to be repair due to its active state of use. 
echo You may still schedule it to be repair upon the next reboot. 
echo.
set /p input4="Disk: "
echo.
IF "%input4%"=="0" (
	goto :start
) Else (
	chkdsk /f "%input4%":
	echo.
	PAUSE
	goto :repair
)

:tool2
echo.
echo =========================== System Repair ============================
echo.
sfc /scannow
echo.
PAUSE
goto :repair

:tool3
echo.
echo ========================== System Image Scan ==========================
echo.
Dism /Online /Cleanup-Image /ScanHealth
echo.
echo Note: If Windows Resource Protection reports that there are problems with the system image, run action 4
echo.
PAUSE
goto :repair

:tool4
echo.
echo ========================= System Image Repair ==========================
echo.
Dism /Online /Cleanup-Image /RestoreHealth
echo.
echo Note: Run action 2 upon the next reboot to patch corrupted or missing system files
echo.
PAUSE
goto :repair

:dfg
echo.
echo ============================ Defragment =============================
echo.
wmic logicaldisk get name
echo 0 - Main Menu
echo.
set /p input3="Disk: "
IF "%input3%"=="0" (
	goto :start
) ELSE (
	defrag "%input3%":
	echo. 
	PAUSE
	goto :dfg
)


:upd
echo.
echo =========================== Driver Update ===========================
echo.
winget upgrade
echo.
set /p input5="Do you want to proceed with the update?(Y/N): "
IF "%input5%"=="n" (
	echo.
	echo Exiting to Main Menu...
	goto :start
) ELSE IF "%input5%"=="y" (
	goto :updno	
)

:updno
echo.
set /p input6="Do you wish to update all software driver?(Y/N): "
IF "%input6%"=="y" (
	goto :updal
)  ELSE IF "%input6%"=="n" (
	goto :updso
)

:updal
winget upgrade -h --all
echo.
PAUSE
goto start

:updso
echo.
set /p input1="Enter name or id of the software you wish to update: "
winget upgrade "%input1%"
echo.
PAUSE
goto start

goto start
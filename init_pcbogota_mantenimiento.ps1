function Get-RequiredModules {
	$remoteModulesPath = 'https://raw.githubusercontent.com/pcbogota/mante/refs/heads/main/lib'

	$modules = @(
		'pcb-Add-To-Reg.psm1',
		'pcb-dbSqlite3.psm1',
		'pcb-install-App.psm1',
		'pcb-main_mante_module.psm1',
		'pcb-Take-own.psm1',
		'pcb-win_install_main_module.psm1',
		'pcb-Write-to-user.psm1'
	)
	if (!(Test-Path -Path $global:ManteScriptPath)) {
		New-Item -Path $global:ManteScriptPath -ItemType Directory | Out-Null
	}

	$modules | ForEach-Object {
		$destFile = "$global:ManteScriptPath\$_"
		Invoke-RestMethod -Uri "$remoteModulesPath\$_" | Out-File $destFile -Force
		ConvertTo-UTF8WithBOM $destFile
	}
}

function Add-processUpdate() {
	#$progPercent = 1
	$procItems = $PSC
	$i = ($i / $procItems) * 100
	Write-Progress -Activity "Inicializando..." -Status "Onde va esto?" -PercentComplete $i
	$i++
}

######################
## ---------------- ##
## GLOBAL VARIABLES ##
## ---------------- ##
######################

$global:ManteScriptPath = "$env:PROGRAMDATA\PCBogota\libs"

##################
## ------------ ##
## SCRIPT START ##
## ------------ ##
##################

#Get-RequiredModules

Clear-Host
Import-Module -DisableNameChecking "$PSScriptroot\lib\pcb-win_install_main_module.psm1" -Global -Force
Import-Module -DisableNameChecking "$PSScriptroot\lib\pcb-main_mante_module.psm1" -Global -Force
# Get-Greetings
# return


#tools (descargar e instalar)
# Aria2c
# 7-Zip ¿si no está? ó ¿usar solo 7z.exe (command line)?
# PSExec.exe
# PSExec64.exe

##### ¿Usar desde el repo de chybeat\instalarw10 o como se llame?
# sqlite3.exe ??
# instalar.sqlite3 ??

# Get-Aria2c
# exit


Get-ExecutionPolicy -List
#powershell.exe Set-ExecutionPolicy -Scope LocalMachine Undefined -force
#PowerShell.exe Set-ExecutionPolicy -Scope CurrentUser Undefined -force


Write-Host "Inicializalizando...`n`n"
Write-Host 'Para inicializar se require:
Set-ExecutionPolicy -Scope CurrentUser Unrestricted -force
Set-ExecutionPolicy -Scope LocalMachine Unrestricted -force

El valor predeterminado es:
Set-ExecutionPolicy -Scope LocalMachine Undefined -force
Set-ExecutionPolicy -Scope CurrentUser Undefined -force
'
Write-Host "Aquí veras cositas raras nene ❤️😂😊👌."

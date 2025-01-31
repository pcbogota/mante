<# EXTENSIONES DE ARCHIVO RELLEVANTES PARA POWERSHELL

.ps1:
	Archivos de script de PowerShell.

.psm1:
	Archivos de módulo de PowerShell. Contienen funciones, variables, alias y otros elementos de PowerShell que se pueden importar y reutilizar en otros scripts o sesiones.

.psd1:
	Archivos de datos de módulo de PowerShell. Contienen metadatos sobre un módulo, como su nombre, descripción, autor, versión y dependencias. Se utilizan junto con los archivos .psm1 para definir la estructura y la información del módulo.

.psrc:
	Archivos de recursos de script de PowerShell. Contienen recursos localizados, como cadenas de texto para diferentes idiomas.

.cdxml:
	Archivos de definición de cmdlets basados en XML. Se utilizan para definir cmdlets que se implementan en código administrado (C# u otros lenguajes .NET).

.bat:
	Archivos por lotes de Windows para automatizar tareas.

.cmd: Similar a .bat.

.txt: Archivos de texto plano.

.xml: Archivos XML. Se utilizan para almacenar datos estructurados que se pueden analizar y manipular con PowerShell.

.json:
	Archivos JSON. Se utilizan para almacenar datos estructurados en formato JSON, PowerShell tiene cmdlets para trabajar con JSON.
.csv:
	Archivos de valores separados por comas. Se utilizan para almacenar datos tabulares que se pueden importar y exportar fácilmente con PowerShell.

.log:
	Archivos de registro.

.ini:
	Archivos de configuración. Se utilizan para almacenar opciones de configuración para aplicaciones.

.inf:
	Archivos de información de configuración. Se utilizan para la instalación de controladores y software.

.format.ps1xml:
	Archivos de formato de PowerShell. Definen cómo se muestran los objetos en la consola de PowerShell. Permiten personalizar la salida de los cmdlets.
#>
function Get-FileEncoding {
	param(
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[string]$Path
	)

	try {

		if (!(Test-Path $Path -PathType Leaf)) {
			Write-Warning "El archivo '$Path' no existe."
			return $null
		}
		# Obtener la extensión del archivo
		$extension = [System.IO.Path]::GetExtension($Path)

		# Verificar si es un archivo de texto manejado (.bat, .cmd, .ps1, .psm1, .psd1, .txt, etc.)


		$textExtensions = @(".bat", ".cmd", ".ps1", ".psm1", ".psd1", ".psrc", ".txt", ".xml", ".json", ".csv", ".log", ".ini", ".inf", ".format.ps1xml") #Añade aqui las extensiones que quieras
		if ($extension -notin $textExtensions) {
			Write-Warning "El archivo '$Path' no es un archivo de texto manejado (extensión '$extension')."
			return "No es un archivo de texto manejado"
		}
		# Intentar detectar la codificación usando StreamReader (maneja BOM automáticamente)
		$reader = New-Object System.IO.StreamReader -ArgumentList $Path, $true
		$encoding = $reader.CurrentEncoding
		$reader.Close()

		# Comprobaciones adicionales para casos especiales
		if ($encoding.CodePage -eq 1252) {
			# Codepage 1252 es un superconjunto de ASCII y a veces se confunde
			$bytes = [System.IO.File]::ReadAllBytes($Path)
			if ($bytes -eq [byte[]](0xEF, 0xBB, 0xBF)) { return "UTF8-BOM" } #verifica si es UTF8 con BOM aunque lo detecte como 1252
			elseif (($bytes | Measure-Object -Maximum).Maximum -le 127) {
				#verifica si todos los bytes son menores a 128 (ASCII)
				return "ASCII"
			} elseif ((($bytes | Where-Object { $_ -gt 127 } | Measure-Object).Count) -gt 0) { return "CP850" } #verifica si hay caracteres extendidos de CP850
		} elseif ($encoding.CodePage -eq 65001) { return "UTF8" } #UTF8 sin BOM
		elseif ($encoding.CodePage -eq 1200) { return "Unicode (UTF-16 Little Endian)" }
		elseif ($encoding.CodePage -eq 1201) { return "Unicode (UTF-16 Big Endian)" }
		elseif ($encoding.CodePage -eq 20127) { return "ASCII" }
		elseif ($encoding.CodePage -eq 850) { return "CP850" }


		return $encoding.EncodingName # Devuelve el nombre de la codificación detectada por StreamReader
	} catch {
		Write-Error "Error al leer el archivo: $($_.Exception.Message)"
		return $null
	}
}

<#
# Ejemplos de uso:
"archivo_utf8_bom.txt", "archivo_utf8_sin_bom.txt", "archivo_unicode.txt", "archivo_ascii.txt", "archivo_cp850.txt" | ForEach-Object {
	if (Test-Path $_) {
		Write-Host "Codificación de $_ : $(Get-FileEncoding $_)"
	} else {
		Write-Warning "El archivo $_ no existe."
	}
}

#Para usarla directamente con archivos ps1 o cmd
Get-ChildItem *.ps1, *.cmd | ForEach-Object {
	Write-Host "Codificación de $($_.FullName): $(Get-FileEncoding $_.FullName)"
}
#>

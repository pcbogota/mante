function ConvertTo-UTF8WithBOM {
	param (
		[string]$FilePath
	)
	$content = Get-Content -Path $FilePath -Raw -Encoding UTF8
	$utf8WithBOM = New-Object System.Text.UTF8Encoding $true
	[System.IO.File]::WriteAllText($FilePath, $content, $utf8WithBOM)
}

function Get-Aria2c {
	$url = "https://github.com/aria2/aria2/releases/latest"

	# Obtener el contenido de la página de releases
	$url = Invoke-WebRequest -Uri $url -UseBasicParsing

	# Extraer el enlace del instalador más reciente (versión de 64 bits)
	$url = $url.Links | Where-Object {
			($_.href -Match "*.zip")
		#		$_.href -match "Git-\d+\.\d+\.\d+\.\d+-64-bit\.exe"
	} | Select-Object -First 1 -ExpandProperty href

	$url
	exit
	# Construir la URL completa del instalador
	$url = "https://github.com" + $url
}

function Get-Greetings {
	Write-Host "Bienvenido!! :) canción datos y cosítas ü 😊❤️. ¿Qué mas puedo decir 🤪🤪🤪🤪?"
}

Write-Host "test in main!"

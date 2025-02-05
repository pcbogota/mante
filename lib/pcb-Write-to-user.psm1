# Funciones para mostrar mensajes en colores
# Las configuraciónes de texto y/o fondo se deben colocar al inicio del texto. Al final de toda línea, si o si
# debe llevar $($TerminalColor.reset). Esto último para evitr cabios de color en textos suyacentes!
# Ej: Write-Host "$($TerminalColor.txt.green)fondo verde letras$($TerminalColor.reset) negras"

#Función para dividir líneas con su respectivo fin de cambios de color ANSI
function Reset-EndLine {
	param(
		[Parameter(Mandatory, Position = 0)]
		[string]
		$Text,
		[string]
		$custom,
		[switch]
		$space
	)
	# Dividir el texto en líneas basado en los saltos de línea
	if ($space) {
		$spacer = " "
	} else {
		$spacer = ''
	}
	$lines = ($Text -split "`n")
	$formatedText = ""
	# Recorrer cada línea y aplicar el formato de color
	foreach ($line in $lines) {
		if (-not [string]::IsNullOrWhiteSpace($line)) {
			$formatedText += "$($custom)$spacer$($line)$spacer$($TerminalColor.reset)`n"
		}
	}
	return $formatedText.TrimEnd("`n")
}

function wError {
	<#
	.SYNOPSIS
		Mostar un texto en formateado que simbolice error

	.DESCRIPTION
		Muestra un texto con fondo rojo y letras blancas simbolizando un error

	.PARAMETER Text
		El texto a mostrar
	#>
	param(
		[Parameter(Mandatory, Position = 0)]
		[string]
		$Text
	)
	process {
		$text = $text[0].ToString().ToUpper() + $text.Substring(1)
		$errotText = Reset-EndLine -Text "$($Text)" -custom "$($TerminalColor.txt.bold)$($TerminalColor.bg.red)" -space
		Write-Host "$($errotText)`n"
	}
}

function wInfo {
	<#
	.SYNOPSIS
		Mostar un texto informativo

	.DESCRIPTION
		Muestra un texto de color cyan y sin formato

	.PARAMETER Text
		El texto a mostrar
	#>
	param(
		[Parameter(Mandatory, Position = 0)]
		[string]
		$Text
	)
	process {
		Write-Host (Reset-EndLine -Text "$($Text)" -custom "$($TerminalColor.txt.bold)$($TerminalColor.txt.cyan)")
	}
}

function wOk {
	<#
	.SYNOPSIS
		Mostar un texto en formato de ejecución exitosa

	.DESCRIPTION
		Muestra un texto con letras verdes indicando una ejecución exitosa

	.PARAMETER Text
		El texto a mostrar
	#>
	param(
		[Parameter(Mandatory, Position = 0)]
		[string]
		$Text
	)
	process {
		Write-Host (Reset-EndLine -Text "$($Text)" -custom "$($TerminalColor.txt.green)")"`n"
	}
}

function wRun {
	<#
	.SYNOPSIS
		Mostar un texto en formato relevante indicando inicio o ejecución

	.DESCRIPTION
		Muestra un texto con fondo verde y letras blancas indicando una ejecución

	.PARAMETER Text
		El texto a mostrar
	#>
	param(
		[Parameter(Mandatory, Position = 0)]
		[string]
		$Text
	)
	process {
		Write-Host (Reset-EndLine -Text " $($Text) " -custom "$($TerminalColor.bg.green)$($TerminalColor.txt.white)" -Space)

	}
}

function WTitulo {
	<#
	.SYNOPSIS
		Mostar un texto en formato relevante

	.DESCRIPTION
		Muestra un texto con fondo negro y letras blancas indicando relevancia

	.PARAMETER Text
		El texto a mostrar en formato relevante
	#>
	param(
		[Parameter(Mandatory, Position = 0)]
		[string]
		$Text
	)
	process {
		$width = $text.Length
		$Spaces = 8
		$width += ($spaces * 2)
		#		$formatedText = (Reset-EndLine -Text "$($text.ToUpper())" -custom "$($TerminalColor.txt.underline)$($TerminalColor.txt.black)")
		#		$finalText += $formatedText + $TerminalColor.reset
		$clearLine = "-" * $width
		# Primera línea en blanco
		$finalText = "$($TerminalColor.bg.white)$($TerminalColor.txt.white)$clearLine`n"
		# Espacios al lado izquierdo
		$finalText += "$($TerminalColor.bg.white)" + ("-" * $Spaces) + $($TerminalColor.txt.underline)
		# Texto del título
		$finalText += "$($TerminalColor.txt.black)$($text.ToUpper())$($TerminalColor.reset)"
		# Espacios al lado derecho
		$finalText += "$($TerminalColor.bg.white)$($TerminalColor.txt.white)" + ("-" * $Spaces) + "$($TerminalColor.txt.reset)$($TerminalColor.bg.reset)$($TerminalColor.reset)`n"
		# Ultima línea en blanco
		$finalText += "$($TerminalColor.txt.white)$($TerminalColor.bg.white)$clearLine$($TerminalColor.reset)`n"
		Write-Host $finalText
	}
}

function Preprint {
	<#
	.SYNOPSIS
		Mostrar el elemento e información de ejecución

	.DESCRIPTION
		Muestra un elemento enviado y la ubicación donde se solicitó la ejecución de la función

	.PARAMETER Text
		Un texto o resultado que se mostrará en la ejecución
	#>
	param(
		$Data
	)
	process {
		#write-host ($MyInvocation | Format-List | Out-String)
		$file = Split-Path $MyInvocation.ScriptName -Leaf
		$line = $MyInvocation.ScriptLineNumber
		if ($null -ne $Data) {
			$type = $Data.GetType().Name
		} else {
			$type = "NULL"
		}
		#$test = $data.GetType() | Format-List | Out-String;
		#write-host ${type};

		$command = $MyInvocation.Line.Trim()
		$width = (Get-Host).UI.RawUI.MaxWindowSize.Width
		$separatorBlock = '_' * $width
		$separatorLine = '*' * $width

		if (($type -eq "String") -or ($type -eq "Char")) {
			$Data = $Data.Trim()
			if ('' -eq $Data) {
				$Data = "(EMPTY)"
			}
		}

		if (($type -ne 'Single', 'Double', 'Decimal', 'Char', 'Boolean', 'String', 'Int32', 'Int64')) {
			$Data = ($Data | Format-List | Out-String)
		}

		Write-Host -ForegroundColor Cyan ${separatorBlock}
		Write-Host -ForegroundColor Cyan "File: ${file} (ln ${line}) - ${type}"
		Write-Host -ForegroundColor Cyan "Command: ${command}"
		Write-Host -ForegroundColor Cyan ${separatorLine}
		Write-Host -ForegroundColor Red $Data `n
		Write-Host -ForegroundColor Cyan ${separatorLine}
	}
}

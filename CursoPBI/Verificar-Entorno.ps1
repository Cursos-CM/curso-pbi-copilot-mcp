# Verifica el entorno del curso "Modelado semántico de Power BI con GitHub Copilot y MCP"
# Uso: powershell -ExecutionPolicy Bypass -File C:\CursoPBI\Verificar-Entorno.ps1
$ErrorActionPreference = "SilentlyContinue"
$raiz = Split-Path -Parent $MyInvocation.MyCommand.Path
function Linea($estado, $texto) {
  $color = @{ "OK" = "Green"; "ADVERTENCIA" = "Yellow"; "ERROR" = "Red" }[$estado]
  Write-Host ("[{0}] {1}" -f $estado, $texto) -ForegroundColor $color
}
Write-Host "Verificación del entorno - carpeta: $raiz`n"

# Herramientas
if (Get-Command code -ErrorAction SilentlyContinue) { Linea "OK" ("VS Code " + (code --version | Select-Object -First 1)) } else { Linea "ERROR" "VS Code no está en el PATH" }
if (Get-Command git -ErrorAction SilentlyContinue) { Linea "OK" (git --version) } else { Linea "ERROR" "Git para Windows no está instalado" }
if (Get-Command node -ErrorAction SilentlyContinue) {
  $v = (node --version); $mayor = [int]($v.TrimStart('v').Split('.')[0])
  if ($mayor -ge 20) { Linea "OK" "Node.js $v" } else { Linea "ADVERTENCIA" "Node.js $v (se requiere 20 o superior)" }
} else { Linea "ADVERTENCIA" "Node.js no instalado (recomendado para el modo solo lectura de los Labs 2 y 3)" }

if (Get-Command code -ErrorAction SilentlyContinue) {
  $ext = code --list-extensions --show-versions
  $mcp = $ext | Where-Object { $_ -like "analysis-services.powerbi-modeling-mcp*" }
  if ($mcp) { Linea "OK" "Extensión $mcp" } else { Linea "ERROR" "Falta la extensión analysis-services.powerbi-modeling-mcp" }
  $cop = $ext | Where-Object { $_ -like "github.copilot-chat*" }
  if ($cop) { Linea "OK" "Extensión $cop" } else { Linea "ADVERTENCIA" "No se encontró github.copilot-chat (puede venir integrada en VS Code; verifiquen el chat)" }
}

$pbi = Get-AppxPackage -Name "Microsoft.MicrosoftPowerBIDesktop" -ErrorAction SilentlyContinue
if ($pbi) { Linea "OK" "Power BI Desktop (Store) $($pbi.Version)" }
elseif (Test-Path "C:\Program Files\Microsoft Power BI Desktop\bin\PBIDesktop.exe") { Linea "OK" "Power BI Desktop (instalador) encontrado" }
else { Linea "ERROR" "No se encontró Power BI Desktop" }

# Materiales
$esperado = @{ "FACT_Ventas.csv" = 34330; "fact_devoluciones.csv" = 2386; "Presupuesto.csv" = 1532; "dim_producto.csv" = 184;
  "dim_subcategoria.csv" = 15; "Cliente.csv" = 2400; "tbl_Tienda.csv" = 16; "Calendario.csv" = 731 }
foreach ($k in $esperado.Keys) {
  $f = Join-Path $raiz "Datos\$k"
  if (Test-Path $f) {
    $n = (Get-Content $f -Encoding UTF8 | Measure-Object -Line).Lines - 1
    if ($n -eq $esperado[$k]) { Linea "OK" "$k ($n filas)" } else { Linea "ERROR" "$k tiene $n filas (esperadas $($esperado[$k]))" }
  } else { Linea "ERROR" "Falta Datos\$k" }
}
foreach ($d in @("TiendasAndinas", "Checkpoints\T05_inicio", "Checkpoints\T06_inicio", "Checkpoints\T07_inicio", "Checkpoints\T08_inicio")) {
  $p = Join-Path $raiz "$d\TiendasAndinas.pbip"
  if (Test-Path $p) { Linea "OK" "$d\TiendasAndinas.pbip" } else { Linea "ERROR" "Falta $d\TiendasAndinas.pbip" }
}
if ($raiz -ne "C:\CursoPBI") { Linea "ADVERTENCIA" "Los materiales no están en C:\CursoPBI: actualicen el parámetro RutaDatos en Power BI Desktop a '$raiz\Datos\'" }
if (Test-Path (Join-Path $raiz "Solucion")) { Linea "OK" "Solucion\ presente" }
Write-Host "`nFin de la verificación."

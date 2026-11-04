# Guía de preparación

Hagan esta preparación **antes** de la primera sesión. Toma unos 30 minutos y evita que la clase se vaya en instalaciones.

## 1. Requisitos

- Equipo con **Windows 10 u 11** de 64 bits y permisos para instalar software. Si no tienen permisos, pidan a su área de TI que instale lo del paso 2.
- Cuenta de **GitHub** con una licencia paga de **GitHub Copilot** (Pro o Business). El plan gratuito no alcanza para los laboratorios.
- Si su cuenta de GitHub pertenece a una organización empresarial: un administrador debe habilitar la política **MCP servers in Copilot**, que viene desactivada por defecto.

## 2. Instalar el software

| Programa | Cómo instalarlo |
|---|---|
| Visual Studio Code | Desde `https://code.visualstudio.com`. GitHub Copilot ya viene integrado. |
| Power BI Desktop | Desde Microsoft Store (se actualiza solo). |
| Git (opcional, Temas 7 y 8) | En PowerShell: `winget install --id Git.Git -e --source winget` |
| Node.js 20 o superior (opcional) | En PowerShell: `winget install --id OpenJS.NodeJS.LTS -e --source winget` |
| Extensión del servidor MCP | En VS Code, vista de Extensiones (Ctrl+Shift+X): **Power BI Authoring MCP Server**, editor **Microsoft**, identificador `analysis-services.powerbi-modeling-mcp` |

Git y Node.js son **opcionales**. Si al instalarlos Windows pide permisos de administrador que no tienen, omítanlos: el curso tiene alternativa. Si los instalan, cierren y vuelvan a abrir VS Code y PowerShell.

Si no pueden instalar el software o no tienen licencia de Copilot, sigan los laboratorios en **modo demo** con el instructor: cada guía muestra el resultado esperado de cada paso.

Si winget responde *Found an existing package already installed* y *No available upgrade found*, ese programa ya está instalado y al día: no hay que hacer nada más.

> Hay extensiones de terceros con nombres parecidos. Comprueben que el identificador sea exactamente `analysis-services.powerbi-modeling-mcp`.

## 3. Descargar los materiales

1. En la página del repositorio, abran **Releases** y descarguen `CursoPBI.zip` de la versión más reciente.
2. Clic derecho sobre `CursoPBI.zip` → **Extraer todo…**. En el destino escriban solo `C:\` (no `C:\CursoPBI`) y hagan clic en **Extraer**.
3. Comprueben que existe `C:\CursoPBI\Verificar-Entorno.ps1`. Si ven `C:\CursoPBI\CursoPBI`, muevan su contenido una carpeta arriba.

## 4. Verificar

En PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File C:\CursoPBI\Verificar-Entorno.ps1
```

Todas las líneas deben salir en `[OK]`. La línea de GitHub Copilot sale como `[INFO]`: es normal, porque Copilot viene integrado en VS Code.

Por último, abran VS Code y abran el chat con el **icono de chat** que está arriba, a la derecha del cuadro **Search** (o con **Ctrl+Alt+I**). Inicien sesión con GitHub si lo pide y escriban `Hola`. Si Copilot responde, están listos.

Si algo sale en `[ERROR]`, escriban al instructor antes de la primera sesión con una captura del resultado.

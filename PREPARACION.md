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
| Git | En PowerShell: `winget install --id Git.Git -e` |
| Node.js (20 o superior) | En PowerShell: `winget install --id OpenJS.NodeJS.LTS -e` |
| Extensión del servidor MCP | En VS Code, vista de Extensiones (Ctrl+Shift+X): **Power BI Authoring MCP Server**, editor **Microsoft**, identificador `analysis-services.powerbi-modeling-mcp` |

Después de instalar Git y Node.js, cierren y vuelvan a abrir VS Code y PowerShell.

> Hay extensiones de terceros con nombres parecidos. Comprueben que el identificador sea exactamente `analysis-services.powerbi-modeling-mcp`.

## 3. Descargar los materiales

1. En la página del repositorio, abran **Releases** y descarguen `CursoPBI.zip` de la versión más reciente.
2. Descompriman el archivo directamente en `C:\`. Debe quedar la carpeta `C:\CursoPBI` con `Datos`, `TiendasAndinas`, `Checkpoints` y `Prompts` adentro.

## 4. Verificar

En PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File C:\CursoPBI\Verificar-Entorno.ps1
```

Todas las líneas deben salir en `[OK]`. La de `github.copilot-chat` puede salir como `[ADVERTENCIA]`: es normal, porque Copilot viene integrado en VS Code.

Por último, abran VS Code, abran el chat con **Ctrl+Alt+I**, inicien sesión con GitHub y escriban `Hola`. Si Copilot responde, están listos.

Si algo sale en `[ERROR]`, escriban al instructor antes de la primera sesión con una captura del resultado.

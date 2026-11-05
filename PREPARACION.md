# Guía de preparación

Hagan esta preparación **antes** de la sesión. Toma unos 20 minutos y evita que la clase se vaya en instalaciones.

## 1. Requisitos

- Equipo con **Windows 10 u 11** de 64 bits.
- Cuenta de **GitHub** (gratuita) con **GitHub Copilot Free** activado. Para activarlo, entren con su cuenta a `https://github.com/settings/copilot` y elijan **Copilot Free**.
- Si su cuenta de GitHub pertenece a una organización empresarial: un administrador debe habilitar la política **MCP servers in Copilot**, que viene desactivada por defecto. Si no es posible, usen una cuenta personal.

> **Sobre Copilot Free:** usa solo la selección automática de modelo (**Auto**) y tiene una cuota mensual de uso que se renueva el primer día de cada mes. Los laboratorios están pensados para unos 10 a 15 mensajes cada uno. Copien los mensajes de las guías tal cual y no repitan un mensaje si el agente ya respondió.

## 2. Instalar el software

Solo hacen falta tres cosas:

| Programa | Cómo instalarlo |
|---|---|
| Visual Studio Code | Desde `https://code.visualstudio.com`. GitHub Copilot ya viene integrado. |
| Power BI Desktop | Desde Microsoft Store (se actualiza solo). |
| Extensión del servidor MCP | En VS Code, vista de Extensiones (Ctrl+Shift+X): **Power BI Authoring MCP Server**, editor **Microsoft**, identificador `analysis-services.powerbi-modeling-mcp` |

**No hace falta** instalar Git ni Node.js, ni usar PowerShell o la terminal. El servidor de solo lectura usa el programa que ya trae la extensión, y el control de versiones del Tema 7 se hace en la página web de GitHub.

> Hay extensiones de terceros con nombres parecidos. Comprueben que el identificador sea exactamente `analysis-services.powerbi-modeling-mcp`.

Si no pueden instalar el software, sigan los laboratorios en **modo demo** con el instructor: cada guía muestra el resultado esperado de cada paso.

## 3. Descargar los materiales

1. En la página del repositorio, abran **Releases** y descarguen `CursoPBI.zip` de la versión más reciente (en la sección **Assets**; no es *Source code*).
2. Clic derecho sobre `CursoPBI.zip` → **Extraer todo…**. En el destino escriban solo `C:\` (no `C:\CursoPBI`) y hagan clic en **Extraer**.
3. En el Explorador de archivos, comprueben que existen `C:\CursoPBI\Datos`, `C:\CursoPBI\TiendasAndinas\TiendasAndinas.pbip` y `C:\CursoPBI\Checkpoints`. Si ven `C:\CursoPBI\CursoPBI`, muevan su contenido una carpeta arriba.

## 4. Verificar

1. Hagan doble clic en `C:\CursoPBI\TiendasAndinas\TiendasAndinas.pbip`. Debe abrir Power BI Desktop con el modelo de Tiendas Andinas. Si las tablas aparecen vacías, **Inicio → Actualizar**.
2. Abran VS Code → **File → Open Folder…** → `C:\CursoPBI`. Si pregunta si confían en los autores, elijan **Yes, I trust the authors**.
3. Abran el chat con el **icono de chat** que está arriba, a la derecha del cuadro **Search**. Si abajo a la derecha aparece **Sign In**, inicien sesión con su cuenta de GitHub. Escriban `Hola`. Si Copilot responde, están listos.

Si el chat responde *Language model unavailable*, falta iniciar sesión o activar Copilot Free (paso 1). Si algo no funciona, escriban al instructor con una captura de pantalla.

> Quien sí pueda usar PowerShell tiene además una verificación automática: `powershell -ExecutionPolicy Bypass -File C:\CursoPBI\Verificar-Entorno.ps1`. Es opcional.

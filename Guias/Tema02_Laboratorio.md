# Laboratorio 2: Conexiones y modos de trabajo

| Dato | Detalle |
|---|---|
| Duración | 60 minutos |
| Modalidad | Individual |
| Punto de partida | Equipo preparado y Laboratorio 1 hecho. No importa si el equipo se reinició o si cerraron todo: el **Arranque** deja el entorno listo |
| Resultado esperado | Un servidor propio de solo lectura que bloquea cambios, el mismo modelo consultado desde Desktop y desde la carpeta PBIP, una exportación de prueba y la lectura del registro de auditoría |

## Objetivos

- Registrar un servidor MCP propio, en modo de solo lectura, con un archivo `mcp.json`.
- Comprobar que el servidor rechaza los cambios aunque ustedes los aprueben.
- Conectarse al mismo modelo desde Power BI Desktop y desde la carpeta PBIP, y comparar qué permite cada conexión.
- Exportar un cambio de prueba a una carpeta temporal y comprobar que el proyecto original no cambió.
- Leer el registro de auditoría y encontrar sus propias operaciones.

## Escenario

El equipo de BI de Tiendas Andinas quiere usar el agente sobre modelos importantes, pero el área de control interno pide tres garantías: que se pueda trabajar sin riesgo de cambiar nada, que se sepa siempre a qué modelo está conectado el agente y que quede evidencia de lo que hizo. En este laboratorio ustedes preparan esas tres garantías.

> **Cómo leer esta guía:** cada recuadro gris con texto en español es un **mensaje para el chat de Copilot**: cópienlo, péguenlo en el cuadro *Chat with Copilot* y presionen **Enter**. Los recuadros de PowerShell o JSON se indican aparte.
>
> **Modo demo:** si no pueden ejecutar el laboratorio en su equipo, sigan al instructor en la pantalla compartida con esta misma guía. Debajo de los pasos, los recuadros **Resultado esperado** muestran lo que debe aparecer, para que puedan comprobarlo y responder las verificaciones.
>
> **Regla de hoy:** el proyecto de trabajo `C:\CursoPBI\TiendasAndinas` no se modifica. No guarden cambios en Desktop y no exporten a la carpeta original.

## Arranque: dejar el entorno listo (5 min)

Cada laboratorio empieza desde cero: no supongan que algo quedó abierto de la sesión anterior.

1. Si Power BI Desktop o VS Code están abiertos de antes, ciérrenlos. Si Desktop pregunta si desean guardar, elijan **No guardar**.
2. Hagan doble clic en `C:\CursoPBI\TiendasAndinas\TiendasAndinas.pbip` y esperen a que Power BI Desktop termine de abrirlo.
3. En el panel **Datos** de Desktop, expandan `FACT_Ventas` y abran la **vista de tabla** (segundo icono de la barra izquierda). Si la tabla aparece vacía, vayan a **Inicio → Actualizar** y esperen a que termine.

   > **Resultado esperado:** La vista de tabla de `FACT_Ventas` muestra filas con datos.

4. Abran **Visual Studio Code**. Vayan a **File → Open Folder…**, elijan `C:\CursoPBI` y hagan clic en **Seleccionar carpeta**. Si VS Code pregunta si confían en los autores, elijan **Yes, I trust the authors**.

   > **Resultado esperado:** El Explorador de VS Code muestra **CURSOPBI** y no aparece el aviso **Restricted Mode**.

✔ **Verificación**

- Desktop muestra Tiendas Andinas con datos en `FACT_Ventas`.
- En VS Code, el **Explorer** (Ctrl+Shift+E) muestra arriba **CURSOPBI**, y no aparece el aviso **Restricted Mode**.

## Ejercicio 1: Un servidor propio de solo lectura (15 min)

### A. Crear el archivo mcp.json

1. En VS Code, con la carpeta `C:\CursoPBI` abierta, vayan al **Explorador** (primer icono de la barra izquierda, o **Ctrl+Shift+E**).
2. Pasen el cursor sobre el nombre **CURSOPBI** y hagan clic en el icono **New Folder**. Escriban `.vscode` (con el punto al inicio) y presionen Enter.
3. Hagan clic derecho sobre la carpeta `.vscode` → **New File…**, escriban `mcp.json` y presionen Enter. Se abre el archivo vacío.

   > **Resultado esperado:** En el Explorador aparece `.vscode` con el archivo `mcp.json` adentro, abierto y vacío.

4. Copien y peguen exactamente este contenido:

   ```json
   {
     "servers": {
       "powerbi-solo-lectura": {
         "type": "stdio",
         "command": "npx",
         "args": [
           "-y",
           "@microsoft/powerbi-modeling-mcp@latest",
           "--start",
           "--readonly",
           "--accept-eula"
         ]
       }
     }
   }
   ```

   **Cómo leer este archivo:** `powerbi-solo-lectura` es el nombre con el que verán el servidor; `npx` descarga y arranca el servidor publicado por Microsoft; `--start` lo enciende; `--readonly` lo deja en solo lectura; y `--accept-eula` registra la aceptación de la licencia que ya leyeron en el Laboratorio 1.

5. Guarden con **Ctrl+S**.

   > **Resultado esperado:** El archivo queda guardado sin subrayados rojos.

### B. Encender solo el servidor de solo lectura

6. Abran una conversación nueva: **Ctrl+Shift+P** → `Chat: New Chat`. Ojo: el **+** que está *dentro* del cuadro de texto del chat es para adjuntar archivos, no para una conversación nueva. Confirmen **Agent** y **Manual permissions**, escriban `Hola` y esperen la respuesta.
7. Abran la paleta de comandos (**Ctrl+Shift+P**) → `MCP: List Servers`. En la lista:
   - **powerbi-solo-lectura**: si no dice **Running**, hagan clic en **▷ (Start Server)**. La primera vez puede tardar un poco, porque `npx` descarga el servidor.
   - **powerbi-authoring-local** y **github-mcp-server**: si dicen **Running**, hagan clic en su nombre → **Stop Server**.

   > Así el agente solo tiene a mano el servidor que no puede escribir.

   > **Resultado esperado:** En la lista: **powerbi-solo-lectura** con **Running**; **powerbi-authoring-local** y **github-mcp-server** detenidos.

### C. Probar el bloqueo

8. Conéctense a Desktop. Escriban en el chat y presionen Enter:

   ```text
   Conéctate al archivo 'TiendasAndinas' abierto en Power BI Desktop.
   ```

   El agente no se conecta solo: en el chat aparece un recuadro que pide permiso para usar la herramienta `connection_operations`. Ábranlo para ver los detalles, comprueben que dice **powerbi-solo-lectura** y hagan clic en **Allow** (Permitir). Esperen la respuesta: el agente confirma que se conectó a TiendasAndinas.

   > **Resultado esperado:** La aprobación de `connection_operations` muestra el servidor **powerbi-solo-lectura**. El agente confirma la conexión a TiendasAndinas.

9. Pidan un dato de control. Escriban en el chat:

   ```text
   Sin hacer cambios, dime cuántas medidas tiene la tabla FACT_Ventas.
   ```

   > **Resultado esperado:** El agente responde que FACT_Ventas tiene **16 medidas**.

10. Ahora pidan un cambio. Escriban en el chat:

    ```text
    Intenta crear en FACT_Ventas una medida llamada 'Prueba Bloqueo' con la
    expresión 1 usando la herramienta measure_operations, aunque creas que no
    se puede. Quiero ver la respuesta exacta del servidor.
    ```

    Cuando aparezca la aprobación de `measure_operations` con la operación **Create**, hagan clic en **Allow**: **permitan** la llamada a propósito. Lean la respuesta del servidor.

    > Si el agente contesta que no puede porque el servidor es de solo lectura y **no** pide aprobación, el agente se adelantó: vio que el servidor está en solo lectura y ni lo intentó. Envíen de nuevo el mensaje; la idea es ver el rechazo **del servidor**, no la opinión del agente.

    > **Resultado esperado:** Respuesta real del servidor: `MCP server 'powerbi-solo-lectura': Operation 'Create' is not permitted: The MCP Server is currently running in read-only mode…`. El agente informa que no pudo crear la medida.

11. En Power BI Desktop, en el panel **Datos**, abran la tabla `FACT_Ventas` y busquen la medida `Prueba Bloqueo`.

    > **Resultado esperado:** La medida `Prueba Bloqueo` no existe en el panel Datos de Desktop.

✔ **Verificación**

- En *MCP: List Servers*, **powerbi-solo-lectura** dice **Running** y los otros dos servidores están detenidos.
- FACT_Ventas tiene **16 medidas**.
- El agente muestra la respuesta del servidor: *Operation 'Create' is not permitted: The MCP Server is currently running in read-only mode…*
- La medida `Prueba Bloqueo` **no existe** en Desktop, aunque ustedes aprobaron la llamada.

## Ejercicio 2: El mismo modelo desde la carpeta PBIP (13 min)

Sigan en la misma conversación, con el servidor de solo lectura.

1. Abran una segunda conexión, esta vez a los archivos del proyecto. Escriban en el chat:

   ```text
   Abre el modelo semántico de la carpeta PBIP
   'C:\CursoPBI\TiendasAndinas\TiendasAndinas.SemanticModel\definition'
   ```

   En la aprobación de `connection_operations`, comprueben que la operación es **ConnectFolder** y permitan. Lean la advertencia que devuelve el servidor.

   > **Resultado esperado:** El servidor carga el modelo desde la carpeta (8 tablas, 16 medidas, 6 relaciones) y advierte: *Changes made through MCP are not automatically written to disk. Run `ExportToTmdlFolder` before disconnecting to persist them.*

2. Pregunten qué conexiones tiene abiertas. Escriban en el chat:

   ```text
   Sin hacer cambios, lista las conexiones abiertas: nombre, si es fuera de
   línea (offline) y cuál estás usando ahora.
   ```

   > **Resultado esperado:** Dos conexiones: la de Desktop y una cuyo nombre empieza por `TMDL-`, marcada como offline (fuera de línea). La activa es la última que se abrió, la de carpeta.

3. Comparen el inventario de las dos conexiones. Escriban en el chat:

   ```text
   Sin hacer cambios, en la conexión de carpeta dime cuántas tablas, medidas
   y relaciones tiene el modelo. Luego haz lo mismo en la conexión de Desktop.
   ```

   > **Resultado esperado:** Las dos conexiones reportan 8 tablas, 16 medidas en FACT_Ventas y 6 relaciones.

4. Intenten una consulta DAX en cada conexión. Escriban en el chat el primer mensaje, esperen la respuesta y luego envíen el segundo:

   ```text
   En la conexión de carpeta, ejecuta una consulta DAX que devuelva
   [Total Ventas] por Calendario[Anio].
   ```

   ```text
   Ahora ejecuta la misma consulta en la conexión de Desktop.
   ```

   > **Resultado esperado:** En la carpeta: *DAX query operations are not supported on offline connections*. En Desktop: 2024 = 5.121.728.115 y 2025 = 6.287.796.955.

5. Completen esta tabla con lo que observaron:

   | Pregunta | Desktop | Carpeta PBIP |
   |---|---|---|
   | ¿Es fuera de línea (offline)? | | |
   | Tablas, medidas de FACT_Ventas y relaciones | | |
   | ¿Se pueden ejecutar consultas DAX? | | |
   | ¿Dónde quedaría un cambio? | | |

   > **Resultado esperado:** Desktop: en línea · 8, 16, 6 · DAX sí · el cambio queda en el modelo abierto. Carpeta: fuera de línea · 8, 16, 6 · DAX no · el cambio queda en memoria hasta exportarlo.

✔ **Verificación**

- Al conectarse a la carpeta, el servidor advierte: *Changes made through MCP are not automatically written to disk. Run `ExportToTmdlFolder` before disconnecting to persist them.*
- Hay dos conexiones abiertas; la de carpeta aparece como **offline** y su nombre empieza por `TMDL-`.
- Las dos conexiones reportan **8 tablas, 16 medidas en FACT_Ventas y 6 relaciones**.
- En la carpeta, la consulta DAX falla con *DAX query operations are not supported on offline connections*.
- En Desktop, la consulta devuelve 2024 = **5.121.728.115** y 2025 = **6.287.796.955**.

## Ejercicio 3: Exportación de prueba a una carpeta temporal (13 min)

Para ver dónde quedan los cambios hace falta un servidor que sí pueda escribir. Van a usar el servidor normal, pero solo sobre la conexión de carpeta y exportando a una carpeta temporal.

1. **Ctrl+Shift+P** → `MCP: List Servers`:
   - **powerbi-solo-lectura** → **Stop Server**.
   - **powerbi-authoring-local** → **▷ Start Server**. Debe quedar en **Running**.

   > **Resultado esperado:** **powerbi-authoring-local** en **Running** y **powerbi-solo-lectura** detenido.

2. Abran una conversación nueva (**Ctrl+Shift+P** → `Chat: New Chat`) y escriban `Hola`. Luego conéctense **solo** a la carpeta. Escriban en el chat:

   ```text
   Abre el modelo semántico de la carpeta PBIP
   'C:\CursoPBI\TiendasAndinas\TiendasAndinas.SemanticModel\definition'
   No te conectes a Power BI Desktop.
   ```

   > Cada servidor tiene sus propias conexiones: al cambiar de servidor, hay que volver a conectarse.

   > **Resultado esperado:** El agente se conecta solo a la carpeta y muestra de nuevo la advertencia de exportar.

3. Creen un cambio de prueba. Escriban en el chat:

   ```text
   En la conexión de carpeta, crea en FACT_Ventas una medida llamada
   'Prueba Export' con la expresión 1. No exportes ni guardes nada todavía.
   ```

   Esta vez la aprobación de `measure_operations` con **Create** sí funciona. El cambio queda **en memoria**.

   > Si después de crear la medida aparece otra aprobación de `database_operations` que ustedes no pidieron, **recházenla**: el agente intenta guardar por su cuenta.

   > **Resultado esperado:** La aprobación de `measure_operations` con **Create** se ejecuta sin error. La medida existe solo en memoria.

4. Exporten a una carpeta temporal, **no** a la original. Escriban en el chat:

   ```text
   Exporta el modelo de la conexión de carpeta a la carpeta TMDL
   'C:\CursoPBI\Temp\export_prueba'. No exportes a la carpeta original.
   ```

   En el chat aparece el recuadro de aprobación de la herramienta `database_operations`. **No hagan clic todavía.** Ábranlo para ver los detalles: muestra los datos que el agente le va a enviar al servidor, algo así:

   ```text
   "Operation": "ExportToTmdlFolder",
   "TmdlFolderPath": "C:\CursoPBI\Temp\export_prueba"
   ```

   - Si dice `ExportToTmdlFolder` y la ruta termina en `Temp\export_prueba` → **Allow** (permitir).
   - Si la ruta termina en `definition` (la carpeta original) → rechacen la llamada y repitan el mensaje.
   - Si **no aparece** `TmdlFolderPath` → **rechacen**. Sin ruta, el servidor exporta a la carpeta de origen y sobrescribe el proyecto original.

   > **Resultado esperado:** La aprobación muestra `ExportToTmdlFolder` y `TmdlFolderPath: C:\CursoPBI\Temp\export_prueba`. El servidor informa 12 archivos creados.

5. Abran **Windows PowerShell** (tecla Windows, escriban `PowerShell`, Enter) y busquen la medida en las dos carpetas. Copien las dos líneas, péguenlas en PowerShell y presionen Enter:

   ```powershell
   Select-String -Path C:\CursoPBI\Temp\export_prueba\tables\FACT_Ventas.tmdl -Pattern "Prueba Export"
   Select-String -Path C:\CursoPBI\TiendasAndinas\TiendasAndinas.SemanticModel\definition\tables\FACT_Ventas.tmdl -Pattern "Prueba Export"
   ```

   > **Resultado esperado:** El primer comando muestra `...\export_prueba\tables\FACT_Ventas.tmdl:52: measure 'Prueba Export' = 1`. El segundo no muestra nada.

✔ **Verificación**

- La exportación reporta **12 archivos** creados en `C:\CursoPBI\Temp\export_prueba`.
- El primer `Select-String` muestra una línea con `measure 'Prueba Export'`.
- El segundo no muestra nada: el proyecto original **no cambió**.
- En Power BI Desktop tampoco existe `Prueba Export`.

## Ejercicio 4: Leer el registro de auditoría (10 min)

1. En el Explorador de archivos de Windows, peguen esta ruta en la barra de direcciones y presionen Enter:

   ```text
   %LOCALAPPDATA%\Microsoft\powerbi-authoring-mcp\Logs
   ```

   Verán archivos `audit-AAAA-MM-DD-pNNNN.log`: uno por día y por cada vez que arrancó un servidor. Abran el más reciente con el Bloc de notas y miren una línea.

   > **Resultado esperado:** Archivos con nombres como `audit-2026-11-02-p1234.log`. Cada línea es un texto en formato JSON que empieza por `{"SchemaVersion":2`.

2. Para leerlo como tabla, copien todo el bloque, péguenlo en PowerShell y presionen Enter:

   ```powershell
   $logs = "$env:LOCALAPPDATA\Microsoft\powerbi-authoring-mcp\Logs"
   Get-ChildItem $logs -Filter *.log |
     Where-Object { $_.LastWriteTime -gt (Get-Date).Date } |
     Get-Content | ConvertFrom-Json |
     Select-Object CreationTime, Operation, ResultStatus,
       @{n='Herramienta'; e={ ($_.OperationProperties | Where-Object Name -eq 'MCPTool').Value }},
       @{n='Accion';      e={ ($_.OperationProperties | Where-Object Name -eq 'MCPOperation').Value }} |
     Format-Table -AutoSize
   ```

   **Cómo leer el resultado:** cada fila es una operación del servidor sobre un modelo. `CreationTime` está en hora UTC (en Colombia, 5 horas menos). `ReadByPowerBIMCP` es una lectura y `ModifiedByPowerBIMCP` es un cambio.

   > **Resultado esperado:** Una tabla con las columnas CreationTime, Operation, ResultStatus, Herramienta y Accion. Ejemplo: `ReadByPowerBIMCP · Succeeded · measure_operations · List`.

3. Busquen en la tabla:
   - Sus lecturas del Ejercicio 1 y 2, por ejemplo `measure_operations` con la acción `List` o `Get`, y `dax_query_operations` con `Execute`.
   - La creación de `Prueba Export`: `ModifiedByPowerBIMCP`, `measure_operations`, `Create`.
   - La exportación: `database_operations`, `ExportToTmdlFolder`.
   - La medida `Prueba Bloqueo` del Ejercicio 1.

   > **Resultado esperado:** Una fila `ModifiedByPowerBIMCP · measure_operations · Create` (Prueba Export) y una `database_operations · ExportToTmdlFolder`. No hay ninguna fila por Prueba Bloqueo.

✔ **Verificación**

- Hay al menos una fila `ModifiedByPowerBIMCP` con `measure_operations` y `Create`: es `Prueba Export`.
- Hay una fila con `ExportToTmdlFolder`.
- **No** hay ninguna fila por `Prueba Bloqueo`: el servidor la rechazó antes de tocar el modelo, así que no hubo operación que registrar. Las consultas DAX que fallaron en la carpeta tampoco aparecen.

## Cierre del laboratorio (4 min)

1. **Ctrl+Shift+P** → `MCP: List Servers`: dejen **powerbi-authoring-local** en **Running** y **powerbi-solo-lectura** detenido. Lo usaremos de nuevo en el Tema 3.
2. Pueden borrar la carpeta `C:\CursoPBI\Temp`; ya cumplió su función.
3. Cierren Power BI Desktop **sin guardar** si les pregunta.

## Reto opcional: conexión a Fabric

Solo si su organización tiene un área de trabajo de desarrollo en Fabric o Power BI Premium con un modelo publicado y ustedes tienen permiso para leerlo. Con el servidor de solo lectura encendido, escriban en el chat:

```text
Conéctate al modelo semántico '<NombreDelModelo>' del área de trabajo de
Fabric '<NombreDelArea>'. Sin hacer cambios, lista sus tablas y medidas.
```

Inicien sesión con su cuenta de Microsoft Entra ID cuando se les pida. Luego pidan la lista de conexiones abiertas y comprueben que la de Fabric no es fuera de línea.

## Solución de problemas

| Síntoma | Causa probable | Acción |
|---|---|---|
| **powerbi-solo-lectura** no aparece en *MCP: List Servers* | `mcp.json` no está en `C:\CursoPBI\.vscode\` o tiene un error | Revisar el nombre de la carpeta (`.vscode`, con punto) y del archivo; VS Code marca en rojo los errores del JSON |
| Aparece la opción *Show locally configured servers…* | VS Code agrupa los servidores de la carpeta aparte | Elegir esa opción y encender **powerbi-solo-lectura** desde ahí, o abrir `mcp.json` y usar **Start** sobre el nombre del servidor |
| **powerbi-solo-lectura** queda en **Error** | No hay conversación abierta o `npx` no puede descargar el servidor (sin internet o con proxy) | Enviar un mensaje en el chat y volver a ▷; si sigue, usar la alternativa sin `npx` de abajo |
| El agente creó `Prueba Bloqueo` sin error | La llamada la atendió **powerbi-authoring-local**, que no está en solo lectura | Detener powerbi-authoring-local, eliminar la medida en Desktop (clic derecho → **Eliminar del modelo**) y repetir desde el paso 8 |
| La ruta de la carpeta no funciona | No llega hasta `definition` | Usar la ruta completa que termina en `TiendasAndinas.SemanticModel\definition` |
| Al hacer clic en **+** aparece *Search attachments* | Ese **+** del cuadro de texto adjunta archivos | Presionar Esc y usar **Ctrl+Shift+P** → `Chat: New Chat` |
| El agente consulta la conexión equivocada | Varias conexiones abiertas | Nombrar la conexión en el prompt: "en la conexión de carpeta" o "en la conexión de Desktop" |
| El segundo `Select-String` **sí** encuentra `Prueba Export` | Se aprobó una exportación sin ruta o con la ruta original, y se sobrescribió el proyecto | Avisar al instructor. Para recuperar el proyecto, descomprimir de nuevo `TiendasAndinas` desde `CursoPBI.zip` |
| `Select-String` dice que no encuentra el archivo | La exportación no terminó o se hizo a otra ruta | Revisar en el Explorador la carpeta `C:\CursoPBI\Temp\export_prueba\tables` |
| La tabla de auditoría sale vacía | El filtro de fecha usa la hora local y el archivo es de ayer en UTC | Quitar la línea `Where-Object` y volver a ejecutar |
| Aparece `accept_eula` en las herramientas | Falta `--accept-eula` en `mcp.json` | Revisar el archivo y reiniciar el servidor |

**Alternativa sin `npx`:** usen el programa que ya trae la extensión. En el Explorador de Windows, abran `%USERPROFILE%\.vscode\extensions`, busquen la carpeta que empieza por `analysis-services.powerbi-modeling-mcp` y, dentro de `server`, el archivo `powerbi-modeling-mcp.exe`. En `mcp.json` reemplacen `command` y `args` así (ajusten el nombre de la carpeta si su versión es distinta):

```json
"command": "${userHome}\\.vscode\\extensions\\analysis-services.powerbi-modeling-mcp-1.0.0-win32-x64\\server\\powerbi-modeling-mcp.exe",
"args": ["--start", "--readonly", "--accept-eula"]
```

## Resumen y entregables

- `C:\CursoPBI\.vscode\mcp.json` con el servidor **powerbi-solo-lectura**.
- Evidencia de que el servidor de solo lectura rechazó `Prueba Bloqueo`.
- La tabla comparativa de Desktop y carpeta PBIP.
- La exportación de prueba en una carpeta temporal y el proyecto original intacto.
- Sus operaciones identificadas en el registro de auditoría.

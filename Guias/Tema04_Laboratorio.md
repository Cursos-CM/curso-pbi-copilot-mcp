# Laboratorio 4: Biblioteca de prompts para Tiendas Andinas

| Dato | Detalle |
|---|---|
| Duración | 60 minutos |
| Modalidad | Individual |
| Punto de partida | Equipo preparado. No hace falta haber terminado los laboratorios anteriores. No importa si el equipo se reinició o si cerraron todo: el **Arranque** deja el entorno listo |
| Resultado esperado | La carpeta `C:\CursoPBI\.github` con `copilot-instructions.md` y tres archivos `.prompt.md` probados, y el chat configurado para que el agente no pueda editar archivos ni escribir en el modelo |

## Objetivos

- Redactar prompts con los cinco componentes: contexto, objetivo, restricciones, formato y criterio.
- Escribir las instrucciones del proyecto en `.github/copilot-instructions.md`.
- Crear archivos de prompt reutilizables que se lanzan con `/` en el chat.
- Limitar las herramientas del agente, en lugar de solo pedirle que no haga algo.

## Escenario

El equipo de BI de Tiendas Andinas va a crecer: el próximo mes llegan dos analistas. La gerencia quiere que cualquier persona del equipo trabaje con el agente con el mismo procedimiento seguro, sin depender de que cada uno recuerde las reglas. Su tarea es construir la biblioteca de instrucciones y prompts del proyecto, y demostrar que funciona. **Regla del encargo: el modelo no se modifica.**

> **Cómo leer esta guía:** cada recuadro gris con texto en español es un **mensaje para el chat de Copilot**: cópienlo, péguenlo en el cuadro del chat y presionen **Enter**. Los recuadros que empiezan con `---` o con `#` son **contenido de archivos**: se pegan en el archivo que indica el paso, no en el chat. En este laboratorio **no se usa PowerShell ni la terminal**.
>
> **Modo demo:** si no pueden ejecutar el laboratorio en su equipo, sigan al instructor en la pantalla compartida con esta misma guía. Los recuadros **Resultado esperado** muestran lo que debe aparecer.
>
> **Copilot Free:** el laboratorio usa unos 7 mensajes. Los archivos los crean ustedes en el Explorador de VS Code, **no el agente**: así no gastan cuota. Envíen un mensaje a la vez y no repitan un mensaje si el agente ya respondió. Si se les acaba la cuota, sigan en modo demo o en pareja.
>
> **Aprobaciones:** conectarse y las consultas DAX no piden aprobación. Las demás herramientas de Power BI sí la piden, aunque solo lean. La ventana muestra el servidor, la herramienta y, en **Input**, la operación. Si dice **powerbi-solo-lectura** y la operación es List o Get, elijan **Allow in this Session**. Si dice **powerbi-authoring-local**, elijan **Skip**.

## Arranque: dejar el entorno listo (8 min)

Cada laboratorio empieza desde cero: no supongan que algo quedó abierto de la sesión anterior.

1. Si Power BI Desktop o VS Code están abiertos de antes, ciérrenlos. Si Desktop pregunta si desean guardar, elijan **No guardar**.
2. Hagan doble clic en `C:\CursoPBI\TiendasAndinas\TiendasAndinas.pbip` y esperen a que Power BI Desktop termine de abrirlo. Si tienen otros archivos de Power BI abiertos, ciérrenlos.
3. En el panel **Datos** de Desktop, expandan `FACT_Ventas` y abran la **vista de tabla** (segundo icono de la barra izquierda). Si la tabla aparece vacía, vayan a **Inicio → Actualizar** y esperen a que termine.

   > **Resultado esperado:** La vista de tabla de `FACT_Ventas` muestra filas con datos.

4. Abran **Visual Studio Code** → **File → Open Folder…** → `C:\CursoPBI` → **Seleccionar carpeta**. Si pregunta si confían en los autores, elijan **Yes, I trust the authors**.
5. En el **Explorador** de VS Code (Ctrl+Shift+E), comprueben que existe `.vscode\mcp.json` y ábranlo.
   - Si existe y define **powerbi-solo-lectura** con `--readonly`, no lo cambien. Si en command dice npx o ${userHome}, o la ruta no termina en powerbi-modeling-mcp.exe, borren todo su contenido (Ctrl+A y Supr), peguen el bloque de abajo y guarden con Ctrl+S.
   - Si **no existe**, créenlo: pasen el cursor sobre **CURSOPBI** → icono **New Folder** → `.vscode`; clic derecho sobre `.vscode` → **New File…** → `mcp.json`; peguen este contenido y guarden con **Ctrl+S**:

   ```json
   {
     "servers": {
       "powerbi-solo-lectura": {
         "type": "stdio",
         "command": "${env:USERPROFILE}\\.vscode\\extensions\\analysis-services.powerbi-modeling-mcp-1.0.0-win32-x64\\server\\powerbi-modeling-mcp.exe",
         "args": [
           "--start",
           "--readonly",
           "--accept-eula"
         ]
       }
     }
   }
   ```

   > **Resultado esperado:** `C:\CursoPBI\.vscode\mcp.json` abierto, sin subrayados rojos, con el servidor **powerbi-solo-lectura** y el parámetro `--readonly`.

6. Trabajen en el **panel de chat de la derecha**. Abran una conversación nueva con el **+** de la **parte superior del panel de chat**. Miren la **parte inferior** del chat, debajo del cuadro de texto:
   - Si dice **Copilot**, hagan clic sobre esa palabra y elijan **Local**.
   - Si ya dice **Local**, no cambien nada. Si aparece una encuesta preguntando por qué cambiaron, ciérrenla con la **X**.

   > **Resultado esperado:** Debajo del cuadro de texto dice **Local**, y el cuadro muestra *Describe what to build*.

7. Quiten al agente las herramientas que no debe tener. En el cuadro del chat, hagan clic en el icono **Configure Tools** (el de los controles deslizantes, a la derecha de **Auto**). En la lista:
   - Dentro de **Built-In**, **desmarquen** `edit` (editar archivos) y `execute` (ejecutar programas).
   - **Desmarquen** la línea **Power BI Authoring MCP Server (Local) powerbi-authoring-local**.
   - Dejen **marcada** la línea **powerbi-solo-lectura** y también `read` y `search`.
   - Hagan clic en **OK**.

   > **Resultado esperado:** En la lista quedan sin marcar `edit`, `execute` y **powerbi-authoring-local**. VS Code aplica esta selección a todos los chats en modo Local.

✔ **Verificación**

- Desktop muestra Tiendas Andinas con datos en `FACT_Ventas`, y es el único archivo de Power BI abierto.
- El chat de la derecha dice **Local**.
- En **Configure Tools**, `edit`, `execute` y **powerbi-authoring-local** están sin marcar.

## Ejercicio 1: Prompt vago contra prompt estructurado (8 min)

1. Escriban en el chat el prompt vago:

   ```text
   Revisa las relaciones y mejóralas.
   ```

   Si aparece una aprobación, léanla antes de decidir: si la operación no es List ni Get, o si el servidor es **powerbi-authoring-local**, elijan **Skip**.

   > **Resultado esperado:** Una respuesta general. Es posible que el agente intente cambiar algo y no pueda, porque ya no tiene herramientas para editar ni para escribir en el modelo. Si debajo de la respuesta aparece **files changed** con **Keep** y **Undo**, elijan **Undo**.

2. Abran una conversación nueva con el **+** de la parte superior del chat (si abajo vuelve a decir **Copilot**, cámbienlo a **Local**). Escriban el prompt estructurado:

   ```text
   CONTEXTO: Modelo TiendasAndinas abierto en Power BI Desktop. Usa el servidor powerbi-solo-lectura.
   OBJETIVO: Evaluar las relaciones del modelo.
   RESTRICCIONES: No hagas cambios en el modelo ni en ningún archivo.
   FORMATO: Una tabla con: desde, hacia, dirección, activa y evaluación. Máximo 8 filas.
   CRITERIO: Deben aparecer las 6 relaciones. Al final, di qué tablas de hechos no tienen relación con Calendario.
   ```

   El agente se conecta (sin aprobación) y pide permiso para **Relationship Operations** y quizá **Table Operations**: si dicen **powerbi-solo-lectura** y la operación es **List**, elijan **Allow in this Session**.

   > **Resultado esperado:** Una tabla con las 6 relaciones. La de `FACT_Ventas[cust_id]` → `Cliente[cust_id]` aparece como **bidireccional**. Al final dice que **fact_devoluciones** y **Presupuesto** no tienen relación con Calendario. Ningún cambio.

3. Comparen las dos respuestas. Marquen con una X en esta tabla (pueden copiarla a un papel o a un archivo de notas):

   | | Prompt vago | Prompt estructurado |
   |---|---|---|
   | ¿Usó el servidor de solo lectura? | | |
   | ¿Intentó cambiar algo? | | |
   | ¿Trajo las 6 relaciones? | | |
   | ¿Pueden comprobar la respuesta? | | |

✔ **Verificación**

- La respuesta estructurada tiene las 6 relaciones, marca la bidireccional y nombra fact_devoluciones y Presupuesto.
- No quedó ningún archivo cambiado: si apareció **Keep / Undo**, eligieron **Undo**.

## Ejercicio 2: Las instrucciones del proyecto (12 min)

1. Creen el archivo en el **Explorador** de VS Code:
   - Pasen el cursor sobre **CURSOPBI** → icono **New Folder** → escriban `.github` (con el punto) → Enter.
   - Clic derecho sobre `.github` → **New File…** → `copilot-instructions.md` → Enter.
2. Peguen este contenido en el archivo:

   ```markdown
   # Instrucciones del proyecto Tiendas Andinas

   ## Contexto
   - Modelo semántico de Power BI TiendasAndinas (retail ficticio de Colombia, datos 2024 y 2025), en la carpeta TiendasAndinas.
   - Tablas de hechos: FACT_Ventas, fact_devoluciones y Presupuesto. Dimensiones: Calendario, Cliente, dim_producto, dim_subcategoria y tbl_Tienda.
   - Usa siempre los nombres exactos de los objetos del modelo.

   ## Conexión
   - Usa solo el servidor MCP powerbi-solo-lectura.
   - Si no hay una conexión activa, conéctate primero al archivo TiendasAndinas abierto en Power BI Desktop.
   - Si no encuentras ninguna instancia de Power BI Desktop, lee el número del archivo msmdsrv.port.txt que está en %LOCALAPPDATA%\Microsoft\Power BI Desktop\AnalysisServicesWorkspaces (subcarpeta Data) y conéctate a localhost con ese puerto.

   ## Respuestas
   - Responde siempre en español, breve, con tablas en Markdown.
   - Cuando des un número calculado, muestra la consulta DAX que lo produjo.

   ## Seguridad
   - Antes de cualquier cambio en el modelo, propone un plan numerado y espera mi aprobación.
   - Nunca borres ni renombres sin mi confirmación. Antes, busca qué lo usa: otras medidas y los visuales del informe (archivos visual.json dentro de TiendasAndinas/TiendasAndinas.Report/definition).
   - No incluyas contraseñas, tokens ni datos personales.

   ## Convenciones DAX
   - Divide con DIVIDE. Filtra con CALCULATE, no con SUMX(FILTER()).
   - Formatos: moneda \$#,0;(\$#,0);\$#,0 · porcentaje 0.0% · enteros #,0.
   - Inteligencia de tiempo sobre Calendario[Fecha], sin años fijos en el código.
   ```

3. Agreguen **dos reglas propias** al final, en una sección `## Mis reglas`. Deben ser concretas y comprobables. Ejemplos de la forma (escriban las suyas):
   - `- Cuando propongas una medida, indica también en qué carpeta de visualización va.`
   - `- Si una respuesta pasa de 15 filas, resume y pregúntame si quiero el detalle.`

   Guarden con **Ctrl+S**.

   > **Resultado esperado:** El archivo `C:\CursoPBI\.github\copilot-instructions.md` existe, tiene las secciones del bloque y sus dos reglas propias.

4. Prueben el efecto. Abran una conversación nueva con el **+** (y **Local** abajo) y escriban **solo** esto:

   ```text
   Crea una medida que cuente las órdenes.
   ```

   > **Resultado esperado:** Aunque el mensaje es corto, el agente responde en español, propone una medida con `DISTINCTCOUNT(FACT_Ventas[NumOrden])` y formato `#,0`, y **pide su aprobación** antes de crearla. **No la aprueben.** Si responde que no puede crearla porque no tiene herramientas de escritura, también es correcto: así lo configuraron.

5. Comparen con lo que habría pasado sin instrucciones: el mensaje no decía idioma, formato ni «espera mi aprobación». Todo eso salió del archivo que acaban de escribir.

✔ **Verificación**

- El agente respondió en español, propuso la medida y no la creó.
- Ningún archivo del modelo cambió (no apareció **Keep / Undo**, o eligieron **Undo**).

## Ejercicio 3: Sus archivos de prompt (15 min)

Van a crear tres archivos en la carpeta `.github\prompts`: el primero completo, el segundo para completar y el tercero escrito por ustedes.

1. Creen la carpeta: clic derecho sobre `.github` → **New Folder…** → `prompts` → Enter.
2. **Prompt 1, completo.** Clic derecho sobre `prompts` → **New File…** → `plan-de-cambio.prompt.md`. Peguen y guarden con **Ctrl+S**:

   ```markdown
   ---
   agent: 'agent'
   description: 'Plan de cambio en el modelo, sin ejecutar nada'
   argument-hint: 'Describa el cambio que necesita'
   ---
   Necesito este cambio en el modelo TiendasAndinas: ${input:cambio}

   NO EJECUTES NADA. Solo propone un plan.

   1. Primero, lista lo que depende del objeto: otras medidas que lo usan y visuales del informe (busca su nombre en los archivos visual.json de TiendasAndinas/TiendasAndinas.Report/definition).
   2. Luego, un plan numerado. En cada paso: qué herramienta usarías, qué objeto cambia, qué riesgo tiene y cómo se revierte.
   3. Al final, cómo comprobarías que quedó bien.

   Responde con dos tablas: Dependencias y Plan.
   ```

3. **Prompt 2, para completar.** Creen `crear-medida.prompt.md` en la misma carpeta y peguen este contenido. Luego **reemplacen las dos líneas que dicen COMPLETAR** con reglas suyas, y guarden:

   ```markdown
   ---
   agent: 'agent'
   description: 'Propuesta de medida DAX a partir de un requisito de negocio'
   argument-hint: 'Describa el indicador que necesita'
   ---
   Requisito de negocio: ${input:requisito}

   No crees nada todavía. Propón la medida en una tabla con: nombre, expresión DAX, formato, carpeta y descripción para el usuario de negocio.

   Reglas:
   - Reutiliza medidas que ya existan, por ejemplo [Total Ventas].
   - COMPLETAR: una regla sobre cómo dividir.
   - COMPLETAR: una regla sobre fechas.
   - Después de la tabla, ejecuta una consulta DAX que calcule la expresión propuesta por Calendario[Anio] (con DEFINE MEASURE, sin crearla en el modelo) y muestra el resultado.
   ```

   > Pista: las reglas que faltan ya están en sus instrucciones del proyecto, en **Convenciones DAX**.

4. **Prompt 3, escrito por ustedes.** Creen `revisar-relaciones.prompt.md`. Escríbanlo desde cero con el encabezado de los otros dos y los cinco componentes. Debe pedir:
   - que no haga cambios;
   - una tabla con todas las relaciones (desde, hacia, cardinalidad, dirección, activa);
   - una segunda tabla de problemas con severidad Alta, Media o Baja, que revise relaciones bidireccionales, tablas de hechos sin relación con Calendario y tablas sin ninguna relación;
   - un máximo de filas.

   Guarden con **Ctrl+S**.

5. Comprueben que VS Code los encuentra. En un chat en modo **Local**, escriban solo `/` en el cuadro (sin enviar) y busquen sus tres prompts. Luego borren la `/`.

   > **Resultado esperado:** En la lista aparecen **/plan-de-cambio**, **/crear-medida** y **/revisar-relaciones**, cada uno con su descripción. Si no aparecen, revisen que el pie del chat diga **Local**.

✔ **Verificación**

- `C:\CursoPBI\.github\prompts` tiene tres archivos que terminan en `.prompt.md`.
- Los tres aparecen al escribir `/` en un chat **Local**.

## Ejercicio 4: Probar y refinar (12 min)

Cada prueba va en una conversación nueva, con **Local** abajo. Escriban el comando, un espacio y el texto, y presionen **Enter**.

1. **El prompt que protege el informe.** Escriban:

   ```text
   /plan-de-cambio Eliminar la medida Ventas Totales porque está duplicada
   ```

   > **Resultado esperado:** Una tabla de **Dependencias** que incluye la tarjeta **Ventas (KPI gerencia)** del informe, que usa `Ventas Totales`, y un **Plan** que primero reasigna esa tarjeta a `Total Ventas` y después elimina la medida. El agente no ejecuta nada.

2. **Su prompt completado.** Escriban:

   ```text
   /crear-medida Unidades vendidas: suma de la cantidad vendida
   ```

   > **Resultado esperado:** La propuesta `SUM(FACT_Ventas[Cantidad])`, formato `#,0`, y una consulta con `DEFINE MEASURE` que da **24.249** en 2024 y **27.531** en 2025. La medida **no** se crea en el modelo.

3. **Su prompt escrito desde cero.** Escriban:

   ```text
   /revisar-relaciones
   ```

   > **Resultado esperado:** La tabla con las 6 relaciones y una tabla de problemas que incluye, como mínimo, la relación bidireccional FACT_Ventas–Cliente (Alta), fact_devoluciones sin Calendario y Presupuesto sin relaciones.

4. **Refinar.** Elijan **una** de las tres pruebas que no haya cumplido su resultado esperado (o la que menos les haya gustado). Cambien **el archivo** `.prompt.md`, no el mensaje del chat: agreguen la restricción, el formato o el criterio que faltó. Guarden y vuelvan a ejecutarla en una conversación nueva.

✔ **Verificación**

- `/plan-de-cambio` advirtió la tarjeta **Ventas (KPI gerencia)**.
- `/crear-medida` dio 24.249 y 27.531 sin crear la medida.
- `/revisar-relaciones` trajo las 6 relaciones y los problemas principales.
- Mejoraron un archivo y volvieron a probarlo.

## Ejercicio 5: Comparar con la biblioteca base (5 min)

1. En el Explorador de VS Code, abran `Prompts\.github\copilot-instructions.md` y la carpeta `Prompts\.github\prompts`. Es la biblioteca base del curso: tiene 10 prompts.
2. Comparen con los suyos y anoten:
   - **Tres ideas** de la biblioteca base que adoptarían.
   - **Una idea** suya que les parezca mejor que la de la base.
3. Si quieren, copien a su `.github\prompts` uno de los prompts base que no tengan (por ejemplo `explicar-medida.prompt.md`): clic derecho → **Copy**, clic derecho sobre su carpeta `prompts` → **Paste**.

✔ **Verificación**

- Tienen anotadas tres ideas para adoptar y una propia.

## Cierre del laboratorio (2 min)

1. Cierren Power BI Desktop. Si pregunta si desean guardar, elijan **No guardar**.
2. Dejen la carpeta `C:\CursoPBI\.github` donde está: la usarán en los Laboratorios 5 a 8.
3. Dejen **Configure Tools** como quedó. El Laboratorio 5 les indicará qué herramientas volver a activar cuando haya que escribir en el modelo.

## Reto opcional

Solo si les sobra tiempo y cuota. Elijan **uno**:

- **Un prompt con sus propias herramientas.** Agreguen al encabezado de `revisar-relaciones.prompt.md` la línea `tools: ['read', 'search', 'powerbi-solo-lectura/*']`. Así ese prompt solo puede leer, aunque alguien vuelva a activar `edit` en Configure Tools. Ejecútenlo de nuevo y comprueben que funciona igual.
- **Dos audiencias.** Creen `explicar-para-gerencia.prompt.md`, que pida explicar una medida (`${input:medida}`) en tres líneas para un gerente comercial, sin fórmulas, con un ejemplo en pesos. Pruébenlo con `Ticket Promedio`.

## Solución de problemas

| Síntoma | Causa probable | Acción |
|---|---|---|
| Al escribir `/` no aparecen sus prompts | El chat está en modo **Copilot**, o el archivo está mal ubicado | Cambiar el pie del chat a **Local**. Los archivos deben estar en `C:\CursoPBI\.github\prompts` y terminar en `.prompt.md` |
| El pie del chat volvió a decir **Copilot** | Cada conversación nueva arranca en el modo por defecto | Clic sobre **Copilot** → **Local** |
| Aparece **N files changed** con **Keep** y **Undo** | El agente editó archivos con sus herramientas, sin pasar por el servidor | Elegir **Undo**. Revisar en **Configure Tools** que `edit` esté desmarcado |
| Aparece una aprobación de **powerbi-authoring-local** | Ese servidor sigue marcado en **Configure Tools** | Elegir **Skip** y desmarcarlo en **Configure Tools** |
| El agente dice que no encuentra Power BI Desktop | La detección automática falla en algunos equipos corporativos | La regla de **Conexión** de sus instrucciones lo resuelve con el puerto. Si no, escribir: `Lee el número del archivo msmdsrv.port.txt que está en la carpeta %LOCALAPPDATA%\Microsoft\Power BI Desktop\AnalysisServicesWorkspaces (dentro de la subcarpeta Data) y conéctate a Power BI Desktop en localhost con ese puerto.` |
| La consulta DAX devuelve 0 filas o valores en blanco | El modelo de Desktop no tiene datos cargados | En Desktop, **Inicio → Actualizar**, y repetir la prueba |
| El agente no responde en español | No leyó las instrucciones del proyecto | Revisar que el archivo se llame exactamente `copilot-instructions.md` y esté en `C:\CursoPBI\.github`; abrir una conversación nueva |
| **powerbi-solo-lectura** no aparece en Configure Tools | `mcp.json` no está en `C:\CursoPBI\.vscode\` o tiene un error | Revisar el Arranque, paso 5 |
| El chat deja de responder por límite de uso | Se acabó la cuota mensual de Copilot Free | Seguir en modo demo o en pareja |

## Resumen y entregables

- `C:\CursoPBI\.github\copilot-instructions.md` con las reglas del proyecto y dos reglas propias.
- `C:\CursoPBI\.github\prompts\` con `plan-de-cambio`, `crear-medida` y `revisar-relaciones`, probados.
- El chat en modo **Local** con `edit`, `execute` y **powerbi-authoring-local** desactivados.
- La comparación del Ejercicio 1 y las ideas del Ejercicio 5.

Esta biblioteca se usará en los Laboratorios 5 a 8.

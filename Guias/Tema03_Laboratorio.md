# Laboratorio 3: Diagnóstico inicial del modelo

| Dato | Detalle |
|---|---|
| Duración | 60 minutos |
| Modalidad | Individual |
| Punto de partida | Equipo preparado. No hace falta haber terminado el Laboratorio 2. No importa si el equipo se reinició o si cerraron todo: el **Arranque** deja el entorno listo |
| Resultado esperado | Las cifras de control comprobadas, dos diagnósticos (estructura y DAX) con severidad, dos hallazgos verificados con consultas DAX y otros en Desktop, y el archivo `diagnostico_inicial.md` |

## Objetivos

- Obtener el inventario del modelo con lenguaje natural y validarlo con cifras de control.
- Pedir al agente un diagnóstico frente a buenas prácticas con criterios de severidad explícitos.
- Verificar hallazgos con consultas DAX y con Power BI Desktop, sin creerle al agente a ciegas.
- Entregar un diagnóstico escrito, sin modificar el modelo.

## Escenario

La gerencia comercial de Tiendas Andinas, una cadena de retail ficticia con 15 tiendas físicas y una tienda online, heredó un modelo semántico construido por un proveedor anterior. Antes de invertir en mejoras, pidió un diagnóstico independiente: qué está bien, qué está mal, qué tan grave es y cómo se demuestra. Ustedes son los consultores. **Regla del encargo: no se modifica nada.**

> **Cómo leer esta guía:** cada recuadro gris con texto en español es un **mensaje para el chat de Copilot**: cópienlo, péguenlo en el cuadro *Chat with Copilot* y presionen **Enter**. Los recuadros con contenido JSON se indican aparte. En este laboratorio **no se usa PowerShell ni la terminal**.
>
> **Modo demo:** si no pueden ejecutar el laboratorio en su equipo, sigan al instructor en la pantalla compartida con esta misma guía. Debajo de los pasos, los recuadros **Resultado esperado** muestran lo que debe aparecer, para que puedan comprobarlo y responder las verificaciones.
>
> **Copilot Free:** el laboratorio usa unos 9 mensajes. Copien los mensajes tal cual, envíen uno a la vez y no repitan un mensaje si el agente ya respondió: si falta algo, pidan solo lo que falta. Si se les acaba la cuota, sigan en modo demo o en pareja con un compañero.
>
> **Aprobaciones:** en este laboratorio el agente solo lee, y en VS Code las lecturas (conexiones, `List`, `Get`, `GetStats` y consultas DAX) **no piden aprobación**. Si aparece una aprobación (**Allow tool from…?**), es porque el agente quiere cambiar algo: elijan **Skip**. La excepción es el Ejercicio 5, cuando el agente crea el archivo del diagnóstico.

## Arranque: dejar el entorno listo (6 min)

Cada laboratorio empieza desde cero: no supongan que algo quedó abierto de la sesión anterior.

1. Si Power BI Desktop o VS Code están abiertos de antes, ciérrenlos. Si Desktop pregunta si desean guardar, elijan **No guardar**.
2. Hagan doble clic en `C:\CursoPBI\TiendasAndinas\TiendasAndinas.pbip` y esperen a que Power BI Desktop termine de abrirlo. Si tienen otros archivos de Power BI abiertos, ciérrenlos.
3. En el panel **Datos** de Desktop, expandan `FACT_Ventas` y abran la **vista de tabla** (segundo icono de la barra izquierda). Si la tabla aparece vacía, vayan a **Inicio → Actualizar** y esperen a que termine.

   > **Resultado esperado:** La vista de tabla de `FACT_Ventas` muestra filas con datos.

4. Abran **Visual Studio Code** → **File → Open Folder…** → `C:\CursoPBI` → **Seleccionar carpeta**. Si pregunta si confían en los autores, elijan **Yes, I trust the authors**.
5. En el **Explorador** de VS Code (Ctrl+Shift+E), comprueben que existe `.vscode\mcp.json`, el archivo del Laboratorio 2. Si existe, ábranlo.
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

6. Trabajen en el **panel de chat de la derecha**. Si hay pestañas de chat abiertas en el centro, ciérrenlas. Abran una conversación nueva con el **+** de la **parte superior del panel de chat** (no el **+** del cuadro de texto, que adjunta archivos). Confirmen **Copilot** (o **Agent**) y **Manual permissions**, escriban `Hola` y esperen la respuesta.
7. **Ctrl+Shift+P** → `MCP: List Servers`:
   - **powerbi-solo-lectura** → si no dice **Running**, clic en su nombre → **Start Server**.
   - **powerbi-authoring-local** y **github-mcp-server** → si dicen **Running**, clic en su nombre → **Stop Server**.

   > **Resultado esperado:** **powerbi-solo-lectura** en **Running**; los otros dos detenidos.

✔ **Verificación**

- Desktop muestra Tiendas Andinas con datos en `FACT_Ventas`, y es el único archivo de Power BI abierto.
- **powerbi-solo-lectura** dice **Running** y los otros dos servidores están detenidos.
- Hay una sola conversación abierta, en el chat de la derecha.

## Ejercicio 1: Conexión y cifras de control (10 min)

1. Conéctense a Desktop. Escriban en el chat:

   ```text
   Conéctate al archivo 'TiendasAndinas' abierto en Power BI Desktop.
   No hagas cambios.
   ```

   Es una lectura: el agente se conecta sin pedir aprobación.

   > **Resultado esperado:** El agente confirma la conexión a TiendasAndinas.

2. Pidan las cifras de control y las relaciones. Escriban en el chat:

   ```text
   Sin hacer cambios, usa las estadísticas del modelo (GetStats) y dime
   cuántas tablas, medidas, relaciones y roles tiene.
   Luego lista las relaciones en una tabla con: tabla y columna de origen,
   tabla y columna de destino, cardinalidad, dirección del filtro y si está activa.
   Responde solo con esas dos tablas, sin explicaciones.
   ```

   El agente usa `model_operations` (**GetStats**) y `relationship_operations` (**List**) sin pedir aprobación.

   > **Resultado esperado:** 8 tablas, 16 medidas, 6 relaciones y 0 roles. La relación `FACT_Ventas[cust_id]` → `Cliente[cust_id]` aparece con dirección **BothDirections** (ambas). Las demás, **OneDirection**.

3. Comparen con la tabla de control. Si algún valor no coincide, **no sigan**: revisen que Desktop tenga abierto solo TiendasAndinas y repitan el paso 1.

   | Elemento | Valor esperado | Lo que respondió el agente |
   |---|---|---|
   | Tablas | 8 | |
   | Medidas | 16 | |
   | Relaciones | 6 | |
   | Roles | 0 | |
   | Relación en ambas direcciones | FACT_Ventas – Cliente | |
   | Tabla que no aparece en ninguna relación | | |

   > Si el agente cuenta tablas ocultas con nombres como `LocalDateTable_…` o `DateTableTemplate_…`, no las sumen a las 8: las crea la opción de fecha y hora automáticas. Anótenlas para el Ejercicio 2.

   > **Resultado esperado:** Los cuatro conteos coinciden. La tabla que no aparece en ninguna relación es **Presupuesto**.

✔ **Verificación**

- Las cifras de control coinciden: **8 tablas, 16 medidas, 6 relaciones, 0 roles**.
- La única relación bidireccional es **FACT_Ventas – Cliente**.
- **Presupuesto** no tiene relaciones.

## Ejercicio 2: Diagnóstico de estructura (12 min)

1. Pidan el diagnóstico de estructura con criterios de severidad. Escriban en el chat:

   ```text
   Sin hacer cambios, evalúa la estructura del modelo frente a buenas prácticas.
   Revisa: esquema (estrella o copo de nieve), granularidad de cada tabla de hechos,
   tablas desconectadas, dirección de las relaciones, tabla de fechas (marcada o no,
   fecha y hora automáticas), columnas de ordenación, claves visibles, resumen
   predeterminado de columnas numéricas, columnas técnicas y columnas calculadas.
   Entrega una tabla con: hallazgo, objeto, severidad y cómo comprobarlo en Desktop.
   Severidad: Alta = produce cifras incorrectas o ambigüedad; Media = funciona hoy
   pero falla en el futuro o confunde al usuario; Baja = mantenimiento.
   Máximo 12 filas, ordenadas por severidad.
   ```

   El agente hace varias lecturas (`table_operations`, `column_operations`, `relationship_operations`, `model_operations`) sin pedir aprobación.

   > **Resultado esperado:** Una tabla de 8 a 12 hallazgos. Entre ellos, como mínimo: la relación bidireccional FACT_Ventas–Cliente, Presupuesto sin relaciones y `fact_devoluciones` sin relación con Calendario.

2. Lean la tabla con ojo crítico. Para cada fila, pregúntense: ¿es un hecho del modelo o una opinión? ¿La severidad sigue el criterio que le dieron? Marquen con un asterisco las filas con las que no estén de acuerdo.

3. Comprueben **en Desktop, sin escribir en el chat**, tres hallazgos de estructura:
   - **Vista de modelo** (tercer icono de la barra izquierda): busquen la línea entre `FACT_Ventas` y `Cliente` y miren si tiene **doble flecha**. Busquen la tabla `Presupuesto` y miren si tiene alguna línea.
   - **Panel Datos → Cliente**: miren si `cust_id` muestra el icono **Σ** (resumen Suma).
   - **Vista de informe → página Resumen**: miren el orden de los meses en el gráfico **Ventas por mes**.

   > **Resultado esperado:** La línea FACT_Ventas–Cliente tiene doble flecha. Presupuesto no tiene ninguna línea. `cust_id` tiene el icono Σ. Los meses salen en orden alfabético (abril, agosto, diciembre…).

✔ **Verificación**

- El diagnóstico incluye la relación bidireccional, Presupuesto desconectada y las devoluciones sin fecha.
- Comprobaron en Desktop la doble flecha, la tabla Presupuesto sin líneas, el Σ en `cust_id` y los meses en orden alfabético.

## Ejercicio 3: Diagnóstico del DAX (8 min)

1. Escriban en el chat:

   ```text
   Sin hacer cambios, revisa la expresión DAX de cada medida y señala solo las que
   tienen problemas: divisiones sin DIVIDE, filtros con SUMX(FILTER()) que deberían
   ser CALCULATE, valores fijos en el código, inteligencia de tiempo que no usa la
   tabla Calendario, medidas duplicadas y medidas de prueba.
   Entrega una tabla con: medida, problema, severidad (mismo criterio) y riesgo en
   una línea.
   ```

   > **Resultado esperado:** Una tabla con, como mínimo: `Ventas Totales` (duplicada de `Total Ventas`), divisiones sin `DIVIDE` en `Margen %`, `Ticket Promedio`, `Tasa Devolucion` y `Cumplimiento`, `Ventas Online` con `SUMX(FILTER())`, `Ventas 2025` con el año fijo, `Ventas YTD` sobre `FACT_Ventas[FechaOrden]` y la medida de prueba `Test`.

2. Comparen con la lista del resultado esperado. Si al agente se le pasó alguna, **no repitan el mensaje completo**: pregunten solo por esa medida, por ejemplo `Sin hacer cambios, evalúa la medida Ventas YTD.`

✔ **Verificación**

- La tabla incluye la medida duplicada, al menos dos divisiones sin `DIVIDE`, el año fijo y la medida de prueba.

## Ejercicio 4: Verificar dos hallazgos con evidencia (12 min)

Un hallazgo entra al diagnóstico solo con evidencia. Van a demostrar con consultas DAX los dos hallazgos de severidad alta que afectan cifras.

1. **Devoluciones sin relación con Calendario.** Escriban en el chat:

   ```text
   Ejecuta una consulta DAX que devuelva [Unidades Devueltas] por Calendario[Anio].
   ```

   La consulta no pide aprobación. Cuando el agente responda, comprueben qué consulta ejecutó: debajo de su mensaje hagan clic en **Completed … steps** y luego en **DAX Query Operations**; en **Input** está la consulta, y debe agrupar por `Calendario[Anio]`.

   > **Resultado esperado:** **2.929** en 2024 y **2.929** en 2025: el mismo total repetido, porque el filtro de año no le llega a `fact_devoluciones`. (Las devoluciones reales por año son 1.324 y 1.605.)

2. **Presupuesto desconectado.** Escriban en el chat:

   ```text
   Ejecuta una consulta DAX con [Total Ventas], [Presupuesto] y [Cumplimiento]
   por dim_subcategoria[Categoria], filtrando Calendario[Anio] = 2025.
   ```

   > **Resultado esperado:** El Presupuesto es el mismo en todas las filas: **11.668.662.000**, el total de los dos años, porque ningún filtro le llega. El Cumplimiento por categoría no tiene sentido: por ejemplo, Tecnología ≈ **22,1 %**.

3. Anoten la evidencia de cada hallazgo en una frase, para el entregable. Por ejemplo: *«Unidades Devueltas da 2.929 en 2024 y en 2025 (consulta por Calendario[Anio])»*.

✔ **Verificación**

- Unidades Devueltas: **2.929** en los dos años.
- Presupuesto: **11.668.662.000** en todas las categorías; Cumplimiento de Tecnología ≈ **22,1 %**.
- Tienen una frase de evidencia por cada hallazgo.

## Ejercicio 5: El entregable diagnostico_inicial.md (9 min)

1. Escriban en el chat:

   ```text
   Crea el archivo TiendasAndinas/diagnostico_inicial.md en la carpeta abierta con:
   1. Resumen ejecutivo de 5 líneas.
   2. Cifras del modelo (tablas, medidas, relaciones, roles).
   3. Tabla de hallazgos con: N.º, hallazgo, objeto, severidad, evidencia y
      recomendación, ordenada por severidad. Usa los hallazgos de esta conversación.
      En evidencia escribe solo lo que se comprobó en esta conversación; si no se
      comprobó, escribe "Por verificar".
   4. Sección "Hipótesis por confirmar".
   No modifiques el modelo.
   ```

   Si VS Code pide permiso para crear el archivo, elijan **Allow Once**. Cuando el agente termine, el archivo aparece en el Explorador dentro de `TiendasAndinas`.

   > **Resultado esperado:** El archivo `C:\CursoPBI\TiendasAndinas\diagnostico_inicial.md` existe y tiene las cuatro secciones. Si VS Code muestra los botones **Keep** y **Undo** sobre el archivo, elijan **Keep**.

2. Abran el archivo y revísenlo **ustedes**, sin pedir más al agente:
   - Corrijan las severidades con las que no estén de acuerdo (las que marcaron con asterisco en el Ejercicio 2).
   - En la columna de evidencia, escriban las frases del Ejercicio 4 y lo que comprobaron en Desktop en el Ejercicio 2.
   - Muevan a **Hipótesis por confirmar** los hallazgos que digan *Por verificar* y que ustedes no hayan comprobado.
   - Guarden con **Ctrl+S**.
3. Para ver el documento con formato: clic derecho sobre el archivo en el Explorador → **Open Preview** (o **Ctrl+Shift+V** con el archivo abierto).

   > **Resultado esperado:** La vista previa muestra los títulos y la tabla de hallazgos con formato. Hay al menos 10 hallazgos, cada uno con severidad, y los de las devoluciones y el presupuesto tienen su cifra como evidencia.

✔ **Verificación**

- Existe `C:\CursoPBI\TiendasAndinas\diagnostico_inicial.md` con resumen, cifras, tabla de hallazgos e hipótesis.
- Al menos 10 hallazgos con severidad; los verificados tienen evidencia concreta.
- El modelo no cambió: en Desktop no aparece ningún aviso de cambios sin guardar.

## Cierre del laboratorio (3 min)

1. Cierren Power BI Desktop. Si pregunta si desean guardar, elijan **No guardar**.
2. Dejen `diagnostico_inicial.md` donde está: les servirá de referencia en los Laboratorios 5 y 6, que empiezan desde su propio punto de partida.
3. En `MCP: List Servers` pueden dejar los servidores como están.

## Reto opcional

Solo si les sobra tiempo y cuota. Elijan **uno**:

- **Dos audiencias.** Escriban en el chat: `Sin hacer cambios, explica este modelo en un párrafo de 5 líneas para un gerente comercial: qué preguntas de negocio responde bien y cuáles todavía no.` Copien el párrafo al resumen ejecutivo si les parece mejor que el que tenían.
- **Plan de corrección.** Escriban en el chat: `Sin ejecutar nada, propone el orden en que corregirías los hallazgos de diagnostico_inicial.md: primero relaciones y fechas, luego columnas, luego DAX y al final nombres y documentación. Responde con una lista numerada de máximo 10 pasos.` Agréguenlo como anexo del archivo.

## Solución de problemas

| Síntoma | Causa probable | Acción |
|---|---|---|
| **powerbi-solo-lectura** no aparece en *MCP: List Servers* | `mcp.json` no está en `C:\CursoPBI\.vscode\` o tiene un error | Revisar el nombre de la carpeta (`.vscode`, con punto) y del archivo; VS Code marca en rojo los errores del JSON |
| **powerbi-solo-lectura** queda en **Error** | No hay conversación abierta, o la ruta de `command` no coincide con la carpeta de su extensión | Enviar un mensaje en el chat y volver a **Start Server**. Comprobar en el Explorador de Windows (`%USERPROFILE%\.vscode\extensions`) el nombre de la carpeta `analysis-services.powerbi-modeling-mcp-…` y corregirlo en `mcp.json` |
| El agente dice que no tiene herramientas de Power BI | El servidor se encendió en otra conversación, o sus herramientas están desmarcadas | Trabajar en un solo chat (el de la derecha); en la caja del chat, clic en el icono de herramientas y marcar **powerbi-solo-lectura** |
| Las cifras de control no coinciden | Conexión a otro archivo de Desktop o inventario resumido | Cerrar los demás archivos de Power BI y repetir la conexión; si el agente resumió, pedir solo el conteo que falta |
| Aparece una aprobación de **powerbi-authoring-local** | Ese servidor sigue encendido | Detenerlo en *MCP: List Servers* y repetir el mensaje |
| «DAX query operations are not supported on offline connections» | El agente usó una conexión de carpeta | Escribir: `Usa la conexión de Power BI Desktop.` |
| El agente quiere crear o cambiar algo en el modelo | Interpretó el diagnóstico como una corrección | Elegir **Skip** en la aprobación. Con el servidor de solo lectura, el cambio se rechaza de todas formas |
| El archivo `diagnostico_inicial.md` quedó en otra carpeta | El agente eligió otra ruta | Arrastrarlo en el Explorador de VS Code a la carpeta `TiendasAndinas` |
| El chat responde *Language model unavailable* | No inició sesión en GitHub dentro de VS Code o no activó Copilot Free | Clic en **Sign In** (abajo a la derecha) o **Ctrl+Shift+P** → *GitHub Copilot: Sign In*; activar Copilot Free en github.com/settings/copilot |
| El chat deja de responder por límite de uso | Se acabó la cuota mensual de Copilot Free | Seguir en modo demo o en pareja; la cuota se renueva el primer día del mes |

## Resumen y entregables

- Cifras de control comprobadas: 8 tablas, 16 medidas, 6 relaciones, 0 roles.
- Diagnóstico de estructura y de DAX con severidad, revisado con criterio propio.
- Dos hallazgos de severidad alta verificados con consultas DAX y tres comprobaciones en Desktop.
- `C:\CursoPBI\TiendasAndinas\diagnostico_inicial.md` con al menos 10 hallazgos, evidencia e hipótesis. Les servirá de referencia en los Laboratorios 5 y 6, que empiezan desde su propio punto de partida.

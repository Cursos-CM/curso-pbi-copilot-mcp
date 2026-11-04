# Laboratorio 1: El entorno en marcha

| Dato | Detalle |
|---|---|
| Duración | 60 minutos |
| Modalidad | Individual |
| Punto de partida | Equipo preparado con la guía "Antes del Día 1" y el paquete del curso descomprimido en `C:\CursoPBI` |
| Resultado esperado | Entorno verificado, modelo Tiendas Andinas con datos, servidor MCP encendido y primeras conversaciones de solo lectura con el agente |

## Objetivos

- Comprobar que todas las piezas del entorno están instaladas.
- Abrir el proyecto PBIP de Tiendas Andinas, cargar los datos y validar los conteos de filas.
- Ejecutar e interpretar consultas en la vista de consultas DAX de Power BI Desktop.
- Confiar en la carpeta del curso, encender el servidor MCP y confirmar que el agente ve sus 21 herramientas.
- Hacer la primera consulta de solo lectura al modelo con GitHub Copilot en modo Agent.
- Explorar el modelo con preguntas en lenguaje natural y contrastar las respuestas con lo que se ve en Power BI Desktop.

## Escenario

Tiendas Andinas es una cadena de retail ficticia con 15 tiendas físicas en 10 ciudades de Colombia y un canal en línea. Su equipo de BI heredó un modelo semántico con varios problemas. Durante el curso ustedes lo van a analizar, corregir, ampliar y documentar con ayuda de GitHub Copilot. Hoy dejan listo el taller.

> **Modo demo:** si no pueden ejecutar el laboratorio en su equipo, sigan al instructor en la pantalla compartida con esta misma guía. Debajo de los pasos, los recuadros **Resultado esperado** muestran lo que debe aparecer, para que puedan comprobarlo y responder las verificaciones.
>
> **Regla de hoy:** no se cambia nada del modelo. Si el agente propone crear, modificar o eliminar algo, rechacen la llamada.

## Ejercicio 1: Verificar los materiales y el entorno (12 min)

### A. Materiales

1. Abran el Explorador de archivos de Windows y vayan a `C:\CursoPBI`.
2. Verifiquen que la estructura es esta:

   ```text
   C:\CursoPBI\
     Datos\                 (8 archivos .csv)
     TiendasAndinas\        (proyecto PBIP de trabajo)
     Checkpoints\           (T05_inicio, T06_inicio, T07_inicio, T08_inicio)
     Prompts\
     LEAME.txt
     ValoresEsperados.md
     Verificar-Entorno.ps1
   ```

   > **Resultado esperado:** En `C:\CursoPBI` se ven las carpetas `Datos`, `TiendasAndinas`, `Checkpoints` y `Prompts`, y los archivos `LEAME.txt`, `ValoresEsperados.md` y `Verificar-Entorno.ps1`.

### B. Entorno

3. Abran **Windows PowerShell** (tecla Windows, escriban `PowerShell` y presionen Enter).
4. Ejecuten:

   ```powershell
   powershell -ExecutionPolicy Bypass -File C:\CursoPBI\Verificar-Entorno.ps1
   ```

5. Lean el resultado. Cada línea empieza con `[OK]`, `[INFO]`, `[ADVERTENCIA]` o `[ERROR]`.

   > **Resultado esperado:** Una lista de líneas que empiezan con `[OK]`: VS Code, Git, Node.js, la extensión, Power BI Desktop, 8 archivos CSV y 5 proyectos `.pbip`. La línea de GitHub Copilot sale como `[INFO]`.

6. Si aparece `[ERROR] Git para Windows no está instalado` o `[ADVERTENCIA] Node.js no instalado`, instálenlos en la misma ventana:

   ```powershell
   winget install --id Git.Git -e --source winget
   winget install --id OpenJS.NodeJS.LTS -e --source winget
   ```

   Cierren PowerShell, ábranlo de nuevo y repitan el paso 4.
7. Abran **Visual Studio Code**. Abran el chat con el **icono de chat** que está arriba, a la derecha del cuadro **Search** (o con **Ctrl+Alt+I**). Si VS Code pide iniciar sesión, elijan **GitHub** y completen el inicio de sesión en el navegador.

   > **Resultado esperado:** El chat de Copilot se abre a la derecha. Al escribir `Hola`, Copilot responde con un saludo.

8. Abran la vista de **Extensiones** (Ctrl+Shift+X), busquen `powerbi-modeling-mcp` y abran la extensión instalada. Comprueben:
   - Nombre: **Power BI Authoring MCP Server**
   - Editor: **Microsoft**
   - Identificador: `analysis-services.powerbi-modeling-mcp`

   > **Resultado esperado:** La extensión se llama **Power BI Authoring MCP Server**, el editor es **Microsoft** y el identificador es `analysis-services.powerbi-modeling-mcp`.

✔ **Verificación**

- Existen las cuatro carpetas y los tres archivos de `C:\CursoPBI`.
- El script muestra `[OK]` para VS Code, Git, Node.js, la extensión `analysis-services.powerbi-modeling-mcp`, Power BI Desktop, los 8 archivos CSV y los 5 proyectos `.pbip`.
- La línea de GitHub Copilot sale como `[INFO]`: Copilot viene integrado en VS Code. Lo que importa es que el chat responda.
- En el chat escriben `Hola` y Copilot responde.

## Ejercicio 2: Abrir el modelo, cargar los datos y consultarlo con DAX (15 min)

1. Hagan doble clic en `C:\CursoPBI\TiendasAndinas\TiendasAndinas.pbip`. Se abre en Power BI Desktop.

   > **Resultado esperado:** Power BI Desktop abre el proyecto TiendasAndinas con la página **Resumen**.

2. Si Desktop muestra avisos de datos o de actualización pendiente, ciérrenlos.
3. Vayan a **Inicio → Transformar datos → Editar parámetros**. En `RutaDatos` confirmen o escriban `C:\CursoPBI\Datos\` (terminada en `\`) y acepten.
4. Si aparece la barra de cambios pendientes, elijan **Aplicar cambios**. Luego, **Inicio → Actualizar**.

   > **Resultado esperado:** Al terminar la actualización, las tarjetas muestran cifras: Total Ventas 11,41 mil M.

5. Abran la **vista de consultas DAX**: es el cuarto icono de la barra izquierda de Desktop, debajo de las vistas de informe, de tabla y de modelo. Peguen esta consulta y ejecútenla con **Ejecutar** (o F5):

   ```dax
   EVALUATE
   UNION (
       ROW ( "Tabla", "FACT_Ventas", "Filas", COUNTROWS ( FACT_Ventas ) ),
       ROW ( "Tabla", "fact_devoluciones", "Filas", COUNTROWS ( fact_devoluciones ) ),
       ROW ( "Tabla", "Presupuesto", "Filas", COUNTROWS ( Presupuesto ) ),
       ROW ( "Tabla", "dim_producto", "Filas", COUNTROWS ( dim_producto ) ),
       ROW ( "Tabla", "dim_subcategoria", "Filas", COUNTROWS ( dim_subcategoria ) ),
       ROW ( "Tabla", "Cliente", "Filas", COUNTROWS ( Cliente ) ),
       ROW ( "Tabla", "tbl_Tienda", "Filas", COUNTROWS ( tbl_Tienda ) ),
       ROW ( "Tabla", "Calendario", "Filas", COUNTROWS ( Calendario ) )
   )
   ```

   **Cómo leer esta consulta:** `COUNTROWS` cuenta las filas de una tabla; `ROW` arma una fila con dos columnas (el nombre de la tabla y su conteo); `UNION` junta las ocho filas en una sola tabla; y `EVALUATE` la devuelve como resultado. El resultado debe coincidir con la columna *Filas* de la diapositiva de Tiendas Andinas.

   > **Resultado esperado:** Una tabla de dos columnas, *Tabla* y *Filas*: FACT_Ventas 34.330 · fact_devoluciones 2.386 · Presupuesto 1.532 · dim_producto 184 · dim_subcategoria 15 · Cliente 2.400 · tbl_Tienda 16 · Calendario 731.

6. En una pestaña nueva de la vista de consultas DAX (botón **+**), ejecuten las ventas por año:

   ```dax
   EVALUATE
   SUMMARIZECOLUMNS (
       Calendario[Anio],
       "Total Ventas", [Total Ventas]
   )
   ```

   **Cómo leer el resultado:** `SUMMARIZECOLUMNS` agrupa por la columna que le indican (aquí, el año) y calcula la medida para cada grupo. Es lo mismo que haría una tabla visual con el año y la medida, pero sin crear el visual.

   > **Resultado esperado:** Dos filas: 2024 → 5121728115 y 2025 → 6287796955.

7. Ahora, por año **y** por canal de venta:

   ```dax
   EVALUATE
   SUMMARIZECOLUMNS (
       Calendario[Anio],
       FACT_Ventas[Canal],
       "Total Ventas", [Total Ventas]
   )
   ORDER BY Calendario[Anio], FACT_Ventas[Canal]
   ```

   **Cómo leer el resultado:** al agregar una segunda columna, cada fila es una combinación de año y canal. Si suman las dos filas de un año, deben obtener el total de ese año del paso 6. `ORDER BY` solo ordena el resultado.

   > **Resultado esperado:** Cuatro filas: 2024 Online 1061802370 · 2024 Tienda 4059925745 · 2025 Online 1967185175 · 2025 Tienda 4320611780.

8. Por último, los cinco productos que más venden:

   ```dax
   EVALUATE
   TOPN (
       5,
       SUMMARIZECOLUMNS ( dim_producto[Producto], "Total Ventas", [Total Ventas] ),
       [Total Ventas], DESC
   )
   ORDER BY [Total Ventas] DESC
   ```

   **Cómo leer el resultado:** `TOPN` toma una tabla (la de ventas por producto) y se queda con las primeras 5 filas según la columna que le indican, de mayor a menor (`DESC`).

   > **Resultado esperado:** Cinco filas, encabezadas por *Portátiles Altiplano Tech Clásico 10* con 305649710.

9. Revisen la página **Resumen** del informe. Van a notar cosas raras (por ejemplo, los meses en orden alfabético). **No las corrijan**: son errores sembrados a propósito para los próximos temas.

   > **Resultado esperado:** En el gráfico de la página Resumen, los meses aparecen en orden alfabético (abr, ago, dic…) en lugar de enero a diciembre.

10. Guarden el proyecto (Ctrl+S) y dejen Desktop **abierto**.

✔ **Verificación**

Paso 5, filas por tabla:

| Tabla | Filas |
|---|---|
| FACT_Ventas | 34.330 |
| fact_devoluciones | 2.386 |
| Presupuesto | 1.532 |
| dim_producto | 184 |
| dim_subcategoria | 15 |
| Cliente | 2.400 |
| tbl_Tienda | 16 |
| Calendario | 731 |

Paso 6, ventas por año: 2024 = **$5.121.728.115** · 2025 = **$6.287.796.955**.

Paso 7, ventas por año y canal:

| Año | Canal | Total Ventas |
|---|---|---|
| 2024 | Online | $1.061.802.370 |
| 2024 | Tienda | $4.059.925.745 |
| 2025 | Online | $1.967.185.175 |
| 2025 | Tienda | $4.320.611.780 |

Paso 8, los cinco productos que más venden:

| Producto | Total Ventas |
|---|---|
| Portátiles Altiplano Tech Clásico 10 | $305.649.710 |
| Portátiles Altiplano Tech One 11 | $252.228.045 |
| Portátiles Voltia Lite 05 | $218.794.540 |
| Portátiles Nexo Lite 06 | $203.187.265 |
| Electrodomésticos Hogarte One 01 | $198.413.350 |

> Desktop muestra los números sin formato (por ejemplo, `5121728115`): la medida todavía no tiene formato de moneda. Lo corregiremos en los próximos temas.

## Ejercicio 3: Confiar en la carpeta y encender el servidor (12 min)

> En VS Code, el servidor de Power BI aparece con el nombre **powerbi-authoring-local**. Así lo van a reconocer en las listas.

1. En VS Code: **File → Open Folder…**, elijan `C:\CursoPBI` y hagan clic en **Seleccionar carpeta**.
2. Cuando VS Code pregunte si confían en los autores, elijan **Yes, I trust the authors**.
   Si ya habían abierto la carpeta y ven el aviso **Restricted Mode**, hagan clic en él → **Manage** → **Trust**.

   > **Resultado esperado:** Desaparece cualquier aviso **Restricted Mode** y el Explorador de VS Code muestra **CURSOPBI**.

3. Abran el chat con el **icono de chat** que está arriba, a la derecha del cuadro **Search**. Revisen los controles que están debajo del cuadro de texto:
   - **Modo:** debe decir **Agent**.
   - **Modelo:** **Auto** (GitHub elige el modelo y les avisa cuál usó) o el que permita su plan.
   - **Permisos:** debe decir **Manual permissions**. Déjenlo así.

   > **Resultado esperado:** Debajo del cuadro del chat se lee **Agent**, **Auto** y **Manual permissions**.

4. Escriban `Hola` y esperen la respuesta.

   > Los servidores MCP se encienden **por conversación**: hasta que no envíen el primer mensaje, el servidor no puede arrancar. Normalmente arranca solo con ese mensaje.

   > **Resultado esperado:** Copilot responde al saludo.

5. Abran la paleta de comandos (**Ctrl+Shift+P**), escriban `MCP: List Servers` y presionen Enter. En la lista *Select an MCP Server for this session*:
   - **powerbi-authoring-local** debe decir **Running**. Si dice **Stopped** o **Error**, hagan clic en el triángulo **▷ (Start Server)** de su línea.
   - **github-mcp-server** no es del curso: hagan clic en su nombre y elijan **Stop Server**, para que el agente solo use las herramientas de Power BI.

   > **Resultado esperado:** En la lista: **powerbi-authoring-local** con **Running** y **github-mcp-server** detenido.

6. Comprueben las herramientas del servidor preguntándole al agente:

   ```text
   Sin hacer cambios, lista las herramientas que tienes disponibles del servidor
   powerbi-authoring-local y dime cuántas son.
   ```

   > **Resultado esperado:** El agente responde que tiene **21 herramientas** de powerbi-authoring-local, entre ellas `connection_operations`, `table_operations`, `measure_operations` y `dax_query_operations`.

7. **Solo si en la lista aparece `accept_eula`** (y suman 22), la licencia del servidor no está aceptada:
   1. Escriban:

      ```text
      Muéstrame el enlace de la EULA del servidor Power BI Authoring MCP.
      No la aceptes todavía.
      ```

   2. Abran el enlace `https://go.microsoft.com/fwlink/?LinkId=2381247` y **lean** la licencia.
   3. Si están de acuerdo, escriban:

      ```text
      He revisado la EULA en https://go.microsoft.com/fwlink/?LinkId=2381247
      y te autorizo a aceptarla en mi nombre.
      ```

   4. Revisen la ventana de aprobación de la herramienta `accept_eula` y permitan la ejecución. Vuelvan a hacer la pregunta del paso 6.

✔ **Verificación**

- No aparece el aviso **Restricted Mode**.
- En *MCP: List Servers*, **powerbi-authoring-local** dice **Running**.
- El agente responde **21 herramientas** (entre ellas `connection_operations`, `table_operations`, `measure_operations` y `dax_query_operations`), sin `accept_eula`.

## Ejercicio 4: Primera conversación de solo lectura (10 min)

1. Con Tiendas Andinas abierto en Desktop, escriban en el chat (modo Agent):

   ```text
   Conéctate al archivo 'TiendasAndinas' abierto en Power BI Desktop.
   ```

   Lean la ventana de aprobación de `connection_operations` y permitan.

   > **Resultado esperado:** Aparece la aprobación de `connection_operations` con la operación **Connect**. Al permitirla, el agente confirma que se conectó a TiendasAndinas.

2. Pidan el inventario sin cambios:

   ```text
   Sin hacer ningún cambio en el modelo, lista las tablas con su número de
   columnas y de medidas, y dime cuántas relaciones hay.
   ```

   > **Resultado esperado:** El agente lista 8 tablas de negocio, FACT_Ventas con 16 medidas, y 6 relaciones.

3. Validen una cifra con una consulta DAX:

   ```text
   Ejecuta una consulta DAX que devuelva el número de filas de FACT_Ventas
   y el valor de la medida [Total Ventas] por Calendario[Anio].
   ```

   > **Resultado esperado:** El agente muestra una tabla: FACT_Ventas con 34.330 filas y Total Ventas 5.121.728.115 en 2024 y 6.287.796.955 en 2025.

4. En cada paso, observen qué herramienta se invoca y con qué parámetros. Si alguna llamada intenta **crear, actualizar o eliminar** algo, recházenla.

✔ **Verificación**

- El agente reporta 8 tablas y 6 relaciones. Si ven tablas ocultas `LocalDateTable_*` o `DateTableTemplate_*`, no las cuenten: las crea Fecha/hora automática y las veremos en el Tema 3.
- FACT_Ventas tiene 16 medidas.
- FACT_Ventas tiene 34.330 filas; `Total Ventas` = $5.121.728.115 en 2024 y $6.287.796.955 en 2025.

## Ejercicio 5: Explorar el modelo en lenguaje natural (10 min)

Sigan en la misma conversación, con el agente conectado a Desktop. En cada respuesta, miren qué herramienta usó el agente para averiguarlo.

1. Una medida:

   ```text
   Sin hacer cambios, explícame en lenguaje de negocio qué calcula la medida
   'Margen %' y muéstrame su expresión DAX y la de las medidas que usa.
   ```

   > **Resultado esperado:** `Margen %` = `[margen] / [Total Ventas]`, y `margen` = `[Total Ventas] - [Costo]`: qué porcentaje de las ventas queda como ganancia.

2. Una relación:

   ```text
   Describe la relación entre FACT_Ventas y Cliente: qué columnas une,
   su cardinalidad y la dirección del filtro.
   ```

   > **Resultado esperado:** Une `FACT_Ventas[cust_id]` con `Cliente[cust_id]`, de varios a uno, con filtro en **ambas** direcciones.

3. Una dimensión:

   ```text
   ¿Qué columnas tiene la tabla tbl_Tienda y cuál de ellas la relaciona
   con FACT_Ventas?
   ```

   > **Resultado esperado:** `tbl_Tienda` tiene 8 columnas (TiendaKey, Tienda, Ciudad, Departamento, Region, Tipo, FechaApertura, MetrosCuadrados) y se relaciona con FACT_Ventas por `TiendaKey`.

4. Una explicación para otra audiencia:

   ```text
   Explícame este modelo en cinco líneas para un gerente comercial que no
   conoce Power BI.
   ```

   > **Resultado esperado:** Cinco líneas sin términos técnicos: qué se vende, dónde, a quién y cómo se mide el resultado.

5. Contrasten las respuestas 1 a 3 con Power BI Desktop: abran la medida `Margen %` en la vista de modelo y la relación entre `FACT_Ventas` y `Cliente` (doble clic sobre la línea de la relación).

✔ **Verificación**

- `Margen %` = `[margen] / [Total Ventas]`, y `margen` = `[Total Ventas] - [Costo]`.
- La relación une `FACT_Ventas[cust_id]` con `Cliente[cust_id]`, es de varios a uno y filtra en **ambas** direcciones. Anótenlo; no lo cambien.
- `tbl_Tienda` tiene 8 columnas (TiendaKey, Tienda, Ciudad, Departamento, Region, Tipo, FechaApertura, MetrosCuadrados) y se relaciona por `TiendaKey`.
- Lo que dice el agente coincide con lo que ven en Desktop.

## Reto opcional (si les sobra tiempo)

```text
Sin hacer cambios, explícame con ejemplos qué puedo hacer con el servidor
Power BI Authoring MCP sobre este modelo.
```

Comparen la respuesta con los casos de uso vistos en la teoría.

## Solución de problemas

| Síntoma | Causa probable | Acción |
|---|---|---|
| `git`, `node` o `npx` no se reconocen | Se instalaron con VS Code o PowerShell abiertos | Cerrar y volver a abrir VS Code o PowerShell |
| El script no se ejecuta por política de ejecución | Falta `-ExecutionPolicy Bypass` | Copiar el comando exacto del Ejercicio 1 |
| Aparece el aviso Restricted Mode | La carpeta no es confiable | Clic en Restricted Mode → Manage → Trust |
| En *MCP: List Servers* el servidor dice **Error** y no arranca | No hay conversación abierta en el chat (*Cannot start an MCP server before the session runtime has been created*) | Abrir el chat, enviar un mensaje y volver a intentar con ▷ Start Server |
| El agente dice que no tiene herramientas de Power BI | El servidor está detenido en esta conversación | Ctrl+Shift+P → `MCP: List Servers` → ▷ en powerbi-authoring-local |
| No encuentran el registro del servidor en el panel Output | En esta versión de VS Code el servidor corre dentro del motor de agentes y no tiene canal propio | Verificar con *MCP: List Servers* (Running) y con la pregunta del paso 6 |
| Solo aparece el modelo **Auto** | Su plan de Copilot no ofrece otros modelos | Usar Auto: funciona para este laboratorio |
| La extensión instalada tiene otro nombre o editor | Se instaló una extensión de terceros | Desinstalarla e instalar `analysis-services.powerbi-modeling-mcp` |
| Copilot dice que los servidores MCP están deshabilitados | Política **MCP servers in Copilot** desactivada en la organización | Avisar al instructor; trabajar en pareja |
| Error de origen de datos al actualizar en Desktop | `RutaDatos` mal escrita o sin `\` final | Corregir a `C:\CursoPBI\Datos\` y actualizar |
| El agente no encuentra el archivo de Desktop | Desktop cerrado o aún cargando | Esperar a que cargue; pedir `Lista las instancias locales de Power BI Desktop disponibles` |
| Copilot responde sin usar herramientas | Modo Ask seleccionado o servidor detenido | Cambiar a Agent y revisar *MCP: List Servers* |
| Ctrl+Alt+I no abre el chat | El teclado o el foco interfiere con el atajo | Usar el icono de chat junto al cuadro Search |
| La consulta DAX marca error | Se pegó incompleta o con comillas distintas | Volver a copiarla completa desde la guía |

## Resumen y entregables

- Entorno verificado con `Verificar-Entorno.ps1`.
- Modelo con datos y conteos de filas correctos.
- Servidor encendido (Running): 21 herramientas y EULA aceptada.
- Primera respuesta del agente con el inventario del modelo y una exploración contrastada con Desktop.

Guarden el proyecto en Desktop (Ctrl+S) para conservar los datos cargados. Después pueden cerrar Desktop y VS Code: el Laboratorio 2 empieza con su propio arranque y deja todo listo de nuevo.

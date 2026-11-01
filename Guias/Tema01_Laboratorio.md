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
- Confiar en la carpeta del curso, encender el servidor MCP y confirmar en el panel Output que está listo.
- Hacer la primera consulta de solo lectura al modelo con GitHub Copilot en modo Agent.
- Explorar el modelo con preguntas en lenguaje natural y contrastar las respuestas con lo que se ve en Power BI Desktop.

## Escenario

Tiendas Andinas es una cadena de retail ficticia con 15 tiendas físicas en 10 ciudades de Colombia y un canal en línea. Su equipo de BI heredó un modelo semántico con varios problemas. Durante el curso ustedes lo van a analizar, corregir, ampliar y documentar con ayuda de GitHub Copilot. Hoy dejan listo el taller.

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

### B. Entorno

3. Abran **Windows PowerShell** (tecla Windows, escriban `PowerShell` y presionen Enter).
4. Ejecuten:

   ```powershell
   powershell -ExecutionPolicy Bypass -File C:\CursoPBI\Verificar-Entorno.ps1
   ```

5. Lean el resultado. Cada línea empieza con `[OK]`, `[ADVERTENCIA]` o `[ERROR]`.
6. Si aparece `[ERROR] Git para Windows no está instalado` o `[ADVERTENCIA] Node.js no instalado`, instálenlos en la misma ventana:

   ```powershell
   winget install --id Git.Git -e
   winget install --id OpenJS.NodeJS.LTS -e
   ```

   Cierren PowerShell, ábranlo de nuevo y repitan el paso 4.
7. Abran **Visual Studio Code**. Abran el chat con **Ctrl+Alt+I**. Si VS Code pide iniciar sesión, elijan **GitHub** y completen el inicio de sesión en el navegador.
8. Abran la vista de **Extensiones** (Ctrl+Shift+X), busquen `powerbi-modeling-mcp` y abran la extensión instalada. Comprueben:
   - Nombre: **Power BI Authoring MCP Server**
   - Editor: **Microsoft**
   - Identificador: `analysis-services.powerbi-modeling-mcp`

✔ **Verificación**

- Existen las cuatro carpetas y los tres archivos de `C:\CursoPBI`.
- El script muestra `[OK]` para VS Code, Git, Node.js, la extensión `analysis-services.powerbi-modeling-mcp`, Power BI Desktop, los 8 archivos CSV y los 5 proyectos `.pbip`.
- La línea de `github.copilot-chat` puede salir como `[ADVERTENCIA]`: Copilot viene integrado en VS Code. Lo que importa es que el chat responda.
- En el chat escriben `Hola` y Copilot responde.

## Ejercicio 2: Abrir el modelo y cargar los datos (12 min)

1. Hagan doble clic en `C:\CursoPBI\TiendasAndinas\TiendasAndinas.pbip`. Se abre en Power BI Desktop.
2. Si Desktop muestra avisos de datos o de actualización pendiente, ciérrenlos.
3. Vayan a **Inicio → Transformar datos → Editar parámetros**. En `RutaDatos` confirmen o escriban `C:\CursoPBI\Datos\` (terminada en `\`) y acepten.
4. Si aparece la barra de cambios pendientes, elijan **Aplicar cambios**. Luego, **Inicio → Actualizar**.
5. Abran la **vista de consultas DAX** (icono en la barra izquierda de Desktop), peguen esta consulta y ejecútenla:

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

6. Revisen la página **Resumen** del informe. Van a notar cosas raras (por ejemplo, los meses en orden alfabético). **No las corrijan**: son errores sembrados a propósito para los próximos temas.
7. Guarden el proyecto (Ctrl+S) y dejen Desktop **abierto**.

✔ **Verificación:** la consulta devuelve:

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

## Ejercicio 3: Confiar en la carpeta y encender el servidor (12 min)

1. En VS Code: **File → Open Folder…**, elijan `C:\CursoPBI` y hagan clic en **Seleccionar carpeta**.
2. Cuando VS Code pregunte si confían en los autores, elijan **Yes, I trust the authors**.
   Si ya habían abierto la carpeta y ven el aviso **Restricted Mode**, hagan clic en él → **Manage** → **Trust**.
3. Abran la paleta de comandos (**Ctrl+Shift+P**), escriban `MCP: List Servers` y presionen Enter.
4. Elijan **powerbi-authoring-local** y luego **Start**.
5. Abran el panel **Output** (**Ctrl+Shift+U**). En la lista desplegable de la derecha del panel, elijan la entrada del servidor **powerbi-authoring-local**.
6. Busquen en el texto:
   - la versión del servidor,
   - la línea **Discovered 21 tools**,
   - el valor de **EulaAccepted**.
7. **Solo si `EulaAccepted` aparece en `False`:**
   1. Abran el chat (Ctrl+Alt+I), elijan el modo **Agent** y escriban:

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

   4. Revisen la ventana de aprobación de la herramienta `accept_eula` y permitan la ejecución.
8. En el chat, revisen los cuatro controles:
   - **Modo:** Agent.
   - **Modelo:** uno de razonamiento profundo de los que ofrezca su plan.
   - **Herramientas:** abran el selector y comprueben que aparece el servidor de Power BI con sus herramientas.

✔ **Verificación**

- No aparece el aviso **Restricted Mode**.
- En Output: `Discovered 21 tools` y `EulaAccepted=True`. (Si la licencia no está aceptada verán 22 herramientas: la adicional es `accept_eula`, y desaparece al aceptarla).
- El selector de herramientas del chat muestra el servidor de Power BI.

## Ejercicio 4: Primera conversación de solo lectura (10 min)

1. Con Tiendas Andinas abierto en Desktop, escriban en el chat (modo Agent):

   ```text
   Conéctate al archivo 'TiendasAndinas' abierto en Power BI Desktop.
   ```

   Lean la ventana de aprobación de `connection_operations` y permitan.
2. Pidan el inventario sin cambios:

   ```text
   Sin hacer ningún cambio en el modelo, lista las tablas con su número de
   columnas y de medidas, y dime cuántas relaciones hay.
   ```

3. Validen una cifra con una consulta DAX:

   ```text
   Ejecuta una consulta DAX que devuelva el número de filas de FACT_Ventas
   y el valor de la medida [Total Ventas] por Calendario[Anio].
   ```

4. En cada paso, observen qué herramienta se invoca y con qué parámetros. Si alguna llamada intenta **crear, actualizar o eliminar** algo, recházenla.

✔ **Verificación**

- El agente reporta 8 tablas y 6 relaciones. Si ven tablas ocultas `LocalDateTable_*` o `DateTableTemplate_*`, no las cuenten: las crea Fecha/hora automática y las veremos en el Tema 3.
- FACT_Ventas tiene 16 medidas.
- FACT_Ventas tiene 34.330 filas; `Total Ventas` = $5.121.728.115 en 2024 y $6.287.796.955 en 2025.

## Ejercicio 5: Explorar el modelo en lenguaje natural (12 min)

Sigan en la misma conversación, con el agente conectado a Desktop. En cada respuesta, miren qué herramienta usó el agente para averiguarlo.

1. Una medida:

   ```text
   Sin hacer cambios, explícame en lenguaje de negocio qué calcula la medida
   'Margen %' y muéstrame su expresión DAX y la de las medidas que usa.
   ```

2. Una relación:

   ```text
   Describe la relación entre FACT_Ventas y Cliente: qué columnas une,
   su cardinalidad y la dirección del filtro.
   ```

3. Una dimensión:

   ```text
   ¿Qué columnas tiene la tabla tbl_Tienda y cuál de ellas la relaciona
   con FACT_Ventas?
   ```

4. Una explicación para otra audiencia:

   ```text
   Explícame este modelo en cinco líneas para un gerente comercial que no
   conoce Power BI.
   ```

5. Contrasten las respuestas 1 a 3 con Power BI Desktop: abran la medida `Margen %` en la vista de modelo y la relación entre `FACT_Ventas` y `Cliente` (doble clic sobre la línea de la relación).

✔ **Verificación**

- `Margen %` = `[margen] / [Total Ventas]`, y `margen` = `[Total Ventas] - [Costo]`.
- La relación une `FACT_Ventas[cust_id]` con `Cliente[cust_id]`, es de varios a uno y filtra en **ambas** direcciones. Anótenlo; no lo cambien.
- `tbl_Tienda` tiene 8 columnas (TiendaKey, Tienda, Ciudad, Departamento, Region, Tipo, FechaApertura, MetrosCuadrados) y se relaciona por `TiendaKey`.
- Lo que dice el agente coincide con lo que ven en Desktop.

## Reto opcional (si les sobra tiempo)

```text
Tell me with some examples what I can do with the Power BI Authoring MCP server
```

Comparen la respuesta con los casos de uso vistos en la teoría.

## Solución de problemas

| Síntoma | Causa probable | Acción |
|---|---|---|
| `git`, `node` o `npx` no se reconocen | Se instalaron con VS Code o PowerShell abiertos | Cerrar y volver a abrir VS Code o PowerShell |
| El script no se ejecuta por política de ejecución | Falta `-ExecutionPolicy Bypass` | Copiar el comando exacto del Ejercicio 2 |
| Aparece el aviso Restricted Mode | La carpeta no es confiable | Clic en Restricted Mode → Manage → Trust |
| No se ve el servidor en el selector de herramientas | El servidor no ha arrancado | Ctrl+Shift+P → `MCP: List Servers` → powerbi-authoring-local → Start |
| La extensión instalada tiene otro nombre o editor | Se instaló una extensión de terceros | Desinstalarla e instalar `analysis-services.powerbi-modeling-mcp` |
| Copilot dice que los servidores MCP están deshabilitados | Política **MCP servers in Copilot** desactivada en la organización | Avisar al instructor; trabajar en pareja |
| Error de origen de datos al actualizar en Desktop | `RutaDatos` mal escrita o sin `\` final | Corregir a `C:\CursoPBI\Datos\` y actualizar |
| El agente no encuentra el archivo de Desktop | Desktop cerrado o aún cargando | Esperar a que cargue; pedir `Lista las instancias locales de Power BI Desktop disponibles` |
| Copilot responde sin usar herramientas | Modo Ask seleccionado o servidor desactivado | Cambiar a Agent y marcar el servidor en el selector |

## Resumen y entregables

- Entorno verificado con `Verificar-Entorno.ps1`.
- Modelo con datos y conteos de filas correctos.
- Servidor encendido: 21 herramientas y EULA aceptada.
- Primera respuesta del agente con el inventario del modelo y una exploración contrastada con Desktop.

Dejen Desktop y VS Code abiertos: en el Laboratorio 2 se conectarán de varias formas al mismo modelo.

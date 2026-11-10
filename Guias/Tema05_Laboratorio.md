# Laboratorio 5: Corrección estructural del modelo

| Dato | Detalle |
|---|---|
| Duración | 60 minutos |
| Modalidad | Individual |
| Punto de partida | Equipo preparado. No hace falta haber terminado los laboratorios anteriores. El **Arranque** deja el modelo en su estado inicial y el entorno listo |
| Resultado esperado | El modelo `C:\CursoPBI\TiendasAndinas` guardado con 9 tablas y 13 relaciones, la tabla de fechas marcada, el presupuesto conectado y las columnas sobrantes eliminadas, con las mismas ventas de siempre |

## Objetivos

- Aplicar el método **respaldo → plan → aprobación → lote → verificación → guardado**.
- Corregir relaciones y configurar la tabla de fechas con el agente.
- Conectar una tabla con granularidad distinta (Presupuesto) mediante puentes.
- Eliminar columnas de una tabla de importación de forma completa: modelo **y** consulta M.

## Escenario

La gerencia de Tiendas Andinas aprobó corregir la **estructura** del modelo heredado. Las medidas DAX se corrigen en el siguiente laboratorio: **hoy no se modifica ninguna medida**. El número de control que no puede cambiar es **Total Ventas 2025 = 6.287.796.955**.

> **Cómo leer esta guía:** cada recuadro gris con texto en español es un **mensaje para el chat de Copilot**: cópienlo, péguenlo en el cuadro del chat y presionen **Enter**. En este laboratorio **no se usa PowerShell ni la terminal**.
>
> **Modo demo:** si no pueden ejecutar el laboratorio en su equipo, sigan al instructor en la pantalla compartida. Los recuadros **Resultado esperado** muestran lo que debe aparecer.
>
> **Copilot Free:** el laboratorio usa unos 7 mensajes. Envíen un mensaje a la vez y no repitan un mensaje si el agente ya respondió. Si se les acaba la cuota, sigan en modo demo o en pareja.
>
> **Aprobaciones:** hoy el agente escribe en el modelo. En la ventana de aprobación, las lecturas aparecen con **✓** («reads data», «fetches read-only data») y las escrituras con **⚠** («changes workspace state»). Elijan siempre **Allow Once**: clic en la **flecha** junto a *Allow in this Session* → **Allow Once**. *Allow in this Session* se aplica a toda la herramienta, también a sus escrituras. Si la aprobación dice **powerbi-solo-lectura**, elijan **Skip**.

## Arranque: respaldo, datos y herramientas (10 min)

Cada laboratorio empieza desde cero: no supongan que algo quedó abierto de la sesión anterior.

1. Si Power BI Desktop o VS Code están abiertos, ciérrenlos. Si Desktop pregunta si desean guardar, elijan **No guardar**.
2. **Estado inicial.** En el Explorador de archivos, abran `C:\CursoPBI\TiendasAndinas\TiendasAndinas.SemanticModel\definition\tables`. Si ahí existe un archivo `Categoria.tmdl`, su modelo no está en el estado inicial: borren el contenido de `C:\CursoPBI\TiendasAndinas` y copien en su lugar el contenido de `C:\CursoPBI\Checkpoints\T05_inicio`.
3. **Respaldo.** Copien la carpeta `C:\CursoPBI\TiendasAndinas` y péguenla en `C:\CursoPBI` con el nombre `Respaldo_T05`. Si ya existe de un intento anterior, reemplácenla.

   > **Resultado esperado:** Existe `C:\CursoPBI\Respaldo_T05` con los mismos archivos que `TiendasAndinas`.

4. Hagan doble clic en `C:\CursoPBI\TiendasAndinas\TiendasAndinas.pbip`. Cuando abra, vayan a **Inicio → Actualizar** y esperen a que termine. Cierren cualquier otro archivo de Power BI.
5. **Página de control.** En Desktop, agreguen una página con el **+** de abajo y llámenla `Control`. Inserten una **matriz** con `Calendario[Anio]` en **Filas** y `Total Ventas`, `Unidades Devueltas` y `Presupuesto` en **Valores**.

   > **Resultado esperado:**
   >
   > | Anio | Total Ventas | Unidades Devueltas | Presupuesto |
   > |---|---|---|---|
   > | 2024 | 5.121.728.115 | 2.929 | 11.668.662.000 |
   > | 2025 | 6.287.796.955 | 2.929 | 11.668.662.000 |
   >
   > Las medidas todavía no tienen formato; lo que importa es la cifra. Devoluciones y presupuesto repiten el mismo valor en los dos años porque esas tablas no llegan al calendario.

6. Abran **Visual Studio Code** → **File → Open Folder…** → `C:\CursoPBI`. Si pregunta si confían en los autores, elijan **Yes, I trust the authors**.
7. **Solo si hicieron el Laboratorio 4:** abran `.github\copilot-instructions.md` y cambien la línea `- Usa solo el servidor MCP powerbi-solo-lectura.` por `- Usa el servidor MCP powerbi-authoring-local.` Guarden con **Ctrl+S**. Si no existe la carpeta `.github`, sigan.
8. En el **panel de chat de la derecha**, abran una conversación nueva con el **+** de la parte superior. Si abajo dice **Copilot**, hagan clic sobre esa palabra y elijan **Local**.
9. Hagan clic en **Configure Tools** (el icono de controles, a la derecha de **Auto**) y dejen así la lista:
   - **Marcado:** **powerbi-authoring-local**, `read` y `search`.
   - **Desmarcado:** `edit`, `execute` y, si aparece, **powerbi-solo-lectura**.
   - Clic en **OK**.

✔ **Verificación**

- Existe `C:\CursoPBI\Respaldo_T05`.
- La página **Control** muestra 2.929 devoluciones y 11.668.662.000 de presupuesto en los dos años.
- El chat dice **Local**, y en **Configure Tools** está marcado **powerbi-authoring-local** y desmarcados `edit` y `execute`.

## Ejercicio 1: Lote 1, relaciones (12 min)

1. Pidan el plan. Escriban en el chat:

   ```text
   Conéctate al archivo TiendasAndinas abierto en Power BI Desktop.
   Lote 1, solo relaciones:
   1. Cambia la relación FACT_Ventas[cust_id] -> Cliente[cust_id] para que filtre en una sola dirección.
   2. Crea una relación INACTIVA FACT_Ventas[FechaEnvio] -> Calendario[Fecha].
   3. Crea fact_devoluciones[FechaDevolucion] -> Calendario[Fecha], activa, muchos a uno.
   4. Crea fact_devoluciones[TiendaKey] -> tbl_Tienda[TiendaKey], activa, muchos a uno.
   Restricciones: no modifiques medidas, columnas ni otras relaciones.
   Entrega el plan en una tabla (paso, operación, desde, hacia, activa, dirección) y no ejecutes nada hasta que escriba APROBADO.
   ```

   Aparecerán aprobaciones de lectura (**✓**) para conectarse y listar relaciones: **Allow Once**.

   > **Resultado esperado:** Una tabla de 4 pasos. El paso 2 dice **Activa: No**. En los pasos 3 y 4, **Desde** es la tabla de hechos (`fact_devoluciones`) y **Hacia** es la dimensión. El agente dice que espera APROBADO.

2. Revisen el plan con la lista: ¿la relación de envío es **inactiva**? ¿El lado **Desde** es siempre la tabla de hechos? Si algo no coincide, pidan la corrección antes de aprobar (ese mensaje adicional vale la pena).
3. Escriban:

   ```text
   APROBADO
   ```

   Ahora las aprobaciones son de escritura (**⚠**, «Updates relationship…», «Creates relationship…»): **Allow Once** en cada una. Si el agente consulta la ayuda (**Help**) porque una operación falló, es normal: **Allow Once**.

   > **Resultado esperado:** El agente confirma que aplicó las 4 relaciones y que el modelo tiene 9 relaciones.

4. **Verifiquen en Desktop.** Vayan a **Inicio → Actualizar** y luego a la página **Control**.

   > **Resultado esperado:** Unidades Devueltas: **1.324** en 2024 y **1.605** en 2025. Total Ventas 2025 sigue en **6.287.796.955**. En la **vista de modelo**, la relación FACT_Ventas–Cliente tiene una sola flecha y la de `FechaEnvio` se ve **punteada** (inactiva).

✔ **Verificación**

- Devoluciones 1.324 / 1.605 y Total Ventas 2025 sin cambios.
- Si un número no cuadra, **no sigan**: cierren Desktop sin guardar, ábranlo de nuevo y repitan el lote.

## Ejercicio 2: Lote 2, tabla de fechas (8 min)

Este lote es pequeño y de bajo riesgo: va directo, sin plan.

1. Escriban:

   ```text
   Lote 2, tabla de fechas. Es un cambio pequeño: ejecútalo directamente, sin plan.
   1. Marca la tabla Calendario como tabla de fechas con la columna Fecha.
   2. Ordena Calendario[NombreMes] por Calendario[Mes] y Calendario[DiaSemana] por Calendario[DiaSemanaNum].
   No cambies nada más. Al final, confirma en una línea qué quedó hecho.
   ```

   Aprobaciones de escritura: «Marks Calendario as a date table…» y «Updates columns in the Calendario table…»: **Allow Once**.

2. Desactiven la fecha y hora automáticas **en Desktop**: **Archivo → Opciones y configuración → Opciones → ARCHIVO ACTUAL → Carga de datos → Inteligencia de tiempo** → desmarquen **Fecha/hora automática** → **Aceptar**.
3. Vayan a la página **Resumen**.

   > **Resultado esperado:** El gráfico **Ventas por mes** muestra los meses de **enero a diciembre**, en orden.

✔ **Verificación**

- Los meses van de enero a diciembre.
- Total Ventas 2025 sigue en 6.287.796.955.

## Ejercicio 3: Lote 3, presupuesto (14 min)

El presupuesto está a nivel **mes × tienda × categoría**: no tiene fecha exacta ni producto. Se construyen dos puentes: una fecha de mes y una tabla de categorías.

1. Pidan el plan:

   ```text
   Lote 3, presupuesto. Presupuesto tiene granularidad Anio, Mes, TiendaKey y Categoria. Conéctala así:
   1. En Presupuesto, columna calculada oculta FechaPresupuesto = DATE(Presupuesto[Anio], Presupuesto[Mes], 1), tipo fecha, sin resumen.
   2. Tabla de importación nueva Categoria con una partición M que lea RutaDatos & "dim_subcategoria.csv", conserve solo la columna Categoria, quite duplicados y la tipifique como texto con cultura "en-US". Declara la columna Categoria (String).
   3. Relaciones muchos a uno, una dirección: dim_subcategoria[Categoria] -> Categoria[Categoria]; Presupuesto[Categoria] -> Categoria[Categoria]; Presupuesto[TiendaKey] -> tbl_Tienda[TiendaKey]; Presupuesto[FechaPresupuesto] -> Calendario[Fecha].
   No toques medidas. Muestra el plan en una tabla y la expresión M completa, y no ejecutes nada hasta que escriba APROBADO.
   ```

   > **Resultado esperado:** Un plan de unos 7 pasos y una expresión M parecida a esta:
   >
   > `let Origen = Csv.Document(File.Contents(RutaDatos & "dim_subcategoria.csv"), …), Encabezados = Table.PromoteHeaders(…), SoloCategoria = Table.SelectColumns(Encabezados, {"Categoria"}), SinDuplicados = Table.Distinct(SoloCategoria), Tipos = Table.TransformColumnTypes(SinDuplicados, {{"Categoria", type text}}, "en-US") in Tipos`

2. Revisen que la M use `RutaDatos`, `Table.Distinct` y la cultura `"en-US"`. Si el plan propone una relación **muchos a muchos** entre Presupuesto y dim_subcategoria en lugar de crear la tabla Categoria, pidan que siga el diseño del mensaje.
3. Escriban `APROBADO` y den **Allow Once** en cada aprobación. Este lote tiene varias: crear la columna, crear la tabla, actualizarlas y crear 4 relaciones.

   > **Resultado esperado:** El agente confirma la columna FechaPresupuesto oculta, la tabla Categoria y las 4 relaciones.

4. En Desktop: **Inicio → Actualizar**. En la página **Control**, agreguen una segunda matriz con `Categoria[Categoria]` en **Filas** y `Total Ventas`, `Presupuesto` y `Cumplimiento` en **Valores**. Con la matriz seleccionada, en el panel **Filtros** arrastren `Calendario[Anio]` a **Filtros de este objeto visual** y elijan **2025**.

   > **Resultado esperado:**
   >
   > | Categoria | Total Ventas | Presupuesto | Cumplimiento |
   > |---|---|---|---|
   > | Deportes | 864.669.750 | 879.711.000 | 0,98 |
   > | Hogar | 1.423.787.965 | 1.464.544.000 | 0,97 |
   > | Moda | 1.415.211.750 | 1.434.910.000 | 0,99 |
   > | Tecnología | 2.584.127.490 | 2.650.017.000 | 0,98 |
   >
   > Y en la primera matriz, Presupuesto ahora es **5.239.480.000** (2024) y **6.429.182.000** (2025).

> Usen `Categoria[Categoria]` (la tabla nueva), no `dim_subcategoria[Categoria]`: el filtro viaja desde Categoria hacia dim_subcategoria y Presupuesto.

✔ **Verificación**

- La tabla Categoria tiene 4 filas: Tecnología, Hogar, Moda y Deportes.
- Presupuesto 2025 = 6.429.182.000; Tecnología 2025 cumple al 0,98 (antes daba 0,22).

## Ejercicio 4: Lote 4, limpieza de columnas y consulta M (10 min)

1. Pidan el plan:

   ```text
   Lote 4, limpieza en FACT_Ventas:
   1. Elimina la columna calculada 'Margen Linea %'.
   2. Elimina ETL_LoadDate y Columna1 del modelo Y de la consulta M de la partición: agrega un paso ColumnasQuitadas = Table.RemoveColumns(Encabezados, {"ETL_LoadDate", "Columna1"}) antes del paso Tipos, haz que Tipos parta de ColumnasQuitadas y quita esas dos columnas de la lista de tipos. Conserva la cultura "en-US".
   No toques medidas. Muéstrame la expresión M final completa y no ejecutes nada hasta que escriba APROBADO. Cuando ejecutes, cópiame textualmente cualquier advertencia del servidor.
   ```

   > **Resultado esperado:** La expresión M con los pasos `Origen`, `Encabezados`, `ColumnasQuitadas` y `Tipos`, y `Tipos` partiendo de `ColumnasQuitadas`.

2. Escriban `APROBADO` y den **Allow Once** en cada aprobación. Es posible que el agente primero lea las medidas para confirmar que ninguna usa las columnas que va a borrar: es una buena práctica.

   > **Resultado esperado:** El agente confirma el lote y copia advertencias del servidor, entre ellas una que empieza con **«WARNING: The column may be re-added automatically…»**. Anótenla: es la razón de cambiar también la consulta M.

3. En Desktop: **Inicio → Actualizar**. En el panel **Datos**, expandan `FACT_Ventas`.

   > **Resultado esperado:** No aparecen `ETL_LoadDate`, `Columna1` ni `Margen Linea %`, ni siquiera después de actualizar. Total Ventas 2025 sigue en **6.287.796.955**.

✔ **Verificación**

- Las tres columnas desaparecieron y no volvieron al actualizar.
- Total Ventas 2025 sin cambios.

## Ejercicio 5: Guardar y verificación final (6 min)

1. En Desktop, guarden con **Ctrl+S**. Los cambios del agente vivían en el modelo abierto; ahora llegan a los archivos del proyecto.
2. Comprueben la lista final **sin escribir en el chat**:

   | Criterio | Valor esperado | Dónde se ve |
   |---|---|---|
   | Tablas | 9 (incluida Categoria) | Panel Datos |
   | Relaciones | 13, una punteada | Vista de modelo |
   | Unidades Devueltas 2024 / 2025 | 1.324 / 1.605 | Página Control |
   | Presupuesto 2025 | 6.429.182.000 | Página Control |
   | Total Ventas 2025 | 6.287.796.955 | Página Control |
   | Meses | Enero → diciembre | Página Resumen |

3. En VS Code, abran `TiendasAndinas\TiendasAndinas.SemanticModel\definition\relationships.tmdl` y busquen con **Ctrl+F** la palabra `relationship`.

   > **Resultado esperado:** **13** coincidencias, una por relación, y una de ellas con `isActive: false`.

✔ **Verificación final**

- Los seis criterios de la tabla se cumplen y el modelo está guardado.

## Cierre del laboratorio (2 min)

1. Cierren Power BI Desktop (ya guardaron).
2. Dejen `C:\CursoPBI\TiendasAndinas` como quedó: es el punto de partida del Laboratorio 6. Quien no terminó puede empezar el Laboratorio 6 desde `C:\CursoPBI\Checkpoints\T06_inicio`.
3. Pueden borrar `C:\CursoPBI\Respaldo_T05` si todo salió bien.

## Reto opcional

Solo si les sobra tiempo y cuota. Elijan **uno**:

- **Claves ocultas.** Pidan, con plan y APROBADO, ocultar y dejar sin resumen las columnas clave: `FACT_Ventas[LineaOrden]`, `FACT_Ventas[cust_id]`, `FACT_Ventas[ProductoKey]`, `FACT_Ventas[TiendaKey]`, `Cliente[cust_id]`, `tbl_Tienda[TiendaKey]`, `dim_producto[ProductoKey]` y `dim_subcategoria[SubcategoriaKey]`. Revisen en el plan que **no** aparezca `FACT_Ventas[Cantidad]`, que debe seguir visible y con resumen Suma.
- **Deshacer con transacción.** Pidan al agente que abra una transacción, cambie el formato de `dim_producto[PrecioLista]` a `#,0` y luego la **revierta** (Rollback). Comprueben en Desktop que el formato no cambió.

## Solución de problemas

| Síntoma | Causa probable | Acción |
|---|---|---|
| Una consulta o una matriz falla con «…needs to be recalculated» | Desktop no ha procesado las relaciones o columnas nuevas | **Inicio → Actualizar** |
| La relación de envío quedó activa | El agente omitió que debía ser inactiva | Escribir: `Desactiva la relación FACT_Ventas[FechaEnvio] -> Calendario[Fecha].` |
| Presupuesto sale igual en todas las categorías | En la matriz usaron `dim_subcategoria[Categoria]` o falta una relación | Usar `Categoria[Categoria]`; actualizar |
| `ETL_LoadDate` reaparece al actualizar | Se borró solo del modelo | Pedir que agregue `Table.RemoveColumns` en la consulta M de FACT_Ventas |
| Error al actualizar: «The column 'ETL_LoadDate' … wasn't found» | El paso `Tipos` todavía nombra la columna | Pedir que la quite de la lista de tipos de la partición |
| Aparece **N files changed** con **Keep** y **Undo** | `edit` quedó marcado en Configure Tools | **Undo**, desmarcar `edit` y repetir el lote |
| Una aprobación dice **powerbi-solo-lectura** | Ese servidor sigue marcado en Configure Tools | **Skip** y desmarcarlo |
| El agente no encuentra Power BI Desktop | La detección automática falla en algunos equipos | Escribir: `Lee el número del archivo msmdsrv.port.txt que está en la carpeta %LOCALAPPDATA%\Microsoft\Power BI Desktop\AnalysisServicesWorkspaces (dentro de la subcarpeta Data) y conéctate a Power BI Desktop en localhost con ese puerto.` |
| El modelo quedó inconsistente | Un lote se aplicó mal | Cerrar Desktop **sin guardar** y reabrir. Si ya guardaron, borrar el contenido de `TiendasAndinas` y copiar el de `Respaldo_T05` |
| El chat deja de responder por límite de uso | Se acabó la cuota de Copilot Free | Seguir en modo demo o en pareja; el Laboratorio 6 puede empezar desde `Checkpoints\T06_inicio` |

## Resumen y entregables

- `C:\CursoPBI\TiendasAndinas` guardado en el estado objetivo: 9 tablas, 13 relaciones (1 inactiva), Calendario marcada, presupuesto conectado, sin columnas sobrantes, 16 medidas sin cambios.
- La página **Control** con los números de control.

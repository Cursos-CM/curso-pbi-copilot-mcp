# Laboratorio 6: Indicadores de negocio con DAX asistido

| Dato | Detalle |
|---|---|
| Duración | 60 minutos |
| Modalidad | Individual |
| Punto de partida | `C:\CursoPBI\Checkpoints\T06_inicio`, que equivale al resultado del Laboratorio 5. No hace falta haber terminado ningún laboratorio anterior: el **Arranque** deja todo listo |
| Resultado esperado | 18 medidas corregidas, con formato y carpeta, validadas contra los valores esperados, y sin las medidas sobrantes `Ventas Totales`, `Ventas 2025` y `Test` |

## Objetivos

- Pedirle al agente que explique una medida y que **demuestre** su comportamiento con una consulta.
- Crear medidas a partir de requisitos de negocio, con plan y aprobación.
- Corregir medidas existentes con los patrones DIVIDE, KEEPFILTERS e inteligencia de tiempo sobre la tabla de fechas.
- Validar todas las medidas con una consulta DAX contra valores esperados.
- Borrar medidas revisando antes qué las usa, incluido el informe.

## Escenario

Con la estructura del modelo corregida, la gerencia de Tiendas Andinas pide indicadores confiables: medidas que no fallen con divisiones por cero, que respeten los filtros del informe, que comparen contra el año anterior y contra el presupuesto, y que tengan formato y carpetas para que cualquiera las encuentre. Además, hay tres medidas sobrantes que confunden a los usuarios.

> **Cómo leer esta guía:** cada recuadro gris con texto en español es un **mensaje para el chat de Copilot**: cópienlo, péguenlo en el cuadro del chat y presionen **Enter**. En este laboratorio **no se usa PowerShell ni la terminal**.
>
> **Modo demo:** si no pueden ejecutar el laboratorio en su equipo, sigan al instructor en la pantalla compartida. Los recuadros **Resultado esperado** muestran lo que debe aparecer.
>
> **Copilot Free:** el laboratorio usa unos 8 mensajes. Envíen un mensaje a la vez y no repitan un mensaje si el agente ya respondió.
>
> **Aprobaciones:** las lecturas aparecen con **✓** y las escrituras con **⚠**. Elijan siempre **Allow Once** (flecha junto a *Allow in this Session* → **Allow Once**). Las consultas DAX no piden aprobación.

## Arranque: punto de partida, datos y herramientas (8 min)

1. Si Power BI Desktop o VS Code están abiertos, ciérrenlos. Si Desktop pregunta si desean guardar, elijan **No guardar**.
2. **Respaldo de su trabajo.** Si quieren conservar su resultado del Laboratorio 5, copien la carpeta `C:\CursoPBI\TiendasAndinas` y péguenla en `C:\CursoPBI` con el nombre `Respaldo_T06`.
3. **Punto de partida.** Borren el contenido de `C:\CursoPBI\TiendasAndinas` y copien en su lugar todo el contenido de `C:\CursoPBI\Checkpoints\T06_inicio`.

   > **Resultado esperado:** En `C:\CursoPBI\TiendasAndinas\TiendasAndinas.SemanticModel\definition\tables` existe `Categoria.tmdl`.

4. Hagan doble clic en `C:\CursoPBI\TiendasAndinas\TiendasAndinas.pbip`, vayan a **Inicio → Actualizar** y esperen a que termine. Cierren cualquier otro archivo de Power BI.

   > **Resultado esperado:** La página **Resumen** muestra datos. La tarjeta **Ventas (KPI gerencia)** dice *Ventas Totales* debajo del número.

5. Abran **Visual Studio Code** → **File → Open Folder…** → `C:\CursoPBI`. Si pregunta si confían en los autores, elijan **Yes, I trust the authors**.
6. **Solo si existe** `.github\copilot-instructions.md` (Laboratorio 4): comprueben que no diga «Usa solo el servidor MCP powerbi-solo-lectura». Si lo dice, cámbienlo por `- Usa el servidor MCP powerbi-authoring-local.` y guarden.
7. En el **panel de chat de la derecha**, abran una conversación nueva con el **+**. Si abajo dice **Copilot**, hagan clic sobre esa palabra y elijan **Local**.
8. **Configure Tools** (icono de controles a la derecha de **Auto**): **marcado** powerbi-authoring-local, `read` y `search`; **desmarcado** `edit`, `execute` y, si aparece, powerbi-solo-lectura. Clic en **OK**.

✔ **Verificación**

- `TiendasAndinas` tiene el estado de `T06_inicio` y Desktop muestra datos.
- El chat dice **Local** y Configure Tools tiene el servidor que escribe y no tiene `edit` ni `execute`.

## Ejercicio 1: Explicar y demostrar antes de corregir (8 min)

Este ejercicio **no cambia nada**: el agente explica una medida heredada y demuestra su comportamiento con una consulta.

1. Escriban:

   ```text
   Conéctate al archivo TiendasAndinas abierto en Power BI Desktop. No hagas cambios.
   1. Explica en 3 líneas cómo funciona la medida [Ventas Online] y qué problema tiene.
   2. Ejecuta UNA consulta DAX que compare, por FACT_Ventas[Canal] y filtrando Calendario[Anio] = 2025, tres versiones definidas con DEFINE MEASURE: la actual (SUMX con FILTER), CALCULATE([Total Ventas], FACT_Ventas[Canal] = "Online") y CALCULATE([Total Ventas], KEEPFILTERS(FACT_Ventas[Canal] = "Online")).
   3. Muestra el resultado en una tabla y explica en 2 líneas por qué difieren.
   ```

   > **Resultado esperado:**
   >
   > | Canal | Actual (SUMX + FILTER) | CALCULATE | CALCULATE + KEEPFILTERS |
   > |---|---|---|---|
   > | Online | 1.967.185.175 | 1.967.185.175 | 1.967.185.175 |
   > | Tienda | (en blanco) | **1.967.185.175** | (en blanco) |
   >
   > CALCULATE sin KEEPFILTERS **reemplaza** el filtro de canal: por eso muestra el total Online en la fila Tienda. Con KEEPFILTERS el filtro se suma y la fila Tienda queda en blanco.

2. Abran el paso **DAX Query Operations** debajo de la respuesta y lean en **Input** la consulta que ejecutó el agente.

✔ **Verificación**

- La versión CALCULATE sin KEEPFILTERS muestra 1.967.185.175 en la fila Tienda; las otras dos, en blanco.

## Ejercicio 2: Lote 1, medidas nuevas desde requisitos (12 min)

1. Pidan el plan:

   ```text
   Lote 1, medidas nuevas en FACT_Ventas a partir de estos requisitos de negocio:
   1. Unidades Vendidas: suma de la cantidad vendida.
   2. # Órdenes: número de órdenes distintas.
   3. Ventas por Fecha de Envío: Total Ventas usando la relación inactiva por FechaEnvio.
   4. Crecimiento AA %: variación de Total Ventas contra el año anterior, usando la medida Ventas AA que ya existe.
   5. Diferencia vs Presupuesto: Total Ventas menos Presupuesto.
   Reglas: reutiliza medidas existentes, divide con DIVIDE, sin años fijos. No modifiques otras medidas.
   Entrega el plan en una tabla (nombre, expresión DAX, formato) y no ejecutes nada hasta que escriba APROBADO.
   ```

   > **Resultado esperado:** Una tabla con 5 medidas: `SUM(FACT_Ventas[Cantidad])`, `DISTINCTCOUNT(FACT_Ventas[NumOrden])`, `CALCULATE([Total Ventas], USERELATIONSHIP(FACT_Ventas[FechaEnvio], Calendario[Fecha]))`, `DIVIDE([Total Ventas] - [Ventas AA], [Ventas AA])` y `[Total Ventas] - [Presupuesto]`. El formato lo corregirán en el siguiente lote.

2. Revisen el plan: ¿Ventas por Fecha de Envío usa **USERELATIONSHIP**? ¿Crecimiento AA % usa **DIVIDE**? Si no, pidan la corrección antes de aprobar.
3. Escriban `APROBADO` y den **Allow Once** en cada aprobación (**⚠** «Creates measures…»).

   > **Resultado esperado:** El agente confirma que creó las 5 medidas en FACT_Ventas.

✔ **Verificación**

- En el panel **Datos** de Desktop, dentro de FACT_Ventas, aparecen las 5 medidas nuevas.

## Ejercicio 3: Lote 2, corregir medidas, formatos y carpetas (12 min)

1. Pidan el plan:

   ```text
   Lote 2, corregir medidas existentes y dar formato:
   1. Divisiones con DIVIDE: Margen % = DIVIDE([margen], [Total Ventas]); Ticket Promedio = DIVIDE([Total Ventas], [# Órdenes]); Tasa Devolucion = DIVIDE([Unidades Devueltas], [Unidades Vendidas]); Cumplimiento = DIVIDE([Total Ventas], [Presupuesto]).
   2. Ventas Online = CALCULATE([Total Ventas], KEEPFILTERS(FACT_Ventas[Canal] = "Online")).
   3. Ventas YTD: la misma lógica, pero sobre Calendario[Fecha].
   4. Formato y carpeta de visualización para todas las medidas, excepto Ventas Totales, Ventas 2025 y Test. Formatos: moneda \$#,0;(\$#,0);\$#,0 · porcentaje 0.0% · enteros #,0. Carpetas: Ventas, Rentabilidad, Inteligencia de tiempo, Devoluciones, Presupuesto.
   No cambies nombres ni borres nada. Entrega el plan en una tabla (medida, expresión, formato, carpeta) y no ejecutes nada hasta que escriba APROBADO.
   ```

   > **Resultado esperado:** Una tabla con 18 medidas, cada una con su formato y carpeta, y con las 6 expresiones corregidas.

2. Revisen tres cosas: que `Ventas YTD` use `Calendario[Fecha]`, que `Ventas Online` tenga **KEEPFILTERS** y que **no** aparezcan Ventas Totales, Ventas 2025 ni Test.
3. Escriban `APROBADO` y den **Allow Once** en cada aprobación (**⚠** «Updates measures…»).
4. En Desktop, miren la página **Resumen** y expandan **FACT_Ventas** en el panel **Datos**.

   > **Resultado esperado:** Las tarjetas muestran formato: **$** en ventas y **%** en Margen % y Cumplimiento (33,6 % y 97,8 %). En el panel Datos aparecen las carpetas **Devoluciones**, **Inteligencia de tiempo**, **Presupuesto**, **Rentabilidad** y **Ventas**.

✔ **Verificación**

- Formatos visibles en las tarjetas y carpetas visibles en el panel Datos.

## Ejercicio 4: Validar todo con una consulta (8 min)

1. Escriban:

   ```text
   Sin hacer cambios, ejecuta UNA consulta DAX por Calendario[Anio] con estas medidas: Total Ventas, Unidades Vendidas, # Órdenes, Ticket Promedio, Margen %, Ventas Online, Ventas por Fecha de Envío, Unidades Devueltas, Tasa Devolucion, Presupuesto, Cumplimiento y Crecimiento AA %.
   Muéstrame la consulta y el resultado en una tabla con una fila por medida y una columna por año, sin redondear.
   ```

2. Comparen con los valores esperados y marquen cada fila:

   | Medida | 2024 | 2025 | ¿Cumple? |
   |---|---|---|---|
   | Total Ventas | 5.121.728.115 | 6.287.796.955 | |
   | Unidades Vendidas | 24.249 | 27.531 | |
   | # Órdenes | 9.696 | 10.923 | |
   | Ticket Promedio | 528.231 | 575.647 | |
   | Margen % | 31,3 % | 35,5 % | |
   | Ventas Online | 1.061.802.370 | 1.967.185.175 | |
   | Ventas por Fecha de Envío | 5.105.941.485 | 6.272.545.930 | |
   | Unidades Devueltas | 1.324 | 1.605 | |
   | Tasa Devolucion | 5,5 % | 5,8 % | |
   | Presupuesto | 5.239.480.000 | 6.429.182.000 | |
   | Cumplimiento | 97,8 % | 97,8 % | |
   | Crecimiento AA % | (en blanco) | 22,8 % | |

   > El agente puede mostrar los porcentajes como decimales (por ejemplo 0,3127 = 31,3 %). Es posible que aparezca una columna **sin año** con un valor en *Ventas por Fecha de Envío*: son envíos cuya fecha cae fuera del calendario del modelo. Anótenlo: no es un error de la medida.

✔ **Verificación**

- Las 12 medidas cumplen en los dos años.
- Pueden explicar por qué Crecimiento AA % está en blanco en 2024.

## Ejercicio 5: Borrar medidas sin romper el informe (10 min)

1. Pidan la revisión de dependencias:

   ```text
   Quiero eliminar las medidas Ventas Totales, Ventas 2025 y Test. NO ejecutes nada todavía.
   Para cada una, busca qué la usa: otras medidas del modelo y los visuales del informe (busca el nombre en los archivos visual.json dentro de TiendasAndinas/TiendasAndinas.Report/definition).
   Responde con una tabla: medida, qué la usa, se puede borrar ya (sí/no) y qué hacer antes.
   ```

   > **Resultado esperado:** `Ventas Totales` **no** se puede borrar todavía: la usa la tarjeta **Ventas (KPI gerencia)** de la página Resumen. `Ventas 2025` y `Test` sí se pueden borrar.

2. **Cambien la tarjeta en Desktop**, sin escribir en el chat:
   - Hagan clic en la tarjeta **Ventas (KPI gerencia)**.
   - En el panel **Visualizaciones**, sección **Campos**, quiten *Ventas Totales* con la **X**.
   - En el panel **Datos**, expandan **FACT_Ventas** → carpeta **Ventas** y marquen **Total Ventas**.
   - Guarden con **Ctrl+S**. El archivo del informe solo se actualiza al guardar.

   > **Resultado esperado:** La tarjeta muestra el mismo valor y debajo dice **Total Ventas**.

3. Pidan el borrado:

   ```text
   Ya cambié la tarjeta Ventas (KPI gerencia) a Total Ventas en Desktop y guardé. Elimina las medidas Ventas Totales, Ventas 2025 y Test del modelo abierto. No toques nada más.
   ```

   Den **Allow Once** en cada aprobación (**⚠** «Deletes measures…»).

   > **Resultado esperado:** El agente confirma el borrado y que quedan **18 medidas**. La tarjeta sigue mostrando su valor.

4. Guarden en Desktop con **Ctrl+S**.

✔ **Verificación**

- Quedan 18 medidas, la tarjeta funciona y el modelo está guardado.

## Cierre del laboratorio (2 min)

1. Cierren Power BI Desktop (ya guardaron).
2. `C:\CursoPBI\TiendasAndinas` queda como punto de partida del Laboratorio 7. Quien no terminó puede empezar el Laboratorio 7 desde `C:\CursoPBI\Checkpoints\T07_inicio`.

## Reto opcional

Solo si les sobra tiempo y cuota. Elijan **uno**:

- **Ventas YTD al 30 de junio.** Pidan una consulta que evalúe `[Ventas YTD]` en la fecha 30-jun-2025. Valor esperado: **2.810.010.265**.
- **Explicar para gerencia.** Pidan que explique `Crecimiento AA %` en tres líneas para un gerente comercial, sin fórmulas y con un ejemplo en pesos.
- **Rendimiento.** Pidan que compare el tiempo de ejecución de la versión SUMX(FILTER()) de Ventas Online con la de CALCULATE + KEEPFILTERS, con una consulta de cada una.

## Solución de problemas

| Síntoma | Causa probable | Acción |
|---|---|---|
| La consulta falla con «…needs to be recalculated» | Desktop no ha procesado el modelo | **Inicio → Actualizar** |
| El agente propone Ventas por Fecha de Envío sin USERELATIONSHIP | No usó la relación inactiva | Pedir: `Usa USERELATIONSHIP(FACT_Ventas[FechaEnvio], Calendario[Fecha]).` |
| Ticket Promedio da un valor distinto | Se creó antes que # Órdenes, o divide por otra cosa | Revisar que use `DIVIDE([Total Ventas], [# Órdenes])` |
| Los formatos no se ven en las tarjetas | Desktop no refrescó la vista | Cambiar de página y volver, o **Actualizar** |
| La tarjeta KPI muestra un error después del borrado | Se borró Ventas Totales antes de cambiar la tarjeta o sin guardar | En Desktop, quitar el campo con error de la tarjeta y poner **Total Ventas**; guardar |
| El agente dice que el informe todavía usa Ventas Totales | No guardaron después de cambiar la tarjeta | **Ctrl+S** en Desktop y repetir el mensaje |
| Aparece **N files changed** con **Keep** y **Undo** | `edit` quedó marcado | **Undo** y desmarcar `edit` |
| El agente no encuentra Power BI Desktop | La detección automática falla en algunos equipos | Usar el mensaje del puerto del Laboratorio 5 (Solución de problemas) |
| El chat deja de responder por límite de uso | Se acabó la cuota de Copilot Free | Seguir en modo demo o en pareja; el Laboratorio 7 puede empezar desde `Checkpoints\T07_inicio` |

## Resumen y entregables

- 18 medidas con formato y carpeta: 6 corregidas, 5 nuevas y 7 que ya estaban bien.
- La tabla de validación del Ejercicio 4 completa.
- `Ventas Totales`, `Ventas 2025` y `Test` eliminadas sin romper el informe.

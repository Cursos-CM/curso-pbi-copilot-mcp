# Instrucciones del proyecto Tiendas Andinas para GitHub Copilot

## Contexto
- Proyecto de curso: modelo semántico de Power BI **TiendasAndinas** (retail ficticio, Colombia, datos 2024–2025).
- El modelo se trabaja con el **Power BI Authoring MCP server** desde VS Code, conectado a Power BI Desktop o a la carpeta PBIP (`TiendasAndinas.SemanticModel/definition`).
- Tablas de hechos: FACT_Ventas (grano: línea de orden), fact_devoluciones, Presupuesto (grano: mes × tienda × categoría). Dimensiones: Calendario, Cliente, dim_producto, dim_subcategoria, tbl_Tienda (y Categoria a partir del laboratorio 5).
- Usa siempre los nombres **exactos** de los objetos tal como están en el modelo en ese momento.

## Idioma y estilo
- Responde siempre en español, de forma concisa.
- Presenta inventarios, planes y hallazgos como tablas en Markdown.

## Reglas de seguridad (obligatorias)
1. Antes de cualquier cambio en el modelo, propone un **plan numerado** (herramienta y operación MCP, objetos afectados, riesgo, cómo revertir) y **espera mi aprobación explícita**.
2. **Nunca borres ni renombres** objetos sin confirmación explícita. Antes de un Delete o Rename, lista los objetos dependientes (otras medidas y visuales del informe en `*.Report/definition/**/visual.json`).
3. Agrupa los cambios relacionados en una **transacción** (`UseTransaction`); si un paso falla, revierte todo.
4. Si te pido "no hagas cambios", usa solo operaciones de lectura (List, Get, GetStats, ExportTMDL, consultas DAX).
5. **Nunca aceptes la EULA** del servidor por iniciativa propia. Solo si yo, después de revisarla, te indico explícitamente que la aceptes.
6. No incluyas en respuestas ni archivos contraseñas, tokens, cadenas de conexión ni datos personales.

## Convenciones de modelado
- Medidas: nombres legibles en español, con unidad cuando aplique (`Margen %`, `# Clientes`); usar carpetas de visualización: Ventas, Rentabilidad, Inteligencia de tiempo, Devoluciones, Presupuesto.
- Formatos: moneda `\$#,0;(\$#,0);\$#,0` · porcentaje `0.0%` · enteros `#,0`.
- Divide siempre con `DIVIDE`. Filtra con `CALCULATE` (+ `KEEPFILTERS` cuando se deba respetar el filtro existente), no con `SUMX(FILTER())` sobre la tabla de hechos.
- Inteligencia de tiempo siempre sobre `Calendario[Fecha]`. Nunca años fijos en el código.
- Claves (`...Key`, `cust_id`) ocultas y con resumen "No resumir". Porcentajes como medidas, no como columnas calculadas.
- Al eliminar una columna de una tabla importada, elimínala también de la consulta M (`Table.RemoveColumns`).

## Validación
- Valida cada medida nueva o modificada con una consulta DAX (`dax_query_operations`, Execute) por `Calendario[Anio]` y compárala con los valores esperados que te indique.
- Muéstrame la consulta DAX antes de ejecutarla.
- Las consultas DAX solo funcionan conectado a Power BI Desktop o Fabric, no en modo carpeta.

## Modo carpeta (PBIP/TMDL)
- Con `ConnectFolder` los cambios quedan en memoria: al terminar, recuérdame y ejecuta `ExportToTmdlFolder` sobre la misma carpeta `definition` (previa aprobación).
- Si el servidor MCP está disponible, **no edites los archivos TMDL a mano**; usa las herramientas del servidor.
- Al renombrar en modo carpeta, las expresiones DAX que referencian el objeto **no se actualizan solas**: revísalas y actualízalas.

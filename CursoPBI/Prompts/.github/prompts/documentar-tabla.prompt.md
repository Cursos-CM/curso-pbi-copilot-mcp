---
agent: 'agent'
description: 'Proponer descripciones de negocio para una tabla y sus columnas y medidas'
argument-hint: 'Nombre exacto de la tabla'
---
Para la tabla '${input:tabla}' del modelo conectado:

1. Lista sus columnas y medidas con su descripción actual (si existe).
2. Propón una descripción en lenguaje de negocio (máximo 2 líneas, en español) para la tabla, cada columna visible y cada medida. Para las medidas, explica la lógica del DAX en términos de negocio.
3. Presenta la propuesta en una tabla: Objeto | Tipo | Descripción actual | Descripción propuesta.
4. **Espera mi aprobación.** Cuando apruebe, aplica las descripciones en una sola operación por tipo de objeto, usando transacción.
5. Si estás conectado en modo carpeta, al final recuérdame ejecutar ExportToTmdlFolder.

---
agent: 'agent'
description: 'Diagnóstico de solo lectura del modelo semántico frente a buenas prácticas'
argument-hint: 'Nombre del modelo abierto en Power BI Desktop'
---
Conéctate al modelo '${input:modelo:TiendasAndinas}' en Power BI Desktop. **No hagas ningún cambio**: usa solo operaciones de lectura.

1. Confirma el modelo conectado y entrega las estadísticas (GetStats): tablas, columnas, medidas, relaciones y roles.
2. Evalúa la estructura: esquema (estrella o copo de nieve), granularidad de cada tabla de hechos, tablas desconectadas, dirección de las relaciones, tabla de fechas (marcada o no; fecha y hora automáticas), columnas de ordenación, claves visibles, resumen predeterminado de columnas numéricas, columnas técnicas y columnas calculadas.
3. Revisa las expresiones DAX: divisiones sin DIVIDE, SUMX(FILTER()) en lugar de CALCULATE, valores fijos, inteligencia de tiempo que no use la tabla de calendario, medidas duplicadas o de prueba.
4. Revisa descripciones, formatos y carpetas de visualización.

Clasifica cada hallazgo:
- **Alta**: produce cifras incorrectas o riesgo de ambigüedad/rendimiento.
- **Media**: funciona hoy pero falla en el futuro o confunde al usuario.
- **Baja**: mantenimiento y documentación.

Entrega una tabla ordenada por severidad: N.º | Hallazgo | Objeto | Severidad | Por qué importa | Cómo comprobarlo.
Separa al final las "Hipótesis por confirmar" (lo que no pudiste verificar con las herramientas).

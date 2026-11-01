---
agent: 'agent'
description: 'Proponer y aplicar con control un renombrado masivo según la convención del proyecto'
argument-hint: 'Alcance: tablas, columnas, medidas o todo'
---
Alcance del renombrado: ${input:alcance:todo}

Convención del proyecto:
- Tablas con nombre de negocio, sin prefijos técnicos (FACT_, fact_, dim_, tbl_).
- Columnas en PascalCase, sin espacios ni guiones bajos; claves con sufijo Key.
- Medidas legibles en español, con tildes y unidad cuando aplique (%, #).

1. **No ejecutes nada todavía.** Propón una tabla: Tipo | Nombre actual | Nombre propuesto | Dependencias (medidas DAX y visuales del informe que lo usan).
2. Advierte qué visuales del informe (`*.Report/definition/**/visual.json`) quedarán rotos y deberán ajustarse.
3. Espera mi aprobación. Al ejecutar, usa transacción y renombra por lotes (primero tablas, luego columnas, luego medidas).
4. Después del renombrado, revisa todas las expresiones DAX: si alguna sigue usando el nombre anterior (en modo carpeta no se corrigen solas), propón y, con aprobación, aplica la corrección.
5. Verifica con una consulta DAX que [Total Ventas] por año no cambió.

---
agent: 'agent'
description: 'Proponer un plan de cambio verificable sin ejecutar nada'
argument-hint: 'Describa el cambio que necesita en el modelo'
---
Necesito este cambio en el modelo conectado: ${input:cambio}

**NO EJECUTES NADA TODAVÍA.**

Propón un plan numerado. Para cada paso indica:
- herramienta y operación del servidor MCP (por ejemplo, relationship_operations / Create),
- objetos que se crean, modifican o eliminan,
- riesgo y cómo se revierte,
- si conviene agruparlo en una transacción con otros pasos.

Antes del plan, lista los objetos dependientes que podrían verse afectados (medidas que los referencian y visuales del informe en `*.Report/definition/**/visual.json`).
Después del plan, indica cómo lo validarías: consulta DAX y resultado esperado.
Si existen dos alternativas razonables, preséntalas con ventajas y desventajas y recomienda una.

Espera mi aprobación. Cuando apruebe, ejecuta solo los pasos que yo indique.

---
agent: 'agent'
description: 'Explicar una medida existente para negocio y para desarrolladores'
argument-hint: 'Nombre exacto de la medida'
---
No hagas cambios. Obtén la definición de la medida [${input:medida}] del modelo conectado.

Explica:
1. **Para negocio** (3 líneas): qué indicador representa y cómo se interpreta.
2. **Técnicamente**: qué hace cada función, contexto de fila y de filtro, transición de contexto si aplica, y de qué otras medidas o columnas depende.
3. **Riesgos**: divisiones por cero, valores fijos, filtros que se pierden o se sobrescriben, dependencia de relaciones inactivas.
4. **Alternativa recomendada**, si la hay, con la expresión propuesta (sin aplicarla).
5. Una consulta DAX que permita comprobar tu explicación (muéstrala, no la ejecutes hasta que te lo pida).

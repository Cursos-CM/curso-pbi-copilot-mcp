---
agent: 'agent'
description: 'Validar medidas contra valores esperados con consultas DAX'
argument-hint: 'Medidas a validar, separadas por coma'
---
No modifiques el modelo. Valida estas medidas: ${input:medidas:[Total Ventas], [Margen %], [Ticket Promedio]}

1. Escribe una consulta DAX con `SUMMARIZECOLUMNS` por Calendario[Anio] que devuelva todas las medidas indicadas. Muéstramela antes de ejecutarla.
2. Ejecútala con dax_query_operations (Execute) y muestra los resultados en una tabla.
3. Compáralos con estos valores esperados: ${input:esperados:pegue aquí los valores de la guía del curso}
4. Marca cada valor como ✔ (coincide) o ✖ (difiere), y para cada diferencia propone una hipótesis de causa (relación, filtro, fórmula).
5. Si estás conectado en modo carpeta, indícame que debo conectarme a Power BI Desktop, porque las consultas DAX no funcionan sin conexión.

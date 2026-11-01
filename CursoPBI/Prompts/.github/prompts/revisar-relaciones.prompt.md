---
agent: 'agent'
description: 'Revisión de solo lectura de las relaciones del modelo'
---
No hagas cambios. Lista todas las relaciones del modelo conectado en una tabla:
Desde (tabla[columna]) | Hacia (tabla[columna]) | Cardinalidad | Dirección del filtro | Activa.

Luego evalúa:
- relaciones bidireccionales y si tienen justificación de negocio,
- tablas sin relaciones o con relaciones faltantes (por ejemplo, tablas de hechos sin relación con el calendario),
- relaciones inactivas y qué medida las activa (USERELATIONSHIP),
- posibles caminos ambiguos entre tablas,
- tablas de hechos con granularidad distinta que necesitan columnas o dimensiones puente.

Para cada problema indica severidad (Alta/Media/Baja) y una consulta DAX que demuestre su efecto en las cifras.

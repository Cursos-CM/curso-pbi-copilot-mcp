---
agent: 'agent'
description: 'Generar un diccionario de datos en Markdown a partir del modelo conectado'
---
No modifiques el modelo. Genera el archivo `diccionario_datos.md` en la raíz del área de trabajo con:

1. Resumen del modelo: propósito, tablas de hechos y dimensiones, granularidad de cada tabla de hechos.
2. Por cada tabla visible: descripción, y una tabla Columna | Tipo de dato | Descripción | Oculta.
3. Medidas agrupadas por carpeta de visualización: Nombre | Descripción | Formato | Expresión DAX (en bloque de código).
4. Relaciones: Desde | Hacia | Cardinalidad | Dirección | Activa.
5. Roles de seguridad y su filtro (si existen).
6. Lista de objetos sin descripción, como pendientes.

Usa la información real del modelo (herramientas del servidor MCP); no inventes descripciones que no existan: márcalas como "Pendiente".

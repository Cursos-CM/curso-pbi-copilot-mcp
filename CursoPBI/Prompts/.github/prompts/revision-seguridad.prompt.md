---
agent: 'agent'
description: 'Revisión de seguridad y gobierno del modelo antes de publicar'
---
No hagas cambios. Revisa el modelo conectado desde la perspectiva de seguridad y gobierno:

1. Columnas que contienen o podrían contener datos personales (nombres, fechas de nacimiento, documentos, correos) y si están visibles.
2. Roles de seguridad existentes (security_role_operations): nombre, permisos y filtros DAX. ¿Hay tablas sensibles sin filtrar?
3. Expresiones M y parámetros: ¿hay rutas, servidores o credenciales expuestas en texto?
4. Objetos sin descripción que impiden entender qué se publica.
5. Recomendaciones: qué ocultar, qué rol crear (por ejemplo, por región), qué documentar y qué validar en Power BI Desktop con "Ver como".

Entrega una tabla: Riesgo | Objeto | Severidad | Recomendación. No incluyas datos de filas reales en la respuesta, solo metadatos.

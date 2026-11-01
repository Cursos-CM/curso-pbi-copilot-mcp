---
agent: 'agent'
description: 'Crear una medida DAX a partir de un requisito de negocio, con plan y validación'
argument-hint: 'Describa el indicador de negocio'
---
Crea una medida en el modelo conectado a partir de este requisito de negocio:

${input:requisito}

Tabla destino: ${input:tabla:FACT_Ventas}

1. Propón: nombre (legible, en español, con unidad si aplica), expresión DAX, formato (moneda `\$#,0;(\$#,0);\$#,0`, porcentaje `0.0%` o entero `#,0`), carpeta de visualización y descripción en lenguaje de negocio.
2. Explica en dos líneas cómo se comporta con el contexto de filtro (por año, por categoría, por canal).
3. Reutiliza medidas existentes cuando sea posible; usa DIVIDE para divisiones y Calendario[Fecha] para inteligencia de tiempo.
4. **Espera mi aprobación** antes de crearla.
5. Después de crearla, muéstrame y ejecuta una consulta DAX que la evalúe por Calendario[Anio] junto con [Total Ventas].

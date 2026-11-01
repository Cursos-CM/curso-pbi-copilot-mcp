# Valores esperados – Tiendas Andinas

Cifras de control calculadas directamente desde los CSV. Úsenlas para validar las medidas en los laboratorios (los nombres de medida corresponden al estado posterior al Laboratorio 6).

| Medida | 2024 | 2025 | Total |
|---|---|---|---|
| Total Ventas | $5.121.728.115 | $6.287.796.955 | $11.409.525.070 |
| Costo | $3.520.079.400 | $4.058.260.200 | $7.578.339.600 |
| Margen | $1.601.648.715 | $2.229.536.755 | $3.831.185.470 |
| Margen % | 31,3 % | 35,5 % | 33,6 % |
| Unidades Vendidas | 24.249 | 27.531 | 51.780 |
| # Órdenes | 9.696 | 10.923 | 20.619 |
| # Clientes | 2.192 | 2.231 | 2.375 |
| Ticket Promedio | $528.231 | $575.647 | $553.350 |
| Ventas Online | $1.061.802.370 | $1.967.185.175 | $3.028.987.545 |
| Unidades Devueltas (por fecha de devolución) | 1.324 | 1.605 | 2.929 |
| Tasa de Devolución % | 5,5 % | 5,8 % | 5,7 % |
| Presupuesto | $5.239.480.000 | $6.429.182.000 | $11.668.662.000 |
| Cumplimiento % | 97,8 % | 97,8 % | 97,8 % |

2025: Crecimiento AA % = 22,8 %; Ventas AA = $5.121.728.115; Ventas YTD al 30-jun-2025 = $2.810.010.265. Ventas por Fecha de Envío: 2024 = $5.105.941.485; 2025 = $6.272.545.930.
Ventas 2025 por categoría: Tecnología $2.584.127.490; Hogar $1.423.787.965; Moda $1.415.211.750; Deportes $864.669.750. Presupuesto 2025: Tecnología $2.650.017.000; Hogar $1.464.544.000; Moda $1.434.910.000; Deportes $879.711.000. Cumplimiento 2025: Tecnología 97,5 %; Hogar 97,2 %; Moda 98,6 %; Deportes 98,3 %.
Margen % 2025 por categoría: Deportes 37,4 %; Hogar 35,6 %; Moda 35,3 %; Tecnología 34,8 %. Tasa de devolución 2025: Moda 8,1 %; Tecnología 3,9 %; Deportes 3,0 %; Hogar 2,4 %.
Ventas 2025 por región: Online $1.967.185.175; Centro $1.150.672.665; Caribe $1.003.341.385; Noroccidente $762.567.105; Suroccidente $661.172.015; Eje Cafetero $391.177.825; Orinoquía $182.497.455; Nororiente $169.183.330. Canal 2025: Tienda $4.320.611.780; Online $1.967.185.175.
Con el rol `Gerente Regional Caribe`, Total Ventas 2025 = $1.003.341.385.
Comportamientos erróneos del estado inicial: `Ventas Online` (SUMX/FILTER) filtrado por Canal = "Tienda" → en blanco (correcto); con CALCULATE **sin** KEEPFILTERS → muestra $1.967.185.175 en la fila "Tienda" (incorrecto) → por eso KEEPFILTERS. `Unidades Devueltas` por año antes de relacionar → 2.929 en cada año. `Cumplimiento` por categoría antes de relacionar → ningún filtro (ni el de año) llega a Presupuesto, así que divide las ventas de la categoría entre el presupuesto total de los dos años ($11.668.662.000); p. ej. Tecnología 2025 ≈ 22,1 %.

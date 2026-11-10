# Modelado semántico de Power BI asistido por IA con GitHub Copilot y MCP

Material oficial para los participantes del curso. 16 horas en 4 sesiones virtuales de 4 horas.

Durante el curso van a analizar, corregir, ampliar y documentar el modelo semántico de **Tiendas Andinas**, una cadena de retail ficticia, con GitHub Copilot en modo agente y el **Power BI Authoring MCP server**. Todos los datos son ficticios.

---

## Contenido

- [Antes de la primera sesión](#antes-de-la-primera-sesión)
- [Descargar los materiales](#descargar-los-materiales)
- [Ruta del curso](#ruta-del-curso)
- [Estructura del repositorio](#estructura-del-repositorio)
- [Soporte](#soporte)

---

## Antes de la primera sesión

Sigan la **[guía de preparación](PREPARACION.md)**. Toma unos 20 minutos y deja su equipo listo: requisitos, instalación del software, descarga de los materiales y verificación.

Requisitos en resumen:

| Requisito | Detalle |
|---|---|
| Equipo | Windows 10 u 11 de 64 bits |
| Licencia | GitHub Copilot Free (gratuito) o cualquier plan pago |
| Software (gratuito) | Visual Studio Code, Power BI Desktop y la extensión Power BI Authoring MCP Server. No hace falta Git, Node.js ni PowerShell |
| Cuentas de empresa | Política **MCP servers in Copilot** habilitada por un administrador de GitHub |

## Descargar los materiales

1. Abran la **[última versión publicada](../../releases/latest)** y descarguen `CursoPBI.zip`.
2. Descompriman el archivo directamente en `C:\`. Debe quedar la carpeta `C:\CursoPBI`.

> No clonen este repositorio dentro de `C:\CursoPBI`. En el Tema 7 cada participante crea su propio repositorio en GitHub, desde la página web.

## Ruta del curso

| Sesión | Temas | Material |
|---|---|---|
| **Día 1** | 1. Fundamentos: GitHub Copilot, agentes y MCP | [Laboratorio 1](Guias/Tema01_Laboratorio.md) |
| **Día 2** | 2. Configuración del entorno y conexión a modelos semánticos | [Laboratorio 2](Guias/Tema02_Laboratorio.md) |
| | 3. Exploración y diagnóstico con lenguaje natural | [Laboratorio 3](Guias/Tema03_Laboratorio.md) |
| **Día 3** | 4. Ingeniería de instrucciones | [Laboratorio 4](Guias/Tema04_Laboratorio.md) |
| | 5. Creación y modificación del modelo | [Laboratorio 5](Guias/Tema05_Laboratorio.md) |
| | 6. DAX asistido por IA | Próximamente |
| **Día 4** | 7. PBIP, TMDL y control de versiones en GitHub · 8. Operaciones masivas, documentación, seguridad y gobierno + laboratorio final | Próximamente |

El material de cada sesión se publica a medida que avanza el curso.

## Estructura del repositorio

```text
├── CursoPBI/           Carpeta de trabajo (la misma de CursoPBI.zip)
│   ├── Datos/            Archivos CSV de Tiendas Andinas
│   ├── TiendasAndinas/   Proyecto PBIP con el que se inicia el curso
│   ├── Checkpoints/      Punto de partida de los laboratorios 5 a 8
│   ├── Prompts/          Biblioteca base de instrucciones para Copilot
│   ├── ValoresEsperados.md
│   └── Verificar-Entorno.ps1   (opcional, requiere PowerShell)
├── Guias/              Guías de laboratorio
└── PREPARACION.md      Guía de preparación del equipo
```

## Soporte

Si algo de la preparación no funciona, escriban al instructor con una captura de pantalla.

---

Material de uso exclusivo de los participantes del curso. No se permite su redistribución.

# Laboratorio final: El informe del equipo

| Dato | Detalle |
|---|---|
| Duración | 2 horas, por tramos guiados |
| Modalidad | En equipo: todo el grupo trabaja sobre el mismo repositorio |
| Punto de partida | El repositorio de su grupo en GitHub: `Cursos-CM/tiendas-andinas-grupo1` o `Cursos-CM/tiendas-andinas-grupo2`. No hace falta haber terminado ningún laboratorio anterior |
| Resultado esperado | Una página suya en el informe del equipo, creada con el agente, validada con datos, entregada por pull request, revisada por un compañero e integrada en `main` |

## Objetivos

- Trabajar sobre un mismo proyecto PBIP con ramas y pull requests, todo desde la web de GitHub.
- Usar los prompts del equipo que vienen dentro del repositorio.
- Consultar el modelo con el agente sin cambiar nada (repaso de los Temas 1 a 3 y 6).
- Pedirle al agente que **cree y cambie visuales** del informe, con plan y APROBADO (Tema 8).
- Validar la página contra valores esperados antes de entregarla (repaso del Tema 6).
- Revisar el pull request de un compañero.

## Escenario

La gerencia de Tiendas Andinas pidió doce análisis. Cada integrante del equipo toma uno, su **encargo**, y lo convierte en una página del informe. Nadie trabaja sobre el archivo de otro: cada página es una carpeta y cada persona entrega la suya con un pull request. Al final, `main` tiene el informe completo del equipo.

> **Cómo leer esta guía:** cada recuadro gris con texto en español es un **mensaje para el chat de Copilot**: cópienlo, péguenlo en el cuadro del chat y presionen **Enter**. Reemplacen lo que está entre `< >` por sus datos. En este laboratorio **no se usa PowerShell ni la terminal**.
>
> **Por tramos:** el instructor marca el inicio y el final de cada tramo. Al final de cada uno hay un **Punto de control**: no sigan al siguiente hasta que el instructor lo indique. Si algo no sale, levanten la mano o escriban en el chat de la reunión **✋ y el número del paso**.
>
> **Copilot Free:** el laboratorio usa unos 5 mensajes. Envíen un mensaje a la vez.
>
> **Dos ventanas:** tengan abiertos el **navegador** con GitHub y **Visual Studio Code**. Van a ir y volver varias veces.

## Datos de su trabajo

Antes de empezar, anoten estos datos. Los van a usar en todo el laboratorio.

| Dato | Ejemplo | Suyo |
|---|---|---|
| Grupo y repositorio | `tiendas-andinas-grupo1` | |
| Su nombre (como aparecerá en la página) | `Ana` | |
| Su rama | `pagina-ana` (minúsculas, sin tildes ni espacios) | |
| Número de encargo | Su número en la lista de asistencia; del 13 en adelante, vuelvan a empezar (13 → 1, 14 → 2…) | |
| Compañero que va a revisar | El siguiente en la lista (el último revisa al primero) | |

## Tramo 1 · Arranque: el proyecto del equipo en su equipo (15 min)

1. Si Power BI Desktop o VS Code están abiertos, ciérrenlos. Si Desktop pregunta si desean guardar, elijan **No guardar**.
2. En el navegador, entren a **github.com** con su cuenta (la misma de Copilot) y abran `https://github.com/Cursos-CM/tiendas-andinas-grupo<N>`, con el número de su grupo.

   > **Resultado esperado:** Ven el repositorio con las carpetas `.github`, `TiendasAndinas.Report`, `TiendasAndinas.SemanticModel` y los archivos `ENCARGOS.md` y `README.md`. Si GitHub dice que la página no existe, avisen al instructor: falta aceptar la invitación a la organización.

3. Abran `ENCARGOS.md` y busquen la fila de su número de encargo. Anoten qué gráfico y qué tarjeta les toca.
4. Vuelvan a la página principal del repositorio → botón verde **Code** → **Download ZIP**. Guarden el archivo.
5. En el Explorador de archivos, clic derecho sobre el ZIP → **Extract All…** → escriban como destino `C:\CursoPBI\Equipo` → **Extract**.

   > **Resultado esperado:** Existe la carpeta `C:\CursoPBI\Equipo\tiendas-andinas-grupo<N>-main` con `TiendasAndinas.pbip` adentro. En esta guía la llamamos **la carpeta del proyecto**.

6. Hagan doble clic en `TiendasAndinas.pbip` de la carpeta del proyecto. Cuando abra, **Inicio → Actualizar** y esperen a que termine.

   > **Resultado esperado:** La página **Resumen** muestra datos: Total Ventas **$11 mil M**.
   >
   > Si aparece un error de «referencia cíclica» en Presupuesto, elijan **Cerrar** y vuelvan a **Actualizar**: la segunda vez funciona.

7. Abran **Visual Studio Code** → **File → Open Folder…** → la carpeta del proyecto. Si pregunta si confían en los autores, elijan **Yes, I trust the authors**.
8. En el chat de la derecha, abran una conversación nueva con el **+**. Si abajo dice **Copilot**, hagan clic sobre esa palabra y elijan **Local**.
9. **Configure Tools** (icono de controles a la derecha de **Auto**):
   - **Marcados:** `read`, `search` y **powerbi-authoring-local**.
   - **Desmarcados:** `edit`, `execute` y `browser`.
   - Clic en **OK**.
10. En el cuadro del chat escriban `/con` y comprueben que aparece **/consultar-encargo**. Después borren lo que escribieron.

✔ **Punto de control 1**

- Desktop muestra datos desde la carpeta del proyecto.
- VS Code tiene abierta la carpeta del proyecto, el chat dice **Local** y los prompts del equipo aparecen con `/`.

> **Pregunta para el grupo:** ¿de dónde salieron los prompts `/consultar-encargo`, `/crear-pagina` y `/cambiar-visual`, si ustedes no los crearon?

## Tramo 2 · Su rama (10 min)

1. En GitHub, en la página principal del repositorio, hagan clic en el selector de ramas (el botón que dice **main**, arriba a la izquierda).
2. Escriban el nombre de su rama, por ejemplo `pagina-ana`, y hagan clic en **Create branch pagina-ana from main**.

   > **Resultado esperado:** El selector ahora dice el nombre de su rama. En **Branches** (o en el mismo selector) aparecen `main` y su rama.

3. Vuelvan a `main` con el selector y comprueben que nada cambió: su rama es una copia de trabajo, no el informe oficial.

✔ **Punto de control 2**

- Su rama existe en el repositorio.

> **Pregunta para el grupo:** si su rama es una copia de `main`, ¿qué tiene que pasar para que su página llegue al informe oficial?

## Tramo 3 · Consultar su encargo, sin cambiar nada (15 min)

1. En el chat de VS Code escriban, con su número de encargo:

   ```text
   /consultar-encargo <número>
   ```

2. Si aparece una aprobación, léanla: debe ser de **powerbi-authoring-local** y de lectura (**✓**, *reads data*). Elijan **Allow Once**.

   > **Resultado esperado:** Dos consultas DAX con `SUMMARIZECOLUMNS`, una tabla de resultados ordenada de mayor a menor y una línea final que dice si coinciden con `ENCARGOS.md`.
   >
   > Si el agente no encuentra Desktop: `Lee el número del archivo msmdsrv.port.txt que está en %LOCALAPPDATA%\Microsoft\Power BI Desktop\AnalysisServicesWorkspaces (subcarpeta Data) y conéctate a localhost con ese puerto.`

3. Comparen ustedes mismos dos valores con la columna **Valores esperados** de `ENCARGOS.md`.

✔ **Punto de control 3**

- Sus números coinciden con `ENCARGOS.md`.
- Ningún archivo cambió: no apareció **Keep / Undo**.

> **Pregunta para el grupo:** ¿por qué consultamos los datos **antes** de construir la página?

## Tramo 4 · Crear su página con el agente (25 min)

En este tramo el agente **sí** va a crear archivos. Por eso, y solo por este tramo, abrimos la llave de edición.

1. **Configure Tools:** marquen `edit`. Dejen `execute` y `browser` desmarcados. **OK**.
2. Escriban, con su nombre y su encargo:

   ```text
   /crear-pagina <Nombre>, encargo <número>
   ```

3. Lean el plan **antes** de aprobar. Debe decir:
   - una carpeta nueva dentro de `TiendasAndinas.Report/definition/pages`;
   - un `page.json` con el nombre **Página de [Nombre]**;
   - dos `visual.json`: el gráfico de su encargo, con los campos de `ENCARGOS.md`, y la tarjeta;
   - que **no** cambia `pages.json` ni el modelo.

   Si algo no coincide, pidan la corrección antes de aprobar.

4. Escriban:

   ```text
   APROBADO
   ```

5. Si el agente pide ejecutar código o abrir un navegador para «validar» (por ejemplo *Run Playwright Code*), elijan **Skip**: la validación la hacemos en Desktop.

   > **Resultado esperado:** El agente termina con el **nombre de la carpeta** de su página (20 letras y números) y recuerda cerrar Desktop sin guardar. Debajo aparece **3 files changed** con **Keep** y **Undo**.

6. Anoten el nombre de la carpeta en su tabla de datos y elijan **Keep**.
7. En Desktop: ciérrenlo y, cuando pregunte si desean guardar, elijan **No guardar**. Ábranlo de nuevo con `TiendasAndinas.pbip` y vayan a **Inicio → Actualizar**.

   > **Importante:** si guardan en Desktop, Desktop sobrescribe los archivos con lo que tenía en memoria y se pierde la página que creó el agente.

8. Abajo, en las pestañas de páginas, abran **Página de [Nombre]**. Pasen el mouse sobre dos barras o puntos del gráfico y comparen con `ENCARGOS.md`.

   > **Resultado esperado:** Un gráfico con el título de su encargo y su nombre entre paréntesis, y una tarjeta. Los valores coinciden con los del Tramo 3.

✔ **Punto de control 4**

- Su página abre en Desktop sin errores y sus números coinciden.
- Anotaron el nombre de la carpeta de su página.

> **Pregunta para el grupo:** ¿qué diferencia hubo entre esta aprobación y las de los Temas 5 y 6, cuando el agente cambiaba el modelo?

## Tramo 5 · Cambiar un visual (10 min)

1. Elijan **un** cambio para su gráfico y escríbanlo con su nombre. Por ejemplo:

   ```text
   /cambiar-visual <Nombre>, cambia el gráfico principal de columnas a barras
   ```

   Otras opciones: cambiar el título, poner la tarjeta debajo del gráfico o hacer el gráfico más ancho.

2. Revisen la tabla de cambios (propiedad, valor actual, valor nuevo) y escriban `APROBADO`. Elijan **Keep**.
3. Cierren Desktop **sin guardar**, ábranlo de nuevo, **Actualizar** y revisen su página.
4. **Configure Tools:** desmarquen `edit`. **OK**. La llave se devuelve al terminar.

✔ **Punto de control 5**

- Su página muestra el cambio y los números siguen iguales.
- `edit` está desmarcado otra vez.

## Tramo 6 · Subir su página y abrir el pull request (20 min)

1. En el Explorador de archivos, abran `<carpeta del proyecto>\TiendasAndinas.Report\definition\pages` y ubiquen la carpeta de su página (el nombre que anotaron). Dejen esta ventana a la vista.
2. En GitHub, cambien a **su rama** con el selector de ramas.
3. Entren a `TiendasAndinas.Report` → `definition` → `pages`.
4. Clic en **Add file → Upload files**.
5. **Arrastren la carpeta de su página** desde el Explorador de archivos hasta la zona de carga de GitHub.

   > **Resultado esperado:** GitHub lista 3 archivos: `page.json` y dos `visual.json`, dentro de la carpeta de su página.
   >
   > Arrastren **solo** su carpeta. No suban `pages.json` ni otras carpetas.

6. Abajo, en **Commit changes**:
   - Mensaje: `Agrega Página de <Nombre> (encargo <número>)`.
   - Elijan **Commit directly to the pagina-[nombre] branch**.
   - Clic en **Commit changes**.
7. Arriba aparece un aviso amarillo con el botón **Compare & pull request**. Hagan clic. (Si no aparece: pestaña **Pull requests → New pull request**, *base:* `main`, *compare:* su rama.)
8. Título: `Página de <Nombre> · encargo <número>`. En la descripción ya viene la plantilla del equipo: complétenla y marquen las casillas que correspondan.
9. Clic en **Create pull request**.
10. Abran la pestaña **Files changed** de su pull request.

    > **Resultado esperado:** Aparecen **3 archivos**, todos dentro de la carpeta de su página, en verde (agregados).

✔ **Punto de control 6**

- Su pull request está abierto, con la plantilla completa.
- **Files changed** muestra solo los 3 archivos de su página.

> **Pregunta para el grupo:** ¿qué ventaja tiene que el pull request diga cómo validaron la página?

## Tramo 7 · Revisión cruzada e integración (20 min)

1. En la pestaña **Pull requests** del repositorio, abran el pull request del compañero que les toca revisar.
2. En **Files changed**, revisen con la lista de la plantilla:
   - ¿Cambia solo una carpeta dentro de `pages`?
   - ¿El título del gráfico termina con el nombre de la persona?
   - En el `visual.json` del gráfico, ¿los campos (`Entity` y `Property`) son los de su encargo en `ENCARGOS.md`?
3. Dejen al menos un comentario: pasen el mouse sobre una línea, hagan clic en el **+** azul, escriban y elijan **Start a review**.
4. Clic en **Review changes** (o **Finish your review**) → elijan **Approve** si todo está bien, o **Comment** si algo hay que corregir → **Submit review**.
5. El instructor integra los pull requests aprobados en `main` (**Merge pull request**). Síganlo en la pantalla compartida.
6. Cuando el instructor lo indique, descarguen otra vez `main` (**Code → Download ZIP**), extráiganlo en `C:\CursoPBI\Equipo\final`, abran ese `TiendasAndinas.pbip` y **Actualizar**.

   > **Resultado esperado:** El informe tiene la página **Resumen** y una página por cada pull request integrado.

✔ **Punto de control 7**

- Revisaron un pull request y dejaron su revisión.
- El informe final del equipo abre con todas las páginas.

## Reto opcional

- Pidan a un compañero que revise un **segundo** pull request, y comparen sus comentarios: ¿vieron lo mismo?
- En la carpeta `final`, pídanle al agente (sin cambiar nada) que liste todas las páginas del informe, con su autor y los campos que usa cada visual.

## Solución de problemas

| Síntoma | Causa probable | Acción |
|---|---|---|
| GitHub dice que el repositorio no existe | No han aceptado la invitación a la organización Cursos-CM | Abrir `https://github.com/orgs/Cursos-CM/invitation` con su cuenta y aceptar, o avisar al instructor |
| Al actualizar sale «referencia cíclica» en Presupuesto | Error ocasional del primer refresco | **Cerrar** y **Actualizar** otra vez |
| Al escribir `/` no aparecen los prompts del equipo | El chat está en **Copilot**, o VS Code no abrió la carpeta del proyecto | Cambiar a **Local**; **File → Open Folder** sobre la carpeta del proyecto |
| El agente pide ejecutar código, abrir un navegador o usar una terminal | Intenta validar por su cuenta | **Skip**; dejar `execute` y `browser` desmarcados |
| La página no aparece en Desktop | Desktop seguía abierto, o se guardó después del cambio | Cerrar Desktop **sin guardar** y abrir de nuevo. Si se guardó, pedir otra vez `/crear-pagina` |
| El visual sale en blanco o con una X | Un campo con otro nombre en el `visual.json` | `/cambiar-visual <Nombre>, revisa que los campos del gráfico existan en el modelo y corrígelos` |
| No se puede arrastrar la carpeta a GitHub | El navegador no acepta carpetas | Abrir la carpeta, seleccionar `page.json` y arrastrarlo; luego **Add file → Create new file** para cada `visual.json`, escribiendo la ruta `visuals/<carpeta del visual>/visual.json` y pegando el contenido |
| GitHub no deja hacer commit en `main` | La rama `main` está protegida | Es lo esperado: cambiar a su rama y subir ahí |
| **Files changed** muestra más de 3 archivos | Se subió algo más que la carpeta de la página | En **Files changed**, menú **…** del archivo de más → **Delete file**, o pedir ayuda al instructor |
| El chat deja de responder por límite de uso | Se acabó la cuota de Copilot Free | Seguir en pareja con un compañero; la revisión cruzada no usa Copilot |

## Resumen y entregables

- Una rama `pagina-<nombre>` con la carpeta de su página.
- Un pull request con la plantilla completa y validado.
- Una revisión hecha al pull request de un compañero.
- El informe del equipo en `main`, con su página.

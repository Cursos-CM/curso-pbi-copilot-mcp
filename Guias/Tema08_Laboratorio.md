# Laboratorio final: El informe del equipo

| Dato | Detalle |
|---|---|
| Duración | 2 horas, por tramos guiados |
| Modalidad | En equipo: todo el grupo trabaja sobre el mismo repositorio |
| Punto de partida | El repositorio de su grupo en GitHub: `Cursos-CM/tiendas-andinas-grupo1` o `Cursos-CM/tiendas-andinas-grupo2`. No hace falta haber terminado ningún laboratorio anterior |
| Resultado esperado | El modelo documentado y con un rol de seguridad en su equipo, y una página suya en el informe del equipo, creada con el agente, validada, entregada por pull request, revisada por un compañero e integrada en `main` |

## Objetivos

- Seguir el orden de un proyecto real: primero el **modelo**, después el **informe** y al final **Git**.
- Documentar todas las medidas del modelo en una sola operación masiva (Tema 8).
- Crear y probar un rol de seguridad por filas (RLS) con el agente (Tema 8).
- Pedirle al agente que cree y cambie visuales del informe, con plan y APROBADO (Tema 8).
- Validar contra valores esperados antes de entregar (repaso del Tema 6).
- Entregar con rama y pull request, y revisar el de un compañero (Tema 7).

## Escenario

La gerencia de Tiendas Andinas pidió doce análisis. El equipo trabaja como en un proyecto real: primero deja el modelo listo para usar (documentado y con seguridad por región), después cada integrante construye la página de su **encargo** y, al final, la entrega con un pull request. Al terminar, `main` tiene el informe completo del equipo.

> **Cómo leer esta guía:** cada recuadro gris con texto en español es un **mensaje para el chat de Copilot**: cópienlo, péguenlo en el cuadro del chat y presionen **Enter**. Reemplacen lo que está entre `< >` por sus datos. En este laboratorio **no se usa PowerShell ni la terminal**.
>
> **Por tramos:** el instructor marca el inicio y el final de cada tramo. Al final de cada uno hay un **Punto de control**: no sigan al siguiente hasta que el instructor lo indique. Si algo no sale, levanten la mano o escriban en el chat de la reunión **✋ y el número del paso**.
>
> **Copilot Free:** el laboratorio usa unos 9 mensajes. Envíen un mensaje a la vez.
>
> **Aprobaciones:** las lecturas aparecen con **✓** y las escrituras con **⚠**. Elijan siempre **Allow Once** (flecha junto a *Allow in this Session* → **Allow Once**).

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
10. En el cuadro del chat escriban `/` seguido de las primeras letras y comprueben que aparecen los cinco prompts del equipo: **/consultar-encargo**, **/documentar-medidas**, **/crear-rol**, **/crear-pagina** y **/cambiar-visual**. Después borren lo que escribieron.

✔ **Punto de control 1**

- Desktop muestra datos desde la carpeta del proyecto.
- VS Code tiene abierta la carpeta del proyecto, el chat dice **Local** y los prompts del equipo aparecen con `/`.

> **Pregunta para el grupo:** ¿de dónde salieron esos cinco prompts, si ustedes no los crearon?

## Tramo 2 · Conocer su encargo, sin cambiar nada (10 min)

1. En el chat de VS Code escriban, con su número de encargo:

   ```text
   /consultar-encargo <número>
   ```

2. Si aparece una aprobación, léanla: debe ser de **powerbi-authoring-local** y de lectura (**✓**). Elijan **Allow Once**.

   > **Resultado esperado:** Dos consultas DAX con `SUMMARIZECOLUMNS`, una tabla de resultados ordenada de mayor a menor y una línea final que dice si coinciden con `ENCARGOS.md`.
   >
   > Si el agente no encuentra Desktop: `Lee el número del archivo msmdsrv.port.txt que está en %LOCALAPPDATA%\Microsoft\Power BI Desktop\AnalysisServicesWorkspaces (subcarpeta Data) y conéctate a localhost con ese puerto.`

3. Comparen ustedes mismos dos valores con la columna **Valores esperados** de `ENCARGOS.md`.

✔ **Punto de control 2**

- Sus números coinciden con `ENCARGOS.md`.

> **Pregunta para el grupo:** ¿por qué consultamos los datos **antes** de construir nada?

## Tramo 3 · Modelo: documentar todas las medidas en un lote (15 min)

Un modelo que se va a compartir necesita que cualquiera entienda sus medidas. El agente las va a documentar todas en **una sola operación masiva**.

1. Escriban:

   ```text
   /documentar-medidas
   ```

2. Aprueben las lecturas (**✓**) con **Allow Once**.
3. Lean el plan **antes** de aprobar: una tabla con las **18 medidas**, su carpeta y una descripción en lenguaje de negocio. Elijan dos descripciones y pregúntense si un gerente las entendería.
4. Escriban:

   ```text
   APROBADO
   ```

5. Aparece una aprobación de escritura (**⚠**, *Updates measures in FACT_Ventas… changes workspace source*). Es **una sola** escritura para las 18 medidas: eso es una operación masiva. Elijan **Allow Once**.

   > **Resultado esperado:** «Se actualizaron las descripciones de las 18 medidas… en una sola operación».

6. En Desktop, panel **Datos** → `FACT_Ventas`: pasen el mouse sobre **Total Ventas** y sobre otra medida.

   > **Resultado esperado:** Aparece la descripción que propuso el agente.

✔ **Punto de control 3**

- Las 18 medidas tienen descripción.
- Hubo **una** aprobación de escritura, no dieciocho.

> **Pregunta para el grupo:** si fueran 300 medidas, ¿qué revisarían antes de escribir APROBADO?

## Tramo 4 · Modelo: seguridad por filas (15 min)

La gerencia regional del Caribe solo debe ver los datos de sus tiendas. Eso se resuelve con un **rol de seguridad por filas** (RLS, *Row-Level Security*).

1. Escriban:

   ```text
   /crear-rol Región Caribe, solo las tiendas de la región Caribe
   ```

2. Aprueben las lecturas (**✓**) con **Allow Once**. Lean el plan: rol **Región Caribe**, permiso de lectura, tabla `tbl_Tienda` y filtro `[Region] = "Caribe"`.
3. Escriban `APROBADO` y aprueben las escrituras (**⚠**, *Creates a security role…*) con **Allow Once**.

   > **Resultado esperado:** El agente crea el rol y su filtro, y dice que con el rol Total Ventas debería ser **1.866.538.345**. Puede que corrija algo por su cuenta (por ejemplo, crear el filtro como un permiso de tabla aparte) y pida otra aprobación: es normal.

4. **Probar el rol en Desktop:** pestaña **Modelado → Ver como** → marquen **Región Caribe** → **Aceptar**.

   > **Resultado esperado:** Arriba aparece *Se muestra como Región Caribe*. Total Ventas **$2 mil M**, Margen % **33,1 %**, Cumplimiento **98,4 %**, y la tabla *Ventas por región* muestra solo **Caribe: $1.866.538.345**.

5. Clic en **Detener la visualización**.
6. **Guarden con Ctrl+S.** Así el modelo queda guardado en los archivos antes de pasar al informe.

✔ **Punto de control 4**

- Con *Ver como Región Caribe*, solo se ven los datos del Caribe.
- Guardaron con **Ctrl+S**.

> **Pregunta para el grupo:** el rol ya existe en el modelo, pero ¿quién decide qué personas pertenecen a él?

## Tramo 5 · Informe: crear su página con el agente (20 min)

En este tramo el agente **sí** va a crear archivos del informe. Por eso, y solo por este tramo y el siguiente, abrimos la llave de edición.

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

   > **Importante:** si guardan en Desktop ahora, Desktop sobrescribe los archivos del informe con lo que tenía en memoria y se pierde la página que creó el agente. El modelo no se pierde: lo guardaron en el Tramo 4.

8. Abajo, en las pestañas de páginas, abran **Página de [Nombre]**. Pasen el mouse sobre dos barras o puntos del gráfico y comparen con `ENCARGOS.md`.

   > **Resultado esperado:** Un gráfico con el título de su encargo y su nombre entre paréntesis, y una tarjeta. Los valores coinciden con los del Tramo 2. Las descripciones y el rol **Región Caribe** siguen ahí.

✔ **Punto de control 5**

- Su página abre en Desktop sin errores y sus números coinciden.
- Anotaron el nombre de la carpeta de su página.

> **Pregunta para el grupo:** ¿qué diferencia hubo entre esta aprobación y las de los Tramos 3 y 4, cuando el agente cambiaba el modelo?

## Tramo 6 · Informe: cambiar un visual (10 min)

1. Elijan **un** cambio para su gráfico y escríbanlo con su nombre. Por ejemplo:

   ```text
   /cambiar-visual <Nombre>, cambia el gráfico principal de columnas a barras
   ```

   Otras opciones: cambiar el título, poner la tarjeta debajo del gráfico o hacer el gráfico más ancho.

2. Revisen la tabla de cambios (propiedad, valor actual, valor nuevo) y escriban `APROBADO`. Elijan **Keep**.
3. Cierren Desktop **sin guardar**, ábranlo de nuevo, **Actualizar** y revisen su página.
4. **Configure Tools:** desmarquen `edit`. **OK**. La llave se devuelve al terminar.

✔ **Punto de control 6**

- Su página muestra el cambio y los números siguen iguales.
- `edit` está desmarcado otra vez.

## Tramo 7 · Git: su rama, su página y el pull request (20 min)

Con el trabajo terminado y validado, llega el momento de entregarlo al equipo.

1. En GitHub, en la página principal del repositorio, hagan clic en el selector de ramas (el botón **main**, arriba a la izquierda), escriban el nombre de su rama, por ejemplo `pagina-ana`, y hagan clic en **Create branch pagina-ana from main**.

   > **Resultado esperado:** El selector dice el nombre de su rama.

2. En el Explorador de archivos, abran `<carpeta del proyecto>\TiendasAndinas.Report\definition\pages` y ubiquen la carpeta de su página (el nombre que anotaron).
3. En GitHub, con **su rama** seleccionada, entren a `TiendasAndinas.Report` → `definition` → `pages`.
4. Clic en **Add file → Upload files**.
5. **Arrastren la carpeta de su página** desde el Explorador de archivos hasta la zona de carga de GitHub.

   > **Resultado esperado:** GitHub lista 3 archivos: `page.json` y dos `visual.json`, dentro de la carpeta de su página.
   >
   > Arrastren **solo** su carpeta. No suban `pages.json` ni archivos del modelo: las descripciones y el rol se quedan en su equipo (vean la pregunta del tramo).

6. Abajo, en **Commit changes**:
   - Mensaje: `Agrega Página de <Nombre> (encargo <número>)`.
   - Elijan **Commit directly to the pagina-[nombre] branch**.
   - Clic en **Commit changes**.
7. Arriba aparece un aviso amarillo con el botón **Compare & pull request**. Hagan clic. (Si no aparece: pestaña **Pull requests → New pull request**, *base:* `main`, *compare:* su rama.)
8. Título: `Página de <Nombre> · encargo <número>`. En la descripción ya viene la plantilla del equipo: complétenla y marquen las casillas que correspondan.
9. Clic en **Create pull request** y abran la pestaña **Files changed**.

   > **Resultado esperado:** Aparecen **3 archivos**, todos dentro de la carpeta de su página, en verde (agregados).

✔ **Punto de control 7**

- Su pull request está abierto, con la plantilla completa.
- **Files changed** muestra solo los 3 archivos de su página.

> **Pregunta para el grupo:** sus descripciones y su rol están en su equipo, pero no los subieron. Si veinte personas subieran cambios al modelo, ¿qué pasaría? ¿Quién debería subirlos y cómo?

## Tramo 8 · Revisión cruzada e integración (15 min)

1. En la pestaña **Pull requests** del repositorio, abran el pull request del compañero que les toca revisar.
2. En **Files changed**, revisen con la lista de la plantilla:
   - ¿Cambia solo una carpeta dentro de `pages`?
   - ¿El título del gráfico termina con el nombre de la persona?
   - En el `visual.json` del gráfico, ¿los campos (`Entity` y `Property`) son los de su encargo en `ENCARGOS.md`?
3. Dejen al menos un comentario: pasen el mouse sobre una línea, hagan clic en el **+** azul, escriban y elijan **Start a review**.
4. Clic en **Review changes** (o **Finish your review**) → elijan **Approve** si todo está bien, o **Comment** si algo hay que corregir → **Submit review**.
5. El instructor integra los pull requests aprobados en `main` (**Merge pull request**) y, como dueño del modelo, abre un pull request aparte con la documentación y el rol. Síganlo en la pantalla compartida.
6. Cuando el instructor lo indique, descarguen otra vez `main` (**Code → Download ZIP**), extráiganlo en `C:\CursoPBI\Equipo\final`, abran ese `TiendasAndinas.pbip` y **Actualizar**.

   > **Resultado esperado:** El informe tiene la página **Resumen** y una página por cada pull request integrado.

✔ **Punto de control 8**

- Revisaron un pull request y dejaron su revisión.
- El informe final del equipo abre con todas las páginas.

## Reto opcional

- Pídanle al agente un segundo rol, por ejemplo `/crear-rol Canal Online, solo las ventas del canal Online`, y pruébenlo con **Ver como**. ¿Qué tabla filtra esta vez?
- En la carpeta `final`, pídanle al agente (sin cambiar nada) que liste todas las páginas del informe, con su autor y los campos que usa cada visual.

## Solución de problemas

| Síntoma | Causa probable | Acción |
|---|---|---|
| GitHub dice que el repositorio no existe | No han aceptado la invitación a la organización Cursos-CM | Abrir `https://github.com/orgs/Cursos-CM/invitation` con su cuenta y aceptar, o avisar al instructor |
| Al actualizar sale «referencia cíclica» en Presupuesto | Error ocasional del primer refresco | **Cerrar** y **Actualizar** otra vez |
| Al escribir `/` no aparecen los prompts del equipo | El chat está en **Copilot**, o VS Code no abrió la carpeta del proyecto | Cambiar a **Local**; **File → Open Folder** sobre la carpeta del proyecto |
| El agente no pide aprobación para escribir en el modelo | **powerbi-authoring-local** está desmarcado, o se eligió *Allow in this Session* antes | Revisar Configure Tools; usar **Allow Once** |
| Con *Ver como* se ven todos los datos | El rol se creó sin filtro de tabla | `/crear-rol Región Caribe, agrega el filtro [Region] = "Caribe" sobre tbl_Tienda` |
| Las descripciones o el rol desaparecieron después de reabrir Desktop | No guardaron con **Ctrl+S** al final del Tramo 4 | Repetir el Tramo 3 o 4 y guardar |
| El agente pide ejecutar código, abrir un navegador o usar una terminal | Intenta validar por su cuenta | **Skip**; dejar `execute` y `browser` desmarcados |
| La página no aparece en Desktop | Desktop seguía abierto, o se guardó después del cambio | Cerrar Desktop **sin guardar** y abrir de nuevo. Si se guardó, pedir otra vez `/crear-pagina` |
| El visual sale en blanco o con una X | Un campo con otro nombre en el `visual.json` | `/cambiar-visual <Nombre>, revisa que los campos del gráfico existan en el modelo y corrígelos` |
| No se puede arrastrar la carpeta a GitHub | El navegador no acepta carpetas | Abrir la carpeta, seleccionar `page.json` y arrastrarlo; luego **Add file → Create new file** para cada `visual.json`, escribiendo la ruta `visuals/<carpeta del visual>/visual.json` y pegando el contenido |
| GitHub no deja hacer commit en `main` | La rama `main` está protegida | Es lo esperado: cambiar a su rama y subir ahí |
| **Files changed** muestra más de 3 archivos | Se subió algo más que la carpeta de la página | En **Files changed**, menú **…** del archivo de más → **Delete file**, o pedir ayuda al instructor |
| El chat deja de responder por límite de uso | Se acabó la cuota de Copilot Free | Seguir en pareja con un compañero; la revisión cruzada no usa Copilot |

## Resumen y entregables

- En su equipo: las 18 medidas documentadas y el rol **Región Caribe** probado con *Ver como*.
- Una rama `pagina-<nombre>` con la carpeta de su página.
- Un pull request con la plantilla completa y validado.
- Una revisión hecha al pull request de un compañero.
- El informe del equipo en `main`, con su página.

# Laboratorio final: El informe del equipo

| Dato | Detalle |
|---|---|
| Duración | 2 horas, por tramos guiados |
| Modalidad | En equipo: todo el grupo trabaja sobre el mismo repositorio |
| Punto de partida | El repositorio de su grupo en GitHub: `Cursos-CM/tiendas-andinas-grupo1` o `Cursos-CM/tiendas-andinas-grupo2`. No hace falta haber terminado ningún laboratorio anterior |
| Resultado esperado | El modelo documentado y con un rol de seguridad en su computador, y una página suya en el informe del equipo, creada con el agente, validada, entregada por pull request, revisada por un compañero e integrada en `main` |

## Objetivos

- Seguir el orden de un proyecto real: primero el **modelo**, después el **informe** y al final **Git**.
- Documentar todas las medidas del modelo en una sola operación masiva (Tema 8).
- Crear y probar un rol de seguridad por filas (RLS) con el agente (Tema 8).
- Pedirle al agente que cree y cambie visuales del informe, con un plan que ustedes aprueban escribiendo APROBADO (Tema 8).
- Validar contra valores esperados antes de entregar (repaso del Tema 6).
- Entregar con rama y pull request, y revisar el de un compañero (Tema 7).

## Escenario

La gerencia de Tiendas Andinas pidió doce análisis. El equipo trabaja como en un proyecto real: primero deja el modelo listo para usar (documentado y con seguridad por región), después cada integrante construye la página de su **encargo** y, al final, la entrega con un pull request. Al terminar, `main` tiene el informe completo del equipo.

> **Cómo leer esta guía:** cada recuadro gris con texto en español es un **mensaje para el chat de Copilot**: cópienlo, péguenlo en el cuadro del chat y presionen **Enter**. Reemplacen lo que está entre `< >` por sus datos, **sin** los signos `< >`: por ejemplo, `/consultar-encargo <número>` se escribe `/consultar-encargo 4`. En este laboratorio **no se usa PowerShell ni la terminal**.
>
> **Por tramos:** el instructor marca el inicio y el final de cada tramo. Al final de cada uno hay un **Punto de control**: no sigan al siguiente hasta que el instructor lo indique. Si algo no sale, levanten la mano o escriban en el chat de la reunión **✋ y el número del paso**.
>
> **Copilot Free:** el laboratorio usa entre 9 y 12 mensajes. Envíen un mensaje a la vez. Cada corrección que pidan al agente gasta un mensaje más.
>
> **Si terminan un tramo antes que el grupo:** ayuden a un compañero o hagan el **Reto opcional** del final, sin adelantarse al siguiente tramo.
>
> **Aprobaciones:** cuando el agente quiere usar el modelo, en el chat aparece una tarjeta con un botón azul y una flecha **⌄** al lado. Las lecturas se marcan con **✓** y las escrituras con **⚠**. Elijan siempre **Allow Once**: clic en la **flecha ⌄** que está junto al botón azul *Allow in this Session* → **Allow Once**. Es normal que aparezcan varias tarjetas seguidas.

## Datos de su trabajo

Antes de empezar, anoten estos datos. Los van a usar en todo el laboratorio.

| Dato | Ejemplo | Suyo |
|---|---|---|
| Grupo y repositorio | `tiendas-andinas-grupo1` | |
| Su nombre (como aparecerá en la página) | `Ana` | |
| Su rama | `pagina-ana` (minúsculas, sin tildes ni espacios) | |
| Número de encargo | Su número en la lista de asistencia; del 13 en adelante, vuelvan a empezar (13 → 1, 14 → 2…) | |
| Compañero que va a revisar | El siguiente en la lista (el último revisa al primero) | |

## Tramo 1 · Arranque: el proyecto del equipo en su computador (15 min)

1. Si Power BI Desktop o VS Code están abiertos, ciérrenlos. Si Desktop pregunta si desean guardar, elijan **No guardar**.
2. En el navegador, entren a **github.com**. Arriba a la derecha debe verse su foto o su usuario; si dice **Sign in**, inicien sesión con su cuenta (la misma que usan para Copilot). Después abran `https://github.com/Cursos-CM/tiendas-andinas-grupo<N>`, con el número de su grupo.

   > **Resultado esperado:** Ven el repositorio con las carpetas `.github`, `TiendasAndinas.Report`, `TiendasAndinas.SemanticModel` y los archivos `ENCARGOS.md` y `README.md`. Si GitHub dice que la página no existe (*404*), avisen al instructor: falta aceptar la invitación a la organización.

3. En la lista de archivos, hagan clic en `ENCARGOS.md` y busquen la fila de su número de encargo. Anoten qué gráfico y qué tarjeta les toca. Después vuelvan a la página principal haciendo clic en el nombre del repositorio, arriba a la izquierda.
4. Botón verde **Code** → **Download ZIP**. El navegador guarda el archivo `tiendas-andinas-grupo<N>-main.zip` en la carpeta **Descargas**.
5. Abran el Explorador de archivos (tecla **Windows + E**) → **Descargas**. Clic derecho sobre el ZIP → **Extraer todo…** (*Extract All…*) → en el cuadro de destino borren lo que aparece y escriban `C:\CursoPBI\Equipo` → **Extraer** (*Extract*).

   > **Resultado esperado:** Existe la carpeta `C:\CursoPBI\Equipo\tiendas-andinas-grupo<N>-main` con `TiendasAndinas.pbip` adentro. En esta guía la llamamos **la carpeta del proyecto**.

6. Hagan doble clic en `TiendasAndinas.pbip` de la carpeta del proyecto. Al abrir, la página aparece con tarjetas **(En blanco)** y franjas amarillas o rojas arriba («objetos calculados deben actualizarse», «tablas con datos incompletos»): es normal, el proyecto llega sin datos. Vayan a **Inicio → Actualizar** y esperen a que termine.

   > **Resultado esperado:** Las franjas desaparecen y la página **Resumen** muestra datos: Total Ventas **$11 mil M**.
   >
   > Si aparece un error de «referencia cíclica» en Presupuesto, elijan **Cerrar** y vuelvan a **Actualizar**: la segunda vez funciona. Si aparece una franja de **Autorrecuperación**, ciérrenla con la **X**.

7. Abran **Visual Studio Code** → **File → Open Folder…** → la carpeta del proyecto → **Seleccionar carpeta**. Si pregunta si confían en los autores, elijan **Yes, I trust the authors**. Si se abre una pestaña de **Release Notes** o **Welcome**, pueden cerrarla. Si abajo a la derecha aparece el aviso *«5 workspace customizations need an update»* (o un panel **Keep your customizations working** con un botón **Migrate**), **no migren**: cierren el aviso con la **X**. Los prompts del equipo funcionan tal como están en el chat **Local**.

   > **Resultado esperado:** A la izquierda, en el Explorador de VS Code, se ven `.github`, `TiendasAndinas.Report`, `TiendasAndinas.SemanticModel`, `ENCARGOS.md`, `README.md` y `TiendasAndinas.pbip`.

8. En el chat de la derecha, abran una conversación nueva con el **+** (arriba del chat). Debajo del cuadro donde se escribe, a la izquierda, hay un selector que dice **Local**, **Copilot** o **Cloud**: debe decir **Local**. Si dice otra cosa, hagan clic sobre esa palabra y elijan **Local**.
9. **Configure Tools** (icono pequeño de controles, a la derecha de **Auto**, en la parte de abajo del cuadro del chat; si no lo ven: **Ctrl+Shift+P** → escriban `Configure Tools` → Enter):
   - **Marcados:** `read`, `search` y **powerbi-authoring-local**.
   - **Desmarcados:** `edit`, `execute` y `browser`.
   - Lo demás (`agent`, `todo`, `vscode`, `web` u otros) déjenlo como está.
   - Clic en **OK**.
10. En el cuadro del chat escriban `/` seguido de las primeras letras (por ejemplo `/con`, `/doc`, `/cre`) y comprueben que aparecen los cinco prompts del equipo: **/consultar-encargo**, **/documentar-medidas**, **/crear-rol**, **/crear-pagina** y **/cambiar-visual**. Después borren lo que escribieron.

✔ **Punto de control 1**

- Desktop muestra datos desde la carpeta del proyecto.
- VS Code tiene abierta la carpeta del proyecto, el chat dice **Local** y los prompts del equipo aparecen con `/`.

> **Pregunta para el grupo:** ¿de dónde salieron esos cinco prompts, si ustedes no los crearon?

## Tramo 2 · Conocer su encargo, sin cambiar nada (10 min)

1. En el chat de VS Code escriban, con su número de encargo:

   ```text
   /consultar-encargo <número>
   ```

2. Si aparece una tarjeta de aprobación, léanla: debe ser de **powerbi-authoring-local** y de lectura (**✓**). Elijan **Allow Once**. Pueden ser varias seguidas.

   > **Resultado esperado:** Dos consultas DAX con `SUMMARIZECOLUMNS`, una tabla de resultados ordenada de mayor a menor y una línea final que dice si coinciden con `ENCARGOS.md`.

   Si el agente muestra la consulta y pregunta si la ejecuta, respondan:

   ```text
   Sí, ejecútala.
   ```

   Si el agente dice que no encuentra Power BI Desktop, escriban:

   ```text
   Lee el número del archivo msmdsrv.port.txt que está en %LOCALAPPDATA%\Microsoft\Power BI Desktop\AnalysisServicesWorkspaces (subcarpeta Data) y conéctate a localhost con ese puerto.
   ```

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

2. Aprueben las lecturas (**✓**) con **Allow Once**. En las pruebas fueron 3 o 4 tarjetas seguidas (conexión, base de datos, medidas): lean cada una.
3. Esperen el plan y léanlo **antes** de aprobar: una tabla con las **18 medidas**, su carpeta y una descripción en lenguaje de negocio. Elijan dos descripciones y pregúntense si un gerente las entendería.
4. Escriban:

   ```text
   APROBADO
   ```

5. Aparece una aprobación de escritura (**⚠**, *Updates measures…*). Es **una sola** escritura para las 18 medidas: eso es una operación masiva. Elijan **Allow Once**.

   > **Resultado esperado:** «Se actualizaron las descripciones de las 18 medidas… en una sola operación».

6. En Desktop, en el panel **Datos** de la derecha: clic en la flecha **>** de `FACT_Ventas` → clic en la flecha **>** de la carpeta **Ventas** → dejen el mouse quieto unos segundos sobre **Total Ventas**.

   > **Resultado esperado:** Aparece un recuadro con **Nombre** y **Descripción**: la descripción es la que propuso el agente. Si no aparece, cambien de página y vuelvan, o vayan a **Inicio → Actualizar**.

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

2. Aprueben las lecturas (**✓**) con **Allow Once** (pueden ser varias). Lean el plan: rol **Región Caribe**, permiso de lectura, tabla `tbl_Tienda` y filtro `[Region] = "Caribe"`.
3. Escriban `APROBADO` y aprueben las escrituras (**⚠**, *Creates a security role…* y *Creates permissions…*) con **Allow Once**. Son dos: primero el rol y después el filtro.

   > **Resultado esperado:** El agente termina con una tabla de comprobación donde aparece el permiso de `tbl_Tienda` con el filtro `[Region] = "Caribe"`. Si el agente dice que el permiso **no** aparece, avisen al instructor antes de seguir.

4. **Probar el rol en Desktop:** pestaña **Modelado** (arriba) → botón **Ver como** (grupo *Seguridad*). En la ventana *Ver como roles* marquen la casilla **Región Caribe** → **Aceptar**.

   > **Resultado esperado:** Arriba aparece *Se muestra como Región Caribe*. Total Ventas **$2 mil M**, Margen % **33,1 %**, Cumplimiento **98,4 %**, y la tabla *Ventas por región* muestra solo **Caribe: $1.866.538.345**.
   >
   > Si sigue mostrando $11 mil M, el rol quedó sin filtro: vean **Solución de problemas**. Si aparece una ventana *ProviderMessage* que dice que el usuario «no tiene acceso a la base de datos», elijan **Cerrar**: sale cuando el agente consulta el modelo mientras *Ver como* está activo.

5. Clic en **Detener la visualización**, a la derecha de la franja *Se muestra como Región Caribe*. El informe vuelve a mostrar todo ($11 mil M).
6. Con la ventana de **Power BI Desktop** al frente, **guarden con Ctrl+S** (o el ícono de disquete, arriba a la izquierda). Así el modelo queda guardado en los archivos antes de pasar al informe. No aparece ninguna ventana: se guarda directamente.

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
   - un `page.json` con el nombre **Página de** y su nombre;
   - dos `visual.json`: el gráfico de su encargo, con los campos de `ENCARGOS.md`, y la tarjeta;
   - que **no** cambia `pages.json` ni el modelo.

   Si algo no coincide, pidan la corrección antes de aprobar.

4. Escriban:

   ```text
   APROBADO
   ```

5. Si el agente pide ejecutar código o abrir un navegador para «validar» (por ejemplo *Run Playwright Code*), elijan **Skip**: la validación la hacemos en Desktop.

   > **Resultado esperado:** El agente termina con el **nombre de la carpeta** de su página (20 caracteres: letras de la a a la f y números) y recuerda cerrar Desktop sin guardar. Debajo aparece **3 files changed** con **Keep** y **Undo**.

6. Anoten el nombre de la carpeta en su tabla de datos y elijan **Keep**.
7. En Desktop: ciérrenlo con la **X** de arriba a la derecha y, si pregunta si desean guardar, elijan **No guardar**. Ábranlo de nuevo con `TiendasAndinas.pbip` y vayan a **Inicio → Actualizar**.

   > **Importante:** si guardan en Desktop ahora, Desktop sobrescribe los archivos del informe con lo que tenía en memoria y se pierde la página que creó el agente. El modelo no se pierde: lo guardaron en el Tramo 4.

8. Abajo, en las pestañas de páginas, abran la pestaña **Página de** y su nombre. Pasen el mouse sobre dos barras o puntos del gráfico y comparen con `ENCARGOS.md`.

   > **Resultado esperado:** Un gráfico con el título de su encargo y su nombre entre paréntesis, y una tarjeta. Los valores coinciden con los del Tramo 2. Las descripciones y el rol **Región Caribe** siguen ahí.

✔ **Punto de control 5**

- Su página abre en Desktop sin errores y sus números coinciden.
- Anotaron el nombre de la carpeta de su página.

> **Pregunta para el grupo:** ¿qué diferencia hubo entre esta aprobación y las de los Tramos 3 y 4, cuando el agente cambiaba el modelo?

## Tramo 6 · Informe: cambiar un visual (10 min)

1. Elijan **un** cambio para su gráfico y escríbanlo con su nombre. Si su gráfico es de **columnas**:

   ```text
   /cambiar-visual <Nombre>, cambia el gráfico principal de columnas a barras
   ```

   Si es de **barras** o de **líneas**:

   ```text
   /cambiar-visual <Nombre>, cambia el gráfico principal a columnas
   ```

   Otras opciones: cambiar el título del gráfico o hacerlo más ancho.

2. Revisen la tabla de cambios (propiedad, valor actual, valor nuevo) y escriban `APROBADO`. Si el agente pide ejecutar código o abrir un navegador, elijan **Skip**. Cuando aparezca **1 file changed**, elijan **Keep**.
3. Cierren Desktop con la **X** → **No guardar** → doble clic en `TiendasAndinas.pbip` → **Inicio → Actualizar** (si sale «referencia cíclica», **Cerrar** y **Actualizar** otra vez). Revisen su página.
4. **Configure Tools:** desmarquen `edit`. **OK**. La llave se devuelve al terminar.

✔ **Punto de control 6**

- Su página muestra el cambio y los números siguen iguales.
- `edit` está desmarcado otra vez.

## Tramo 7 · Git: su rama, su página y el pull request (20 min)

Con el trabajo terminado y validado, llega el momento de entregarlo al equipo.

1. En GitHub, vayan a la página principal del repositorio (clic en el nombre del repositorio, arriba a la izquierda) y hagan clic en el selector de ramas: el botón que dice **main**, arriba a la izquierda de la lista de archivos. En el cuadro de búsqueda que se abre, escriban el nombre de su rama, por ejemplo `pagina-ana`, y hagan clic en **Create branch pagina-ana from main** (aparece debajo del cuadro).

   > **Resultado esperado:** El selector dice el nombre de su rama.

2. En el Explorador de archivos de Windows, abran la carpeta del proyecto → `TiendasAndinas.Report` → `definition` → `pages`, y ubiquen la carpeta de su página: la del nombre que anotaron. **No** es `57ecea57327b43cc957e`: esa es la página Resumen. Dejen esta ventana abierta, al lado del navegador.
3. En GitHub, comprueben que el selector de ramas dice **su rama** y hagan clic en las carpetas `TiendasAndinas.Report` → `definition` → `pages`.
4. Clic en **Add file → Upload files**.
5. **Arrastren la carpeta de su página** desde el Explorador de archivos hasta la zona de carga de GitHub.

   > **Resultado esperado:** GitHub lista 3 archivos: `page.json` y dos `visual.json`, dentro de la carpeta de su página.
   >
   > Arrastren **solo** su carpeta. No suban `pages.json` ni archivos del modelo: las descripciones y el rol se quedan en su computador (lo discutimos en la pregunta del final de este tramo).

6. Bajen hasta el recuadro **Commit changes**:
   - Mensaje: `Agrega Página de <Nombre> (encargo <número>)`.
   - Elijan **Commit directly to the …** con el nombre de su rama (por ejemplo, *Commit directly to the pagina-ana branch*).
   - Clic en **Commit changes**.
7. Vuelvan a la página principal del repositorio (clic en el nombre del repositorio, arriba). Aparece un aviso amarillo *«pagina-ana had recent pushes»* con el botón verde **Compare & pull request**: hagan clic. (Si no aparece: pestaña **Pull requests** → **New pull request** → en *base* dejen `main` y en *compare* elijan su rama → **Create pull request**.)
8. Título: `Página de <Nombre> · encargo <número>`. En la descripción ya viene la plantilla del equipo: escriban su nombre y su encargo, y en *Carpeta de la página* reemplacen `...` por el nombre de su carpeta. Marquen solo las casillas de **Cómo la validé**, cambiando `[ ]` por `[x]`; las de **Para quien revisa** las marca su compañero.
9. Clic en **Create pull request**. Si aparece la ventana *«Try the new pull requests Overview page!»*, elijan **Not now**. Después abran la pestaña **Files changed**.

   > **Resultado esperado:** Aparecen **3 archivos**, todos dentro de la carpeta de su página, en verde (agregados).

✔ **Punto de control 7**

- Su pull request está abierto, con la plantilla completa.
- **Files changed** muestra solo los 3 archivos de su página.

> **Pregunta para el grupo:** sus descripciones y su rol están en su computador, pero no los subieron. Si veinte personas subieran cambios al modelo, ¿qué pasaría? ¿Quién debería subirlos y cómo?

## Tramo 8 · Revisión cruzada e integración (15 min)

1. En la pestaña **Pull requests** del repositorio, abran el pull request del compañero que les toca revisar: búsquenlo por el título *Página de* y el nombre de su compañero. Si todavía no lo ha abierto, revisen el de otra persona que no tenga revisión.
2. En **Files changed**, revisen con la lista de la plantilla:
   - ¿Cambia solo una carpeta dentro de `pages`?
   - ¿Los títulos de los visuales terminan con el nombre de la persona?
   - En el `visual.json` del gráfico, ¿los campos (`Entity` y `Property`) son los de su encargo en `ENCARGOS.md`?
3. Dejen al menos un comentario: pasen el mouse sobre una línea, hagan clic en el **+** azul, escriban y elijan **Start a review**.
4. Clic en **Review changes** (o **Finish your review**) → elijan **Approve** si todo está bien, o **Comment** si algo hay que corregir → **Submit review**.
5. El instructor integra los pull requests aprobados en `main` (**Merge pull request**) y, como dueño del modelo, abre un pull request aparte con la documentación y el rol. Síganlo en la pantalla compartida.
6. Cuando el instructor lo indique: cierren Desktop (**No guardar**). En GitHub, vayan a la página principal del repositorio y **cambien el selector de ramas a `main`** (si queda en su rama, descargarían solo su página). Después **Code → Download ZIP**. El archivo nuevo puede llamarse `tiendas-andinas-grupo<N>-main (1).zip`: usen ese. Extráiganlo en `C:\CursoPBI\Equipo\final`. Abran `C:\CursoPBI\Equipo\final\tiendas-andinas-grupo<N>-main\TiendasAndinas.pbip` y vayan a **Inicio → Actualizar**.

   > **Resultado esperado:** El informe tiene la página **Resumen** y una página por cada pull request integrado.

✔ **Punto de control 8**

- Revisaron un pull request y dejaron su revisión.
- El informe final del equipo abre con todas las páginas.

## Reto opcional

- **Un segundo rol.** En la carpeta del proyecto (no en `final`) escriban:

  ```text
  /crear-rol Categoría Moda, solo los productos de la categoría Moda
  ```

  Pruébenlo con **Ver como**. Esta vez el filtro va sobre la tabla `Categoria`, y por las relaciones llega a los productos y a las ventas: el gráfico *Ventas por categoría* debe mostrar solo **Moda**. (Este reto no se probó en clase: si el agente propone otra tabla, revisen el plan antes de aprobar.)
- **El informe del equipo, explicado.** En VS Code: **File → Open Folder…** → `C:\CursoPBI\Equipo\final\tiendas-andinas-grupo<N>-main` → **Seleccionar carpeta** → **Yes, I trust the authors**. Abran un chat nuevo en **Local** y escriban:

  ```text
  Sin cambiar nada, lista en una tabla todas las páginas del informe de esta carpeta, con su autor y los campos que usa cada visual.
  ```

## Solución de problemas

| Síntoma | Causa probable | Acción |
|---|---|---|
| GitHub dice que el repositorio no existe | No han aceptado la invitación a la organización Cursos-CM | Abrir `https://github.com/orgs/Cursos-CM/invitation` con su cuenta y aceptar, o avisar al instructor |
| Al actualizar sale «referencia cíclica» en Presupuesto | Error ocasional del primer refresco | **Cerrar** y **Actualizar** otra vez |
| Al escribir `/` no aparecen los prompts del equipo | El chat está en **Copilot**, o VS Code no abrió la carpeta del proyecto | Cambiar a **Local**; **File → Open Folder** sobre la carpeta del proyecto. Si siguen sin aparecer: **Ctrl+Shift+P** → `Reload Window` |
| El agente escribe en el modelo sin pedir aprobación | Antes se eligió *Allow in this Session* | Desde ahora, **Allow Once**; abrir un chat nuevo reinicia los permisos |
| El agente dice que no tiene herramientas del modelo | **powerbi-authoring-local** está desmarcado | Configure Tools: marcar **powerbi-authoring-local** → **OK** |
| Con *Ver como* se ven todos los datos ($11 mil M) | El rol se creó sin el permiso de tabla (pasó en una de las pruebas) | **Detener la visualización**. Abrir un chat nuevo en **Local** y escribir: `/crear-rol Región Caribe. El rol ya existe: crea solo el permiso de tabla con CreatePermissions sobre tbl_Tienda con el filtro [Region] = "Caribe" y compruébalo con ListPermissions`. Después, **Ver como** otra vez |
| Aparece la ventana *ProviderMessage* «no tiene acceso a la base de datos» | El agente consultó el modelo mientras *Ver como* estaba activo | **Cerrar** y **Detener la visualización** |
| Aviso *«workspace customizations need an update»* o botón **Migrate** | VS Code 1.146 propone convertir los prompts al modo Copilot | No migrar: cerrar el aviso. En **Local** los prompts funcionan igual |
| Las descripciones o el rol desaparecieron después de reabrir Desktop | No guardaron con **Ctrl+S** al final del Tramo 4 | Repetir el Tramo 3 o 4 y guardar |
| El agente pide ejecutar código, abrir un navegador o usar una terminal | Intenta validar por su cuenta | **Skip**; dejar `execute` y `browser` desmarcados |
| La página no aparece en Desktop | Desktop seguía abierto, o se guardó después del cambio | Cerrar Desktop **sin guardar** y abrir de nuevo. Si se guardó: Configure Tools → marcar `edit`, pedir otra vez `/crear-pagina` y, al terminar, desmarcar `edit` |
| El visual sale en blanco o con una X | Un campo con otro nombre en el `visual.json` | Configure Tools → marcar `edit`. Escribir `/cambiar-visual <Nombre>, revisa que los campos del gráfico existan en el modelo y corrígelos` → **Keep** → cerrar Desktop sin guardar y abrirlo otra vez. Si ya habían subido la página, vuelvan a subir la carpeta a su rama. Al terminar, desmarcar `edit` |
| No se puede arrastrar la carpeta a GitHub | El navegador no acepta carpetas | Crear los 3 archivos a mano, dentro de `pages` y en su rama: **Add file → Create new file**. En el nombre escriban la ruta completa, por ejemplo `<carpeta de su página>/page.json` (al escribir `/` GitHub crea la carpeta); abran ese archivo en VS Code, copien todo (**Ctrl+A**, **Ctrl+C**) y péguenlo en GitHub → **Commit changes**. Repitan con `<carpeta de su página>/visuals/<carpeta del visual>/visual.json` para cada visual |
| GitHub no deja hacer commit en `main` | La rama `main` está protegida | Es lo esperado: cambiar a su rama y subir ahí |
| **Files changed** muestra más de 3 archivos | Se subió algo más que la carpeta de la página | En **Files changed**, menú **…** del archivo de más → **Delete file**, o pedir ayuda al instructor |
| Sale *«Tool 'tool_search' is not supported with gpt-5»* | En modo Auto, Copilot eligió un modelo que no acepta tantas herramientas | Reenviar el mensaje; si se repite, clic en **Auto** y elegir otro modelo de la lista |
| No aparece el icono de Configure Tools | El panel del chat es angosto | Ensanchar el panel, o **Ctrl+Shift+P** → `Configure Tools` |
| El agente se quedó «esperando» | Hay una tarjeta de aprobación más arriba en el chat | Desplazarse hacia arriba en el chat y responderla |
| El agente responde una parte en inglés | Elige el idioma por su cuenta | Es normal; el contenido sirve igual |
| El chat deja de responder por límite de uso | Se acabó la cuota de Copilot Free | Seguir en pareja con un compañero; la revisión cruzada no usa Copilot |

## Resumen y entregables

- En su computador: las 18 medidas documentadas y el rol **Región Caribe** probado con *Ver como*.
- Una rama `pagina-<nombre>` con la carpeta de su página.
- Un pull request con la plantilla completa y validado.
- Una revisión hecha al pull request de un compañero.
- El informe del equipo en `main`, con su página.

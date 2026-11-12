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

> **Por tramos:** el instructor marca el inicio y el final de cada tramo. Al final de cada uno hay un **Punto de control**: no sigan al siguiente hasta que el instructor lo indique. Si algo no sale, levanten la mano o escriban en el chat de la reunión **✋ y el número del paso**.
>
> **Copilot Free:** el laboratorio usa entre 9 y 12 mensajes. Envíen un mensaje a la vez. Cada corrección que pidan al agente gasta un mensaje más.
>
> **Si terminan un tramo antes que el grupo:** ayuden a un compañero o hagan el **Reto opcional** del final, sin adelantarse al siguiente tramo.
>
> En este laboratorio **no se usa PowerShell ni la terminal**.

## Datos de su trabajo

Antes de empezar, anoten estos datos. Los van a usar en todo el laboratorio.

| Dato | Ejemplo | Suyo |
|---|---|---|
| Grupo y repositorio | `tiendas-andinas-grupo1` | |
| Su nombre (como aparecerá en la página) | `Ana` | |
| Su rama | `pagina-ana` (minúsculas, sin tildes ni espacios) | |
| Número de encargo | Su número en la lista de asistencia; del 13 en adelante, vuelvan a empezar (13 → 1, 14 → 2…) | |
| Compañero que va a revisar | El siguiente en la lista (el último revisa al primero) | |

## Las cinco acciones que se repiten

Estas acciones aparecen varias veces. Cada paso de la guía las vuelve a explicar, pero aquí están juntas para consultarlas cuando quieran.

**A. Enviar un mensaje al agente.**
1. En Visual Studio Code, el chat está en el panel de la **derecha**. Si no lo ven, presionen **Ctrl+Alt+I**.
2. Abajo del panel hay un cuadro donde se escribe (dice *Describe what to build* o *Chat with Copilot*). Hagan clic dentro de ese cuadro.
3. Escriban el mensaje del recuadro gris de la guía, o cópienlo de la guía (selecciónenlo y **Ctrl+C**) y péguenlo en el cuadro (**Ctrl+V**).
4. Si el mensaje tiene partes entre `< >`, cámbienlas por sus datos y borren los signos `< >`. Por ejemplo, `/consultar-encargo <número>` se escribe `/consultar-encargo 4`.
5. Presionen **Enter**.

Los mensajes que empiezan con `/` usan un **prompt del equipo**. Al escribir `/` y las primeras letras, aparece una lista: pueden hacer clic en el prompt o seguir escribiendo el texto completo.

**B. Aprobar lo que el agente quiere hacer (Allow Once).**
1. Cuando el agente quiere leer o cambiar el modelo, en el chat aparece una **tarjeta** con un botón azul **Allow in this Session**, una flecha **⌄** al lado y un botón **Skip**.
2. Lean la tarjeta: las lecturas se marcan con **✓** y las escrituras con **⚠**.
3. Hagan clic en la **flecha ⌄** (no en el botón azul).
4. En el menú que se abre, hagan clic en **Allow Once**.
5. Pueden aparecer varias tarjetas seguidas: repitan con cada una. Si el agente parece detenido, desplácense hacia arriba en el chat: puede haber una tarjeta esperando.

**C. Marcar o desmarcar herramientas (Configure Tools).**
1. Abajo del cuadro del chat hay una fila con **+**, el nombre del modelo (**Auto**) y, a la derecha, un **icono pequeño de controles**. Hagan clic en ese icono. Si no lo ven: presionen **Ctrl+Shift+P**, escriban `Configure Tools` y presionen **Enter**.
2. Arriba en la pantalla se abre una lista. Cada línea tiene una casilla a la izquierda: con **✓** está marcada. Un clic en la casilla la marca o la desmarca.
3. Al terminar, hagan clic en el botón azul **OK**, arriba a la derecha de la lista.

**D. Aceptar los archivos que creó el agente (Keep).**
Cuando el agente crea o cambia archivos, debajo del cuadro del chat aparece una barra que dice **N files changed** con dos botones: **Keep** (conservar) y **Undo** (deshacer). Para conservar, clic en **Keep**.

**E. Cerrar Power BI Desktop sin guardar y volver a abrirlo.**
1. En Power BI Desktop, clic en la **X** de arriba a la derecha.
2. Si pregunta si desean guardar los cambios, clic en **No guardar**.
3. En el Explorador de archivos, entren a la carpeta del proyecto y hagan doble clic en `TiendasAndinas.pbip`.
4. Cuando abra, pestaña **Inicio** (arriba) → botón **Actualizar** (grupo *Consultas*). Esperen a que termine. Si sale un error de «referencia cíclica», clic en **Cerrar** y otra vez **Actualizar**.

## Tramo 1 · Arranque: el proyecto del equipo en su computador (15 min)

1. Si Power BI Desktop o Visual Studio Code están abiertos, ciérrenlos con la **X** de arriba a la derecha. Si Desktop pregunta si desean guardar, elijan **No guardar**.
2. Abran el navegador (Edge o Chrome) y escriban en la barra de direcciones `github.com`, luego **Enter**.
   - Arriba a la derecha debe verse su foto o la inicial de su usuario: ya iniciaron sesión.
   - Si arriba a la derecha dice **Sign in**, hagan clic ahí e inicien sesión con su cuenta de GitHub (la misma que usan para Copilot).
3. En la barra de direcciones escriban la dirección de su grupo y presionen **Enter**:
   - Grupo 1: `https://github.com/Cursos-CM/tiendas-andinas-grupo1`
   - Grupo 2: `https://github.com/Cursos-CM/tiendas-andinas-grupo2`

   > **Resultado esperado:** Ven una lista de archivos con las carpetas `.github`, `TiendasAndinas.Report`, `TiendasAndinas.SemanticModel` y los archivos `ENCARGOS.md` y `README.md`. Si GitHub muestra una página que dice *404* o *This is not the web page you are looking for*, avisen al instructor: falta aceptar la invitación a la organización.

4. En esa lista, hagan clic en `ENCARGOS.md`. Busquen la fila con su número de encargo y anoten en su tabla de datos qué gráfico y qué tarjeta les toca.
5. Vuelvan a la página principal: arriba a la izquierda, hagan clic en el nombre del repositorio (`tiendas-andinas-grupo1` o `tiendas-andinas-grupo2`).
6. Hagan clic en el botón verde **Code** (arriba a la derecha de la lista de archivos). En el menú que se abre, hagan clic en **Download ZIP** (abajo del menú).

   > **Resultado esperado:** El navegador descarga el archivo `tiendas-andinas-grupo<N>-main.zip` en la carpeta **Descargas**.

7. Abran el Explorador de archivos de Windows: presionen la tecla **Windows** y la letra **E** al mismo tiempo. A la izquierda, hagan clic en **Descargas** (*Downloads*).
8. Hagan **clic derecho** sobre el archivo `tiendas-andinas-grupo<N>-main.zip` → **Extraer todo…** (*Extract All…*).
9. En la ventana que se abre hay un cuadro con una ruta. Hagan clic en ese cuadro, borren todo lo que tiene (**Ctrl+A** y luego **Supr**) y escriban `C:\CursoPBI\Equipo`. Clic en **Extraer** (*Extract*).

   > **Resultado esperado:** Se abre la carpeta `C:\CursoPBI\Equipo` y adentro está la carpeta `tiendas-andinas-grupo<N>-main`, con el archivo `TiendasAndinas.pbip`. En esta guía la llamamos **la carpeta del proyecto**.

10. Entren a la carpeta del proyecto (doble clic sobre `tiendas-andinas-grupo<N>-main`) y hagan doble clic en `TiendasAndinas.pbip`. Se abre Power BI Desktop (puede tardar un minuto).
11. Al abrir, la página aparece con tarjetas **(En blanco)** y franjas amarillas o rojas arriba («objetos calculados deben actualizarse», «tablas con datos incompletos»). Es normal: el proyecto llega sin datos. Hagan clic en la pestaña **Inicio** (arriba) → botón **Actualizar** (grupo *Consultas*) y esperen a que termine.

    > **Resultado esperado:** Las franjas desaparecen y la página **Resumen** muestra datos: Total Ventas **$11 mil M**.
    >
    > Si aparece un error de «referencia cíclica» en Presupuesto, clic en **Cerrar** y otra vez **Actualizar**: la segunda vez funciona. Si aparece una franja de **Autorrecuperación**, ciérrenla con la **X** de la derecha de la franja.

12. Abran **Visual Studio Code** (búsquenlo en el menú Inicio de Windows). Arriba a la izquierda, menú **File** → **Open Folder…**.
13. En la ventana que se abre, vayan a `C:\CursoPBI\Equipo`, hagan **un** clic sobre la carpeta `tiendas-andinas-grupo<N>-main` y luego clic en el botón **Seleccionar carpeta** (*Select Folder*).
14. Si VS Code pregunta si confían en los autores de los archivos, clic en **Yes, I trust the authors**.
15. Pueden aparecer avisos; así se responden:
    - Una pestaña **Release Notes**, **Welcome** o **Walkthrough**: ciérrenla con la **X** de la pestaña.
    - Abajo a la derecha, el aviso *«5 workspace customizations need an update»*, o un panel **Keep your customizations working** con el botón **Migrate**: **no** hagan clic en **Migrate**. Cierren el aviso con su **X**. Los prompts del equipo funcionan tal como están.
    - Si se abrió un panel abajo que dice **Terminal**, ciérrenlo con la **X** de ese panel.

    > **Resultado esperado:** A la izquierda, en el **Explorador** de VS Code, se ven `.github`, `TiendasAndinas.Report`, `TiendasAndinas.SemanticModel`, `ENCARGOS.md`, `README.md` y `TiendasAndinas.pbip`.

16. **Abrir el chat en modo Local.**
    - El chat está en el panel de la derecha. Si no lo ven, presionen **Ctrl+Alt+I**.
    - Arriba del panel del chat, hagan clic en el **+** para abrir una conversación nueva.
    - Debajo del cuadro donde se escribe, a la izquierda, hay una palabra: **Local**, **Copilot** o **Cloud**. Debe decir **Local**. Si dice otra cosa, hagan clic sobre esa palabra y, en el menú, clic en **Local**.
17. **Configure Tools:**
    - Abajo del cuadro del chat, a la derecha de **Auto**, hagan clic en el **icono pequeño de controles**. Si no lo ven: **Ctrl+Shift+P** → escriban `Configure Tools` → **Enter**.
    - Arriba en la pantalla se abre una lista. Cada línea tiene una casilla a la izquierda: con **✓** está marcada; un clic en la casilla la marca o la desmarca.
    - Dejen **con ✓** estas tres: **read**, **search** y la línea **powerbi-authoring-local** (al marcar esa línea se marcan todas sus herramientas).
    - Dejen **sin ✓** estas tres: **edit**, **execute** y **browser**.
    - Las demás líneas (**agent**, **todo**, **vscode**, **web** u otras) déjenlas como estén.
    - Clic en el botón azul **OK**, arriba a la derecha de la lista.

    > **Resultado esperado:** Si vuelven a abrir la lista, **edit**, **execute** y **browser** aparecen sin ✓ y **powerbi-authoring-local** con ✓.

18. **Comprobar los prompts del equipo:** hagan clic en el cuadro del chat y escriban solo `/con`. Debe aparecer **/consultar-encargo** en la lista. Prueben también `/doc` (**/documentar-medidas**) y `/cre` (**/crear-rol** y **/crear-pagina**). Después borren lo que escribieron (tecla **Retroceso**).

✔ **Punto de control 1**

- Desktop muestra datos desde la carpeta del proyecto.
- VS Code tiene abierta la carpeta del proyecto, el chat dice **Local** y los prompts del equipo aparecen con `/`.

> **Pregunta para el grupo:** ¿de dónde salieron esos cinco prompts, si ustedes no los crearon?

## Tramo 2 · Conocer su encargo, sin cambiar nada (10 min)

1. Hagan clic en el cuadro del chat de VS Code, escriban este mensaje con **su** número de encargo (sin los signos `< >`) y presionen **Enter**:

   ```text
   /consultar-encargo <número>
   ```

2. Si en el chat aparece una tarjeta de aprobación, léanla: debe decir **powerbi-authoring-local** y tener **✓** (lectura). Clic en la **flecha ⌄** junto al botón azul → **Allow Once**. Pueden aparecer varias seguidas: hagan lo mismo con cada una.

   > **Resultado esperado:** Dos consultas DAX con `SUMMARIZECOLUMNS`, una tabla de resultados ordenada de mayor a menor y una línea final que dice si coinciden con `ENCARGOS.md`.

   Si el agente muestra la consulta y pregunta si la ejecuta, escriban y envíen:

   ```text
   Sí, ejecútala.
   ```

   Si el agente dice que no encuentra Power BI Desktop, escriban y envíen:

   ```text
   Lee el número del archivo msmdsrv.port.txt que está en %LOCALAPPDATA%\Microsoft\Power BI Desktop\AnalysisServicesWorkspaces (subcarpeta Data) y conéctate a localhost con ese puerto.
   ```

3. Comparen ustedes mismos dos valores de la tabla del agente con la columna **Valores esperados** de su fila en `ENCARGOS.md` (en VS Code pueden abrirlo con doble clic en `ENCARGOS.md`, en el Explorador de la izquierda).

✔ **Punto de control 2**

- Sus números coinciden con `ENCARGOS.md`.

> **Pregunta para el grupo:** ¿por qué consultamos los datos **antes** de construir nada?

## Tramo 3 · Modelo: documentar todas las medidas en un lote (15 min)

Un modelo que se va a compartir necesita que cualquiera entienda sus medidas. El agente las va a documentar todas en **una sola operación masiva**.

1. Hagan clic en el cuadro del chat, escriban este mensaje y presionen **Enter**:

   ```text
   /documentar-medidas
   ```

2. Van a aparecer tarjetas de lectura (**✓**), en las pruebas 3 o 4 seguidas (conexión, base de datos, medidas). Con cada una: clic en la **flecha ⌄** → **Allow Once**.
3. Esperen el plan y léanlo **antes** de aprobar: una tabla con las **18 medidas**, su carpeta y una descripción en lenguaje de negocio. Elijan dos descripciones y pregúntense si un gerente las entendería.
4. Hagan clic en el cuadro del chat, escriban y envíen:

   ```text
   APROBADO
   ```

5. Aparece una tarjeta de escritura (**⚠**, *Updates measures…*). Es **una sola** escritura para las 18 medidas: eso es una operación masiva. Clic en la **flecha ⌄** → **Allow Once**.

   > **Resultado esperado:** El agente dice que se actualizaron las descripciones de las 18 medidas en una sola operación.

6. Vayan a Power BI Desktop. A la derecha está el panel **Datos**, con la lista de tablas.
   - Hagan clic en la flecha **>** a la izquierda de `FACT_Ventas` para desplegarla.
   - Dentro, hagan clic en la flecha **>** de la carpeta **Ventas**.
   - Pongan el mouse sobre **Total Ventas** y déjenlo quieto unos segundos, sin hacer clic.

   > **Resultado esperado:** Aparece un recuadro con **Nombre** y **Descripción**: la descripción es la que propuso el agente. Si no aparece, hagan clic en otra página de abajo y vuelvan, o vayan a la pestaña **Inicio** → **Actualizar**.

✔ **Punto de control 3**

- Las 18 medidas tienen descripción.
- Hubo **una** aprobación de escritura, no dieciocho.

> **Pregunta para el grupo:** si fueran 300 medidas, ¿qué revisarían antes de escribir APROBADO?

## Tramo 4 · Modelo: seguridad por filas (15 min)

La gerencia regional del Caribe solo debe ver los datos de sus tiendas. Eso se resuelve con un **rol de seguridad por filas** (RLS, *Row-Level Security*).

1. Hagan clic en el cuadro del chat, escriban este mensaje y presionen **Enter**:

   ```text
   /crear-rol Región Caribe, solo las tiendas de la región Caribe
   ```

2. Si aparecen tarjetas de lectura (**✓**): **flecha ⌄** → **Allow Once** en cada una. Lean el plan: rol **Región Caribe**, permiso de lectura, tabla `tbl_Tienda` y filtro `[Region] = "Caribe"`.
3. Hagan clic en el cuadro del chat, escriban y envíen `APROBADO`.
4. Aparecen tarjetas de escritura (**⚠**, *Creates a security role…* y *Creates permissions…*). Son dos: primero el rol y después el filtro. Con cada una: **flecha ⌄** → **Allow Once**.

   > **Resultado esperado:** El agente termina con una tabla de comprobación donde aparece el permiso de `tbl_Tienda` con el filtro `[Region] = "Caribe"`. Si el agente dice que el permiso **no** aparece, avisen al instructor antes de seguir.

5. **Probar el rol en Power BI Desktop:**
   - Arriba, hagan clic en la pestaña **Modelado**.
   - En la cinta de botones, grupo *Seguridad*, hagan clic en **Ver como**.
   - En la ventana *Ver como roles*, hagan clic en la casilla **Región Caribe** para marcarla.
   - Clic en **Aceptar**.

   > **Resultado esperado:** Arriba aparece una franja *Se muestra como Región Caribe*. Total Ventas **$2 mil M**, Margen % **33,1 %**, Cumplimiento **98,4 %**, y la tabla *Ventas por región* muestra solo **Caribe: $1.866.538.345**.
   >
   > Si sigue mostrando $11 mil M, el rol quedó sin filtro: vean **Solución de problemas**. Si aparece una ventana *ProviderMessage* que dice que el usuario «no tiene acceso a la base de datos», clic en **Cerrar**: sale cuando el agente consulta el modelo mientras *Ver como* está activo.

6. En la franja *Se muestra como Región Caribe*, a la derecha, hagan clic en **Detener la visualización**. El informe vuelve a mostrar todo ($11 mil M).
7. **Guardar el modelo:** hagan clic en cualquier parte de la ventana de **Power BI Desktop** (para que quede al frente) y presionen **Ctrl+S**. También pueden hacer clic en el ícono de disquete, arriba a la izquierda. No aparece ninguna ventana: se guarda directamente.

✔ **Punto de control 4**

- Con *Ver como Región Caribe*, solo se ven los datos del Caribe.
- Guardaron con **Ctrl+S**.

> **Pregunta para el grupo:** el rol ya existe en el modelo, pero ¿quién decide qué personas pertenecen a él?

## Tramo 5 · Informe: crear su página con el agente (20 min)

En este tramo el agente **sí** va a crear archivos del informe. Por eso, y solo por este tramo y el siguiente, abrimos la llave de edición.

1. **Configure Tools:**
   - Abajo del cuadro del chat, a la derecha de **Auto**, hagan clic en el **icono pequeño de controles**. Si no lo ven: **Ctrl+Shift+P** → escriban `Configure Tools` → **Enter**.
   - Arriba en la pantalla se abre la lista. Busquen la línea **edit** (*Edit files in your workspace*) y hagan clic en su casilla para que quede **con ✓**.
   - Comprueben que **execute** y **browser** siguen **sin ✓**, y que **powerbi-authoring-local** sigue **con ✓**.
   - Clic en el botón azul **OK**, arriba a la derecha de la lista.
2. Hagan clic en el cuadro del chat, escriban este mensaje con **su** nombre y **su** número de encargo (sin los signos `< >`) y presionen **Enter**. Ejemplo: `/crear-pagina Ana, encargo 4`.

   ```text
   /crear-pagina <Nombre>, encargo <número>
   ```

3. Lean el plan **antes** de aprobar. Debe decir:
   - una carpeta nueva dentro de `TiendasAndinas.Report/definition/pages`;
   - un `page.json` con el nombre **Página de** y su nombre;
   - dos `visual.json`: el gráfico de su encargo, con los campos de `ENCARGOS.md`, y la tarjeta;
   - que **no** cambia `pages.json` ni el modelo.

   Si algo no coincide, escriban en el chat qué hay que corregir y esperen el plan nuevo.

4. Hagan clic en el cuadro del chat, escriban y envíen:

   ```text
   APROBADO
   ```

5. Si aparece una tarjeta que pide ejecutar código o abrir un navegador para «validar» (por ejemplo *Run Playwright Code*), hagan clic en **Skip**: la validación la hacemos en Desktop.

   > **Resultado esperado:** El agente termina con el **nombre de la carpeta** de su página (20 caracteres: letras de la a a la f y números) y recuerda cerrar Desktop sin guardar. Debajo del cuadro del chat aparece la barra **3 files changed** con los botones **Keep** y **Undo**.

6. Copien el nombre de la carpeta en su tabla de datos. Después hagan clic en **Keep**.
7. **Cerrar Desktop sin guardar y volver a abrirlo:**
   - En Power BI Desktop, clic en la **X** de arriba a la derecha.
   - Si pregunta si desean guardar los cambios, clic en **No guardar**.
   - En el Explorador de archivos, en la carpeta del proyecto, doble clic en `TiendasAndinas.pbip`.
   - Cuando abra: pestaña **Inicio** → **Actualizar**. Si sale «referencia cíclica»: **Cerrar** y otra vez **Actualizar**.

   > **Importante:** si guardan en Desktop ahora, Desktop sobrescribe los archivos del informe con lo que tenía en memoria y se pierde la página que creó el agente. El modelo no se pierde: lo guardaron en el Tramo 4.

8. Abajo de la ventana de Desktop están las pestañas de páginas (**Resumen** y las demás). Hagan clic en la pestaña **Página de** y su nombre. Pongan el mouse sobre dos barras o puntos del gráfico (sin hacer clic) y comparen los valores con `ENCARGOS.md`.

   > **Resultado esperado:** Un gráfico con el título de su encargo y su nombre entre paréntesis, y una tarjeta. Los valores coinciden con los del Tramo 2. Las descripciones y el rol **Región Caribe** siguen ahí.

✔ **Punto de control 5**

- Su página abre en Desktop sin errores y sus números coinciden.
- Anotaron el nombre de la carpeta de su página.

> **Pregunta para el grupo:** ¿qué diferencia hubo entre esta aprobación y las de los Tramos 3 y 4, cuando el agente cambiaba el modelo?

## Tramo 6 · Informe: cambiar un visual (10 min)

1. Hagan clic en el cuadro del chat y escriban **uno** de estos mensajes con **su** nombre (sin `< >`), según el tipo de su gráfico. Presionen **Enter**.

   Si su gráfico es de **columnas** (barras verticales):

   ```text
   /cambiar-visual <Nombre>, cambia el gráfico principal de columnas a barras
   ```

   Si es de **barras** (horizontales) o de **líneas**:

   ```text
   /cambiar-visual <Nombre>, cambia el gráfico principal a columnas
   ```

2. Lean la tabla de cambios (propiedad, valor actual, valor nuevo). Hagan clic en el cuadro del chat, escriban y envíen `APROBADO`.
3. Si aparece una tarjeta que pide ejecutar código o abrir un navegador, clic en **Skip**. Cuando aparezca la barra **1 file changed**, clic en **Keep**.
4. **Cerrar Desktop sin guardar y volver a abrirlo:** **X** de arriba a la derecha → **No guardar** → doble clic en `TiendasAndinas.pbip` en la carpeta del proyecto → pestaña **Inicio** → **Actualizar**. Abran la pestaña de su página y revisen el cambio.
5. **Devolver la llave (Configure Tools):** abajo del cuadro del chat, clic en el **icono de controles** a la derecha de **Auto**. En la lista, hagan clic en la casilla de **edit** para que quede **sin ✓**. Clic en **OK**.

✔ **Punto de control 6**

- Su página muestra el cambio y los números siguen iguales.
- **edit** está sin ✓ otra vez.

## Tramo 7 · Git: su rama, su página y el pull request (20 min)

Con el trabajo terminado y validado, llega el momento de entregarlo al equipo.

**Crear su rama**

1. En el navegador, vuelvan a la página del repositorio de su grupo (si la cerraron, escriban otra vez su dirección). Si están dentro de una carpeta, hagan clic en el nombre del repositorio, arriba a la izquierda.
2. Arriba a la izquierda de la lista de archivos hay un botón con el dibujo de una rama y la palabra **main**. Hagan clic en ese botón.
3. Se abre un recuadro *Switch branches/tags* con un cuadro de búsqueda. Escriban ahí el nombre de su rama, por ejemplo `pagina-ana`.
4. Debajo del cuadro aparece la opción **Create branch pagina-ana from main**. Hagan clic en ella.

   > **Resultado esperado:** El botón que antes decía **main** ahora dice el nombre de su rama.

**Subir la carpeta de su página**

5. En el Explorador de archivos de Windows, entren a la carpeta del proyecto → `TiendasAndinas.Report` → `definition` → `pages`. Ahí hay varias carpetas con nombres de 20 letras y números. La suya es la que anotaron en el Tramo 5. **No** es `57ecea57327b43cc957e`: esa es la página Resumen.
6. Acomoden las ventanas para ver al mismo tiempo el Explorador de archivos y el navegador (por ejemplo, el Explorador a la izquierda y el navegador a la derecha).
7. En GitHub, comprueben que el botón de ramas dice **su rama**. Hagan clic en la carpeta `TiendasAndinas.Report`, después en `definition` y después en `pages`.
8. Arriba a la derecha de la lista de archivos, hagan clic en el botón **Add file** y, en el menú, en **Upload files**.

   > **Resultado esperado:** Aparece un recuadro grande que dice *Drag files here to add them to your repository*.

9. **Arrastrar la carpeta:** en el Explorador de archivos, hagan clic sobre la carpeta de su página y, **sin soltar el botón del mouse**, llévenla hasta el recuadro grande del navegador. Ahí suelten el botón.

   > **Resultado esperado:** GitHub lista 3 archivos: `page.json` y dos `visual.json`, dentro de la carpeta de su página.
   >
   > Arrastren **solo** su carpeta. No suban `pages.json` ni archivos del modelo: las descripciones y el rol se quedan en su computador (lo discutimos en la pregunta del final de este tramo).

10. Bajen en la página hasta el recuadro **Commit changes**:
    - En el primer cuadro (dice *Add files via upload*), borren ese texto y escriban `Agrega Página de <Nombre> (encargo <número>)` con sus datos.
    - Más abajo, comprueben que está marcada la opción **Commit directly to the pagina-…** con el nombre de su rama.
    - Clic en el botón verde **Commit changes**.

**Abrir el pull request**

11. Vuelvan a la página principal del repositorio (clic en el nombre del repositorio, arriba a la izquierda).
    - Si aparece un aviso amarillo *«pagina-ana had recent pushes»* con el botón verde **Compare & pull request**, hagan clic en ese botón.
    - Si no aparece: arriba, pestaña **Pull requests** → botón verde **New pull request** → en el segundo selector (**compare**) elijan su rama → botón verde **Create pull request**.
12. Se abre el formulario *Open a pull request*:
    - En **Add a title**, borren lo que tenga y escriban `Página de <Nombre> · encargo <número>`.
    - En la descripción ya viene la plantilla del equipo. Hagan clic dentro de ella: después de **Nombre:** escriban su nombre; después de **Encargo #:**, su número; y en **Carpeta de la página** reemplacen los `...` por el nombre de su carpeta.
    - En la sección **Cómo la validé**, cambien cada `[ ]` por `[x]` (una equis entre los corchetes, sin espacios) en las casillas que cumplieron. Las casillas de **Para quien revisa** no las toquen: las marca su compañero.
13. Clic en el botón verde **Create pull request**, abajo a la derecha del formulario. Si aparece la ventana *«Try the new pull requests Overview page!»*, clic en **Not now**.
14. Arriba del pull request hay pestañas: **Conversation**, **Commits**, **Checks** y **Files changed**. Hagan clic en **Files changed**.

    > **Resultado esperado:** Aparecen **3 archivos**, todos dentro de la carpeta de su página, en verde (agregados).

✔ **Punto de control 7**

- Su pull request está abierto, con la plantilla completa.
- **Files changed** muestra solo los 3 archivos de su página.

> **Pregunta para el grupo:** sus descripciones y su rol están en su computador, pero no los subieron. Si veinte personas subieran cambios al modelo, ¿qué pasaría? ¿Quién debería subirlos y cómo?

## Tramo 8 · Revisión cruzada e integración (15 min)

1. Arriba en el repositorio, hagan clic en la pestaña **Pull requests**. Busquen el del compañero que les toca revisar por el título *Página de* y su nombre, y hagan clic en ese título. Si todavía no lo ha abierto, revisen el de otra persona que no tenga revisión.
2. Hagan clic en la pestaña **Files changed** y revisen:
   - ¿Cambia solo una carpeta dentro de `pages`?
   - ¿Los títulos de los visuales terminan con el nombre de la persona? (Busquen la palabra `Value` dentro de `title`.)
   - En el `visual.json` del gráfico, ¿los campos (`Entity` y `Property`) son los de su encargo en `ENCARGOS.md`?
3. **Dejar un comentario:** pongan el mouse sobre una línea del archivo. A la izquierda de la línea aparece un **+** azul: hagan clic en él. Escriban su comentario en el cuadro que se abre y hagan clic en **Start a review**.
4. **Terminar la revisión:** arriba a la derecha, hagan clic en el botón verde **Submit review** (en algunas pantallas dice **Review changes**). Se abre el recuadro **Finish your review**: elijan **Approve** si todo está bien, o **Comment** si algo hay que corregir, y hagan clic en el botón verde **Submit review** de abajo. Clic en **Submit review**.
5. El instructor integra los pull requests aprobados en `main` (**Merge pull request**) y, como dueño del modelo, abre un pull request aparte con la documentación y el rol. Síganlo en la pantalla compartida.
6. Cuando el instructor lo indique, descarguen el informe final:
   - Cierren Power BI Desktop con la **X** → **No guardar**.
   - En GitHub, vayan a la página principal del repositorio. Hagan clic en el botón de ramas (que dice el nombre de su rama) y, en la lista, elijan **main**. **Importante:** si queda en su rama, descargarían solo su página.
   - Botón verde **Code** → **Download ZIP**. El archivo nuevo puede llamarse `tiendas-andinas-grupo<N>-main (1).zip`: usen ese.
   - En **Descargas**, clic derecho sobre ese ZIP → **Extraer todo…** → borren la ruta del cuadro y escriban `C:\CursoPBI\Equipo\final` → **Extraer**.
   - Entren a `C:\CursoPBI\Equipo\final\tiendas-andinas-grupo<N>-main` y hagan doble clic en `TiendasAndinas.pbip`. Cuando abra: pestaña **Inicio** → **Actualizar**.

   > **Resultado esperado:** Abajo, en las pestañas de páginas, está **Resumen** y una página por cada pull request integrado.

✔ **Punto de control 8**

- Revisaron un pull request y dejaron su revisión.
- El informe final del equipo abre con todas las páginas.

## Reto opcional

- **Un segundo rol.** En VS Code, con la carpeta del proyecto abierta (no la de `final`), hagan clic en el cuadro del chat, escriban y envíen:

  ```text
  /crear-rol Categoría Moda, solo los productos de la categoría Moda
  ```

  Aprueben las tarjetas con **Allow Once** y pruébenlo en Desktop con **Modelado → Ver como → Categoría Moda → Aceptar**. Esta vez el filtro va sobre la tabla `Categoria`, y por las relaciones llega a los productos y a las ventas: el gráfico *Ventas por categoría* debe mostrar solo **Moda**. (Este reto no se probó en clase: si el agente propone otra tabla, revisen el plan antes de aprobar.)
- **El informe del equipo, explicado.** En VS Code: menú **File** → **Open Folder…** → `C:\CursoPBI\Equipo\final` → un clic en `tiendas-andinas-grupo<N>-main` → **Seleccionar carpeta** → **Yes, I trust the authors**. Abran un chat nuevo con el **+**, comprueben que dice **Local**, y escriban:

  ```text
  Sin cambiar nada, lista en una tabla todas las páginas del informe de esta carpeta, con su autor y los campos que usa cada visual.
  ```

## Solución de problemas

| Síntoma | Causa probable | Acción |
|---|---|---|
| GitHub dice que el repositorio no existe | No han aceptado la invitación a la organización Cursos-CM | Abrir `https://github.com/orgs/Cursos-CM/invitation` con su cuenta y aceptar, o avisar al instructor |
| Al actualizar sale «referencia cíclica» en Presupuesto | Error ocasional del primer refresco | 1. Clic en **Cerrar** en el mensaje. 2. En la cinta **Inicio**, clic en **Actualizar** otra vez |
| Al escribir `/` no aparecen los prompts del equipo | El chat está en **Copilot**, o VS Code no abrió la carpeta del proyecto | 1. Abajo en el chat, clic en el selector que dice **Copilot** y elegir **Local**. 2. Si siguen sin aparecer: menú **File → Open Folder**, elegir `C:\CursoPBI\Equipo` → **Seleccionar carpeta**. 3. Si aún no aparecen: **Ctrl+Shift+P**, escribir `Reload Window` y presionar **Enter** |
| El agente escribe en el modelo sin pedir aprobación | Antes se eligió *Allow in this Session* | 1. Clic en **+** arriba del chat para abrir un chat nuevo (reinicia los permisos). 2. Revisar que abajo diga **Local**. 3. En cada tarjeta, usar la flecha **⌄** → **Allow Once** (acción B) |
| El agente dice que no tiene herramientas del modelo | **powerbi-authoring-local** está desmarcado | 1. Clic en el icono de herramientas (Configure Tools) abajo del chat (acción C). 2. Marcar la casilla de **powerbi-authoring-local**. 3. Clic en **OK**. 4. Enviar el mensaje otra vez |
| Con *Ver como* se ven todos los datos ($11 mil M) | El rol se creó sin el permiso de tabla (pasó en una de las pruebas) | 1. En Desktop, en la franja *Se muestra como Región Caribe*, a la derecha, clic en **Detener la visualización**. 2. En VS Code, clic en **+** para un chat nuevo y revisar que diga **Local**. 3. Escribir: `/crear-rol Región Caribe. El rol ya existe: crea solo el permiso de tabla con CreatePermissions sobre tbl_Tienda con el filtro [Region] = "Caribe" y compruébalo con ListPermissions` y **Enter**. 4. Aprobar con **Allow Once**. 5. En Desktop: cinta **Modelado → Ver como**, marcar **Región Caribe** → **Aceptar** |
| Aparece la ventana *ProviderMessage* «no tiene acceso a la base de datos» | El agente consultó el modelo mientras *Ver como* estaba activo | 1. Clic en **Cerrar** en la ventana. 2. En la franja *Se muestra como Región Caribe*, a la derecha, clic en **Detener la visualización** |
| Aviso *«workspace customizations need an update»* o botón **Migrate** | VS Code 1.146 propone convertir los prompts al modo Copilot | No hacer clic en **Migrate**. Clic en la **X** del aviso para cerrarlo. En **Local** los prompts funcionan igual |
| Las descripciones o el rol desaparecieron después de reabrir Desktop | No guardaron con **Ctrl+S** al final del Tramo 4 | 1. Repetir el Tramo 3 o el Tramo 4 (lo que falte). 2. Al terminar, hacer clic en la ventana de Desktop y presionar **Ctrl+S** |
| El agente pide ejecutar código, abrir un navegador o usar una terminal | Intenta validar por su cuenta | 1. En la tarjeta, clic en **Skip**. 2. Abrir Configure Tools (acción C) y revisar que `execute` y `browser` estén **sin** marca → **OK** |
| La página no aparece en Desktop | Desktop seguía abierto, o se guardó después del cambio | 1. Cerrar Desktop con la **X**; cuando pregunte si guardar, clic en **No guardar**. 2. Abrir otra vez `TiendasAndinas.pbip` (acción E). 3. Si aún no aparece: Configure Tools → marcar `edit` → **OK**; escribir otra vez `/crear-pagina` con sus datos; **Keep**; repetir los pasos 1 y 2; al terminar, Configure Tools → desmarcar `edit` → **OK** |
| El visual sale en blanco o con una X | Un campo con otro nombre en el `visual.json` | 1. Configure Tools → marcar `edit` → **OK**. 2. Escribir `/cambiar-visual <Nombre>, revisa que los campos del gráfico existan en el modelo y corrígelos` (cambiando `<Nombre>` por su nombre) y **Enter**. 3. Clic en **Keep**. 4. Cerrar Desktop con **No guardar** y abrirlo otra vez. 5. Si ya habían subido la página, súbanla otra vez a su rama (Tramo 7). 6. Configure Tools → desmarcar `edit` → **OK** |
| No se puede arrastrar la carpeta a GitHub | El navegador no acepta carpetas | Crear los 3 archivos a mano, dentro de `pages` y en su rama: **Add file → Create new file**. En el nombre escriban la ruta completa, por ejemplo `<carpeta de su página>/page.json` (al escribir `/` GitHub crea la carpeta); abran ese archivo en VS Code, copien todo (**Ctrl+A**, **Ctrl+C**) y péguenlo en GitHub → **Commit changes**. Repitan con `<carpeta de su página>/visuals/<carpeta del visual>/visual.json` para cada visual |
| GitHub no deja hacer commit en `main` | La rama `main` está protegida | Es lo esperado. 1. Clic en el botón de rama que dice **main** (arriba a la izquierda de la lista de archivos). 2. Elegir su rama `pagina-<nombre>`. 3. Repetir la subida (Tramo 7) |
| **Files changed** muestra más de 3 archivos | Se subió algo más que la carpeta de la página | 1. En la pestaña **Files changed**, buscar el archivo que sobra. 2. Clic en el menú **…** a la derecha de su nombre → **Delete file**. 3. Clic en **Commit changes**. Si no sale, pedir ayuda al instructor |
| Sale *«Tool 'tool_search' is not supported with gpt-5»* | En modo Auto, Copilot eligió un modelo que no acepta tantas herramientas | 1. Enviar el mismo mensaje otra vez. 2. Si se repite: abajo en el chat, clic en **Auto** y elegir otro modelo de la lista; enviar de nuevo |
| No aparece el icono de Configure Tools | El panel del chat es angosto | 1. Arrastrar el borde izquierdo del panel del chat hacia la izquierda para ensancharlo. 2. O bien: **Ctrl+Shift+P**, escribir `Configure Tools` y **Enter** |
| El agente se quedó «esperando» | Hay una tarjeta de aprobación más arriba en el chat | Con la rueda del mouse, subir en el chat hasta encontrar la tarjeta y responderla (acción B) |
| El agente responde una parte en inglés | Elige el idioma por su cuenta | Es normal; el contenido sirve igual |
| El chat deja de responder por límite de uso | Se acabó la cuota de Copilot Free | Seguir en pareja con un compañero; la revisión cruzada no usa Copilot |

## Resumen y entregables

- En su computador: las 18 medidas documentadas y el rol **Región Caribe** probado con *Ver como*.
- Una rama `pagina-<nombre>` con la carpeta de su página.
- Un pull request con la plantilla completa y validado.
- Una revisión hecha al pull request de un compañero.
- El informe del equipo en `main`, con su página.

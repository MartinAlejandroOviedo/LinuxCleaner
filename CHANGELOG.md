# Changelog

## 1.6.5 - 2026-07-28

- Refactor visual completo de la TUI: barras de progreso con gradiente (`█▓▒░`),
  separadores Unicode (`─`), iconos modernos (` ℹ ` ` ✔ ` ` ⚡ ` ` ✘ `).
- La barra usa `·` (punto medio) para el espacio vacio, eliminando el ruido
  visual del caracter `░`.
- `c_section` ahora ocupa el ancho completo de la terminal.
- Spinner con colores ciclicos degradados durante operaciones largas.
- README renovado: badges flat-square, tabla de contenidos, modulos colapsables.
- Prompt de confirmacion con prefijo `▸` en cian.
- Paquetes DEB, RPM y Flatpak regenerados el 2026-07-29.
- Corrige la versión interna del paquete DEB, que todavía declaraba `1.6.4`.
- Documenta una descarga segura del DEB con validación HTTP y de metadata.

## 1.6.4 - 2026-07-24

- Agrega `clean -v` y `clean --version`.
- Agrega definición de paquete RPM `noarch`.
- Agrega manifiesto Flatpak con ejecución controlada en el sistema anfitrión.
- Sincroniza la versión de la aplicación y de los paquetes en 1.6.4.
- Documenta instalación, actualización, desinstalación y construcción para
  paquetes DEB, RPM y Flatpak.

## 1.6.3 - 2026-07-24

- Corrige la estructura interna del paquete `.deb` para instalarlo con APT 3 en Debian 13.
- Elimina las barras finales que algunas versiones de `ar` agregaban a los miembros `debian-binary`, `control.tar.xz` y `data.tar.xz`.
- Documenta la compatibilidad del paquete con Debian 13.
- Gracias a [@abejaranoh](https://github.com/abejaranoh) por reportar el problema y comprobarlo tanto en la versión 1.3.0 como en la 1.6.2.

## 1.6.2 - 2026-07-21

- Reserva la ultima fila de la terminal para mantener fija la barra de progreso global.
- Los mensajes y resultados se desplazan por encima sin mover el indicador.
- Restaura los margenes y el cursor de la terminal al finalizar o interrumpir la limpieza.
- Mantiene una salida convencional cuando el comando no se ejecuta en una terminal interactiva.

## 1.6.1 - 2026-07-21

- La barra granular ahora representa progreso global acumulado y no se reinicia por cada directorio.
- El porcentaje nunca retrocede y solo alcanza `100%` al terminar el ultimo modulo.
- Limita las cabeceras a 100 columnas en terminales anchas.
- Aisla la salida de comandos largos para evitar que se mezcle con el spinner.

## 1.6.0 - 2026-07-21

- Nueva barra de progreso granular actualizada sobre una sola linea.
- Muestra porcentaje y contador real de elementos durante la limpieza de papeleras, miniaturas y caches de usuario y desarrollo.
- Conserva el progreso nativo de APT/dpkg durante la eliminacion de paquetes huerfanos.
- El modo `--dry-run` informa cuantos elementos procesaria sin eliminarlos.
- Corrige el total global para incluir los modulos `--venv` y `--apt-check`.

## 1.5.2 - 2026-07-16

- --apt-check ahora ofrece auto-fix para duplicados en sources.list.
- Comenta lineas duplicadas que ya existen en formato .sources.
- Pide confirmacion antes de modificar archivos de sistema.


## 1.5.1 - 2026-07-16

- Nuevo: `--apt-check` / `-K` para diagnosticar fuentes APT (duplicados, claves GPG, repos caídos).
- Ejecuta una sola pasada de `apt-get update` para todo el diagnóstico.
- Detecta convivencia de `.list` y `.sources` en `sources.list.d/`.

## 1.5.0 - 2026-07-16

- Nuevo: modulo `--venv` / `-V` para limpieza de entornos virtuales Python.
- Detecta venvs huerfanos (sin `requirements.txt`, `pyproject.toml`, `setup.py`, etc. en el proyecto padre).
- Preserva automaticamente los venvs de proyectos activos (solo limpia cache interna).
- Incluye `pip cache purge` para eliminar ruedas y HTTP cache vieja.
- Nuevo en `--dev`: deteccion de `node_modules/` huerfanos (sin `package.json` en el padre).
- Limpieza profunda de `node_modules/` abandonados que ocupan espacio innecesario.
- Limpieza profunda de Go: `go clean -cache` y `go clean -modcache`.
- Limpieza profunda de Rust: `registry/src/` + archivos parciales de rustup.

## 1.4.0 - 2026-07-16

- Limpieza profunda de Python: `pip cache purge` (wheels, HTTP cache, ruedas descargadas).
- Limpieza profunda de Rust: `registry/src/` (fuentes de crates) + archivos parciales de rustup.
- Limpieza profunda de Go: `go clean -cache` y `go clean -modcache` nativos.
- Documentacion: actualiza README.md con referencia a assets/screenshot.png y versiones.

## 1.3.1 - 2026-07-17

- Agrega entrada de menú con `clean-debian.desktop` para que Linux Cleaner aparezca en el lanzador de aplicaciones.
- La entrada del menú abre `clean --all` en una terminal, conservando la TUI interactiva y la confirmacion antes de borrar.

## 1.3.0 - 2026-07-17

- Agrega limpieza de juegos con `--games`: Steam, Lutris, Heroic, Legendary, itch, Bottles, RetroArch, PrismLauncher y Minecraft.
- Amplia `--media` con residuos de multimedia, edicion de video, audio y fotografia: OBS, Kdenlive, Shotcut, OpenShot, Pitivi, HandBrake, DaVinci Resolve, Blender, GIMP, Krita, Darktable, RawTherapee, digiKam, Audacity, Ardour, LMMS y Mixxx.
- Agrega TUI 2026 con barras de progreso para escaneo y borrado, porcentaje y detalle de la tarea actual.
- Mejora `--status` para incluir cachés multimedia y de juegos, evitando duplicados por symlinks.
- Mejora seguridad del limpiador: evita borrar backups, bibliotecas, proyectos, partidas guardadas, juegos instalados, prefixes Wine/Proton y descargas parciales.
- Mejora historial: `--status` ya no intenta registrar una limpieza y el historial no falla si la cache del usuario esta en solo lectura.

## 1.2.0 - 2026-07-15

- Nuevo: `--all` incluye escaneo interactivo por defecto.
- Nuevo: `--yes` / `-y` para saltar confirmacion interactiva.
- Mejora: escaneo TUI enriquecido con secciones por categoria y totales.
- Mejora: deteccion de servicios en ejecucion.
- Mejora: modulo `--media` con soporte extendido.
- Mejora: README completo con todas las features documentadas.

## 1.1.0 - 2026-07-14

- Soporte multi-distro para APT, DNF, Pacman y Portage.
- Modulo `--browsers` ampliado a 22 navegadores.
- Modulo `--ram` con limpieza de swap.
- Modulo `--user-cache` para `~/.cache`, NVIDIA y Mesa.
- Modulos `--dev`, `--junk`, `--wine` y `--media`.
- Modo interactivo `--interactive` con escaneo TUI y confirmacion.
- Historial de limpiezas en `~/.cache/clean-history.log`.

## 1.0.0 - 2026-07-09

- Version inicial del comando `clean`.
- Limpieza de temporales, cache APT, logs, papelera, miniaturas, navegadores, RAM y unidades montadas.
- Modo simulacion `--dry-run`.

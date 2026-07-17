# Changelog

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

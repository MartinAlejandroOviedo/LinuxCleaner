# 🧹 Linux Cleaner

**`clean`** es un comando para Linux (Debian/Ubuntu, Fedora, Arch, Gentoo) que limpia archivos temporales, cachés, logs, papeleras y configuraciones residuales del sistema. Con TUI interactiva 2026, barras de progreso de escaneo/borrado y 16 módulos de limpieza.

![Static Badge](https://img.shields.io/badge/debian-%3E%3D%2012-blue?logo=debian)
![Static Badge](https://img.shields.io/badge/fedora-supported-blue?logo=fedora)
![Static Badge](https://img.shields.io/badge/arch-supported-blue?logo=archlinux)
![Static Badge](https://img.shields.io/badge/license-MIT-green)
![Static Badge](https://img.shields.io/badge/version-1.5.0-white)

```bash
$ clean --all

  ============================================
     CLEANER -- Escaneo del sistema
  ============================================

  [ TEMP ] Archivos temporales
  /tmp                                          25M    40 archivos
  /var/tmp                                      40K     9 archivos

  [ CACHE ] Cachés del sistema y usuario
  /var/cache/apt/archives                      197M
  ~/.cache                                      64M
  paquetes en estado 'rc'                        68  configs residuales

  [ LOGS ] Registros del sistema
  /var/log                                     119M
  /var/lib/systemd/coredump                       3  volcados

  [ TRASH ] Papelera del usuario
  ~/.local/share/Trash/files                    10M    39 archivos

  [ BROWSERS ] Caché de navegadores
  detectados                                      3  navegadores

  [ DEV ] Herramientas de desarrollo
  ~/.gradle/caches                             4,0K
  ~/.npm/_cacache                               33M
  ~/.cargo/registry                            795M

  [ JUNK ] Archivos basura
  basura en /tmp, /var/tmp, ~/Downloads           8  archivos
  __pycache__ en ~/                             186  directorios

  [ GAMES ] Launchers y juegos
  ~/.steam/steam/steamapps/shadercache          1,2G
  ~/.cache/lutris                                81M

  --------------------------------------------
  Total aproximado encontrado: 550 MB
  --------------------------------------------

  ¿Ejecutar limpieza? (s/N):
```

![clean --all en acción](assets/screenshot.png)

## 📦 Instalación

### Desde .deb (Debian/Ubuntu)

```bash
sudo apt install ./releases/clean-debian_1.5.0_all.deb
```

### Manual (cualquier distro)

```bash
sudo cp clean /usr/local/bin/clean
sudo chmod +x /usr/local/bin/clean
```

## 🚀 Uso

```bash
clean --all                  # TUI: escanea + muestra progreso + pide confirmación + limpia
clean --all --yes            # limpia todo sin preguntar (cron/scripts)
clean --all --dry-run        # simulación: muestra qué haría sin borrar
clean --browsers --dev       # solo tareas específicas
clean --status               # reporte de espacio ocupado
clean --help                 # ayuda completa
```

## ⚡ Todas las opciones

| Flag | Opción | Descripción |
|------|--------|-------------|
| `-a` | `--all` | **Todas las tareas** (escanea + pide confirmación) |
| `-t` | `--temp` | `/tmp` y `/var/tmp` |
| `-c` | `--cache` | Paquetes (APT/DNF/Pacman/Portage) + huérfanos + configs residuales |
| `-l` | `--logs` | Journald + logs comprimidos + **coredumps** |
| `-T` | `--trash` | Papelera del usuario |
| `-m` | `--thumbs` | Miniaturas |
| `-b` | `--browsers` | Caché de **22 navegadores** |
| `-r` | `--ram` | Page/buffer cache del kernel + **swap** |
| `-d` | `--drives` | Papeleras + `.DS_Store` + `Thumbs.db` de discos montados |
| `-u` | `--user-cache` | `~/.cache/` + `~/.nv/` (NVIDIA) + `~/.mesa_shader_cache/` |
| `-D` | `--dev` | Gradle, npm, Cargo, pip, Yarn, Maven, Go, `node_modules/.cache` |
| `-j` | `--junk` | `*.swp`, `*.bak`, `*.part`, `*.lock`, archivos vacíos, `__pycache__` |
| `-w` | `--wine` | Temporales de Wine + Lutris + PlayOnLinux + Bottles |
| `-M` | `--media` | VLC, MPV, OBS, Kdenlive, Shotcut, GIMP, Krita, Darktable, Audacity, Ardour |
| `-g` | `--games` | Steam, Lutris, Heroic, Legendary, itch, Bottles, RetroArch, PrismLauncher, Minecraft |
| `-V` | `--venv` | Entornos virtuales Python huérfanos + `pip cache purge` + `node_modules/` sin proyecto |
| `-s` | `--status` | Reporte `du -sh` de rutas clave |
| `-n` | `--dry-run` | Modo simulación (no borra nada) |
| `-I` | `--interactive` | TUI con progreso y confirmación (implícito con `--all`) |
| `-y` | `--yes` | Omite la confirmación (útil con `--all` en scripts) |
| `-h` | `--help` | Ayuda |

## 🛡️ Seguridad

- **Escaneo previo**: `--all` muestra qué encontró **antes** de borrar y pide confirmación.
- **TUI con progreso**: muestra fase, porcentaje y detalle durante búsqueda y borrado.
- **Modo simulación**: `--dry-run` imprime los comandos exactos que se ejecutarían.
- **Sin sudo innecesario**: tareas de usuario (papelera, miniaturas, navegadores) no piden privilegios.
- **Servicios en ejecución**: PulseAudio y PipeWire se omiten si están corriendo para no cortar el audio.
- **Display Managers**: solo se limpian si no hay sesión gráfica activa.
- **Regenerable**: todo lo que se borra es caché o temporal que el sistema/vuelve a generar.
- **Historial**: registra cada limpieza en `~/.cache/clean-history.log`.

## 🧪 ¿Qué hace cada módulo?

### `--temp`
Limpia `/tmp` y `/var/tmp`, respetando sockets protegidos del sistema (X11, systemd).

### `--cache`
- **APT** (Debian/Ubuntu): `clean`, `autoclean`, `autoremove --purge`.
- **DNF** (Fedora): `clean all`, `autoremove`.
- **Pacman** (Arch): `-Sc`, metadatos de sincronización.
- **Portage** (Gentoo): temporales de compilación en `/var/tmp/portage`.
- **Configuraciones residuales**: purga paquetes en estado `rc` (desinstalados pero con restos).
- **Cachés regenerables**: fontconfig, man, thumbnails en `/var/cache`.

### `--logs`
- Rota y compacta journals de systemd (`--vacuum-time=3d`).
- Elimina logs comprimidos (`.gz`) y rotados (`.log.1`, etc.) de `/var/log`.
- Limpia **coredumps** (`/var/lib/systemd/coredump/`).

### `--browsers` (22 navegadores)
**Chromium/Blink:** Chrome, Chromium, Brave, Edge, Opera, Vivaldi, Falkon, Midori, Iridium, Slimjet, Dissenter, Ghostery, Epiphany, qutebrowser.

**Firefox/Gecko:** Firefox, LibreWolf, Floorp, Waterfox, Zen, Pale Moon, Basilisk, Tor Browser.

Solo limpia caché de disco (Cache, Code Cache, GPUCache, ShaderCache, cache2, startupCache), sin tocar contraseñas, historial ni extensiones.

### `--ram`
- `sync` + `drop_caches=3` para liberar page/buffer cache del kernel.
- `swapoff -a && swapon -a` para vaciar swap.
- Muestra uso de RAM antes y después con `free -h`.

### `--drives`
Busca discos montados en `/media`, `/mnt`, `/run/media` y `/home` y elimina:
- `.Trash-*` (papeleras Linux)
- `$RECYCLE.BIN` (papelera Windows)
- `Thumbs.db`, `.DS_Store` (metadatos de exploradores)

### `--user-cache`
- `~/.cache/` completo (vuelve a generarse bajo demanda).
- `~/.nv/` (NVIDIA shader cache).
- `~/.mesa_shader_cache/` (Mesa OpenGL/Vulkan).

### `--dev`
- Gradle (`~/.gradle/caches`)
- npm (`~/.npm/_cacache`)
- Cargo (`~/.cargo/registry/cache`)
- pip (`~/.cache/pip`)
- Yarn (`~/.yarn/cache`)
- Maven (solo `.jar` vacíos y `.lastUpdated` en `~/.m2/repository`)
- Go modules (`~/go/pkg/mod/cache`)
- `node_modules/.cache/` (webpack, babel, etc.)

### `--junk`
Busca en `/tmp`, `/var/tmp`, `~/Downloads`, `~/Desktop`, `~/Documentos` y `~/Escritorio`:
- Patrones seguros: `*.swp`, `*.swo`, `*.bak`, `*.old`, `*.part`, `*.crdownload`, `*.unfinished`, `*.tmp`, `*.temp`, `*.lock`
- Archivos vacíos (0 KB)
- `__pycache__/` en todo `~` (bytecode de Python, se regenera solo)

### `--wine`
- `~/.wine/drive_c/users/$USER/Temp/`
- `~/.wine/drive_c/users/$USER/AppData/Local/Temp/`
- `~/.wine/drive_c/users/$USER/AppData/Local/Microsoft/Windows/INetCache/`
- `~/.wine/drive_c/users/$USER/AppData/Local/CrashDumps/`
- `~/.wine/drive_c/windows/temp/`
- Búsqueda recursiva de `Temp`, `INetCache`, `CrashDumps` en prefixes de Lutris, PlayOnLinux y Bottles.

### `--media`
- **Audio:** PulseAudio, PipeWire (solo si no están corriendo)
- **Video y streaming:** VLC, MPV, GStreamer, FFmpeg, OBS.
- **Edición de video:** Kdenlive, Shotcut, OpenShot, Pitivi, HandBrake, DaVinci Resolve, Blender.
- **Fotografía e imagen:** GIMP, Krita, Inkscape, Darktable, RawTherapee, digiKam, Shotwell, gThumb, Nomacs, Pinta, MyPaint.
- **Audio y música:** Rhythmbox, Audacious, Clementine, DeaDBeeF, Audacity, Ardour, LMMS, Mixxx.
- **Residuos seguros:** cachés, thumbnails, proxies, logs, crash-reports y temporales regenerables.
- **Display Managers:** LightDM, SDDM, GDM (solo sin sesión gráfica activa)

### `--games`
- **Steam:** `appcache/httpcache`, `config/htmlcache`, `logs`, `steamapps/shadercache`, `steamapps/temp`.
- **Launchers:** Lutris, Heroic Games Launcher, Legendary/Epic, itch, Bottles, Minigalaxy.
- **Emulación y juegos:** RetroArch, PrismLauncher, logs y crash-reports de Minecraft.
- No borra juegos instalados, partidas guardadas, prefixes de Wine/Proton ni descargas parciales.

### `--venv`
- Detecta entornos virtuales Python buscando `pyvenv.cfg` + `bin/activate` en todo `$HOME`.
- Si el proyecto padre tiene `requirements.txt`, `pyproject.toml`, `setup.py`, `setup.cfg`, `Pipfile`, `Pipfile.lock` o `poetry.lock` → **activo** (solo se limpia cache interna de pip, no se borra el venv).
- Si el proyecto padre **no** tiene esos archivos → **huérfano** (se borra completo).
- Incluye `pip cache purge` para eliminar ruedas descargadas y HTTP cache.
- También detecta `node_modules/` sin `package.json` en el padre (huérfano de npm).
- Ejemplo: 37 venvs encontrados → 11 huérfanos (1.5 GB) eliminados, 26 de proyectos activos preservados.

## 📋 Requisitos

- Linux con bash 4+
- Dependencias: `coreutils`, `findutils`, `util-linux` (vienen preinstaladas en toda distro)
- Opcional según módulo: `apt`, `dnf`, `pacman`, `sudo`

## 🏗️ Construir el .deb

```bash
cd pkg
mkdir -p ../releases
fakeroot dpkg-deb --build clean-debian ../releases/clean-debian_1.5.0_all.deb
```

## 📄 Licencia

MIT

---

¿Encontraste un bug o tenés una idea? ¡Abrí un issue o mandá un PR!

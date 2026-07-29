# 🧹 Linux Cleaner

**`clean`** — Un comando de limpieza para Linux que libera espacio eliminando archivos temporales, cachés, logs, papeleras y configuraciones residuales del sistema.

<p align="center">
  <img alt="Debian" src="https://img.shields.io/badge/debian-%3E%3D%2012-blue?logo=debian&style=flat-square">
  <img alt="Fedora" src="https://img.shields.io/badge/fedora-supported-blue?logo=fedora&style=flat-square">
  <img alt="Arch" src="https://img.shields.io/badge/arch-supported-blue?logo=archlinux&style=flat-square">
  <img alt="Gentoo" src="https://img.shields.io/badge/gentoo-supported-blue?logo=gentoo&style=flat-square">
  <img alt="License" src="https://img.shields.io/badge/license-MIT-green?style=flat-square">
  <img alt="Version" src="https://img.shields.io/badge/version-1.6.5-blue?style=flat-square">
  <img alt="Shell" src="https://img.shields.io/badge/shell-bash%204+-4EAA25?logo=gnu-bash&style=flat-square">
</p>

<p align="center">
  <img src="assets/screenshot.png" alt="clean --all en accion" width="600">
</p>

---

## 📋 Tabla de contenido

- [Características](#-caracteristicas)
- [Instalación](#-instalacion)
- [Uso rápido](#-uso-rapido)
- [Progreso granular](#-progreso-granular)
- [Todas las opciones](#-todas-las-opciones)
- [¿Qué hace cada módulo?](#-que-hace-cada-modulo)
- [Seguridad](#-seguridad)
- [Requisitos](#-requisitos)
- [Construir paquetes](#-construir-paquetes)
- [Licencia](#-licencia)

---

## ✨ Caracteristicas

- **16 módulos** de limpieza: temporales, cachés, logs, navegadores, apps, juegos, desarrollo y más
- **TUI interactiva** con barras de progreso en tiempo real durante escaneo y borrado
- **Multi-distro**: APT (Debian/Ubuntu), DNF (Fedora), Pacman (Arch), Portage (Gentoo)
- **Modo simulación** (`--dry-run`): muestra qué haría sin borrar nada
- **22 navegadores** soportados (Chrome, Firefox, Brave, Edge, Opera, Tor y más)
- **Seguro**: no borra contraseñas, historial, juegos instalados ni partidas guardadas
- **Historial** de cada limpieza en `~/.cache/clean-history.log`

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

---

## 📦 Instalacion

La versión actual es **1.6.5**. Comprobá la versión instalada con:

```bash
clean --version
# Linux Cleaner 1.6.5
```

### Debian/Ubuntu (.deb)

Desde un clon del repositorio:

```bash
sudo apt install ./releases/clean-debian_1.6.5_all.deb
```

O descargando directamente el paquete:

```bash
curl --fail --location \
  --output clean-debian_1.6.5_all.deb \
  https://raw.githubusercontent.com/MartinAlejandroOviedo/LinuxCleaner/master/releases/clean-debian_1.6.5_all.deb
dpkg-deb --info ./clean-debian_1.6.5_all.deb
sudo apt install ./clean-debian_1.6.5_all.deb
```

`curl --fail` evita guardar una respuesta HTTP de error con extensión `.deb`.
`dpkg-deb --info` comprueba que el archivo descargado sea un paquete Debian
válido antes de instalarlo.

APT reemplaza automáticamente una versión anterior del paquete.

### Fedora/RHEL/openSUSE (.rpm)

```bash
# Fedora/RHEL
sudo dnf install ./releases/clean-debian-1.6.5-1*.noarch.rpm

# openSUSE
sudo zypper install ./releases/clean-debian-1.6.5-1*.noarch.rpm
```

> El nombre final puede incluir el identificador de la distribución (ej. `.fc42`). El comodín `*` contempla esa variante.

### Flatpak

```bash
flatpak install --user ./releases/LinuxCleaner-1.6.5.flatpak
flatpak run io.github.MartinAlejandroOviedo.LinuxCleaner
```

> Usa `flatpak-spawn` para ejecutar el limpiador en el host, por lo que solicita acceso al servicio `org.freedesktop.Flatpak`.

### Manual (cualquier distro)

```bash
sudo cp clean /usr/local/bin/clean
sudo chmod +x /usr/local/bin/clean
```

### Actualizar o desinstalar

Para actualizar, instalá el paquete nuevo con el mismo método. Para desinstalar:

| Método          | Comando                                                       |
| --------------- | ------------------------------------------------------------- |
| Debian/Ubuntu   | `sudo apt remove clean-debian`                                |
| Fedora/RHEL     | `sudo dnf remove clean-debian`                                |
| openSUSE        | `sudo zypper remove clean-debian`                             |
| Flatpak         | `flatpak uninstall --user io.github.MartinAlejandroOviedo.LinuxCleaner` |
| Manual          | `sudo rm /usr/local/bin/clean`                                |

---

## 🚀 Uso rapido

```bash
clean --all                  # TUI: escanea + progreso + confirmación + limpia
clean --all --yes            # Limpia todo sin preguntar (ideal para cron/scripts)
clean --all --dry-run        # Simulación: muestra qué haría sin borrar
clean --browsers --dev       # Solo tareas específicas
clean --status               # Reporte de espacio ocupado
clean --version              # Muestra la versión instalada
clean --help                 # Ayuda completa
```

---

## 📊 Progreso granular

Durante la limpieza, `clean` muestra dos niveles de avance:

- **Progreso global acumulado:** avanza entre modulos y dentro de cada lote sin
  reiniciarse ni retroceder; alcanza el 100% al finalizar el ultimo modulo.
- **Detalle granular:** actualiza una sola linea con el contador real de elementos
  procesados dentro de papeleras, miniaturas y caches de
  usuario, Gradle, npm, Cargo, pip, Yarn, Go, NVIDIA y Mesa.

En una terminal interactiva, la ultima fila queda reservada para la barra. Los
mensajes y resultados se desplazan por encima sin moverla; al finalizar o
interrumpir el comando, `clean` restaura automaticamente la terminal. Si la
salida se redirige a un archivo, utiliza texto normal sin regiones de pantalla.

Las operaciones de paquetes conservan la barra nativa de APT/dpkg. Los comandos
que no ofrecen un total medible, como `journalctl` o la gestion de swap, muestran
actividad sin inventar un porcentaje.

```text
Progreso global: [████████▓▒░░░░░░░░░░░░░░░░░]  75%  Cache npm (342/456)
```

---

## ⚡ Todas las opciones

| Flag | Opción          | Descripción                                                     |
| ---- | --------------- | --------------------------------------------------------------- |
| `-a` | `--all`         | **Todas las tareas** (escanea + pide confirmación)              |
| `-t` | `--temp`        | `/tmp` y `/var/tmp`                                             |
| `-c` | `--cache`       | Paquetes + huérfanos + configs residuales                       |
| `-l` | `--logs`        | Journald + logs comprimidos + **coredumps**                     |
| `-T` | `--trash`       | Papelera del usuario                                            |
| `-m` | `--thumbs`      | Miniaturas                                                      |
| `-b` | `--browsers`    | Caché de **22 navegadores**                                     |
| `-r` | `--ram`         | Page/buffer cache del kernel + **swap**                         |
| `-d` | `--drives`      | Papeleras + `.DS_Store` + `Thumbs.db` de discos montados        |
| `-u` | `--user-cache`  | `~/.cache/` + `~/.nv/` (NVIDIA) + `~/.mesa_shader_cache/`      |
| `-D` | `--dev`         | Gradle, npm, Cargo, pip, Yarn, Maven, Go, `node_modules/.cache` |
| `-j` | `--junk`        | `*.swp`, `*.bak`, `*.part`, `*.lock`, vacíos, `__pycache__`    |
| `-w` | `--wine`        | Temporales de Wine + Lutris + PlayOnLinux + Bottles             |
| `-M` | `--media`       | VLC, MPV, OBS, Kdenlive, GIMP, Krita, Audacity, etc.            |
| `-g` | `--games`       | Steam, Lutris, Heroic, Legionari, itch, RetroArch, Minecraft    |
| `-V` | `--venv`        | Entornos virtuales Python huérfanos + `pip cache purge`         |
| `-s` | `--status`      | Reporte `du -sh` de rutas clave                                 |
| `-n` | `--dry-run`     | Modo simulación (no borra nada)                                 |
| `-I` | `--interactive` | TUI con progreso y confirmación (implícito con `--all`)         |
| `-y` | `--yes`         | Omite la confirmación (útil con `--all` en scripts)             |
| `-v` | `--version`     | Muestra la versión instalada                                    |
| `-h` | `--help`        | Ayuda                                                           |

---

## 🛡️ Seguridad

- **Escaneo previo**: `--all` muestra qué encontró **antes** de borrar y pide confirmación.
- **TUI con progreso**: muestra fase, porcentaje y detalle durante búsqueda y borrado.
- **Modo simulación**: `--dry-run` imprime los comandos exactos que se ejecutarían.
- **Sin sudo innecesario**: tareas de usuario (papelera, miniaturas, navegadores) no piden privilegios.
- **Servicios en ejecución**: PulseAudio y PipeWire se omiten si están corriendo para no cortar el audio.
- **Display Managers**: solo se limpian si no hay sesión gráfica activa.
- **Regenerable**: todo lo que se borra es caché o temporal que el sistema vuelve a generar.
- **Historial**: registra cada limpieza en `~/.cache/clean-history.log`.

---

## 🧪 ¿Qué hace cada modulo?

<details>
<summary><strong><code>--temp</code></strong> — Archivos temporales</summary>

Limpia `/tmp` y `/var/tmp`, respetando sockets protegidos del sistema (X11, systemd).
</details>

<details>
<summary><strong><code>--cache</code></strong> — Cachés de paquetes</summary>

- **APT** (Debian/Ubuntu): `clean`, `autoclean`, `autoremove --purge`.
- **DNF** (Fedora): `clean all`, `autoremove`.
- **Pacman** (Arch): `-Sc`, metadatos de sincronización.
- **Portage** (Gentoo): temporales de compilación en `/var/tmp/portage`.
- **Configuraciones residuales**: purga paquetes en estado `rc` (desinstalados pero con restos).
- **Cachés regenerables**: fontconfig, man, thumbnails en `/var/cache`.
</details>

<details>
<summary><strong><code>--logs</code></strong> — Registros del sistema</summary>

- Rota y compacta journals de systemd (`--vacuum-time=3d`).
- Elimina logs comprimidos (`.gz`) y rotados (`.log.1`, etc.) de `/var/log`.
- Limpia **coredumps** (`/var/lib/systemd/coredump/`).
</details>

<details>
<summary><strong><code>--browsers</code></strong> — 22 navegadores</summary>

**Chromium/Blink:** Chrome, Chromium, Brave, Edge, Opera, Vivaldi, Falkon, Midori, Iridium, Slimjet, Dissenter, Ghostery, Epiphany, qutebrowser.

**Firefox/Gecko:** Firefox, LibreWolf, Floorp, Waterfox, Zen, Pale Moon, Basilisk, Tor Browser.

> Solo limpia caché de disco (Cache, Code Cache, GPUCache, ShaderCache, cache2, startupCache), sin tocar contraseñas, historial ni extensiones.
</details>

<details>
<summary><strong><code>--ram</code></strong> — Memoria RAM y swap</summary>

- `sync` + `drop_caches=3` para liberar page/buffer cache del kernel.
- `swapoff -a && swapon -a` para vaciar swap.
- Muestra uso de RAM antes y después con `free -h`.
</details>

<details>
<summary><strong><code>--drives</code></strong> — Discos montados</summary>

Busca discos montados en `/media`, `/mnt`, `/run/media` y `/home` y elimina:
- `.Trash-*` (papeleras Linux)
- `$RECYCLE.BIN` (papelera Windows)
- `Thumbs.db`, `.DS_Store` (metadatos de exploradores)
</details>

<details>
<summary><strong><code>--user-cache</code></strong> — Caché de usuario</summary>

- `~/.cache/` completo (vuelve a generarse bajo demanda).
- `~/.nv/` (NVIDIA shader cache).
- `~/.mesa_shader_cache/` (Mesa OpenGL/Vulkan).
</details>

<details>
<summary><strong><code>--dev</code></strong> — Herramientas de desarrollo</summary>

- Gradle (`~/.gradle/caches`)
- npm (`~/.npm/_cacache`)
- Cargo (`~/.cargo/registry/cache`)
- pip (`~/.cache/pip`)
- Yarn (`~/.yarn/cache`)
- Maven (solo `.jar` vacíos y `.lastUpdated` en `~/.m2/repository`)
- Go modules (`~/go/pkg/mod/cache`)
- `node_modules/.cache/` (webpack, babel, etc.)
</details>

<details>
<summary><strong><code>--junk</code></strong> — Archivos basura</summary>

Busca en `/tmp`, `/var/tmp`, `~/Downloads`, `~/Desktop`, `~/Documentos` y `~/Escritorio`:
- Patrones seguros: `*.swp`, `*.swo`, `*.bak`, `*.old`, `*.part`, `*.crdownload`, `*.unfinished`, `*.tmp`, `*.temp`, `*.lock`
- Archivos vacíos (0 KB)
- `__pycache__/` en todo `~` (bytecode de Python, se regenera solo)
</details>

<details>
<summary><strong><code>--wine</code></strong> — Aplicaciones Wine</summary>

- `~/.wine/drive_c/users/$USER/Temp/`
- `~/.wine/drive_c/users/$USER/AppData/Local/Temp/`
- `~/.wine/drive_c/users/$USER/AppData/Local/Microsoft/Windows/INetCache/`
- `~/.wine/drive_c/users/$USER/AppData/Local/CrashDumps/`
- `~/.wine/drive_c/windows/temp/`
- Búsqueda recursiva de `Temp`, `INetCache`, `CrashDumps` en prefixes de Lutris, PlayOnLinux y Bottles.
</details>

<details>
<summary><strong><code>--media</code></strong> — Aplicaciones multimedia</summary>

- **Audio:** PulseAudio, PipeWire (solo si no están corriendo)
- **Video y streaming:** VLC, MPV, GStreamer, FFmpeg, OBS.
- **Edición de video:** Kdenlive, Shotcut, OpenShot, Pitivi, HandBrake, DaVinci Resolve, Blender.
- **Fotografía e imagen:** GIMP, Krita, Inkscape, Darktable, RawTherapee, digiKam, Shotwell, gThumb, Nomacs, Pinta, MyPaint.
- **Audio y música:** Rhythmbox, Audacious, Clementine, DeaDBeeF, Audacity, Ardour, LMMS, Mixxx.
- **Residuos seguros:** cachés, thumbnails, proxies, logs, crash-reports y temporales regenerables.
- **Display Managers:** LightDM, SDDM, GDM (solo sin sesión gráfica activa)
</details>

<details>
<summary><strong><code>--games</code></strong> — Launchers y juegos</summary>

- **Steam:** `appcache/httpcache`, `config/htmlcache`, `logs`, `steamapps/shadercache`, `steamapps/temp`.
- **Launchers:** Lutris, Heroic Games Launcher, Legendary/Epic, itch, Bottles, Minigalaxy.
- **Emulación y juegos:** RetroArch, PrismLauncher, logs y crash-reports de Minecraft.

> No borra juegos instalados, partidas guardadas, prefixes de Wine/Proton ni descargas parciales.
</details>

<details>
<summary><strong><code>--venv</code></strong> — Entornos virtuales Python</summary>

- Detecta entornos virtuales Python buscando `pyvenv.cfg` + `bin/activate` en todo `$HOME`.
- Si el proyecto padre tiene `requirements.txt`, `pyproject.toml`, `setup.py`, `setup.cfg`, `Pipfile`, `Pipfile.lock` o `poetry.lock` → **activo** (solo se limpia cache interna de pip, no se borra el venv).
- Si el proyecto padre **no** tiene esos archivos → **huérfano** (se borra completo).
- Incluye `pip cache purge` para eliminar ruedas descargadas y HTTP cache.
- También detecta `node_modules/` sin `package.json` en el padre (huérfano de npm).
</details>

---

## 📋 Requisitos

- Linux con bash 4+
- Dependencias: `coreutils`, `findutils`, `util-linux`
- Opcional según módulo: `apt`, `dnf`, `pacman`, `sudo`
- Para construir DEB: `ar`, `tar` y `xz`
- Para construir RPM: `rpmbuild`
- Para construir Flatpak: `flatpak`, `flatpak-builder` y el runtime Freedesktop 25.08

---

## 🏗️ Construir paquetes

Los constructores toman la versión 1.6.5 del repositorio y dejan los resultados en `releases/`.

### Debian/Ubuntu

```bash
./packaging/build-deb.sh
dpkg-deb --info ./releases/clean-debian_1.6.5_all.deb
```

```
releases/clean-debian_1.6.5_all.deb
```

### Fedora/RHEL/openSUSE

En Fedora, instalá primero las herramientas de construcción:

```bash
sudo dnf install rpm-build
./packaging/build-rpm.sh
```

El script genera el RPM binario `noarch` y el RPM fuente.

### Flatpak

Con el SDK y runtime Freedesktop 25.08 instalados:

```bash
./packaging/build-flatpak.sh
```

```
releases/LinuxCleaner-1.6.5.flatpak
```

El manifiesto está en `packaging/flatpak/io.github.MartinAlejandroOviedo.LinuxCleaner.yml` y utiliza el identificador `io.github.MartinAlejandroOviedo.LinuxCleaner`.

### Estructura de packaging

```
packaging/
├── build-deb.sh
├── build-rpm.sh
├── build-flatpak.sh
├── rpm/
│   └── clean-debian.spec
└── flatpak/
    ├── clean-debian-flatpak
    ├── io.github.MartinAlejandroOviedo.LinuxCleaner.yml
    ├── io.github.MartinAlejandroOviedo.LinuxCleaner.desktop
    └── io.github.MartinAlejandroOviedo.LinuxCleaner.metainfo.xml
```

---

## 📄 Licencia

Distribuido bajo la licencia MIT. Consultá el archivo [LICENSE](LICENSE).

---

¿Encontraste un bug o tenés una idea? Abrí un issue o mandá un PR en [GitHub](https://github.com/MartinAlejandroOviedo/LinuxCleaner).

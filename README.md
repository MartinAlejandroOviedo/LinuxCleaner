# 🧹 Linux Cleaner

**`clean`** es un comando para Debian que limpia archivos temporales, cachés, logs, papeleras y configuraciones residuales del sistema. Rápido, seguro y con modo simulación.

![Static Badge](https://img.shields.io/badge/debian-%3E%3D%2012-blue?logo=debian)
![Static Badge](https://img.shields.io/badge/license-MIT-green)
![Static Badge](https://img.shields.io/badge/version-1.0.0-white)

## 📦 Instalación

### Desde el paquete `.deb`

```bash
sudo apt install ./pkg/clean-debian_1.0.0_all.deb
```

### Manual

```bash
sudo cp clean /usr/local/bin/clean
sudo chmod +x /usr/local/bin/clean
```

## 🚀 Uso

```bash
clean --all                # limpieza completa (recomendado)
clean --all --dry-run      # simulacion, muestra que haria sin borrar
clean --cache --browsers   # solo tareas especificas
clean --help               # ayuda
```

![Screenshot from 2025-07-14 19-45-23](https://github.com/user-attachments/assets/a4f362a1-aa5c-45cd-8208-21f3242616ed)

## ⚡ Opciones

| Flag | Opción | Descripción |
|------|--------|-------------|
| `-a` | `--all` | Todas las tareas |
| `-t` | `--temp` | `/tmp` y `/var/tmp` |
| `-c` | `--cache` | Caché de APT, paquetes huérfanos, configuraciones residuales (`rc`), `/var/cache` segura |
| `-l` | `--logs` | Journald logs y logs comprimidos de `/var/log` |
| `-T` | `--trash` | Papelera del usuario (`~/.local/share/Trash`) |
| `-m` | `--thumbs` | Miniaturas y cachés de usuario |
| `-b` | `--browsers` | Caché de Firefox, Chrome, Chromium, Brave, Edge, Opera, Vivaldi |
| `-r` | `--ram` | Libera page/buffer cache del kernel (RAM, sin borrar datos) |
| `-d` | `--drives` | Papeleras (`.Trash-*`, `$RECYCLE.BIN`) de discos montados en `/media`, `/mnt`, `/home` |
| `-n` | `--dry-run` | Modo simulación (no borra nada) |
| `-h` | `--help` | Ayuda |

## 🧪 ¿Qué hace cada tarea?

### `--temp`
Limpia los directorios de archivos temporales del sistema (`/tmp`, `/var/tmp`), respetando los directorios protegidos del sistema como los sockets de X11 y systemd.

### `--cache`
- Ejecuta `apt-get clean`, `autoclean` y `autoremove --purge` para eliminar paquetes descargados y dependencias huérfanas.
- **Purga configuraciones residuales**: detecta paquetes en estado `rc` (desinstalados pero con restos de configuración) y los elimina completamente, liberando espacio que `autoremove` no alcanza.
- Limpia cachés regenerables de `/var/cache` (fontconfig, man, thumbnails).

### `--logs`
- Rota y compacta los journals de systemd (`journalctl --rotate --vacuum-time=3d`).
- Elimina logs comprimidos (`.gz`) y logs rotados antiguos de `/var/log`.

### `--browsers`
Limpia la caché de disco de los principales navegadores sin tocar contraseñas, historial ni extensiones:
- **Firefox** → cache2 y startupCache de cada perfil
- **Chrome / Chromium / Brave / Edge / Opera / Vivaldi** → Cache, Code Cache, GPUCache, ShaderCache por perfil

### `--ram`
Ejecuta `sync` y luego `echo 3 > /proc/sys/vm/drop_caches` para liberar la page cache y buffer cache del kernel. No borra datos reales: el kernel vuelve a poblar la caché bajo demanda. Muestra el uso de RAM antes y después con `free -h`.

### `--drives`
Busca unidades montadas en `/media`, `/mnt`, `/run/media` y `/home` y elimina:
- Papeleras de Linux (`.Trash-1000`, `.Trash-0`, etc.)
- Papeleras de Windows (`$RECYCLE.BIN`)
- Archivos `Thumbs.db` de Windows

No toca los archivos personales del usuario.

### `--all`
Ejecuta **todas** las tareas anteriores en el orden óptimo. Con `--dry-run` podés ver exactamente qué haría antes de ejecutarlo.

## 🛡️ Seguridad

- **Sin borrados ciegos**: cada tarea actúa solo sobre rutas específicas y seguras.
- **Modo simulación**: `--dry-run` imprime los comandos exactos que se ejecutarían.
- **Sin sudo innecesario**: las tareas de usuario (papelera, miniaturas, navegadores) no piden privilegios.
- **Regenerable**: todo lo que se borra es caché o temporal que el sistema regenera solo.

## 📋 Requisitos

- Debian 12+ (Bookworm, Trixie o superior)
- Dependencias: `coreutils`, `findutils`, `util-linux`, `apt` (todas vienen preinstaladas)

## 🏗️ Construir el paquete `.deb`

```bash
dpkg-deb --build pkg/clean-debian pkg/clean-debian_1.0.0_all.deb
```

## 📄 Licencia

MIT — hacé lo que quieras, no me hago responsable.

---

¿Encontraste un bug o tenés una idea? ¡Abrí un issue o mandá un PR!

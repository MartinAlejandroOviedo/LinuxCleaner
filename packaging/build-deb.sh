#!/usr/bin/env bash
set -euo pipefail

version="1.6.5"
project_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
package_root="$project_root/pkg/clean-debian"
work_dir=$(mktemp -d)
output="$project_root/releases/clean-debian_${version}_all.deb"
trap 'find "$work_dir" -depth -delete 2>/dev/null || true' EXIT

for tool in ar tar xz; do
  command -v "$tool" >/dev/null 2>&1 || {
    printf 'Error: falta la herramienta %s\n' "$tool" >&2
    exit 1
  }
done

mkdir -p "$project_root/releases"
tar --owner=0 --group=0 -C "$package_root/DEBIAN" -cJf "$work_dir/control.tar.xz" .
tar --owner=0 --group=0 -C "$package_root" \
  --exclude=DEBIAN --exclude=debian-binary -cJf "$work_dir/data.tar.xz" .
cp "$package_root/debian-binary" "$work_dir/debian-binary"

[ ! -e "$output" ] || find "$output" -delete
(
  cd "$work_dir"
  ar rcs "$output" debian-binary control.tar.xz data.tar.xz
)

printf 'Paquete Debian creado: %s\n' "$output"

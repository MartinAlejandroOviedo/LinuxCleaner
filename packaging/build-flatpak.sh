#!/usr/bin/env bash
set -euo pipefail

version="1.6.4"
app_id="io.github.MartinAlejandroOviedo.LinuxCleaner"
project_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
build_dir=$(mktemp -d)
repo_dir=$(mktemp -d)
output="$project_root/releases/LinuxCleaner-${version}.flatpak"
trap 'find "$build_dir" "$repo_dir" -depth -delete 2>/dev/null || true' EXIT

for tool in flatpak flatpak-builder; do
  command -v "$tool" >/dev/null 2>&1 || {
    printf 'Error: falta %s\n' "$tool" >&2
    exit 1
  }
done

mkdir -p "$project_root/releases"
[ ! -e "$output" ] || find "$output" -delete
flatpak-builder --force-clean --repo="$repo_dir" "$build_dir" \
  "$project_root/packaging/flatpak/${app_id}.yml"
flatpak build-bundle "$repo_dir" "$output" "$app_id" stable
printf 'Paquete Flatpak creado: %s\n' "$output"

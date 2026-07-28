#!/usr/bin/env bash
set -euo pipefail

version="1.6.5"
project_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
topdir=$(mktemp -d)
source_dir="$topdir/clean-debian-$version"
trap 'find "$topdir" -depth -delete 2>/dev/null || true' EXIT

command -v rpmbuild >/dev/null 2>&1 || {
  printf 'Error: falta rpmbuild. En Fedora: sudo dnf install rpm-build\n' >&2
  exit 1
}

mkdir -p "$topdir"/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS} "$source_dir"
cp "$project_root/clean" "$project_root/README.md" "$project_root/CHANGELOG.md" \
  "$project_root/LICENSE" "$source_dir/"
mkdir -p "$source_dir/pkg/clean-debian/usr/share/applications"
cp "$project_root/pkg/clean-debian/usr/share/applications/clean-debian.desktop" \
  "$source_dir/pkg/clean-debian/usr/share/applications/"
tar -C "$topdir" -czf "$topdir/SOURCES/clean-debian-$version.tar.gz" \
  "clean-debian-$version"
cp "$project_root/packaging/rpm/clean-debian.spec" "$topdir/SPECS/"

rpmbuild --define "_topdir $topdir" -ba "$topdir/SPECS/clean-debian.spec"
mkdir -p "$project_root/releases"
find "$topdir/RPMS" -type f -name '*.rpm' -exec cp {} "$project_root/releases/" \;
find "$topdir/SRPMS" -type f -name '*.rpm' -exec cp {} "$project_root/releases/" \;
printf 'Paquetes RPM creados en %s/releases\n' "$project_root"

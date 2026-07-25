Name:           clean-debian
Version:        1.6.4
Release:        1%{?dist}
Summary:        Limpiador de archivos temporales y residuales para Linux
License:        MIT
URL:            https://github.com/MartinAlejandroOviedo/LinuxCleaner
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch

Requires:       bash
Requires:       coreutils
Requires:       findutils
Requires:       util-linux
Recommends:     sudo

%description
Linux Cleaner elimina de forma interactiva archivos temporales, caches,
logs y otros datos regenerables en distribuciones Linux.

%prep
%autosetup

%build

%install
install -Dm0755 clean %{buildroot}%{_bindir}/clean
install -Dm0644 pkg/clean-debian/usr/share/applications/clean-debian.desktop \
  %{buildroot}%{_datadir}/applications/clean-debian.desktop

%files
%license LICENSE
%doc README.md CHANGELOG.md
%{_bindir}/clean
%{_datadir}/applications/clean-debian.desktop

%changelog
* Fri Jul 24 2026 Martin <martin@debian> - 1.6.4-1
- Agregar salida de version y paquetes RPM/Flatpak.

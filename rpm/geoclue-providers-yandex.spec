Name: geoclue-provider-yandex
Version: 0.2.0
Release: 1
Summary: Geoinformation Service from Yandex Location Services Database Provider
Group: System/Libraries
URL: https://github.com/neochapay/geoclue-providers-yandex
License: LGPLv2.1
Source0: %{name}-%{version}.tar.gz
Source1: %{name}.privileges
BuildRequires: pkgconfig(Qt5Core)
BuildRequires: pkgconfig(Qt5DBus)
BuildRequires: pkgconfig(Qt5Network)
BuildRequires: pkgconfig(qofono-qt5)
BuildRequires: pkgconfig(qofonoext)
BuildRequires: pkgconfig(connman-qt5)
BuildRequires: pkgconfig(qt5-boostable)
BuildRequires: pkgconfig(mlite5)
Requires: mapplauncherd-qt5

%description
%{summary}.


%prep
%setup -q -n %{name}-%{version}


%build
qmake -qt=5 geoclue-providers-yandex.pro
make %{?_smp_mflags}


%install
make INSTALL_ROOT=%{buildroot} install

mkdir -p %{buildroot}%{_datadir}/mapplauncherd/privileges.d
install -m 644 -p %{SOURCE1} %{buildroot}%{_datadir}/mapplauncherd/privileges.d/

%files
%defattr(-,root,root,-)
%{_libexecdir}/geoclue-yandex
%{_datadir}/mapplauncherd/privileges.d/*
%{_datadir}/dbus-1/services/org.freedesktop.Geoclue.Providers.Yandex.service
%{_datadir}/geoclue-providers/geoclue-yandex.provider

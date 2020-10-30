TARGET = geoclue-yandex
CONFIG   += console
CONFIG   -= app_bundle
TEMPLATE = app

target.path = /usr/libexec

QT = core dbus network

CONFIG += link_pkgconfig
PKGCONFIG += qofono-qt5 qofonoext connman-qt5 mlite5

LIBS += -lrt

packagesExist(qt5-boostable) {
    DEFINES += HAS_BOOSTER
    PKGCONFIG += qt5-boostable
} else {
    warning("qt5-boostable not available; startup times will be slower")
}

# not installed
dbus_geoclue.files = \
    org.freedesktop.Geoclue.xml \
    org.freedesktop.Geoclue.Position.xml
dbus_geoclue.header_flags = "-l YandexProvider -i yandexprovider.h"
dbus_geoclue.source_flags = "-l YandexProvider"

DBUS_ADAPTORS = \
    dbus_geoclue

# installed
session_dbus_service.files = org.freedesktop.Geoclue.Providers.Yandex.service
session_dbus_service.path = /usr/share/dbus-1/services
geoclue_provider.files = geoclue-yandex.provider
geoclue_provider.path = /usr/share/geoclue-providers

include (../common/common.pri)
HEADERS += \
    yandexonlinelocator.h \
    locationtypes.h \
    yandexprovider.h

SOURCES += \
    main.cpp \
    yandexonlinelocator.cpp \
    yandexprovider.cpp

OTHER_FILES = \
    $${dbus_geoclue.files} \
    $${session_dbus_service.files} \
    $${geoclue_provider.files}

INSTALLS += target session_dbus_service geoclue_provider

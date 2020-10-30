/*
    Copyright (C) 2016 Jolla Ltd.
    Contact: Chris Adams <chris.adams@jollamobile.com>
    Copyright (C) 2020 Chupligin Sergey <neochapay@gmail.com>

    This file is part of geoclue-yandex based on geoclue-mlsdb.

    geoclue-yandex is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License.
*/

#include <QtCore/QCoreApplication>
#include <QtCore/QLoggingCategory>
#include <QtDBus/QDBusConnection>

#include "yandexprovider.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    YandexProvider provider;
    QDBusConnection connection = QDBusConnection::sessionBus();
    if (!connection.registerObject(QStringLiteral("/org/freedesktop/Geoclue/Providers/Yandex"), &provider))
        qFatal("Failed to register object /org/freedesktop/Geoclue/Providers/Yandex - is another instance of the plugin already running?");
    if (!connection.registerService(QStringLiteral("org.freedesktop.Geoclue.Providers.Yandex")))
        qFatal("Failed to register service org.freedesktop.Geoclue.Providers.Yandex - is another instance of the plugin already running?");
    return a.exec();
}

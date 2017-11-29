#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "maincontroller.h"

// Main entry point
// Start-up sequence:
// - Splash Screen (@todo)
// - Load Core Service (@todo)
// - Load UI Service (@todo)
// - Load UI Apps (@todo)
// - Display the main UI
// - Launch external UIs (@todo)
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    // Create the engine and load the main qml
    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    QObject *item = engine.rootObjects()[0];

    // Create the Controller to handle View events
    MainController maincontroller;

    // Connect the signals
    QObject::connect(item, SIGNAL(menuItemSelected(QString)),
                     &maincontroller, SLOT(menuItemSelectedSlot(QString)));

    // Execute the main loop
    int ret = app.exec();

    // Disconnect the signals
    QObject::disconnect(item, SIGNAL(menuItemSelected(QString)),
                        &maincontroller, SLOT(menuItemSelectedSlot(QString)));

    // ret from app.exec()
    return ret;
}

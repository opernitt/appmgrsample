#include "maincontroller.h"
#include <QDebug>

// The Controller used to handle UI events
MainController::MainController(QObject *parent) : QObject(parent)
{
}

// A Menu item was selected on the UI
void MainController::menuItemSelectedSlot(QString item)
{
    qDebug() << "Menu Item selected: " << item;
}

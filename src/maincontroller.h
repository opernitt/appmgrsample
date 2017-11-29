#ifndef MAINCONTROLLER_H
#define MAINCONTROLLER_H

#include <QObject>

// The Controller used to handle UI events
class MainController : public QObject
{
    Q_OBJECT
public:
    explicit MainController(QObject *parent = nullptr);

signals:

    // Public slots used to handle signals from the UI
public slots:
    void menuItemSelectedSlot(QString item);
};

#endif // MAINCONTROLLER_H

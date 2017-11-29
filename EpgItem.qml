import QtQuick 2.0
import QtQuick.Layouts 1.3

// An EPG Item
Item {
    property var title
    property var desc
    property var icon
    property var start
    property var duration

    Rectangle {
        width: Math.min(duration, 32)
        height: 32
        //anchors.fill: parent

        ColumnLayout {
            Text {
                text: title
            }
            Text {
                text: desc
            }
        }
    }
}

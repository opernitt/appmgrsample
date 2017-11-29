import QtQuick 2.0

// A simple Menu Button, which should be visually enhanced
Rectangle {
    color: "gray"
    property var text

    Text {
        anchors.centerIn: parent
        font.family: "Helvetica"
        font.pointSize: 20
        text: parent.text
    }

    MouseArea {
        anchors.fill: parent
        onReleased: {
            //console.log("Menu Item selected: \"" + text + "\"")
            menuItemSelected(text)
        }
    }
}

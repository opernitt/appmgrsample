import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    property var title
    property var desc
    property var logo
    id: epgDetail
    border.color: "black"
    border.width: 2

    anchors.fill: parent
    anchors.topMargin: 25
    anchors.bottomMargin: 25
    anchors.rightMargin: 25
    anchors.leftMargin: 25
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#FF0000ff" }
        GradientStop { position: 0.2; color: "#c00000ff" }
        GradientStop { position: 0.8; color: "#c00000ff" }
        GradientStop { position: 1.0; color: "#FF0000ff" }
    }

    Text {
        text: title
        font.family: "Helvetica"
        font.pointSize: 14
        x: 16
        y: 16
        color: "white"
    }

    Image {
        x: 16
        y: 48
        source: logo
    }

    Text {
        text: desc
        font.family: "Helvetica"
        font.pointSize: 12
        x: 172
        y: 45
        width: parent.width - x - 16
        height: parent.height - y - 16
        wrapMode: Text.WordWrap
        color: "white"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            //console.log("EPG Item de-selected: \"" + title + "\"")
            epgDetail.destroy()
        }
    }
}

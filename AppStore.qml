import QtQuick 2.0

// A sample UI (AppStore), to be completed
Item {
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#FF0000ff" }
            GradientStop { position: 0.2; color: "#800000ff" }
            GradientStop { position: 0.8; color: "#800000ff" }
            GradientStop { position: 1.0; color: "#FF0000ff" }
        }

        Text {
            text: qsTr("AppStore")
            anchors.centerIn: parent
        }
    }
}

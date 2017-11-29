import QtQuick 2.7
import QtQuick.Controls 1.4

// Holds the page layout:
// MENU BAR
// MAIN VIEW
Item {
    // The main view area using Loader to be able to
    // load pages from qrc:
    Loader {
        id: mainView
        x: 0
        y: 0
        width: parent.width
        height: parent.height - y
        sourceComponent: defaultBackground

        states: [
            // Loader State to indicate when a new screen was loaded
            State {
                name: 'loaded'
                when: mainView.status == Loader.Ready
            }
        ]
    }

    // Overlay the screen in order to support a menu or OSD
    Rectangle {
        id: screenView
        anchors.fill: parent
        color: "#00000000"

        // The menu view area
        Rectangle {
            id: menuView
            anchors.left: screenView.left
            anchors.leftMargin: 10
            anchors.top: screenView.top
            width: screenView.width-2*anchors.leftMargin

            MainMenu {
                x: 0
                y: 0
                height: 64
                width: parent.width
            }
        }
    }

    // The default background set up as a Loader Component
    Component {
        id: defaultBackground
        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#FF000000" }
                GradientStop { position: 0.2; color: "#80000000" }
                GradientStop { position: 0.8; color: "#80000000" }
                GradientStop { position: 1.0; color: "#FF000000" }
            }

            Text {
                text: qsTr("Press SPACE for menu -- BACK to return to this screen")
                anchors.centerIn: parent
            }
        }
    }
}

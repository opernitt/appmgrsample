import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

// The main App window
ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("AppMgr")
    id: appWindow

    // A Swipe View containing the main screen and Settings
    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        focus: true

        // Activate the menu bar with Space
        Keys.onSpacePressed: {
            menuActivated()
        }

        // Return to the previous screen using Back or Escape
        Keys.onPressed: {
            switch (event.key) {
            case Qt.Key_Backspace:
            case Qt.Key_Back:
            case Qt.Key_Escape:
                event.accepted = true
                backPressed()
            }
        }

        /*Keys.onPressed: {
            console.log("SV: Key pressed: " + event.key);
        }

        Keys.onReleased: {
            console.log("SV: Key released: " + event.key);
        }*/

        Page1 {
        }

        Settings {
        }
    }

    // The TabBar at the bottom also controls the SwipeView above
    // If the user clicks here, Key events will be received here
    // and must be forwarded to be handled correctly (see below)
    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            id: mainTabBar
            text: qsTr("Main")
        }
        TabButton {
            text: qsTr("Settings")
        }

        // Forward Keys to swipeView (if the user clicks this TabBar)
        Keys.forwardTo: [swipeView]
    }

    // Signals
    signal menuItemSelected(string item)    // Menu item is selected
    signal menuActivated()                  // Menu is activated
    signal backPressed()                    // Close the current screen
}

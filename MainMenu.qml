import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    color: "white"
    id: menuContainer

    // The (translatable) menu items
    property var menuItems: [ qsTr("EPG"), qsTr("AppStore"), qsTr("Settings"), qsTr("Hide") ]
    property var menuVisible: true

    MouseArea {
        anchors.fill: parent
        height: 64

        property var startY: 0
        property var curCol: false

        /*onClicked: {
            console.log("Clicked: (" + mouse.x + ", " + mouse.y + "). startY = " + startY)
            if (curCol)
                parent.color = 'red'
            else
                parent.color = 'blue'
            curCol = !curCol
        }*/

        onPressed: {
            startY = mouse.y
        }

        onReleased: {
            if ((mouse.y > startY) && (mouse.y-15 > startY))
                showMenu(true)
            else if (mouse.y+15 < startY)
                showMenu(false)
        }
    }

    // The menu bar items in a RowLayout
    RowLayout {
        Layout.preferredHeight: menuContainer.height / 2
        Layout.alignment: Layout.Center
        Layout.fillWidth: true
        anchors.fill: parent
        spacing: 6

        MenuButton {
            Layout.minimumWidth: 100
            Layout.preferredWidth: 120
            Layout.maximumWidth: 180
            Layout.minimumHeight: 32
            text: menuItems[0]
        }

        MenuButton {
            Layout.minimumWidth: 100
            Layout.preferredWidth: 120
            Layout.maximumWidth: 180
            Layout.minimumHeight: 32
            text: menuItems[1]
        }

        MenuButton {
            Layout.minimumWidth: 100
            Layout.preferredWidth: 120
            Layout.maximumWidth: 180
            Layout.minimumHeight: 32
            text: menuItems[2]
        }

        MenuButton {
            Layout.minimumWidth: 100
            Layout.preferredWidth: 120
            Layout.maximumWidth: 180
            Layout.minimumHeight: 32
            text: menuItems[3]
        }
    }

    // Menu bar animation (ease up/down)
    Behavior on y {
        NumberAnimation {
            duration: 180; easing.type: Easing.OutQuad
        }
    }

    // Hide the menu at start-up
    Timer {
        id: menuTimer
        interval: 100
        running: true
        onTriggered: {
            showMenu(false)
        }
    }

    // Signal slots
    Connections {
        target: appWindow

        // Handle the menu selection and hide the menu
        onMenuItemSelected: {

            // Special handline for Settings (swipe)
            if (item == "Settings")
                swipeView.incrementCurrentIndex();
            else if (item != "Hide")
                mainView.source = "qrc:/" + item + ".qml"
            showMenu(false)
        }

        // Display the menu bar
        onMenuActivated: {
            showMenu(true)
        }

        // Clear the current component and restore the default background
        onBackPressed: {
            mainView.sourceComponent = defaultBackground
        }
    }

    // Show/hide the menu
    function showMenu(setMenuVisible) {
        if (setMenuVisible != menuVisible) {
            menuContainer.y = setMenuVisible ? menuContainer.height/4 : -menuContainer.height
            menuVisible = setMenuVisible
        }
    }

    // Toggle the menu visibility
    function toggleMenu() {
        showMenu(!menuVisible)
    }
}

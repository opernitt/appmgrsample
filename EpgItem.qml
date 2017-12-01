import QtQuick 2.0
import QtQuick.Layouts 1.3

// An EPG Item
Item {
    property var title
    property var desc
    property var logo
    property var start
    property var duration

    Rectangle {
        //width: Math.min(duration, 32)
        //height: 32
        anchors.fill: parent
        color: "blue"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("EPG Item selected: \"" + title + "\"")
                showDetails(title, desc, logo)
            }
        }

        ColumnLayout {
            Text {
                //anchors.fill: parent
                width: parent.width
                height: parent.height
                wrapMode: Text.WordWrap
                text: title
                color: "white"
            }
            Text {
                //anchors.fill: parent
                width: parent.width
                height: parent.height
                wrapMode: Text.WordWrap
                maximumLineCount: 2
                text: desc
                color: "white"
                //Component.onCompleted: print(x, y, width, height)
            }
        }
    }

    function showDetails(title, desc, logo) {
        var compSrc = "import QtQuick 2.0;" +
                "EpgDetail {" +
                "title: \"" + title + "\";" +
                "desc: \"" + desc + "\";" +
                "logo: \"" + logo + "\";" +
                "}\n"
        print(compSrc)

        // Create the EPG Detail view
        Qt.createQmlObject(compSrc, mainContainer)
    }
}

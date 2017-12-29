import QtQuick 2.0
import QtQuick.Layouts 1.3
import FileIO 1.0

// A sample UI (EPG Guide) populated from a Json file (qrc:/epgdata.json)
//
Item {
    property int timeSlice: 5   // Each Grid unit represents 5 minutes
    property int timeSpan: 120  // The Grid displays 120 minutes
    property int gridWidth: 540 // The grid width in pixels (programs without the logos)

    Rectangle {
        id: mainContainer
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#FF0000ff" }
            GradientStop { position: 0.2; color: "#800000ff" }
            GradientStop { position: 0.8; color: "#800000ff" }
            GradientStop { position: 1.0; color: "#FF0000ff" }
        }

        // Dynamically generate the EPG Grid contents
        Component.onCompleted: setupGrid()
    }

    // Link to the EPG data file within the resource
    FileIO {
        id: jsonFile
        source: ""
        onError: console.log(msg)
    }

    // I am using a GridLayout here to allow for automatic resizing.
    // On an embedded device, the screen would likely not be
    // resizable and a more static approach could be more efficient.
    // The grid spans 120 minutes and displays 5 minute increments.
    // A more elegant approach could be to implement the dynamic code
    // creation in C++ but that would not separate the UI
    // from the business logic
    function setupGrid() {
        var compSrc = "import QtQuick 2.0; import QtQuick.Layouts 1.3;" +
            "GridLayout {" +
            "id: epgGrid;" +
            "anchors.topMargin: 20;" +
            "anchors.bottomMargin: 20;" +
            "anchors.rightMargin: 20;" +
            "anchors.leftMargin: 20;" +
            "anchors.fill: parent;" +
            "columnSpacing: 0;" +
            "rowSpacing: 1;" +
            "rows: 10\;" +
            "columns: 25\n" + // 5 minute slices over 120 minutes, plus the logos
            "Text {" +
            "text: qsTr(\"EPG Guide\");" +
            "font.family: \"Helvetica\";" +
            "font.pointSize: 20;" +
            "Layout.row: 0;" +
            "Layout.column: 0;" +
            "Layout.columnSpan: 25;" +
            "}\n"

        // Add the timeline
        compSrc += addTimeline()

        // Process the EPG data
        compSrc += processEpgData()

        // Complete the GridLayout
        compSrc += "}"
        //print (compSrc)

        // Create the EPG Grid
        Qt.createQmlObject(compSrc, mainContainer)
    }

    // Add the timeline
    function addTimeline() {
        var compSrc = "Text { height: 20; width: 140; text: qsTr(\"11:30\"); font.family: \"Helvetica\"; font.pointSize: 12; Layout.row: 1; Layout.column: 1; Layout.columnSpan: 6 }\n" +
                "Text { height: 20; width: 140; text: qsTr(\"12:00\"); font.family: \"Helvetica\"; font.pointSize: 12; Layout.row: 1; Layout.column: 7; Layout.columnSpan: 6 }\n" +
                "Text { height: 20; width: 140; text: qsTr(\"12:30\"); font.family: \"Helvetica\"; font.pointSize: 12; Layout.row: 1; Layout.column: 13; Layout.columnSpan: 6 }\n" +
                "Text { height: 20; width: 140; text: qsTr(\"1:00\"); font.family: \"Helvetica\"; font.pointSize: 12; Layout.row: 1; Layout.column: 19; Layout.columnSpan: 6 }\n"
        return compSrc
    }

    function processEpgData() {
        var compSrc = ""

        // Read the context of the Json data and parse it
        var raw = readJsonFile(":/epgdata.json")

        try {
            var jsonData = JSON.parse(raw);
            //print(jsonData)

            var epgdata = jsonData["epgdata"]
            var stations = epgdata["stations"]

            // Add the station logos and programming
            for (var cnt = 0; cnt < stations.length; cnt++) {
                compSrc += addStation(cnt+2, stations[cnt]["logo"])

                // Add the programs
                var programs = stations[cnt]["programs"]
                var column = 1
                var columnSpan = 0
                for (var cnt2 = 0; cnt2 < programs.length; cnt2++) {
                    var duration = programs[cnt2]["duration"]
                    var start = programs[cnt2]["start"]
                    var title = programs[cnt2]["title"]
                    var desc = programs[cnt2]["description"]
                    var logo = programs[cnt2]["logo"]
                    column += columnSpan
                    columnSpan = (start < 0) ? (duration + start) / timeSlice : duration / timeSlice
                    print(column, columnSpan, start, duration, title)
                    compSrc += addProgram(cnt+2, column, columnSpan, title, desc, logo)
                }
            }
        }
        catch (e) {
            console.log(e)
        }

        // Return the completed Item(s)
        return compSrc
    }

    // Add a station logo
    function addStation(row, url) {
        var compSrc = "Rectangle {" +
                "color: \"white\";" +
                "Layout.row: " + row + ";" +
                "Layout.column: 0;" +
                "Layout.columnSpan: 1;" +
                "Layout.minimumHeight: 60;" +
                "Layout.minimumWidth: 80\n" +
                "Image {" +
                "source: \"" + url + "\";" +
                "height: 60;" +
                "fillMode: Image.PreserveAspectFit" +
                "}" +
                "}\n"
        return compSrc
    }

    // Add the program
    function addProgram(row, column, columnSpan, title, desc, logo)
    {
        var width = timeSpan / timeSlice

        // Make sure the item fits
        if ((column - 1) >= width)
            return ""
        //print("width:", width, "span:", columnSpan)

        // Adjust the item's width, if necessary
        if ((column + columnSpan - 1) > width)
            columnSpan = width - (column - 1)
        //print("width:", width, "span:", columnSpan)

        // Translate the columnSpan to a physical width
        width = Math.round(gridWidth * columnSpan / width)

        // Add the EPG Item
        var compSrc = "EpgItem {" +
                "Layout.row: " + row + ";" +
                "Layout.column: " + column + ";" +
                "Layout.columnSpan: " + columnSpan + ";" +
                "Layout.minimumHeight: 60;" +
                "Layout.minimumWidth: " + width + ";" +
                "Layout.maximumWidth: " + width + ";" +
                "title: \"" + title + "\";" +
                "desc: \"" + desc + "\";" +
                "logo: \"" + logo + "\";" +
                "}\n"
        return compSrc
    }

    // There was an issue loading the json file from qrc:/
    // QFile.open() failed and I saw an error:
    // Unable to open the file
    // The fix is to use :/, without the qrc prefix
    // See http://doc.qt.io/qt-5/resources.html
    function readJsonFile(url) {
        jsonFile.setSource(url)
        var data = jsonFile.read();
        //print(data);

        // Use canned Json data if the file could not be read
        if (!data.length)
            data = '
{
    "epgdata":
    {
        "date": 58087,
        "time": 690,
        "span": 120,
        "slice": 5,
        "desc": "Sample EPG Guide Data from 11/30/2017, starting at 11:30am. The guide is set to display 2 hours. Data/logos source: tv.com/tv-logo.com.",
        "stations":
        [
            {
                "name": "ABC",
                "logo": "http://www.tv-logo.com/pt-data/uploads/images/logo/abc_hd.jpg",
                "programs":
                [
                    {
                        "title": "ABC7 News 11:00AM",
                        "description": "Local news, sports and weather.",
                        "logo": "http://img2.tvtome.com/i/tvp/sm/204274.jpg",
                        "duration": 60,
                        "start": -30
                    }
                ]
            },
            {
                "name": "CBS",
                "logo": "http://www.tv-logo.com/pt-data/uploads/images/logo/cbs.jpg",
                "programs":
                [
                    {
                        "title": "The Young and the Restless - 11-30-2017",
                        "description": "Cane receives devastating news; Jack shares a warm moment with Dina; Ashley makes a surprising move.",
                        "logo": "http://img2.tvtome.com/i/tvp/sm/100.jpg",
                        "duration": 60,
                        "start": -30
                    }
                ]
            },
            {
                "name": "NBC",
                "logo": "http://www.tv-logo.com/pt-data/uploads/images/logo/nbc_hd.jpg",
                "programs":
                [
                    {
                        "title": "NBC Bay Area News at 11AM",
                        "description": "Local news, sports and weather.",
                        "logo": "http://img2.tvtome.com/i/tvp/sm/204274.jpg",
                        "duration": 60,
                        "start": -30
                    }
                ]
            },
            {
                "name": "A&E HD",
                "logo": "http://www.tv-logo.com/pt-data/uploads/images/logo/ae_hd.jpg",
                "programs":
                [
                ]
            },
            {
                "name": "Animal Planet HD",
                "logo": "http://www.tv-logo.com/pt-data/uploads/images/logo/animal_planet_us_hd.jpg",
                "programs":
                [
                ]
            },
            {
                "name": "Discovery Science",
                "logo": "http://www.tv-logo.com/pt-data/uploads/images/logo/discovery_science.jpg",
                "programs":
                [
                ]
            }
        ]
    }
}'
        return data
    }
}

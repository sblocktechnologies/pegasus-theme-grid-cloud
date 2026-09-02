import QtQuick 2.6

Item {
    property string platformShortName: ""
    property string platformName: platformShortName
    property bool isOnTop: false

    Rectangle {
        anchors.centerIn: parent
        width: Math.min(parent.width - vpx(12), label.width + vpx(42))
        height: vpx(38)
        radius: height / 2
        color: parent.isOnTop ? "#19334a" : "transparent"
        border { color: parent.isOnTop ? "#42c8ff" : "transparent"; width: 1 }

        Text {
            id: label
            anchors.centerIn: parent
            text: parent.parent.platformName || parent.parent.platformShortName
            color: parent.parent.isOnTop ? "#f4fbff" : "#71808d"
            font {
                bold: parent.parent.isOnTop
                capitalization: Font.AllUppercase
                pixelSize: vpx(15)
                letterSpacing: 1.1
                family: globalFonts.sans
            }
        }
    }
}

import QtQuick 2.6
import "qrc:/qmlutils" as PegasusUtils

Rectangle {
    id: root
    property alias model: platformPath.model
    property alias currentIndex: platformPath.currentIndex
    readonly property var currentCollection: model.get(currentIndex)

    height: vpx(72)
    color: "#091018"

    function next() { platformPath.incrementCurrentIndex(); }
    function prev() { platformPath.decrementCurrentIndex(); }

    Rectangle {
        anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
        height: 1
        color: "#24485f"
    }

    Row {
        anchors { left: parent.left; leftMargin: vpx(24); verticalCenter: parent.verticalCenter }
        spacing: vpx(9)

        Rectangle {
            width: vpx(38); height: width; radius: vpx(11)
            gradient: Gradient {
                GradientStop { position: 0; color: "#42c8ff" }
                GradientStop { position: 1; color: "#3976ff" }
            }
            Text {
                anchors.centerIn: parent
                text: "☁"
                color: "white"
                font { pixelSize: vpx(22); bold: true; family: globalFonts.sans }
            }
        }
        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: vpx(-2)
            Text {
                text: "PEGASUS"
                color: "#f5f9fc"
                font { pixelSize: vpx(18); bold: true; letterSpacing: 1.5; family: globalFonts.sans }
            }
            Text {
                text: "CLOUD LIBRARY"
                color: "#42c8ff"
                font { pixelSize: vpx(10); bold: true; letterSpacing: 2.0; family: globalFonts.sans }
            }
        }
    }

    PathView {
        id: platformPath
        anchors { left: parent.left; leftMargin: parent.width * 0.36; right: parent.right; top: parent.top; bottom: parent.bottom }
        delegate: PlatformCard {
            platformShortName: modelData.shortName
            platformName: modelData.name
            isOnTop: PathView.isCurrentItem
            width: platformPath.width * 0.62
            height: platformPath.height
            z: PathView.itemZ
        }
        path: Path {
            startX: vpx(-220); startY: platformPath.height / 2
            PathAttribute { name: "itemZ"; value: 0 }
            PathLine { x: platformPath.width / 2; y: platformPath.height / 2 }
            PathAttribute { name: "itemZ"; value: 10 }
            PathLine { x: platformPath.width + vpx(220); y: platformPath.height / 2 }
            PathAttribute { name: "itemZ"; value: 0 }
        }
        pathItemCount: 5
        snapMode: PathView.SnapOneItem
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
    }

    PegasusUtils.HorizontalSwipeArea {
        anchors.fill: parent
        onSwipeLeft: root.next()
        onSwipeRight: root.prev()
        onClicked: mouse => {
            if (mouse.x < width / 2) root.prev();
            else root.next();
        }
        onWheel: wheel => {
            wheel.accepted = true;
            if (wheel.angleDelta.x > 0 || wheel.angleDelta.y > 0) root.prev();
            else root.next();
        }
    }
}

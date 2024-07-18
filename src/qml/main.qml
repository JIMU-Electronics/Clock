import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.12

Window {
    id: root

    visible: true
    width: 640
    height: 480
//    title: qsTr("Clock")
//    color: "#202020"
    color: root.isBlack ? "black" : "white"
    flags: Qt.FramelessWindowHint | Qt.Window

    property int dragX: 0
    property int dragY: 0
    property bool draging: false

    property real sourceWidth: 0
    property real sourceHeight: 0
    property real sourceX: 0
    property real sourceY: 0
    property var sourceFlags: 0

    property bool isBlack: true

    Rectangle {
        id: shading
        visible: true
        x: root.width
        y: root.height
        width: root.width * 2
        height: root.width * 2
        radius: width / 2
        clip: true
        color: root.isBlack ? "white" : "black"

        property real name: value

        PathAnimation {
            id: shadingAnimation
            target: shading
            duration: 1200

            path: Path {
                PathLine {
                    x: 0 - root.width / 2
                    y: 0 - root.width / 2
                }
            }

            onStarted: {
                shading.visible = true
            }

            onStopped: {
                root.isBlack = ! root.isBlack
                shading.visible = false
                shading.x = root.width
                shading.y = root.height
            }
        }
    }

    Item {
        id: bodyArea
        anchors.fill: parent

        Timer {
            id: bodyTimer
            interval: 500
            repeat: true
            onTriggered: {
//                t.text = TOperation.currentTime() + ":" + TOperation.currentSecond()
                t.text = TOperation.currentTime()
            }
        }

        Text {
            id: t
            color: "#f58a8a"
            text: TOperation.currentTime() + ":" + TOperation.currentSecond()
            font.family: "Times New Roman"
            font.bold: true
            font.italic: true
            font.pointSize: bodyArea.width / 7
            smooth: true
            anchors.centerIn: parent
        }
    }

    Item {
        id: buttonArea
        anchors.top: parent.top
        anchors.right: parent.right
        width: parent.width / 5
        height: parent.height / 20

        Item {
            anchors.right: parent.right
            anchors.top: parent.top
            width: parent.width / 3
            height: parent.height
//            color: "white"

            Text {
                id: buttonClose
                opacity: 0
                color: "#f58a8a"
                text: "X"
                font.family: "Times New Roman"
                font.bold: true
                font.italic: true
                font.pointSize: parent.width / 3
                smooth: true
                anchors.right: parent.right

                MouseArea {
                    id: closeMouseArea
                    anchors.fill: parent
//                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true

                    onClicked: {
                        root.close()
                    }
                    onEntered: {
                        buttonClose.opacity = 1
                        rootMouseArea.cursorShape = Qt.PointingHandCursor
                    }
                    onExited: {
                        buttonClose.opacity = 0
                        rootMouseArea.cursorShape = Qt.ArrowCursor
                    }
                }
            }
        }
    }

    Item {
        id: toolsArea
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: parent.width / 5
        height: parent.height / 15

        Rectangle {
            id: toolA
            opacity: 0
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            width: parent.width / 3
            height: parent.height
            color: root.isBlack ? "white" : "black"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    shadingAnimation.stop()
                    shadingAnimation.start()
                }
                onEntered: {
                    toolA.opacity = 1
                    rootMouseArea.cursorShape = Qt.PointingHandCursor
                }
                onExited: {
                    toolA.opacity = 0
                    rootMouseArea.cursorShape = Qt.ArrowCursor
                }
            }
        }
    }



    Component.onCompleted: {
        bodyTimer.start()
    }

    MouseArea {
        id: rootMouseArea
        anchors.fill: parent

        onPressed: {
            if (rootMouseArea.cursorShape == Qt.ArrowCursor) {
                root.dragX = mouseX
                root.dragY = mouseY
                root.draging = true
            } else {
                mouse.accepted = false
            }
        }
        onReleased: {
            root.draging = false
        }
        onPositionChanged: {
            if (root.draging) {
                root.x += mouseX - root.dragX
                root.y += mouseY - root.dragY
            }
        }
        onDoubleClicked: {
            shadingAnimation.stop()
            root.draging = false

            if (root.flags & Qt.WindowFullScreen) {
                root.flags = root.sourceFlags
                root.width = root.sourceWidth
                root.height = root.sourceHeight
                root.x = root.sourceX
                root.y = root.sourceY
            } else {
                root.sourceWidth = root.width
                root.sourceHeight = root.height
                root.sourceX = root.x
                root.sourceY = root.y
                root.sourceFlags = root.flags

                root.x = 0
                root.y = 0

                root.flags = root.flags | Qt.WindowFullScreen
                root.width = Screen.desktopAvailableWidth
                root.height = Screen.desktopAvailableHeight
            }
        }
    }

//    Connections {
//        target: TOperation
//    }
}

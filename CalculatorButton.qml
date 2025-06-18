import QtQuick 2.15

Rectangle {
    id: button
    property alias text: buttonText.text
    property bool isEqual: false
    signal clicked

    width: 70
    height: 60
    radius: 8
    color: isEqual ? "#3399ff" : "#222"
    border.color: "#333"
    border.width: 1

    MouseArea {
        anchors.fill: parent
        onClicked: button.clicked()
    }
    Text {
        id: buttonText
        anchors.centerIn: parent
        color: "white"
        font.pixelSize: 24
    }
} 
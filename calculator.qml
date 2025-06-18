import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import Calculator 1.0

ApplicationWindow {
    id: window
    width: 360
    height: 560
    minimumWidth: 360
    minimumHeight: 560
    visible: true
    title: "Y-Calculator"
    color: "#000000"

    Calculator {
        id: calculator
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.28
            color: "#000000"
            Text {
                id: display
                text: calculator.display
                color: "white"
                font.pixelSize: parent.height * 0.18
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignBottom
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 20
                anchors.bottomMargin: 10
            }
        }

        GridLayout {
            id: buttonGrid
            columns: 4
            Layout.fillWidth: true
            Layout.fillHeight: true
            rowSpacing: 10
            columnSpacing: 10
            anchors.margins: 10

            // 第一行
            CalculatorButton { text: "AC"; onClicked: calculator.clear() }
            CalculatorButton { text: "+/-"; onClicked: calculator.toggle_sign() }
            CalculatorButton { text: "%"; onClicked: calculator.percentage() }
            CalculatorButton { text: "÷"; onClicked: calculator.input_operation("÷") }

            // 第二行
            CalculatorButton { text: "7"; onClicked: calculator.input_digit("7") }
            CalculatorButton { text: "8"; onClicked: calculator.input_digit("8") }
            CalculatorButton { text: "9"; onClicked: calculator.input_digit("9") }
            CalculatorButton { text: "×"; onClicked: calculator.input_operation("×") }

            // 第三行
            CalculatorButton { text: "4"; onClicked: calculator.input_digit("4") }
            CalculatorButton { text: "5"; onClicked: calculator.input_digit("5") }
            CalculatorButton { text: "6"; onClicked: calculator.input_digit("6") }
            CalculatorButton { text: "-"; onClicked: calculator.input_operation("-") }

            // 第四行
            CalculatorButton { text: "1"; onClicked: calculator.input_digit("1") }
            CalculatorButton { text: "2"; onClicked: calculator.input_digit("2") }
            CalculatorButton { text: "3"; onClicked: calculator.input_digit("3") }
            CalculatorButton { text: "+"; onClicked: calculator.input_operation("+") }

            // 第五行
            CalculatorButton {
                text: "0"
                Layout.columnSpan: 2
                onClicked: calculator.input_digit("0")
            }
            CalculatorButton { text: "."; onClicked: calculator.input_digit(".") }
            CalculatorButton { text: "="; isEqual: true; onClicked: calculator.calculate() }
        }
    }

    // 通用按钮组件
    Component {
        id: buttonComponent
        CalculatorButton {}
    }

    // 自定义按钮
    Rectangle {
        id: buttonTemplate
        visible: false
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
            onClicked: parent.clicked()
        }
        Text {
            id: buttonText
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 24
        }
    }
    // 让 CalculatorButton 继承上面模板
    QtObject {
        id: buttonFactory
        function createButton(text, isEqual, onClicked) {
            var btn = buttonComponent.createObject(buttonGrid, {"text": text, "isEqual": isEqual});
            btn.clicked.connect(onClicked);
            return btn;
        }
    }
}
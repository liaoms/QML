import QtQuick 2.13
import QtQuick.Window 2.13
import "./myButton"

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("MyButton")
    color: "#3C3C3C"

    Row{
        anchors.centerIn: parent
        spacing: 5
        MyButton{
            id: btn1
            text: "button1"

            onClicked: {
                console.log("button1 clicked")
                btn2.enabled = true
                btn1.enabled = false
            }
        }

        MyButton{
            id:btn2
            enabled: false
            text: "button2"

            onClicked: {
                console.log("button2 clicked")
                btn1.enabled = true
                btn2.enabled = false
            }
        }
    }


}

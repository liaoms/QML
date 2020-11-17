import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQml 2.13

Item {
    id: name
    signal click()
    Button{
        anchors.centerIn: parent
        text: "btn"

        //1、直接设置样式
        /*
        style: ButtonStyle {
          background: Rectangle {
              implicitWidth: 100
              implicitHeight: 25
              color: control.hovered ? "#36648B" : "#3A5FCD"
              border.width: control.pressed ? 2 : 1
              border.color: Qt.lighter(color)
              radius: 4

            }
        }
        */

        //2、额外设置样式，再调用
        style: btnStyle

        onClicked: {
            click()
        }
    }

    //单独设置一个样式
    Component{
        id: btnStyle
        ButtonStyle{
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 25
                color: control.hovered ? "#36648B" : "#3A5FCD"
                border.width: control.pressed ? 2 : 1
                border.color: Qt.lighter(color)
                radius: 4

              }
        }
    }
}




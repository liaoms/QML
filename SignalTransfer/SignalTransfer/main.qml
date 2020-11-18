import QtQuick 2.13
import QtQuick.Window 2.13
import lms.General_API 1.0
import "./common"

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("SignalTransfer")
    color: "#3C3C3C"
    id: root

    signal sigQML(var sigMsg)

    MyGeneralApi{
        id: cppApi
    }

    Column{
        anchors.centerIn: parent

        spacing: 2

        //qml发信号，qml处理信号
        MyButton{
            id:btn1
            width: 200
            text: "qml -> qml"
        }

        //qml发信号，C++处理信号
        MyButton{
            id:btn2
            width: 200
            text: "qml -> C++"

            onClicked: {
                sigQML("发送qml信号")
            }

            //信号槽绑定方式1
            Component.onCompleted: {
                root.sigQML.connect(cppApi.cppSlots)
            }

            //信号槽绑定方式2
            Connections{
                target: root

                onSigQML:{
                    cppApi.cppSlots(sigMsg)
                }
            }
        }

        //C++发信号，qml处理信号
        MyButton{
            id:btn3
            width: 200
            text: "C++ -> qml"

            onClicked: {

            }

            Connections{
                target: cppApi

                onSigCPP:{
                    console.log("QML信号处理函数处理C++信号:", sigMsg)
                }
            }
        }

    }
}

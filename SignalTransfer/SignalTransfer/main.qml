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

    //定义一个CPP对象
    MyGeneralApi{
        id: cppApi
    }

    Column{
        anchors.centerIn: parent

        spacing: 2

        /****************************************************/
        //qml发信号，qml处理信号(太简单了，懒得写)
        MyButton{
            id:btn1
            width: 200
            text: "qml -> qml"
        }

        /****************************************************/
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

        /****************************************************/
        //C++发信号，qml处理信号
        MyButton{
            id:btn3
            width: 200
            text: "C++ -> qml"

            onClicked: {
                cppApi.sendCppSig("sigCPP")   //cpp信号发送从这里触发
            }

            //信号槽绑定方式1
            Component.onCompleted: {
                cppApi.sigCPP.connect(btn3.qmlSlot)
            }

            //信号槽绑定方式2
            Connections{
                target: cppApi

                onSigCPP:{
                    btn3.qmlSlot(sigMsg)
                }
            }

            function qmlSlot(sigMsg)
            {
                console.log("QML信号处理函数处理C++信号:", sigMsg)
            }
        }
    }
}

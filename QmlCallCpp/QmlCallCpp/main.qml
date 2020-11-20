import QtQuick 2.13
import QtQuick.Window 2.13
import "./common"
import lms.General_API 1.0
import lms.Singleto_API 1.0


Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("QmlCallCpp")
    color: "#3C3C3C"

    //qml里实例化cpp对象
    MyGeneralApi{
        id: genApi
    }

    Connections{
        target:genApi   //绑定genApi中的messageChanged信号

        onMessageChanged:{
            console.log("onMessageChanged", message)
        }
    }

    Column{
        anchors.centerIn: parent
        spacing: 5

        MyButton{
            id: btn1
            text: "直接调用CPP中实例化的对象"
            width: 200

            onClicked: {
                var ret = m_GeneralApi.generalFun(text)
                console.log(ret)
            }
        }

        MyButton{
            id: btn2
            text: "在QML中实例化C++对象再调用"
            width: 200

            onClicked: {
                var ret = genApi.generalFun(text)
                console.log(ret)
                genApi.message = "message"   //设置message消息的时候，会发送 messageChanged 信号，具体看C++中的写法
            }
        }

        MyButton{
            id: btn3
            text: "直接调用C++中的单例对象"
            width: 200

            onClicked: {
                var ret = MySingleApi.singleFun(text)
                console.log(ret)
            }
        }

    }
}

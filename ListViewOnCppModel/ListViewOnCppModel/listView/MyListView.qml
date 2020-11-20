import QtQuick 2.0
import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.5
import lms.MyModel 1.0


Item {

    MyModel{
        id: myModel
    }

    Component.onCompleted: {
        myModel.pushdata("A1", "B1", "C1", "D1")
        myModel.pushdata("A2", "B2", "C2", "D2")
        myModel.pushdata("A3", "B3", "C3", "D3")
        myModel.pushdata("A4", "B4", "C4", "D4")
    }

    ListView{
        id: myListView
        anchors.fill:parent
        delegate: myListViewDelegate
        header : myListViewHeader
        model: myModel

        headerPositioning: ListView.OverlayHeader
        clip: true
        focus: true

        highlightMoveDuration:100   //移动时的过渡动画速度

        ScrollBar.vertical: ScrollBar {       //滚动条
            width: 10
            anchors.top: myListView.top
            anchors.topMargin: 50
            active: true
        }

        // 高亮当前选中的item
        highlight: Rectangle{
            id: hRect
            color: "#607B8B"
            border.color: Qt.lighter(color)
        }

        onCurrentItemChanged: {

            if(myListView.count > 0)
            {
                var data0 = myListView.model.get(myListView.currentIndex, MyModel.DATA0)  //使用C++的枚举，只能通过类名使用，不能通过id
                var data1 = myListView.model.get(myListView.currentIndex, MyModel.DATA1)
                var data2 = myListView.model.get(myListView.currentIndex, MyModel.DATA2)
                var data3 = myListView.model.get(myListView.currentIndex, MyModel.DATA3)
                console.log(data0, data1, data2, data3)


            }
        }

        //键盘delete键删除
        Keys.enabled: true
        Keys.onDeletePressed: {
            myModel.mremove(myListView.currentIndex)
        }
}

    Component{
        id:myListViewDelegate

        Item{
            id: rectDelegate
            width: parent.width
            height: 50

            property color itemColor: "#3C3C3C"

            RowLayout{
                id:rowItem
                anchors.fill: parent
                spacing: 0

                Rectangle{
                    height: parent.height
                    width: 1
                    color: Qt.lighter(itemColor)
                }

                ListViewItemDelegate{
                    Layout.fillWidth: true
                    height: parent.height-3
                    text: model.data0    //每个listView内容的委托text，直接设置成model项的名就行(这个就直接将model名对应的内容与委托的text一一绑定)
                }

                Rectangle{
                    height: parent.height
                    width: 1
                    color: Qt.lighter(itemColor)
                }

                ListViewItemDelegate{
                    Layout.fillWidth: true
                    height: parent.height-3
                    text: model.data1
                }

                Rectangle{
                    height: parent.height
                    width: 1
                    color: Qt.lighter(itemColor)
                }

                ListViewItemDelegate{
                    Layout.fillWidth: true
                    height: parent.height-3
                    text: model.data2
                }

                Rectangle{
                    height: parent.height
                    width: 1
                    color: Qt.lighter(itemColor)
                }

                ListViewItemDelegate{
                    Layout.fillWidth: true
                    height: parent.height-3
                    text: model.data3
                }

                Rectangle{
                    height: parent.height
                    width: 1
                    color: Qt.lighter(itemColor)
                }
            }

            Rectangle{
                anchors.top: rowItem.bottom
                height: 1
                width: rowItem.width
                color: Qt.lighter(itemColor)
            }

            MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true

                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                    onClicked: {
                        myListView.currentIndex = index

                        if(mouse.button === Qt.RightButton)
                        {
                            //右键删除菜单
                            contextMenu.popup()
                        }

                    }

                    onEntered: {
                        rectDelegate.itemColor = "#528B8B"
                    }
                    onExited: {
                        rectDelegate.itemColor = "#3C3C3C"
                    }
                }

            //右键菜单
            Menu {
                id: contextMenu

                Action {
                    text: "Cut"
                    onTriggered: {
                        console.log("Cut")
                    }
                }
                Action {
                    text: "Copy"
                    onTriggered: {
                        console.log("Copy")
                    }
                }
                Action {
                    text: "Paste"
                    onTriggered: {
                        console.log("Paste")
                    }
                }
                Action {
                    text: "Delete"
                    onTriggered: {
                        myModel.mremove(myListView.currentIndex)
                    }
                }

                MenuSeparator { }

                //子菜单
                Menu {
                    title: "other..."
                    Action { text: "Find Next" }
                    Action { text: "Find Previous" }
                    Action { text: "Replace" }
                }
            }


        }
    }


    Component{
        id:myListViewHeader

        Rectangle{
            id: rectHeader
            width: parent.width
            height: 50
            z: 2

            color: "#3C3C3C"
            border.color: Qt.lighter(color)

            RowLayout{
                anchors.fill: parent
                height: parent.height-3
                spacing: 0

                Rectangle{
                    height: parent.height
                    width: 1
                    color: rectHeader.border.color
                }

                ListViewItemDelegate{
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height
                    text: "标题1"
                }

                Rectangle{
                    height: parent.height
                    width: 1
                    color: rectHeader.border.color
                }

                ListViewItemDelegate{
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height
                    text: "标题2"
                }

                Rectangle{
                    height: parent.height
                    width: 1
                    color: rectHeader.border.color
                }

                ListViewItemDelegate{
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height
                    text: "标题3"
                }
                Rectangle{
                    height: parent.height
                    width: 1
                    color: rectHeader.border.color
                }

                ListViewItemDelegate{
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height
                    text: "标题4"
                }
                Rectangle{
                    height: parent.height
                    width: 1
                    color: rectHeader.border.color
                }
            }
        }
    }
}

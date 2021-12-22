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
        highlightFollowsCurrentItem: true

        ScrollBar.vertical: ScrollBar {       //滚动条
            width: 10
            anchors.top: myListView.top
            anchors.topMargin: 50
            active: true
        }

         //高亮当前选中的item
        highlight: Rectangle{
            id: hRect
            color: "#607B8B"
            border.color: Qt.lighter(color)
        }

        onCurrentItemChanged: {
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
                    text: model.data0
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

            DropArea {//接收拖拽的区域
                anchors.fill: parent
                keys: "index"   //限制接收过来的数据key，即只接收index的数据(对应Drag.mimeData: {"index":index})

                onEntered: {
                    rectDelegate.itemColor = "#AAAAAA"
                }

                onExited: {
                    rectDelegate.itemColor = "#3C3C3C"
                }
                onDropped: {//鼠标拖拽完成  释放时触发
                    rectDelegate.itemColor = "#3C3C3C"
                    myModel.move(drop.source.Drag.mimeData.index, index)
                }
            }

            MouseArea{
                id: dragArea
                anchors.fill: parent
                hoverEnabled: true

                onPressed: {
                    rectDelegate.grabToImage(function(result) {
                        item_mime.Drag.imageSource = result.url;
                        item_mime.Drag.hotSpot.x = mouseX  //设置拖动时鼠标的位置就是点击的位置
                        item_mime.Drag.hotSpot.y = mouseY
                        dragArea.drag.target=item_mime;
                    });
                }

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

            //拖拽用的辅助  移动过程中的悬浮样式
            Item{
                id: item_mime
                Drag.active: dragArea.drag.active
                Drag.mimeData: {"index":index}   //这句很设置了拖动源的数据
                Drag.dragType: Drag.Automatic
                Drag.supportedActions: Qt.CopyAction
                Drag.onDragFinished: {
                    item_mime.x=0;
                    item_mime.y=0;
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

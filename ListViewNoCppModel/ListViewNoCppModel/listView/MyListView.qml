import QtQuick 2.0
import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.5
import lms.General_API 1.0


Item {

    MyGeneralApi{
        id: cppApi
    }

    Component.onCompleted: {
        loadModelValue()
    }

    ListView{
        id: myListView
        anchors.fill:parent
        delegate: myListViewDelegate
        header : myListViewHeader
        model: myListViewModel

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

                var data = myListViewModel.get(myListView.currentIndex)
                console.log(data.title0,",",data.title1,",",data.title2,",",data.title3,",",data.title4,",",data.title5,",",data.title6,",",data.title7)
            }
        }

        //键盘delete键删除
        Keys.enabled: true
        Keys.onDeletePressed: {
            myListViewModel.remove(myListView.currentIndex)
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
                    text: title0    //每个listView内容的委托text，直接设置成model项的名就行(这个就直接将model名对应的内容与委托的text一一绑定)
                }

                Rectangle{
                    height: parent.height
                    width: 1
                    color: Qt.lighter(itemColor)
                }

                ListViewItemDelegate{
                    Layout.fillWidth: true
                    height: parent.height-3
                    text: title1
                }

                Rectangle{
                    height: parent.height
                    width: 1
                    color: Qt.lighter(itemColor)
                }

                ListViewItemDelegate{
                    Layout.fillWidth: true
                    height: parent.height-3
                    text: title2
                }

                Rectangle{
                    height: parent.height
                    width: 1
                    color: Qt.lighter(itemColor)
                }

                ListViewItemDelegate{
                    Layout.fillWidth: true
                    height: parent.height-3
                    text: title3
                }
                Rectangle{
                    height: parent.height
                    width: 1
                    color: Qt.lighter(itemColor)
                }

                ListViewItemDelegate{
                    Layout.fillWidth: true
                    height: parent.height-3
                    text: title4
                }

                Rectangle{
                    height: parent.height
                    width: 1
                    color: Qt.lighter(itemColor)
                }

                ListViewItemDelegate{
                    Layout.fillWidth: true
                    height: parent.height-3
                    text: title5
                }

                Rectangle{
                    height: parent.height
                    width: 1
                    color: Qt.lighter(itemColor)
                }

                ListViewItemDelegate{
                    Layout.fillWidth: true
                    height: parent.height-3
                    text: title6
                }

                Rectangle{
                    height: parent.height
                    width: 1
                    color: Qt.lighter(itemColor)
                }

                ListViewItemDelegate{
                    Layout.fillWidth: true
                    height: parent.height-3
                    text: title7
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
                //z: rectDelegate.z + 1
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

                        //myListViewModel.move(1,3,1)   //移动item，第1行移到第3行，共移动1行  后续做到鼠标拖拽时再完善
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
                        myListViewModel.remove(myListView.currentIndex)  //删除一行
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

    ListModel{
        id:myListViewModel
        //设置一个模型内容，但是不用这里的，实现的是从C++传过来的内容解析

//        ListElement{
//            title0: "备注"   //titlex为模型roleName
//            title1: "aaa"
//            title2: "12kB"
//            title3: "3.09S"
//            title4: "16KHz"
//            title5: "16bit"
//            title6:  "amr"
//            title7: "D:"

//        }
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

                ListViewItemDelegate{
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height
                    text: "标题5"
                }
                Rectangle{
                    height: parent.height
                    width: 1
                    color: rectHeader.border.color
                }

                ListViewItemDelegate{
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height
                    text: "标题6"
                }
                Rectangle{
                    height: parent.height
                    width: 1
                    color: rectHeader.border.color
                }

                ListViewItemDelegate{
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height
                    text: "标题7"
                }
                Rectangle{
                    height: parent.height
                    width: 1
                    color: rectHeader.border.color
                }

                ListViewItemDelegate{
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height
                    text: "标题8"
                }
                Rectangle{
                    height: parent.height
                    width: 1
                    color: rectHeader.border.color
                }
            }
        }
    }

    function loadModelValue()
    {
        myListViewModel.clear()
        //直接解析QStringList得到model的值
        for(var i=0; i<cppApi.modelValue.length; i++)
        {
            var item = cppApi.modelValue[i].split(",");
            //往模型中赋值
            myListViewModel.append({title0:item[0], title1:item[1], title2:item[2], title3:item[3],
                                    title4:item[4], title5:item[5], title6:item[6],title7:item[7]})
        }

    }
}

import QtQuick 2.13
import QtQuick.Window 2.13
import "./listView"

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("ListViewNoCppModel")
    color: "#3C3C3C"

    MyListView{
        anchors.fill: parent
    }
}

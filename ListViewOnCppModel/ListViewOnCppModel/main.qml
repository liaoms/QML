import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.5
import "./listView"


Window {
    id: mainWin
    visible: true
    width: 640
    height: 480
    title: qsTr("ListViewOnCppModel")
    color: "#3C3C3C"

    Rectangle{
        color: mainWin.color
        anchors.fill: parent
        ColumnLayout{
            anchors.fill: parent
            MyListView{
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            RowLayout{
                Layout.fillWidth: true
                Layout.preferredHeight: 30

                Button {
                  text: qsTr("增加")
                  Layout.preferredWidth: 100
                  onClicked: {

                  }
                }
                Button {
                  text: qsTr("删除")
                  Layout.preferredWidth: 100
                  onClicked: {

                  }
                }
            }
        }
    }
}

import QtQuick 2.13
import QtQuick.Controls 2.5

Item {
    property alias text : itemText.text
    property alias textFont : itemText.font
    property alias textColor : itemText.color
    property color backColor: "transparent"

    Rectangle{
        id: itemRect
        width: parent.width
        height: parent.height
        color: backColor
        border.color: Qt.lighter(color)
        //border.width: 1

        Text {
            id: itemText
            anchors.fill: parent 

            color: "white"
            font.pixelSize: 13
            font.family: "Microsoft YaHei"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            elide: Text.ElideRight   //超出显示宽度时显示...

            //设置鼠标悬浮框内容
            ToolTip.text: text
            ToolTip.visible:ma.containsMouse && truncated

            MouseArea{
                id:ma
                anchors.fill: parent
                hoverEnabled: true
            }
        }
    }
}

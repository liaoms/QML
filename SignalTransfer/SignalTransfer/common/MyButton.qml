import QtQuick 2.12
import QtQuick.Controls 2.12

Button {
    width: 100
    height: 50
    background: Rectangle {
        id: backRect
        radius: 4
        color:  enabled ? (hovered ? "#7197ff":"#658BF2") : "#808080"  //综合悬浮、使能的颜色
    }

    contentItem: Text {
        text: parent.text
        font.pixelSize: 13
        font.family: "Microsoft YaHei"
        color: "white"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        bottomPadding: 2
    }

    //点击是增加外框显示效果
    onPressed: {
        backRect.border.width = 1
        backRect.border.color = Qt.lighter(backRect.color)
    }
    onReleased: {
        backRect.border.width = 0
    }
}

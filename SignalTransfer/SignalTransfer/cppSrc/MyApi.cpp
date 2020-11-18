#include "MyApi.h"

QString MyGeneralApi::generalFun(QString strArg)
{
    return  strArg + QStringLiteral(" -> 普通模式中的C++函数");
}

void MyGeneralApi::cppSlots(QString sigMsg)
{
    qDebug() << QStringLiteral("C++的信号处理函数处理QML信号:") << sigMsg;
}

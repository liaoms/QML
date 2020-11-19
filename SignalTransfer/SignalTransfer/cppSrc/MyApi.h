#ifndef MYAPI_H
#define MYAPI_H

#include <QObject>
#include <QDebug>
#include <QQmlEngine>
#include <QJSEngine>


//普通类的C++
class MyGeneralApi : public QObject
{
    Q_OBJECT

public:
    explicit MyGeneralApi(QObject *parent = nullptr)
    {
        Q_UNUSED(parent)
    }

    //通过Q_INVOKABLE关键修饰的函数才能在qml中被调用
    Q_INVOKABLE QString generalFun(QString strArg);
    Q_INVOKABLE void sendCppSig(QString strArg);

signals:
    void sigCPP(QString sigMsg);

public slots:
    void cppSlots(QString sigMsg);
};

#endif // MYAPI_H

#ifndef THIRD_H
#define THIRD_H

#include <QObject>
#include <QDebug>
#include <QQmlEngine>
#include <QJSEngine>
#include <QTimer>


//普通类的C++
class Third : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString message READ getMessage WRITE setMessage NOTIFY messageChanged)  // 属性关联的信号

public:
    explicit Third(QObject *parent = nullptr)
    {
        Q_UNUSED(parent)
    }

    //通过Q_INVOKABLE关键修饰的函数才能在qml中被调用
    Q_INVOKABLE QString generalFun(QString strArg)
    {
        return  strArg + QStringLiteral(" -> 普通模式中的C++函数");
    }

public:
    QString getMessage(){return m_message;}
    void setMessage(QString message){m_message = message; emit messageChanged(message);}  //设置属性时，发送信号

signals:
    void messageChanged(QString message);

private:
    QString m_message;

};

#endif // THIRD_H

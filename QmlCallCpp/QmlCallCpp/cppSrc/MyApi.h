#ifndef MYAPI_H
#define MYAPI_H

#include <QObject>
#include <QDebug>
#include <QQmlEngine>
#include <QJSEngine>
#include <QTimer>

//单例模式的C++  api
class MySingleApi : public QObject
{
    Q_OBJECT
public:
    explicit MySingleApi(QObject *parent = nullptr){Q_UNUSED(parent)}

    //通过Q_INVOKABLE关键修饰的函数才能在qml中被调用
    Q_INVOKABLE QString singleFun(QString strArg)
    {
        return  strArg + QStringLiteral(" -> 单例模式中的C++函数");
    }

    static MySingleApi* NewInstance()
    {
        if(m_instance == nullptr)
        {
            m_instance = new MySingleApi();
        }

        return m_instance;
    }

    //以单例模式注册到qml，回调参数必须为如下两个
    static QObject* instance(QQmlEngine* engine, QJSEngine* scriptEngine)
    {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)
        return NewInstance();
    }


private:
    static MySingleApi* m_instance;

};

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
    Q_INVOKABLE QString generalFun(QString strArg)
    {
        return  strArg + QStringLiteral(" -> 普通模式中的C++函数");
    }

};

#endif // MYAPI_H

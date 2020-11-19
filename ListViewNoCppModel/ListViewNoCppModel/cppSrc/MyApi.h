#ifndef MYAPI_H
#define MYAPI_H

#include <QObject>
#include <QDebug>
#include <QQmlEngine>
#include <QJSEngine>
#include <QStringList>


//普通类的C++
class MyGeneralApi : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList modelValue READ modelValue CONSTANT FINAL)

public:
    explicit MyGeneralApi(QObject *parent = nullptr);

    //通过Q_INVOKABLE关键修饰的函数才能在qml中被调用
    //Q_INVOKABLE QStringList modelValue(){return m_modelList;}
    //Q_INVOKABLE QStringList modelValue(){return m_modelList;}

private:
    QStringList modelValue(){return m_modelList;}

signals:
    void sigModel(QString modelMsg);

private:
    void initModelValue();

    QStringList m_modelList;

};

#endif // MYAPI_H

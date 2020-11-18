#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "./cppSrc/MyApi.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    //方式一、普通方式注册到qml中，qml文件中需要先定义MyApiGeneral对象，才能调用Q_INVOKABLE声明的成员函数
    qmlRegisterType<MyGeneralApi>("lms.General_API",1 , 0, "MyGeneralApi");

    //方式二、单例方式注册到qml中，qml文件中调用MyApiSingleto类时会自动调用回调函数MyApiSingleto::instance，得到MyApiSingleto类对象，可直接MyApiSingleto.fun()方式调用C++类中的函数
    qmlRegisterSingletonType<MySingleApi>("lms.Singleto_API", 1, 0, "MySingleApi", MySingleApi::instance);

    //方式三、C++类对象注册到qml中的另一种方式，在C++代码中先生成对象，然后关联到qml中的名称为 Singlto，这样在qml中也不需要生成对象
    engine.rootContext()->setContextProperty("m_GeneralApi", new MyGeneralApi());


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}

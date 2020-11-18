#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "./cppSrc/MyApi.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    //只使用方式一注册、普通方式注册到qml中，qml文件中需要先定义MyApiGeneral对象，才能调用Q_INVOKABLE声明的成员函数
    qmlRegisterType<MyGeneralApi>("lms.General_API",1 , 0, "MyGeneralApi");

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}

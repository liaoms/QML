#include "MyApi.h"

MyGeneralApi::MyGeneralApi(QObject *parent):QObject(parent)
{
    initModelValue();
}

void MyGeneralApi::initModelValue()
{
    m_modelList.clear();
    for(int i=1; i<=10; i++)
    {
        QString item = QString("A%1,B%2,C%3,D%4,E%5,G%6,H%7,J%8").arg(i).arg(i).arg(i).arg(i).arg(i).arg(i).arg(i).arg(i);
        m_modelList.append(item);
    }
}


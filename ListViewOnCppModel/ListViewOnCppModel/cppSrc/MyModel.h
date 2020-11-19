#ifndef MYMODEL_H
#define MYMODEL_H

#include <QAbstractListModel>
#include <QHash>
#include <QList>
#include <QByteArray>
#include <QDebug>
#include <vector>


class mydata
{
public:
    mydata(const QString& data0, const QString& data1,const QString& data2, const QString& data3):mdata0(data0),mdata1(data1),mdata2(data2),mdata3(data3)
    {

    }
    QString  data0() const { return this->mdata0; }
    QString  data1() const { return this->mdata1; }
    QString  data2() const { return this->mdata2; }
    QString  data3() const { return this->mdata3; }


    QVariant  obj;//当前model的组件对象
private:
    QString  mdata0;
    QString  mdata1;
    QString  mdata2;
    QString  mdata3;

};


class MyModel  :public QAbstractListModel
{
    Q_OBJECT
public:

    MyModel(QObject*  parent=nullptr);

    //外部接口 QML调用 添加数据 
    Q_INVOKABLE void pushdata(const QString& data0, const QString& data1,const QString& data2, const QString& data3);
    //外部接口 QML调用 添加数据在指定行
    Q_INVOKABLE void  minsert(int index, const QString& data0, const QString& data1,const QString& data2, const QString& data3);
    //外部接口 删除指定行
    Q_INVOKABLE void  mremove(int index);

    //外部接口 C++调用 添加数据
    void  Add(mydata&  md);
    //外部接口 清除model
    Q_INVOKABLE void clear();



    //虚函数  qml内部调用  获取第index行的内容  role 内容索引
    QVariant data(const QModelIndex &index, int role =Qt::DisplayRole) const;
    //虚函数     获取model行数
    int rowCount(const QModelIndex &parent  = QModelIndex() ) const;
    // 虚函数 内容的别名  qml 内部调用
    QHash<int, QByteArray> roleNames()  const;


    ~MyModel() {}




private:
      //model数据集合 
    std::vector<mydata>  m_datas;
};

#endif

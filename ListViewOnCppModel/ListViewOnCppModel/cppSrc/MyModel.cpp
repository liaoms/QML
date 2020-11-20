#include "MyModel.h"

MyModel::MyModel(QObject* parent) :QAbstractListModel(parent)
{

}
void MyModel::Add(mydata& md)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_datas.push_back(md);
    endInsertRows();
}
void MyModel::clear()
{
    //清除rows 界面将不显示
    beginRemoveRows(QModelIndex(), 0, m_datas.size());
    //清空动态数组
    m_datas.clear();
    endRemoveRows();
    //end

}
//外部接口 QML调用 添加数据在指定行
void  MyModel::minsert(int index, const QString& data0, const QString& data1,const QString& data2, const QString& data3)
{
    mydata  d(data0, data1, data2, data3);
    beginInsertRows(QModelIndex(), index, index);
    m_datas.insert(m_datas.begin()+index, d);
    endInsertRows();
}
void  MyModel::mremove(int index)
{
    beginRemoveRows(QModelIndex(), index, index);
    m_datas.erase(m_datas.begin() + index);
    endRemoveRows();
}

void  MyModel::move(int from, int to)
{
    if(from <0 || from >= m_datas.size() || to <0 || to >= m_datas.size() || from == to)
    {
        return;
    }

    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    mydata fromData = m_datas[from];
    mydata toData = m_datas[to];

    mremove(from);

    beginInsertRows(QModelIndex(), from, from);
    m_datas.insert(m_datas.begin()+from, toData);
    endInsertRows();

    mremove(to);

    beginInsertRows(QModelIndex(), to, to);
    m_datas.insert(m_datas.begin()+to, fromData);
    endInsertRows();
}

QVariant MyModel::get(int index, dataRole role)
{
    if(index >=0 && index < m_datas.size())
    {
        const mydata& d = m_datas[index];
        if (role == DATA0)
        {
            return d.data0();
        }
        else if (role == DATA1)
        {
            return d.data1();
        }
        else if (role == DATA2)
        {
            return d.data2();
        }
        else if (role == DATA3)
        {
            return d.data3();
        }
    }

    return  QVariant();
}

void MyModel::pushdata(const QString& data0, const QString& data1,const QString& data2, const QString& data3)
{
    mydata  d(data0, data1, data2, data3);
    Add(d);
}
int MyModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_datas.size();
}
QVariant MyModel::data(const QModelIndex &index, int role)  const
{
    if (index.row() < 0 || index.row() >= m_datas.size())
    {
        return QVariant();
    }
    const mydata& d = m_datas[index.row()];
    if (role == DATA0)
    {
        return d.data0();

    }
    else if (role == DATA1)
    {
        return d.data1();
    }
    else if (role == DATA2)
    {
        return d.data2();
    }
    else if (role == DATA3)
    {
        return d.data3();
    }
    return QVariant();


}

//定义数据别名  QHash<int, QByteArray> 父类规定的
QHash<int, QByteArray> MyModel::roleNames() const
{
    QHash<int, QByteArray>  d;
    d[DATA0] = "data0";
    d[DATA1] = "data1";
    d[DATA2] = "data2";
    d[DATA3] = "data3";
    return  d;
}

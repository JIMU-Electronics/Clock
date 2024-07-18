#ifndef TIMEROPERATION_H
#define TIMEROPERATION_H

#include <QObject>
#include <QDateTime>
#include <QTimer>

class TimerOperation : public QObject
{
    Q_OBJECT
public:
    explicit TimerOperation(QObject *parent = nullptr);

    Q_INVOKABLE QString currentTime();
    Q_INVOKABLE QString currentSecond();
    Q_INVOKABLE QString currentYear();
    Q_INVOKABLE QString currentMonth();
    Q_INVOKABLE QString currentDay();

private:
    QDateTime datetime;

signals:
};

#endif // TIMEROPERATION_H

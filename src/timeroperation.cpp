#include "timeroperation.h"

#include <QDateTime>

TimerOperation::TimerOperation(QObject *parent) : QObject(parent)
{
}

QString TimerOperation::currentTime()
{
    return datetime.currentDateTime().toString("hh:mm");
}

QString TimerOperation::currentSecond()
{
    return datetime.currentDateTime().toString("ss");
}

QString TimerOperation::currentYear()
{
    return datetime.currentDateTime().toString("yyyy");
}

QString TimerOperation::currentMonth()
{
    return datetime.currentDateTime().toString("MM");
}

QString TimerOperation::currentDay()
{
    return datetime.currentDateTime().toString("dd");
}

import os, strutils, times

type
    Feetime* = object
        quarter*: int
        week*, halfday*, hour*, tick*, second*: Natural


proc timeFromArgs*(): Feetime =
    var instant = times.getLocalTime(times.getTime())

    let args = os.commandLineParams()
    if args.len > 1:
        instant = times.parse(args[0] & " " & args[1], "yyyy-MM-dd HH:mm:ss")
    elif args.len > 0:
        instant = times.parse(args[0], "yyyy-MM-dd HH:mm:ss")

    let month = instant.month.Natural
    var qday = month mod 3 * 38
    if month == 2 or month == 11:
        qday -= 1
    let weekday = (instant.weekday.Natural + 1) mod 7
    qday += instant.monthday + 5 - weekday
    result.quarter = instant.year * 4 + month div 3
    result.week = qday div 7
    result.halfday = weekday * 2 + Natural(instant.hour > 11)
    result.hour = instant.hour mod 12
    result.second = instant.second
    result.tick = result.second div 15 - result.second div 60
    result.tick += instant.minute * 4
    result.second -= result.tick * 15


proc hex*(x: BiggestInt, len: Positive): string =
     strutils.toLowerAscii(strutils.toHex(x, len))

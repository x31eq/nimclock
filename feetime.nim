import os, strutils, times

type
    Feetime* = object
        quarter*: int
        week*, halfday*, hour*, tick*, second*: Natural


proc timeFromArgs*(): Feetime =
    var timeFormat = "yyyy-MM-dd HH:mm:ss"
    var timeString = format(times.local(times.getTime()), timeFormat)

    let args = os.commandLineParams()
    if args.len > 1:
        timeString = args[0] & " " & args[1]
    elif args.len > 0:
        let datetime = args[0].replace('T', ' ')
        if datetime[0] == '@':
            let unixStamp = strutils.parseInt(datetime[1..datetime.high])
            var stamp = times.local(times.fromUnix(unixStamp))
            timeString = format(stamp, timeFormat)
        elif strutils.contains(datetime, " "):
            timeString = datetime
        elif strutils.contains(datetime, ":"):
            timeString = times.getDateStr() & " " & datetime
        else:
            timeString = datetime & " 00:00:00"

    var instant = times.parse(timeString, "yyyy-MM-dd HH:mm:ss")

    # Nim redefined the month numbering at some point
    let month = instant.month.Natural - times.Month.mJan.Natural
    var qday = month mod 3 * 38
    if month == 2 or month == 11:
        qday -= 1
    let weekday = (instant.weekday.Natural + 1) mod 7
    qday += instant.monthday + 5 - weekday
    result.quarter = instant.year * 4 + month div 3
    result.week = qday div 7
    result.halfday = weekday * 2 + Natural(instant.hour > 11)
    result.hour = instant.hour mod 12
    let sec = instant.second
    result.tick = sec div 15 - sec div 60
    result.second = sec - result.tick * 15
    result.tick += instant.minute * 4


proc echoStandard*(dateIn: string, timeIn: string) =
    var date = 0
    if dateIn != "":
        date = strutils.parseHexInt(dateIn)
    let time = strutils.parseHexInt(timeIn)

    let quarter = date div 0x100
    let week = date div 16 mod 16
    let halfday = date mod 16
    let hour = (time div 0x1000) mod 16 + 12 * (halfday mod 2)
    let tick = time div 16 mod 0x100
    let sec = time mod 16

    var year = quarter div 4  # assumes unsigned
    if dateIn.len < 5:
        try:
            year += strutils.parseInt(os.getEnv("HEXEPOCH"))
        except ValueError:
            year += 1984
    elif dateIn.len < 6:
        if year < 896:
            year += 2048
        else:
            year += 1024
    let month = quarter mod 4 * 3 + (week * 16 + halfday) div 0x55
    let qday = (month mod 3) * 38 - int(month == 2 or month == 11)
    let nimMonth = times.Month(month + times.Month.mJan.Natural)
    let wday = (times.getDayOfWeek(1, nimMonth, year).int + 1) mod 7
    let day = week * 7 + halfday div 2 + (6 + qday - wday) mod 7 - qday - 5

    let toc = tick div 16 * 15 + tick mod 16
    let minute = toc div 4
    let second = (toc mod 4) * 15 + sec

    echo year, '-',
         strutils.intToStr(month + times.Month.mJan.Natural, 2), '-',
         strutils.intToStr(day, 2), ' ',
         strutils.intToStr(hour, 2), ':',
         strutils.intToStr(minute, 2), ':',
         strutils.intToStr(second, 2)


proc hex*(x: BiggestInt, len: Positive): string =
     strutils.toLowerAscii(strutils.toHex(x, len))

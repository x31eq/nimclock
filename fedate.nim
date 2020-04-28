import os, strutils, times

let args = os.commandLineParams()
if len(args) == 0:
    echo "Input a hex timestamp (week before .)"
else:
    var week, time = 0
    let stamp = args[0]
    if '.' in stamp:
        let parts = strutils.split(stamp, '.')
        week = strutils.parseHexInt(parts[0])
        time = strutils.parseHexInt((parts[1] & "0000")[..3])
    else:
        week = strutils.parseHexInt(stamp)

    let quarter = week div 16
    week = week mod 16
    let halfday = time div 0x1000
    let hour = (time div 0x100) mod 16
    let tick = time mod 0x100

    let year = quarter div 4 + 1024  # assumes unsigned
    let month = quarter mod 4 * 3 +
                (week * 16 + halfday) div 0x55
    let qday = (month mod 3) * 38 - int(month == 2 or month == 11)
    let wday = int(times.getDayOfWeek(1, month + 1, year))
    let day = week * 7 + halfday div 2 +
                (6 + qday - wday) mod 7 - qday - 5
    echo year, '-', month + 1, '-', day

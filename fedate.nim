import os, strutils, times

let args = os.commandLineParams()
if args.len == 0:
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
    let hour = (time div 0x100) mod 16 + 12 * (halfday mod 2)
    let tick = time mod 0x100

    let year = quarter div 4 + 1024  # assumes unsigned
    let month = quarter mod 4 * 3 +
                (week * 16 + halfday div 2) div 0x55
    let qday = (month mod 3) * 38 - int(month == 2 or month == 11)
    let wday = (times.getDayOfWeek(1, month + 1, year).int + 1) mod 7
    let day = week * 7 + halfday div 2 +
                (6 + qday - wday) mod 7 - qday - 5

    let toc = tick div 16 * 15 + tick mod 16
    let minute = toc div 4
    let second = (toc mod 4) * 15

    echo year, '-', month + 1, '-', day, ' ',
        hour, ':', minute, ':', second

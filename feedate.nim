import os, strutils, times

let args = os.commandLineParams()
if len(args) == 0:
    echo "Input a hex timestamp (date before :)"
else:
    var date, time = 0
    let stamp = args[0]
    if ':' in stamp:
        let parts = strutils.split(stamp, ':')
        date = strutils.parseHexInt(parts[0])
        time = strutils.parseHexInt((parts[1] & "0000")[..3])
    else:
        date = strutils.parseHexInt(stamp)

    let quarter = date div 0x100
    let week = date div 16 mod 16
    let halfday = date mod 16
    let hour = (time div 0x1000) mod 16 + 12 * (halfday mod 2)
    let tick = time mod 0x1000 mod 0x100
    let sec = time mod 16

    let year = quarter div 4 + 1984  # assumes unsigned
    let month = quarter mod 4 * 3 +
                (week * 16 + halfday div 2) div 0x55
    let qday = (month mod 3) * 38 - int(month == 2 or month == 11)
    let wday = (int(times.getDayOfWeek(1, month + 1, year)) + 1) mod 7
    let day = week * 7 + halfday div 2 +
                (6 + qday - wday) mod 7 - qday - 5

    let toc = tick div 16 * 15 + tick mod 16
    let minute = toc div 4
    let second = (toc mod 4) * 15 + sec

    echo year, '-', month + 1, '-', day, ' ',
        hour, ':', minute, ':', second

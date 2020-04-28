import os, strutils, times

var instant = times.getLocalTime(times.getTime())

let args = os.commandLineParams()
if len(args) > 0:
    instant = times.parse(args[0], "yyyy-MM-dd HH:mm:ss")

let month = Natural(instant.month)
let quarter = instant.year * 4 + month div 3
var qday = month mod 3 * 38
if month == 2 or month == 11:
    qday -= 1
let weekday = (Natural(instant.weekday) + 1) mod 7
qday += instant.monthday + 5 - weekday
var sec = instant.second
var tick = sec div 15 - sec div 60
sec -= tick * 15
tick += instant.minute * 4
let week = qday div 7
let halfday = weekday * 2 + Natural(instant.hour > 11)
let hour = instant.hour mod 12
tick = tick * 16 div 15

proc lowerHex(x: BiggestInt, len: Positive): string =
     strutils.toLowerAscii(strutils.toHex(x, len))

echo lowerHex(quarter mod 0x1000, 3), lowerHex(week, 1), '.',
     lowerHex(halfday, 1), lowerHex(hour, 1), lowerHex(tick, 2)

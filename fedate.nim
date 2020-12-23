import os, strutils
from feetime import echoStandard

let args = os.commandLineParams()
if args.len == 0:
    echo "Input a hex timestamp (week before .)"
else:
    var week, time = "00000"
    let stamp = args[0]
    if '.' in stamp:
        let parts = strutils.split(stamp, '.')
        week = parts[0]
        if week == "":
            week = "00000"
        time = (parts[1] & "00000")[..4]
    else:
        week = stamp
    echoStandard(week & time[0], time[1..4])

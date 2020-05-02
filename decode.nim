import os, strutils
from feetime import echoStandard

let args = os.commandLineParams()
if args.len == 0:
    echo "Input a hex timestamp (week before .)"
else:
    var date, time = "0000"
    let stamp = args[0]
    if ':' in stamp:
        let parts = strutils.split(stamp, ':')
        date = parts[0]
        time = (parts[1] & "0000")[..3]
    elif '.' in stamp:
        let parts = strutils.split(stamp, '.')
        let week = parts[0]
        time = (parts[1] & "00000")[..4]
        date = week & time[0]
        time = time[1..5]
    else:
        date = stamp & "0"
    echoStandard(date, time)

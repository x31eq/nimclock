import os, strutils
from feetime import echoStandard

let args = os.commandLineParams()
if args.len == 0:
    echo "Input a hex timestamp (date before :)"
else:
    var date, time = "0000"
    let stamp = args[0]
    if ':' in stamp:
        let parts = strutils.split(stamp, ':')
        date = parts[0]
        time = (parts[1] & "0000")[..3]
    else:
        date = stamp
    echoStandard(date, time)

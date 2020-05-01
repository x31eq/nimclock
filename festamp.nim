from feetime import timeFromArgs, lowerHex

let instant = timeFromArgs()
echo lowerHex(instant.quarter mod 0x1000, 3),
     lowerHex(instant.week, 1), '.',
     lowerHex(instant.halfday, 1),
     lowerHex(instant.hour, 1),
     lowerHex(instant.tick * 16 div 15, 2)

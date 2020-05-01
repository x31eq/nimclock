from feetime import timeFromArgs, hex

let instant = timeFromArgs()
echo hex(instant.quarter mod 0x1000, 3),
     hex(instant.week, 1), '.',
     hex(instant.halfday, 1),
     hex(instant.hour, 1),
     hex(instant.tick * 16 div 15, 2)

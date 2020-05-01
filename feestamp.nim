from feetime import timeFromArgs, hex

let instant = timeFromArgs()
echo hex(instant.quarter mod 0x100, 2),
     hex(instant.week, 1),
     hex(instant.halfday, 1), ':',
     hex(instant.hour, 1),
     hex(instant.tick * 16 div 15, 2),
     hex(instant.second, 1)

# LUA comparison

| Test | Direct | Lua | Luajit |
| --- | --- | --- | --- |
| KEYS | 0,091s | 1,351s | 0,130s |
| KEYS (longer key) | 0,084s | 13,208s | 0,156s |
| Loop, 1M HSET | - | 1,212s | 1,086s |
| Loop, 10k PING | - | 0,006s | 0,004s |
| Loop, 100k PING | - | 0,040s | 0,029s |
| Loop, 1M PING | - | 0,384s | 0,288s |




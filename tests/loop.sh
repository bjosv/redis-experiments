#!/bin/bash
set -e
RED='\033[0;31m'
NC='\033[0m' # No Color

log () {
    printf "${RED}%s %s${NC}\n" "$(date '+%Y-%m-%d %H:%M:%S')" "${@}"
}


log "Flush.."
redis-cli FLUSHALL

log "loop for(1000000 hset).."
time redis-cli EVAL 'for i=1,1000000 do redis.call("hset", string.format("KEY-" .. "%05d",i), "a", "b"); end' 0

log "loop for(1000000 hset) using arg.."
time redis-cli EVAL 'for i=1,1000000 do redis.call("hset", string.format("KEY-" .. KEYS[1] .. "%05d",i), "a", "b"); end' 1 "ADDVAL"

log "loop for(10 ping).."
time redis-cli EVAL 'for i=1,10 do redis.call("ping"); end' 0
log "loop for(100 ping).."
time redis-cli EVAL 'for i=1,100 do redis.call("ping"); end' 0
log "loop for(1000 ping).."
time redis-cli EVAL 'for i=1,1000 do redis.call("ping"); end' 0
log "loop for(10000 ping).."
time redis-cli EVAL 'for i=1,10000 do redis.call("ping"); end' 0
log "loop for(100000 ping).."
time redis-cli EVAL 'for i=1,100000 do redis.call("ping"); end' 0
log "loop for(1000000 ping).."
time redis-cli EVAL 'for i=1,1000000 do redis.call("ping"); end' 0

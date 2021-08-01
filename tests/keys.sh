#!/bin/bash
set -e
RED='\033[0;31m'
NC='\033[0m' # No Color

log () {
    printf "${RED}%s %s${NC}\n" "$(date '+%Y-%m-%d %H:%M:%S')" "${@}"
}


# From https://github.com/redis/redis/issues/8077

log "Flush.."
redis-cli FLUSHALL

PAD="#############################################################################################################:"

log "Populate.."
redis-cli EVAL 'for i=1,100000 do redis.call("hset", string.format("ASIC_STATE:" .. KEYS[1] .. "%05d",i), "a", "b"); end' 1 $PAD
redis-cli EVAL 'for i=1,100000 do redis.call("hset", string.format("TEMP_ASIC_STATE:" .. KEYS[1] .. "%05d",i), "a", "b"); end' 1 $PAD

log "Call KEYS on: ASIC_STATE"
time (redis-cli KEYS "ASIC_STATE:*" | wc -l)
log "Call KEYS via LUA on: ASIC_STATE"
time redis-cli EVAL 'redis.call("keys", KEYS[1].."*")' 1 ASIC_STATE

log "Call KEYS on: TEMP_ASIC_STATE"
time (redis-cli KEYS "TEMP_ASIC_STATE:*" | wc -l)
log "Call KEYS via LUA on: TEMP_ASIC_STATE"
time redis-cli EVAL 'redis.call("keys", KEYS[1].."*")' 1 TEMP_ASIC_STATE

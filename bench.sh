#!/usr/bin/env bash

COUNT=${AWS_BENCH_COUNT:-128}
BENCH_MULTIPLIER=${AWS_BENCH_MULTIPLIER:-20} # 10,240 handshake rounds per test
OUTPUTS=()
for i in $(seq $COUNT); do
	OUT=$(mktemp)
	OUTPUTS+=($OUT)
	env BENCH_MULTIPLIER=20 taskset -c "$(($i - 1))" ./target/release/examples/bench &>${OUT} &
done

wait

cat "${OUTPUTS[@]}"

rm "${OUTPUTS[@]}"

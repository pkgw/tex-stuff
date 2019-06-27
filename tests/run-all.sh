#! /bin/bash
# Copyright 2019 Peter Williams <peter@newton.cx>
# Licensed under the MIT License

# Run our "test suite".

base="$(dirname "$0")"
ec=0

for runner in $base/*/test.sh ; do
    name="$(basename "$(dirname "$runner")")"
    echo -n "$name ... "
    (cd "$(dirname "$runner")" && ./test.sh)
    if [ $? -eq 0 ] ; then
        echo "ok"
    else
        ec=1
    fi
done

exit $ec

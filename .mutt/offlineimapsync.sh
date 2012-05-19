#!/bin/sh

function sync_normal {
    echo "NORMAL Sync" > /tmp/offlineimaplog2
    /usr/local/bin/offlineimap -o -u quiet 
}
function sync_quick {
    echo "QUICK Sync" > /tmp/offlineimaplog
    /usr/local/bin/offlineimap -o -q -u quiet
}

# This is silly. Got this stuff from Steve Losh again :)
python -c'import sys, random; sys.exit(random.randint(0, 5))' && sync_normal; rm ~/.offlineimap/*.lock || sync_quick

exit 0


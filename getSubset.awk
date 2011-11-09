#!/usr/bin/awk -f
BEGIN{
    max=1000
}
$1 <= max && $2 <= max{
    print $0
}

#!/usr/bin/awk

BEGIN {
    a = 0
}

{
    if (match($0, "以下课堂包含开启的题目") != 0) {
        a = 1
        exit 0
    }
    if (match($0, "以下课堂暂未开启题目") != 0) {
        a = 1
    }
    if (a == 1 && (match($0, "概率统计-计算机1601-4") != 0)) {
        a = 2
        exit 0
    }
}
END {
    if (a == 2) {
        print "NOT_OPENED"
        exit 0
    } else if (a == 1) {
        print "OPENED"
        exit 1
    } else {
        print "UNKNOWN_ERROR"
        exit 2
    }
}

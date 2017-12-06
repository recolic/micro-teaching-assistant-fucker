#!/usr/bin/awk

# Meaning of a: 0-2: check END{}
#               4: 

BEGIN {
    a = 999
}

{
    if (match($0, "\"msg\":\"unauthorized\"") != 0) {
        a = 2
        exit
    }
    if (match($0, "以下课堂包含开启的题目") != 0) {
        a = 1
        exit
    }

    if (match($0, "以下课堂暂未开启题目") != 0) {
        a = 0
    }
    if (a == 1 && (match($0, "single-line\">编号:") != 0)) {
        a = 2
        exit
    }
}
END {
    if (a == 0) {
        print "NOT_OPENED"
        exit 0
    } else if (a == 1) {
        print "OPENED"
        exit 1
    } else if (a == 2) {
        print "OPENID_ERROR"
        exit 2
    } else {
        print "UNKNOWN_ERROR"
        exit 3
    }
}

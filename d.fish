#!/usr/bin/fish
#Usage: fill _url with url of the page "学生->答题".
#You must `echo "known" > /tmp/gay_known` to tell the script that you've been informed.

set _url 'https://www.teachermate.com.cn/wechat/wechat/guide/answer?openid=0a26740fbf9429d1747f8bc8ff8bf1cb'

set _audio_player "mpg123"
#set _audio_player "cvlc --play-and-exit"

function _is_informed
    # May not exist.
    if test (cat /tmp/gay_known 2>&1) = "known"
        echo "LOG> skipped because informed."
        return 0
        # ok.
    else
        echo "LOG> not informed. Launching cvlc."
        return 1
    end
end

function _on_opened
    if _is_informed
        return 0
    end
    eval $_audio_player fire.mp3 > /dev/null 2>&1
    notify-send "Warning: Question opened!" "Gay question opened!"
    echo "LOG> Detected!"
end

function _on_error
    eval $_audio_player error.mp3 > /dev/null 2>&1
    notify-send "Warning: Gay cookie invalid!" "Gay cookie expired!"
    echo "LOG> Error occurred! Maybe invalid cookie."
end

function _on_notopen
    if not test -e /tmp/gay_known
        return 0
    end
    if not rm /tmp/gay_known
        echo "WARNING::::::: UNABLE TO REMOVE /tmp/gay_known. Please deal with this programming error immediately!!!!!"
        _on_error
    end
end

while true
    set _status (curl "$_url" 2>/dev/null | awk -f gl.awk)
    date
    if test "$_status" = "OPENED"
        _on_opened
    end
    if test "$_status" = "UNKNOWN_ERROR"
        _on_error
    end
    if test "$_status" = "NOT_OPENED"
        _on_notopen
    end
    sleep 5
end

    

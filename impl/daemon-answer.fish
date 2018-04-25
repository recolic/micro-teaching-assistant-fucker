#!/usr/bin/fish
#Usage: fill _openid with openid from url of the page "学生->答题".

test -z $_openid; and echo 'openid is unset.' ; and exit 1
set _url "https://www.teachermate.com.cn/wechat/wechat/guide/answer?openid=$_openid"

source ../config.fish

function _check_and_warn
    if _all_answered
        echo "LOG> exit because all question answered."
        return 0
    end
    eval $_audio_player answer.mp3 > /dev/null 2>&1
    notify-send "Warning: Question opened!" "Question opened!"
    echo "LOG> Detected!"
end

function _on_unknown_error
    eval $_audio_player error.mp3 > /dev/null 2>&1
    notify-send "Warning: Error occurred!" "Error occurred!"
    echo "LOG> Error occurred!"
end

function _on_openid_error
    eval $_audio_player badid.mp3 > /dev/null 2>&1
    notify-send "Warning: Invalid openid!" "Error: Invalid openid."
    echo "LOG> Invalid openid."
end

set _tmp_path "/tmp/._teachmate_fucker_html"

set awk_urlfilter '
BEGIN {
    start = 0
}

{
    if (match($0, "以下课堂包含开启的题目")) {
        start = 1
    }
    if (match($0, "以下课堂暂未开启题目") != 0) {
        exit
    } else if (start == 1) {
        print $0
    }
}
'

function _all_answered
    # This function will return true if no question is opened, so OPENED check is unnecessary.
    for class in (cat $_tmp_path | awk $awk_urlfilter | grep 'www.teachermate.com.cn' | sed 's/.*course\(_\|\)id=//g' | sed 's/&open\(_\|\)id=.*//g')
        curl --header "openId: $_openid" "https://www.teachermate.com.cn/wechat-api/v1/questions/$class" > $_tmp_path 2>/dev/null
        if not grep 'question' $_tmp_path
            echo "ERROR> curl wechat-api failed. $class $_openid"
            _on_unknown_error
        end
        if grep '"isAnswered":0' $_tmp_path
            # return false
            return 1
        end
    end
    # return true
    return 0
end

# main loop
while true
    date
    curl "$_url" > $_tmp_path 2>/dev/null
    # network error will be reported by isopen.awk.
    set _status (cat $_tmp_path | awk -f isopen.awk)
    if test "$_status" = "UNKNOWN_ERROR"
        _on_unknown_error
    else if test "$_status" = "OPENID_ERROR"
        _on_openid_error
    else if test "$_status" = "OPENED"
        _check_and_warn
    end
    sleep $_monitor_interval
end



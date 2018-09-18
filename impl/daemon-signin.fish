#!/usr/bin/fish

test -z $_openid; and echo 'openid is unset.' ; and exit 1
set _url "https://www.teachermate.com.cn/wechat/wechat/guide/signin?openid=$_openid"

source ../config.fish

# Where should I signin ?
test -z $_NorthLatitude; and echo "Warning: signin location _NorthLatitude not set. Rejecting dangerous operation..."; and exit 4
test -z $_EastLongitude; and echo "Warning: signin location _EastLongitude not set. Rejecting dangerous operation..."; and exit 4

# How many seconds should I delay before autosign ?
test -z $_autosign_delay; and set _autosign_delay "10"

set tmpfl (mktemp)
set cookiefl (mktemp)
# Just to skip first sleep
rm $tmpfl

set signed_in false

function on_signin_success
    eval $_audio_player autosignin-success.mp3
    eval $_notify "'Teachermate signin'" "'Signin success'"
end

function on_signin_fail
    # will retry automatically
    eval $_audio_player signin.mp3
    eval $_notify "'Teachermate signin'" "'Signin failed'"
end

function on_badid
    eval $_audio_player badid.mp3
    eval $_notify "'Teachermate signin'" "'OpenID expired. Please restart the program with new openID'"
end

function do_signin
    if test $signed_in = true
        return
    end
    echo "sleep for $_autosign_delay seconds..."
    sleep $_autosign_delay
    set _courseid (curl "$_url" -v 2>&1 | grep '^< Location: ' | sed 's/^.*course_id=//')
    set _wx_csrf (grep 'Set-Cookie' $cookiefl | sed 's/^.*wx_csrf_cookie=//' | sed 's/;.*$//')
    curl "https://www.teachermate.com.cn/wechat-api/v1/class-attendance/student-sign-in" --data "openid=$_openid&course_id=$_courseid&lon=$_EastLongitude&lat=$_NorthLatitude&wx_csrf_name=$_wx_csrf" > $cookiefl
    grep -F 'repeat sign in' $cookiefl; and set signed_in true; and return
    grep -F '":["OK",' $cookiefl; and set signed_in true; and on_signin_success; or on_signin_fail
end

while true
    test -f $tmpfl; and sleep $_monitor_interval
    date
    curl -L "$_url" -v 2>$cookiefl > $tmpfl
    if grep '{"data":\[\],"msg":"unauthorized"}' $tmpfl
        on_signin_fail
        continue
    end
    if grep '签到中...' $tmpfl
        do_signin
        continue
    end
    if grep "<p class='success-tip'>暂无开启的签到" $tmpfl
        continue
    end
    if grep '你已签过到了' $tmpfl
        continue
    end
end

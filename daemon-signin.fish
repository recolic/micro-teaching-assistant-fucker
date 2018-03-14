#!/usr/bin/fish

set _openid ''

test "$_openid" = ""; and echo 'Give openid or url please:'; and read _openid
set _openid (echo "$_openid" | sed 's/^.*openid=//g')
echo "Set openid to $_openid"

set _url "https://www.teachermate.com.cn/wechat/wechat/guide/signin?openid=$_openid"

set _audio_player "mpg123"
#set _audio_player "cvlc --play-and-exit"

set tmpfl (mktemp)

while true
    curl "$_url" 2>/dev/null > $tmpfl
    if grep '{"data":\[\],"msg":"unauthorized"}' $tmpfl
        mpg123 badid.mp3
        sleep 5
        continue
    end
    if not grep "<p class='success-tip'>暂无签到开启</p>" $tmpfl
        mpg123 signin.mp3
    end
    sleep 5
end

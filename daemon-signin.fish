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
    sleep 5
    date
    curl -L "$_url" 2>/dev/null > $tmpfl
    if grep '{"data":\[\],"msg":"unauthorized"}' $tmpfl
        mpg123 badid.mp3
        continue
    end
    if grep '签到中...' $tmpfl
        echo 'got'
        mpg123 signin.mp3
        continue
    end
    if grep "<p class='success-tip'>暂无签到开启</p>" $tmpfl
        continue
    end
    if grep '你已签过到了' $tmpfl
        continue
    end
end

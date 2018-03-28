#!/bin/bash

[[ $1 == '' ]] && echo "usage: $0 sign/ans/all" && exit 1

[[ $_openid == "" ]] && echo 'Give openid or url please:' && read _openid
_openid=$(echo "$_openid" | sed 's/^.*openid=//g')
echo "Set openid to $_openid"

_url="https://www.teachermate.com.cn/wechat/wechat/guide/answer?openid=$_openid"

_audio_player="mpg123"
#_audio_player="cvlc --play-and-exit"

function _segfault_detected () {
    echo "WARNING: segfault captured!"
    while true; do
        $_audio_player error.mp3
        [[ $? == 127 ]] && exit 127
        sleep 2
    done
}

if [[ $1 == all ]]; then
    _openid="$_openid" $0 sign &
    _openid="$_openid" $0 ans
    exit 0
fi

cd impl

if [[ $1 == sign ]]; then
    _url="$_url" _audio_player="$_audio_player" ./daemon-signin.fish
    [[ $? == 127 ]] && exit 127
    _segfault_detected
fi
if [[ $1 == ans ]]; then
    _url="$_url" _audio_player="$_audio_player" ./daemon-answer.fish
    [[ $? == 127 ]] && exit 127
    _segfault_detected
fi

cd ..

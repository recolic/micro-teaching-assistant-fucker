#!/usr/bin/fish

set tmpfl (mktemp)
rm $tmpfl

while true
    test -f $tmpfl; and sleep 5
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

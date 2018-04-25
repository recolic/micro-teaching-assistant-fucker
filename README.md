# micro-teaching-assistant-fucker

微助教工具箱

自动检测是否有老师在微助教发布了新的题 并在特殊情况下及时提醒答题

自动检测是否有老师在微助教发布了新的签到 并延时自动签到

## Hard PreRequirements

Non-Windows OS. curl. bash. fish. awk. grep. One mp3 player available on command line.

## Configuration

编辑config.fish，设置自动签到的经纬度和延时，设置你想使用的mp3播放器，设置监视的时间间隔，然后保存。

## Usage

- 获得openid

打开微信 微助教 学生 答题/签到，在*页面加载完成之前*迅速按下右上角的`...`，然后复制链接(copy url)。

- 自动签到

运行`./daemon.sh sign`并填写openid(或含有openid的url)，它会监视你的所有课堂并自动签到。注意，如果有多个课堂同时发起签到请求，其行为是未定义的。如果自动签到失败，它会使用语音提示要求手动干预。

- 监视答题

运行`./daemon.sh ans`并填写openid(或含有openid的url)，它会监视你的所有课堂是否有答题并使用语音发出提醒。注意，如果有多个课堂同时发起答题，其行为是未定义的。

## Tips

daemon.sh使用了notify-send，其他用户请根据自己的情况选择修改或删除气泡提醒。

daemonx.sh默认使用mpg123/cvlc来播放mp3，其他播放器用户请根据自己情况进行修改。**请将电脑声音调大**。

根据经验，url一般会在约1080次请求后失效。这意味着，如果你只开一个脚本，5秒请求一次，它可以自动运行约90分钟。

## 常用经纬度

西十二楼 30.508914°N 114.40718°E

西五楼 30.511227°N 114.41021°E

南一楼 30.509595°N 114.41374°E

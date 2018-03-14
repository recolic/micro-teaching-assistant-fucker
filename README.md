# micro-teaching-assistant-fucker
自动检测是否有老师在微助教发布了新的题 并在特殊情况下及时提醒答题
自动检测是否有老师在微助教发布了新的签到 并在特殊情况下及时提醒签到

## Hard PreRequirements

Non-Windows OS. curl. fish. awk. One mp3 player available on command line.

## Usage

打开微信 微助教 学生 答题/签到，在页面加载完成之前迅速按下右上角...，然后复制这个页面的url。

运行你想要的daemon-\*.fish 输入openid或含有openid的完整URL 它会每5秒检查一次并判断是否需要答题/签到。你也可以将openid直接写进daemon.fish。

daemon-\*.fish使用了notify-send，其他用户请根据自己的情况选择修改或删除气泡提醒。

daemon-\*.fish默认使用mpg123/cvlc来播放mp3，其他播放器用户请根据自己情况进行修改。**请将电脑声音调大**。

## Tips

根据经验，url一般会在1-2小时后失效。因此请在课前获取url启动脚本并睡觉。你可以使用juice ssh或超级本在床上完成这一过程。

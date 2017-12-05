# micro-teaching-assistant-fucker
自动检测是否有老师在微助教发布了新的题 并在特殊情况下及时提醒答题

## Hard PreRequirements

Linux. curl. fish. awk. One mp3 player available on command line.

## Usage

打开微信 微助教 学生 答题，关闭wifi，按住页面选择在浏览器打开，然后复制下这个页面的url。

编辑d.fish，将url填入set \_url "YourURLHere"。

./d.fish 它会每5秒检查一次并判断是否需要答题。

d.fish使用了gnome的notify-send，kde/其他de用户请根据自己的情况选择修改或删除气泡提醒。

d.fish默认使用mpg123/cvlc来播放mp3，其他播放器用户请根据自己情况进行修改。请将电脑声音调大。

## Tips

使用./informed.sh来停止一次提醒。

根据经验，url一般会在1-2小时后失效。因此请在课前获取url启动脚本并睡觉。你可以使用juice ssh或超级本在床上完成这一过程。

警惕以下情形： 老师发出一个题，脚本发出警报，你成功答题，老师在第一个题过期之前发出第2个题，你不知道。

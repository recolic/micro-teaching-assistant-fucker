# micro-teaching-assistant-fucker
自动检测是否有老师在微助教发布了新的题 并在特殊情况下及时提醒答题

## Hard PreRequirements

Linux. curl. fish. awk. One mp3 player available on command line.

## Usage

打开微信 微助教 学生 答题，关闭wifi，按住页面选择在浏览器打开，然后复制下这个页面的url。

编辑d.fish，将url填入set \_url "YourURLHere"。

./d.fish 它会每5秒检查一次并判断是否需要答题。

d.fish使用了gnome的notify-send，kde/其他de用户请根据自己的情况选择修改或删除气泡提醒。

d.fish使用了cvlc来播放mp3，其他播放器用户请根据自己情况进行修改。请将电脑声音调大。

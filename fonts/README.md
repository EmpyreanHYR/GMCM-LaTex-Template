# 字体安装

主文件使用原模板的 `fontset=windows` 配置。编译前请在操作系统中安装所需字体：

| 用途 | 字体名称 |
| --- | --- |
| 中文正文 | SimSun（宋体） |
| 中文标题 | SimHei（黑体） |
| 中文楷体 | KaiTi（楷体） |
| 中文等宽文字 | FangSong（仿宋） |
| 摘要等隶书文字 | LiSu（隶书） |
| 西文正文 | Times New Roman |
| 西文无衬线文字 | Arial |
| 代码 | Courier New |

本目录包含 `SimSun.ttf`、`SimHei.ttf`、`KaiTi.ttf`、`LiSu.ttf` 和 `STXinwei.ttf`，可用于安装和分析。其中 `STXinwei` 未被当前主文件使用；其余所需字体见上表。

macOS：选中字体文件，双击并通过“字体册”安装。Windows：选中字体文件，右键安装。安装完成后运行主文件编译脚本。

模板按系统字体名称加载字体，因此需要先安装，不能仅复制到本目录。

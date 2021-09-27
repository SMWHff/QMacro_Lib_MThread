[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=da7a114a-2775-4102-8c6e-6cba720f4246
Description=多线程立即奔溃例子
Enable=0
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
'#================================================================
'#        【命令库】神梦_多线程例子
'#----------------------------------------------------------------
'#        【作者】：神梦无痕
'#        【ＱＱ】：1042207232
'#        【Ｑ群】：624655641
'#        【更新】：2021-09-27
'#----------------------------------------------------------------
'#  插件说明：解决多线程资源冲突问题
'#----------------------------------------------------------------
'#  神梦工具: http://pan.baidu.com/s/1dESHf8X
'#----------------------------------------------------------------
'#  特别声明：请勿用于非法用途！！（否则后果自负）
'#================================================================



//运行以下代码，保证立即奔溃

//【危险！谨慎操作！！！！！】

If MsgBox("【危险】运行以下代码会导致按键精灵崩溃，您确定要运行吗？", 1 + 48 + 4096, "警告！") <> 1 Then 
	ExitScript 
End If

Dimenv 计次

计次 = 0

For 100
    BeginThread 多线程()
Next

Sub 多线程()
    For 1000
        计次 = 计次 + 1
    Next
    TracePrint 计次
End Sub

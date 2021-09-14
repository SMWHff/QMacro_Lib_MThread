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
MacroID=120a0214-a5c2-4be6-8134-9b733577ec99
Description=【神梦_多线程】多线程稳定奔放例子
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
'===============【多线程稳定奔放例子】===============
'  作者：神梦无痕
'  ＱＱ：1042207232
'　Ｑ群：624655641
'==================================================

//运行以下代码，保证不会奔溃

DimEnv 计次

//初始化命令库，使用前必须调用该命令
Call Lib.神梦_多线程._初始化()

计次 = 0

For 100
    BeginThread 多线程()
Next

Sub 多线程()
    For 100
        '将环境变量名【计次】以字符串传入 
        Call Lib.神梦_多线程.原子_递增("计次") '每执行一次，计次的值+1
    Next
    TracePrint 计次
End Sub

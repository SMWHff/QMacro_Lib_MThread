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
MacroID=f5081328-0680-4e92-ad64-3fa092e5fc8c
Description=表格控件实例_保证显示选中项（多线程信号量）
Enable=0
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=1
QUI=Form1
[Relative]
SetupOCXFile=
[Comment]

[UIPackage]
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


[Script]
DimEnv 信号句柄, 运行行号

//初始化命令库，使用前必须调用该命令
Call Lib.神梦_多线程._初始化()

信号句柄 = Lib.神梦_多线程.信号量创建(5)

For hh = 0 To Form1.Grid1.RowCount - 1
	运行行号 = hh
	BeginThread 执行任务(运行行号)
	Delay 500 '线程数越多，这里的延迟要设置大一点 
Next
Do
	Delay 1000
Loop Until Lib.神梦_多线程.信号量是否空闲(信号句柄)
MsgBox "运行完毕！", 64+4096, "温馨提示！"


Declare Function SetScrollPos Lib "user32" Alias "SetScrollPos" (ByVal hwnd As Long, ByVal nBar As Long, ByVal nPos As Long, ByVal bRedraw As Boolean) As Long
Declare Function SendMessage Lib "user32" Alias "SendMessageW" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Sub 保证显示选择项(行数, 列表框句柄, 列表框高度, 初始行高)
	Dim 初始行数, 滑动位置
	初始行数 = 列表框高度\初始行高
    If 行数 > 初始行数 Then 
    	滑动位置 = 初始行高 * (行数 - 初始行数 + 1)
    Else 
    	滑动位置 = 0
    End If
    SetScrollPos 列表框句柄, 1, 滑动位置, True '滑动条滚动到指定位置
    If 行数 > 初始行数 Then SendMessage 列表框句柄, 277, 1, 0'滑动条向下滚一行
End Sub

Sub 执行任务(行数)    //多线程执行任务
    Dim i, 行号, 次数, n
    行号 = 行数'重新赋值新变量，以免被其他线程影响
    Call Lib.神梦_多线程.信号量等待(信号句柄)
    Call 保证显示选择项(行号, Form1.Grid1.Hwnd, Form1.Grid1.Height, Form1.Grid1.GetRowHeight(0))
    Form1.Grid1.SetProgressBarValue 行号, 7, 0
    次数 = 0
    For i = 0 To 4
        If Form1.Grid1.GetCheckBoxValue(行号, i + 2) = 1 Then   '多选框的勾选返回值是1
            次数 = 次数 + 1
        End If
    Next
    If 次数 = 0 Then Goto 停止    '没有勾选任务，则停止运行
    百分比 = 100 / 次数           '计算进度条的进度值
    n = 0
    For i = 0 To 4
        If Form1.Grid1.GetCheckBoxValue(行号, i + 2) = 1 Then   '多选框的勾选返回值是1
            '在这里，执行的是脚本任务。假设执行完后，任务取消！！！
            Delay 200
            n = n + 1
            Form1.Grid1.SetCheckBoxValue 行号, i + 2, False
            Form1.Grid1.SetProgressBarValue 行号, 7, 百分比 * n
            Delay 500
        End If
    Next
    Rem 停止
    Call 停止状态(行号)
End Sub
 
Sub 运行状态(行)
    Form1.Grid1.SetItemText 行, 8, "运行"
    Form1.Grid1.SetItemText 行, 9, "【点击停止】"
End Sub
Sub 停止状态(行)
    Form1.Grid1.SetItemText 行, 8, "已停止"
    Form1.Grid1.SetItemText 行, 9, "【点击启动】"
End Sub
Sub OnThreadExit()
    Call Lib.神梦_多线程.信号量释放(信号句柄)
End Sub
Sub OnScriptExit()
	Call Lib.神梦_多线程.信号量销毁(信号句柄)
End Sub
Event Form1.LoadOver    //表格内容初始化
    Dim i
    For i = 1 To 100
        Form1.Grid1.SetItemText i, 0, "账号" & i
        Form1.Grid1.SetItemFgColor i, 0, "5EAB25"
        Form1.Grid1.SetItemText i, 1, "窗口" & i
        Form1.Grid1.SetItemFgColor i, 2, "3486F8"
        Form1.Grid1.SetItemFgColor i, 3, "5FB7E3"
        Form1.Grid1.SetItemFgColor i, 5, "B5BE10"
        Form1.Grid1.SetItemFgColor i, 6, "BD53A7"
        Form1.Grid1.SetItemFgColor i, 7, "3486F8"
        Form1.Grid1.SetItemText i, 8, "空闲"
        Form1.Grid1.SetItemFgColor i, 8, "0000FF"
        Form1.Grid1.SetItemText i, 9, "【点击启动】"
        Form1.Grid1.SetItemBkColor i, 9, "D88E0A"
        Form1.Grid1.SetItemFgColor i, 9, "FFFFFF"
        Form1.Grid1.SetCheckBoxValue i, 2, True 
        Form1.Grid1.SetCheckBoxValue i, 3, True
        Form1.Grid1.SetCheckBoxValue i, 4, True
        Form1.Grid1.SetCheckBoxValue i, 5, True
        Form1.Grid1.SetCheckBoxValue i, 6, True 
    Next
    Form1.Grid1.SetColumnEditable 8, False
    Form1.Grid1.SetColumnEditable 9, False
    Redim 任务ID(6)
End Event


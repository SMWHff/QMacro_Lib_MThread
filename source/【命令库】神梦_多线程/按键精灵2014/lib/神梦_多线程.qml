[General]
SyntaxVersion=2
MacroID=652ab43d-d143-47d0-819d-61745b09cade
[Comment]

[Script]
'======================================[��Ҫ�ű����ƿ�������]======================================
'�����ζ��߳�����⡿
'�汾��v1.5
<<<<<<< HEAD
'���£�2021.09.15
=======
'���£�2021.09.27
>>>>>>> my_recovery_branch
'���ߣ������޺�
'�ѣѣ�1042207232
'��Ⱥ��624655641
'================================================================================================
'
'������⡿��WQM����IE+Chrome�ȸ�˫����ҳ������������+����JS+���ܶ�λ{v999}[2018.7.2] http://bbs.anjian.com/showtopic-657914-1.aspx
'
'PC�˹һ�����IP�������̵�IP���ֻ��޼�VPN��������ϵQ��3007328759
'
'����QQ���ֻ����Ƿ�ͨ΢�ţ���ȷ�ȸߴ�99%��������ϵQ��1042207232
'
'================================================================================================
'
'����������������̣�
Declare Function CreateMutex Lib "kernel32" Alias "CreateMutexA" (��ȫ���� As Long , ByVal �Ƿ�����ӵ�� As Long, ByVal �������� As String) As Long
'�������򿪣�����̣�
Declare Function OpenMutex Lib "kernel32" Alias "OpenMutexA" (ByVal Ȩ�� As Long, ByVal �Ƿ�����ӵ�� As Boolean, ByVal �������� As String) As Long
'����������
Declare Function WaitForSingleObject Lib "kernel32" Alias "WaitForSingleObject" (ByVal hHandle As Long, ByVal dwMilliseconds As Long) As Long
'�������˳�
Declare Function ReleaseMutex Lib "kernel32" Alias "ReleaseMutex" (ByVal hMutex As Long)
'
'
'����һ�� Event�¼����󣨿���̣�
Declare Function CreateEvent Lib  "kernel32.dll" Alias  "CreateEventW"(ByVal ��ȫ�Խṹ As Any,ByVal �˹����Զ��¼� As Long,ByVal �Ƿ��ڲ����� As Long,ByVal �¼������� As String) As Long
'�ȴ�������/ӵ�����Event�¼�����
Declare Function WaitForSingleObject Lib  "kernel32.dll" Alias  "WaitForSingleObject"(ByVal hObjcte As Any,ByVal Time As Long) As Long
'��Event�¼���������Ϊ���ź�״̬������״̬
Declare Function SetEvent Lib  "kernel32.dll" Alias  "SetEvent"(ByVal hObjcte As Any) As Long
'��Event�¼���������Ϊ���ź�״̬������/�Ǵ���״̬��
Declare Function ResetEvent Lib  "kernel32.dll" Alias  "ResetEvent"(ByVal hObjcte As Any) As Long
'
'
Declare Function CreateEventLong Lib  "kernel32.dll" Alias  "CreateEventW"(ByVal ��ȫ�Խṹ As Any,ByVal �˹����Զ��¼� As Long,ByVal �Ƿ��ڲ����� As Long,ByVal �¼������� As Long) As Long
'
'�ر�һ���ں˶������а����ļ����ļ�ӳ�䡢���̡��̡߳���ȫ��ͬ������ȡ�
Declare Function CloseHandle Lib "kernel32" Alias "CloseHandle" (ByVal hObject As Long) As Long

'���ڻ�ȡ��windows��������������ʱ�䳤�ȣ����룩
Declare Function GetTickCount Lib "kernel32" () As Long

'��ȡ��ǰ�߳�һ��Ψһ���̱߳�ʶ��
Declare Function GetCurrentThreadId Lib "kernel32" Alias "GetCurrentThreadId" () As Long

'���ڴ�һ�������̶߳���
Declare Function OpenThread Lib "kernel32" (ByVal dwDesiredAccess As Long, ByVal bInheritHandle As Long, ByVal dwThreadId As Long) As Long

'�����߳� ��ͣ���� ������ ���ָ��� ������ִ��
Declare Function SuspendThread Lib "kernel32" Alias "SuspendThread" (ByVal hThread As Long) As Long

'�ָ��������б�������߳�
Declare Function ResumeThread Lib "kernel32" Alias "ResumeThread" (ByVal hThread As Long) As Long

'ǿ�ƽ����̡߳�(���Ƽ�ʹ��)
Declare Function TerminateThread Lib "kernel32" (ByVal hThread As Long, ByVal dwExitCode As Long) As Long

'��ȡ�߳����ȼ�
Declare Function GetThreadPriority Lib "kernel32" Alias "GetThreadPriority" (ByVal hThread As Long) As Long

'�����߳����ȼ�
Declare Function SetThreadPriority Lib "kernel32" Alias "SetThreadPriority" (ByVal hThread As Long, ByVal nPriority As Long) As Long

'����CPU�׺���/��CPU
Declare Function SetProcessAffinityMask Lib "kernel32.dll" (ByVal hProcess As Long, ByVal dwProcessAffinityMask As Long) As Long
'
'
'--------------------------------[�������]--------------------------------
Dimenv DimEnv_Thread_Init, DimEnv_Thread_Tally, DimEnv_Thread_Data, DimEnv_Thread_NewTips, DimEnv_ԭ�Ӿ��
Dimenv DimEnv_Coroutine_IDs(99), DimEnv_Coroutine_Index
'
'--------------------------------[ԭ����]--------------------------------
Sub ԭ��_��ʼ��()
    If DimEnv_Thread_Init Then 
        DimEnv_ԭ�Ӿ�� = CreateEventLong(0, 0, 1, 0)
    Else
        If Not IsObject(Msg) Then Set Msg = CreateObject("QMPlugin.Msg") 
        Msg.Tips "��������ִ�С�_��ʼ��()�������ʼ������⣡" : TracePrint Dim_Tips
    End If
End Sub
Sub ԭ��_����()
    Call CloseHandle(DimEnv_ԭ�Ӿ��)
End Sub
Sub ԭ��_����(������)
    Call WaitForSingleObject(DimEnv_ԭ�Ӿ��, 4294967295)
    SetEnv ������, GetEnv(������) + 1
    Call SetEvent(DimEnv_ԭ�Ӿ��)
End Sub
Sub ԭ��_�ݼ�(������)
    Call WaitForSingleObject(DimEnv_ԭ�Ӿ��, 4294967295)
    SetEnv ������, GetEnv(������) - 1
    Call SetEvent(DimEnv_ԭ�Ӿ��)
End Sub
Sub ԭ��_��ֵ(������, ��ֵ)
    Call WaitForSingleObject(DimEnv_ԭ�Ӿ��, 4294967295)
    SetEnv ������, ��ֵ
    Call SetEvent(DimEnv_ԭ�Ӿ��)
End Sub
Sub ԭ��_����(������, ����������)
    Dim Temp
    Call WaitForSingleObject(DimEnv_ԭ�Ӿ��, 4294967295)
    Temp = GetEnv(������)
    SetEnv ������, GetEnv(����������)
    SetEnv ����������, Temp
    Call SetEvent(DimEnv_ԭ�Ӿ��)
End Sub
Sub ԭ��_����(������, ��ֵ)
    Call WaitForSingleObject(DimEnv_ԭ�Ӿ��, 4294967295)
    SetEnv ������, GetEnv(������) + ��ֵ
    Call SetEvent(DimEnv_ԭ�Ӿ��)
End Sub
Sub ԭ��_��Ŀ����(������, ��ֵ, �Ա�ֵ)
    Call WaitForSingleObject(DimEnv_ԭ�Ӿ��, 4294967295)
    If GetEnv(������) = �Ա�ֵ Then 
        SetEnv ������, ��ֵ
    End If
    Call SetEvent(DimEnv_ԭ�Ӿ��)
End Sub
Sub ԭ��_�������(��ʾ)
    Call WaitForSingleObject(DimEnv_ԭ�Ӿ��, 4294967295)
    TracePrint ��ʾ
    Call SetEvent(DimEnv_ԭ�Ӿ��)
End Sub
'
'
'
'--------------------------------[�ص�����]--------------------------------
' ���ûص����� CallBack
' �������=BeginThread(������)
/*
	Function �Զ���ص�����ģ��()
		Rem Start                                  '�����桿�������벻Ҫ�Ҷ�
		�����б� = Lib.����_���߳�.�ص�����_ȡ����()  '�����桿�������벻Ҫ�Ҷ�
		'-------------------------------------------
		
		
		
		
		//�м�Ĵ�����Ըĳ����Լ���
		For i = 0 To UBound(�����б�)
			TracePrint "��� "& i &" �Ĳ���Ϊ��" & �����б�(i)
		Next 
		����ֵ = "OK"
		
		
		
		'-------------------------------------------
		Call Lib.����_���߳�.�ص�����_����(����ֵ):Goto Start   '�����桿�������벻Ҫ�Ҷ�
	End Function
*/
Function �ص�����_����(�������, ����1, ����2, ����3, ����4)
    If DimEnv_Thread_Init Then 
    	Dim Result, hThread
    	hThread = OpenThread(&H1F0FFF, 0, CLng(�������))
    	If IsNumeric(CStr(hThread)) = False Or hThread = "0" Then Goto over
    	If ����1 <> "" Then SetEnv "Arguments[0]#" & �������, ����1
    	If ����2 <> "" Then SetEnv "Arguments[1]#" & �������, ����2
    	If ����3 <> "" Then SetEnv "Arguments[2]#" & �������, ����3
    	If ����4 <> "" Then SetEnv "Arguments[3]#" & �������, ����4
    	If IsNumeric(CStr(GetEnv("Arguments.Count#" & �������))) = False Then SetEnv "Arguments.Count#" & �������, 4
    	SetEnv "Return#" & �������, Empty
    	ContinueThread �������
    	Do
        	Result = GetEnv("Return#" & �������)
        	Delay 500
    	Loop Until TypeName(Result) <> "Empty"
    	Rem over
    	�ص�����_���� = Result
    Else
        If Not IsObject(Msg) Then Set Msg = CreateObject("QMPlugin.Msg") 
        Msg.Tips "��������ִ�С�_��ʼ��()�������ʼ������⣡" : TracePrint Dim_Tips
    End If
End Function
'
' �ص�����_ȡ���� GetFnArguments
Function �ص�����_ȡ����()
    Dim Length, i
    CallBack_ReturnValue = ""
    If CallBack_ThreadID = "" Then CallBack_ThreadID = GetThreadID()
    Length = GetEnv("Arguments.Count#" & CallBack_ThreadID)
    ReDim RetArr(Length-1)
    For i = 0 To Length - 1
        RetArr(i) = GetEnv("Arguments["& i &"]#" & CallBack_ThreadID)
    Next
    �ص�����_ȡ���� = RetArr
    Erase RetArr
End Function
'
' �ص�����_�ò��� SetFnArguments
Function �ص�����_�ò���(�������, �������, ��������)
    Dim Length, hThread
    hThread = OpenThread(&H1F0FFF, 0, CLng(�������))
    If IsNumeric(CStr(hThread)) = False Or hThread = "0" Then Goto over
    SetEnv "Arguments[" & CLng(�������) & "]#" & �������, ��������
    Length = GetEnv("Arguments.Count#" & CallBack_ThreadID)
    If IsNumeric(CStr(GetEnv("Arguments.Count#" & �������))) = False Then 
        Length = 4
    End If 
    If CLng(Length) < CLng(�������) Then 
        Length = CLng(�������)
    End If
    SetEnv "Arguments.Count#" & �������, CLng(Length)
    Rem over
    �ص�����_�ò��� = CLng(Length)
End Function 
'
' �ص�����_���� ReturnV
Function �ص�����_����(����ֵ)
    If CallBack_ThreadID = "" Then CallBack_ThreadID = GetThreadID()
    If ����ֵ = ""             Then ����ֵ = CallBack_ReturnValue
    SetEnv "Return#" & CallBack_ThreadID, ����ֵ
    PauseThread CallBack_ThreadID
End Function
'
'
'
'--------------------------------[������]--------------------------------
Function ����������()
    If DimEnv_Thread_Init Then 
        Dim ����ʶ, i
        ����ʶ = "������_�����޺�_QQ��1042207232_�ɡ��������ṩ_"
        For i = 0 To 12 : Randomize :����ʶ = ����ʶ & Chr((24 * Rnd) + 65) :Next
        ���������� = CreateMutex(0, false, ����ʶ)
    Else
        If Not IsObject(Msg) Then Set Msg = CreateObject("QMPlugin.Msg") 
        Msg.Tips "��������ִ�С�_��ʼ��()�������ʼ������⣡" : TracePrint Dim_Tips
    End If
End Function
Sub ����������(�����)
    Call WaitForSingleObject(�����, 4294967295)
End Sub
Sub �������˳�(�����)
    Call ReleaseMutex(�����)
End Sub
Sub ����������(�����)
    Call CloseHandle(�����)
End Sub
'
'--------------------------------[�ٽ���]--------------------------------
Function �ٽ�������()
    If DimEnv_Thread_Init Then 
        Dim ��ɱ�ʶ, i
        ��ɱ�ʶ = "�ٽ����_�����޺�_QQ��1042207232_���֤_"
        For i = 0 To 12 : Randomize :��ɱ�ʶ = ��ɱ�ʶ & Chr((24 * Rnd) + 65) :Next
        �ٽ������� = CreateEvent(0, 0, 1, ��ɱ�ʶ)
    Else
        If Not IsObject(Msg) Then Set Msg = CreateObject("QMPlugin.Msg") 
        Msg.Tips "��������ִ�С�_��ʼ��()�������ʼ������⣡" : TracePrint Dim_Tips
    End If
End Function
Sub �ٽ�������(���֤)
    Call WaitForSingleObject(���֤, 4294967295)
End Sub
Sub �ٽ����˳�(���֤)
    Call SetEvent(���֤)
End Sub
Sub �ٽ�������(���֤)
    Call CloseHandle(���֤)
End Sub
'
'--------------------------------[�¼�]--------------------------------
Function �¼�����()
    If DimEnv_Thread_Init Then 
        Dim �¼���ʶ, i
        �¼���ʶ = "�¼�_�����޺�_QQ��1042207232_�ɡ���__���ɡ��ṩ_"
        For i = 0 To 12 : Randomize :�¼���ʶ = �¼���ʶ & Chr((24 * Rnd) + 65) :Next
        �¼����� = CreateEvent(0, 0, 1, �¼���ʶ)
    Else
        If Not IsObject(Msg) Then Set Msg = CreateObject("QMPlugin.Msg") 
        Msg.Tips "��������ִ�С�_��ʼ��()�������ʼ������⣡" : TracePrint Dim_Tips
    End If
End Function
Sub �¼�����(�¼����)
    Call WaitForSingleObject(�¼����, 4294967295)
End Sub
Sub �¼��˳�(�¼����)
    Call SetEvent(�¼����)
End Sub
Sub �¼�����(�¼����)
    Call CloseHandle(�¼����)
End Sub
'
'--------------------------------[������]--------------------------------
Function ����������()
    If DimEnv_Thread_Init Then 
        ���������� = GetThreadID() + Int(GetTickCount() * Rnd)
    Else
        If Not IsObject(Msg) Then Set Msg = CreateObject("QMPlugin.Msg") 
        Msg.Tips "��������ִ�С�_��ʼ��()�������ʼ������⣡" : TracePrint Dim_Tips
    End If
End Function
Sub ����������(�����)
    Dim ��ID��ʶ, ��״̬��ʶ
    ��ID��ʶ = "������_�����޺�_QQ��1042207232_�ɡ�a188652011���ṩ_�߳�ID_" & �����
    ��״̬��ʶ = "������_�����޺�_QQ��1042207232_�ɡ�a188652011���ṩ_״̬_" & �����
    Do While GetEnv(��ID��ʶ) <> GetThreadID()
        While GetEnv(��״̬��ʶ) = True
            '�����߳��ڲ����ˣ��ͽ���ȴ������е��ؼ��ʱ��
            '�������̲߳�ͬ��,��ռ����ܵ�һЩ    
            Delay Int((200 - 100 + 1) * Rnd + 100) '�߳�Խ�࣬�ӳٵķ�Χ��ʵҪ����ź��ʡ�
        Wend
        '�������߳����ڵȴ�����,�������ٲ��ֵ��̻߳ᵽ��һ��
        SetEnv ��״̬��ʶ, True
        '�Լ����߳�ID ����Ҫ��
        SetEnv ��ID��ʶ, GetThreadID()
        '�ȴ������߳�Ҳ���̱߳���д��
        '��������ʵ����ӳ�һ�㣬�����ʸ���
        Delay Int((20 - 10 + 1) * Rnd + 10)
    Loop
End Sub
Sub �������˳�(�����)
    Dim ��ID��ʶ, ��״̬��ʶ
    ��ID��ʶ = "������_�����޺�_QQ��1042207232_�ɡ�a188652011���ṩ_�߳�ID_" & �����
    ��״̬��ʶ = "������_�����޺�_QQ��1042207232_�ɡ�a188652011���ṩ_״̬_" & �����
    SetEnv ��ID��ʶ, 0
    SetEnv ��״̬��ʶ, False
End Sub
'
'
'--------------------------------[�ź���]--------------------------------
'���ߣ������޺�
'�ѣѣ�1042207232
'��Ⱥ��624655641
'
/*���������������߳� --> �ճ�λ��
��һ��ͣ����������Ϊ���������������ͣ����ֻ��������λ���������ޡ��� 
һ��ʼ������λ���ǿյġ������̡߳�����ʱ���ͬʱ������������������������������ֱ�ӽ��롾�����߳�-3���� 
Ȼ����³������ź����ȴ�����ʣ�µĳ����������ڵȴ����˺����ĳ�Ҳ�����ò�����ڴ��ȴ��� 
��ʱ����һ�����뿪ͣ�����������߳�+1���������˵�֪�󣬴򿪳������ź����ͷš������������һ����ȥ�������߳�-1����
������뿪�����������߳�+2�������ֿ��Է��������������߳�-2������������� 

�����ͣ����ϵͳ�У���λ�ǹ�����Դ��ÿ�����ñ�һ���̣߳���������ľ����ź��������á�
*/
Function �ź�������(��������)
    If DimEnv_Thread_Init Then 
        Dim �źű�ʶ, i, Ret, ��ʶ_�����߳�, ��ʶ_��������
        �źű�ʶ = "�ź���_�����޺�_QQ��1042207232_"
        For i = 0 To 12 : Randomize :�źű�ʶ = �źű�ʶ & Chr((24 * Rnd) + 65) :Next
        If IsNumeric(CStr(��������)) = False Or �������� = "0" Then �������� = 1
        Ret = CreateEvent(0, 0, 1, �źű�ʶ)
        ��ʶ_�����߳� = "�ź���_�����޺�_QQ��1042207232_�����߳�_" & Ret
        ��ʶ_�������� = "�ź���_�����޺�_QQ��1042207232_��������_" & Ret
        SetEnv ��ʶ_�����߳�, ��������
        SetEnv ��ʶ_��������, ��������
        �ź������� = Ret
    Else
        If Not IsObject(Msg) Then Set Msg = CreateObject("QMPlugin.Msg") 
        Msg.Tips "��������ִ�С�_��ʼ��()�������ʼ������⣡" : TracePrint Dim_Tips
    End If
End Function
Function �ź����Ƿ����(�źž��)
    Dim ��ʶ_�����߳�, ��ʶ_��������
    ��ʶ_�����߳� = "�ź���_�����޺�_QQ��1042207232_�����߳�_" & �źž��
    ��ʶ_�������� = "�ź���_�����޺�_QQ��1042207232_��������_" & �źž��
    �ź����Ƿ���� = (GetEnv(��ʶ_�����߳�) = GetEnv(��ʶ_��������))
End Function 
Sub �ź����ȴ�(�źž��)
    Dim ��ʶ_�����߳�
    ��ʶ_�����߳� = "�ź���_�����޺�_QQ��1042207232_�����߳�_" & �źž��
    Call WaitForSingleObject(�źž��, 4294967295)
    While GetEnv(��ʶ_�����߳�) = 0
        '�ж��Ƿ��п����߳�
    Wend
    SetEnv ��ʶ_�����߳�, GetEnv(��ʶ_�����߳�) - 1
    If GetEnv(��ʶ_�����߳�) <> 0 Then Call SetEvent(�źž��)
    Dim_ThreadID = GetThreadID()
End Sub
Sub �ź����ͷ�(�źž��)
    Dim ��ʶ_�����߳�, ��ʶ_��������
    If Dim_ThreadID = GetThreadID() Then '�ж��Ƿ���ͬһ�߳���
        ��ʶ_�����߳� = "�ź���_�����޺�_QQ��1042207232_�����߳�_" & �źž��
        ��ʶ_�������� = "�ź���_�����޺�_QQ��1042207232_��������_" & �źž��
        If GetEnv(��ʶ_��������) > GetEnv(��ʶ_�����߳�) Then
            SetEnv ��ʶ_�����߳�, GetEnv(��ʶ_�����߳�) + 1
        End If
        Call SetEvent(�źž��)
    End If 
End Sub
Sub �ź�������(�źž��)
    Call CloseHandle(�źž��)
End Sub 
'
'--------------------------------[��д��]--------------------------------
'���ߣ������޺�
'�ѣѣ�1042207232
'��Ⱥ��624655641
'
/*��������
��д��ʵ����һ������������������ѶԹ�����Դ�ķ����߻��ֳɶ�ȡ�ߺ�д���ߣ���ȡ��ֻ�Թ�����Դ���ж����ʣ�д��������Ҫ�Թ�����Դ����д������ 
����������д���⡣

��������
���ںڰ�����д��Ϊ������ʦ��д���ߣ�ѧ���Ƕ�ȡ�ߣ������ʦ�ںڰ���дһ�����족�֣�
�����ʦû��д�꣬�Ͷ�ȡ�Ļ���������һ����һ���֡����ߡ������֣��ⲻ��������Ҫ�ģ� 
���Ա������ʦд�꣬ѧ���ٶ�ȡ�ڰ��ϵ����ݲ�����ȷ�ģ� 
��ʦ��ѧ��������û��ѧ��˵�����ˣ���ʦ�ͰѺڰ���ɾ��ˣ� 

ÿ��ѧ������һ���̣߳�����ͬʱ��ȡ������������ 
��ʦд��ʱ��ѧ���ȴ���ʦд���ٶ�ȡ��д�����⡿��
��ѧ���������ˣ���ʦ�Ż�Ѻڰ��߸ɾ�����д���⡿��
*/
Function ��д������()
    If DimEnv_Thread_Init Then 
        Dim ��ʶ_��ȡ��, ��ʶ_д����, Ret
        Ret = CreateEventLong(0, 0, 1, 0)
        ��ʶ_��ȡ�� = "��д��_�����޺�_QQ��1042207232_��ȡ��_" & Ret
        ��ʶ_д���� = "��д��_�����޺�_QQ��1042207232_д����_" & Ret
        SetEnv ��ʶ_д����, CreateEvent(0, 1, 1, ��ʶ_д����)
        SetEnv ��ʶ_��ȡ��, CreateMutex(0, false, ��ʶ_��ȡ��)
        SetEnv Ret, 0
        ��д������ = Ret
    Else
        If Not IsObject(Msg) Then Set Msg = CreateObject("QMPlugin.Msg") 
        Msg.Tips "��������ִ�С�_��ʼ��()�������ʼ������⣡" : TracePrint Dim_Tips
    End If
End Function
Sub ��д��������(��д���)
    Dim ��ʶ_��ȡ��, ��ʶ_д����, code, Ret
    Ret = False 
    ��ʶ_��ȡ�� = "��д��_�����޺�_QQ��1042207232_��ȡ��_" & ��д���
    ��ʶ_д���� = "��д��_�����޺�_QQ��1042207232_д����_" & ��д���
    code = WaitForSingleObject(GetEnv(��ʶ_��ȡ��), 4294967295)
    If code = 258 Then 
        Goto over
    End If
    Call WaitForSingleObject(��д���, 4294967295) 'ԭ��������
    SetEnv ��д���, GetEnv(��д���) + 1
    If GetEnv(��д���) = 1 Then 
        Call ResetEvent(GetEnv(��ʶ_д����))
    End If
    Call SetEvent(��д���) 'ԭ��������
    Call ReleaseMutex(GetEnv(��ʶ_��ȡ��))
    Ret = True 
    Rem over
    ��д�������� = Ret
End Sub
Sub ��д��д����(��д���)
    Dim ��ʶ_��ȡ��, ��ʶ_д����, code, Ret
    Ret = False 
    ��ʶ_��ȡ�� = "��д��_�����޺�_QQ��1042207232_��ȡ��_" & ��д���
    ��ʶ_д���� = "��д��_�����޺�_QQ��1042207232_д����_" & ��д���
    code = WaitForSingleObject(GetEnv(��ʶ_��ȡ��), 4294967295)
    If code = 258 Then 
        Goto over
    End If
    code = WaitForSingleObject(GetEnv(��ʶ_д����), 4294967295)
    If code = 258 Then 
        Call ReleaseMutex(GetEnv(��ʶ_д����))
        Goto over
    End If
    Ret = True
    Rem over
    ��д��д���� = Ret
End Sub
Sub ��д������(��д���)
    Dim ��ʶ_��ȡ��, ��ʶ_д����, code
    ��ʶ_��ȡ�� = "��д��_�����޺�_QQ��1042207232_��ȡ��_" & ��д���
    ��ʶ_д���� = "��д��_�����޺�_QQ��1042207232_д����_" & ��д���
    If ReleaseMutex(GetEnv(��ʶ_��ȡ��)) = 0 Then 
        Call WaitForSingleObject(��д���, 4294967295) 'ԭ��������
        SetEnv ��д���, GetEnv(��д���) - 1
        If GetEnv(��д���) = 0 Then 
            Call SetEvent(GetEnv(��ʶ_д����)) 
        End If
        Call SetEvent(��д���) 'ԭ��������
    End If
End Sub
Sub ��д������(��д���)
    Dim ��ʶ_��ȡ��, ��ʶ_д����
    ��ʶ_��ȡ�� = "��д��_�����޺�_QQ��1042207232_��ȡ��_" & ��д���
    ��ʶ_д���� = "��д��_�����޺�_QQ��1042207232_д����_" & ��д���
    Call CloseHandle(GetEnv(��ʶ_��ȡ��))
    Call CloseHandle(GetEnv(��ʶ_д����))
    Call CloseHandle(��д���)
End Sub 
'
'
'
'--------------------------------[�߳�]--------------------------------
'ͨ���߳�ID��ȡ�߳̾��
//Function �߳�_ȡ�߳̾��(�߳�ID)
//    �߳�_ȡ�߳̾�� = OpenThread(&H1F0FFF, 0, �߳�ID)
//End Function
'
'��ȡ��ǰ�߳�ID
Function �߳�_ȡ��ǰID()
    �߳�_ȡ��ǰID = GetThreadID()  //OpenThread(&H1F0FFF, 0, GetCurrentThreadId())
End Function
'
'ǿ�ƽ����߳�
Function �߳�_����(�߳�ID)
    �߳�_���� = StopThread(�߳�ID)  //TerminateThread(�߳̾��, 0)
End Function

'���=-15����=-2�����ڱ�׼=-1����׼=0�����ڱ�׼=1����=2�����=15
Sub �߳�_�����ȼ�(�߳�ID, ����)
    Call SetThreadPriority(OpenThread(&H1F0FFF, 0, CLng(�߳�ID)), CLng(����))
End Sub

Function �߳�_ȡ���ȼ�(�߳�ID)
    �߳�_ȡ���ȼ� = GetThreadPriority(OpenThread(&H1F0FFF, 0, CLng(�߳�ID)))
End Function

Function �߳�_�ָ�(�߳�ID)
    �߳�_�ָ� = ContinueThread(�߳�ID) //ResumeThread(�߳̾��)
End Function

Function �߳�_����(�߳�ID)
    �߳�_���� = PauseThread(�߳�ID) //SuspendThread(�߳̾��)
End Function

'0=�߳��ѽ���  1=�߳���������  -1=�߳̾����ʧЧ������
Function �߳�_ȡ״̬(�߳�ID)
    Dim Ret, �߳̾��
    Ret = -1
    �߳̾�� = OpenThread(&H1F0FFF, 0, CLng(�߳�ID))
    If IsNumeric(CStr(�߳̾��)) = False Or �߳̾�� = "0" Then Goto over
    Ret = WaitForSingleObject(�߳̾��, 0)
    If Ret = 258 Then 
        Ret = 1
    ElseIf Ret = -1 Then
        Ret = -1
    Else 
        Ret = 0
    End If
    Rem over
    �߳�_ȡ״̬ = Ret
End Function
'
' ���߳�ID��ӽ�Э���� 
Sub Э��_���(�߳�ID)
    PauseThread �߳�ID
    If DimEnv_Thread_Init Then 
        Dim i, ID
        If DimEnv_Coroutine_Index = "" Then DimEnv_Coroutine_Index = 0
        For i = 0 To 99
            ID = GetEnv("Э���߳�ID[" & i & "]")
            If ID = "" Or ID = "0" Then 
                SetEnv "Э���߳�ID[" & i & "]", �߳�ID
                Exit Sub 
            End If
        Next
        If Not IsObject(Msg) Then Set Msg = CreateObject("QMPlugin.Msg") 
        Msg.Tips "����Э������ӵ��̴߳ﵽ99�������ˣ�" : TracePrint Dim_Tips
    Else
        If Not IsObject(Msg) Then Set Msg = CreateObject("QMPlugin.Msg") 
        Msg.Tips "��������ִ�С�_��ʼ��()�������ʼ������⣡" : TracePrint Dim_Tips
    End If
End Sub
'
' ����Э�̣���Ҫ�Ƚ��߳���ӽ�Э�����������
' �������ȴ������߳�������ϲŻ��˳���
Sub Э��_����()
    Dim Ret, i, ID
    ID = GetEnv("Э���߳�ID[" & DimEnv_Coroutine_Index & "]")
    If ID <> "" Then 
        ContinueThread ID
        Do
            Ret = 0
            For i = 0 To 99
                ID = GetEnv("Э���߳�ID[" & i & "]")
                If ID = "" Then Goto Continue
                If ID = "0" Then Goto Continue
                If �߳�_ȡ״̬(ID) <> 1 Then Goto Continue
                Ret = 1
                Rem Continue
            Next
            Delay 100
        Loop Until Ret = 0
    Else 
        If Not IsObject(Msg) Then Set Msg = CreateObject("QMPlugin.Msg") 
        Msg.Tips "��������ִ�С�Э��_���()�������Ӷ��̵߳�Э���ڣ�" : TracePrint Dim_Tips
    End If
End Sub
'
'������ŵ����߳̿�ͷ
Sub Э��_�߳̿�ʼ()
    Dim_ThreadID = GetThreadID()
    Delay 100
End Sub
'
'������ŵ����߳���ÿ�������� 
Sub Э��_�߳��л�()
    Dim ID, t, s, ms
    Dim ct, cs, index
    
    If Dim_ThreadWait Then Dim_ThreadWait = False : Exit Sub  
    If [�ȴ�] <> "" Then 
        SetEnv "GetTick#" & Dim_ThreadID, GetTickCount()
        SetEnv "Delay#" & Dim_ThreadID, [�ȴ�]
        [�ȴ�] = ""
    End If
    ct = GetEnv("GetTick#" & Dim_ThreadID) : If ct = "" Then ct = 0
    cs = GetEnv("Delay#" & Dim_ThreadID) : If cs = "" Then cs = 0
    index = DimEnv_Coroutine_Index
    Rem �����л�
    ' Э�̴���ID������+1
    index = index + 1
    ' ������������������������
    If index > 99 Then index = 0
    ' ���ID�����ڣ�����Ҳ����Ϊ��
    If GetEnv("Э���߳�ID[" & index & "]") = "" Then index = 0
    ' ��ȡ���������ID
    ID = GetEnv("Э���߳�ID[" & index & "]")
    If ID <> "" And ID <> "0" And Dim_ThreadID <> ID Then 
    	t = GetEnv("GetTick#" & ID) : If t = "" Then t = 0
    	s = GetEnv("Delay#" & ID) : If s = "" Then s = 0
    	If GetTickCount() - t > s Then 
        	DimEnv_Coroutine_Index = index
        	' �л��߳�
        	ContinueThread ID
        	' ��ͣ��ǰ�̣߳���Ҫ��ǰ�߳�ID����0��
        	If Dim_ThreadID > 0 Then PauseThread Dim_ThreadID
			' �����ӳ���
        	Exit Sub 
        Else
        	Delay 1
        	Goto �����л�
        End If
    Else
    	' �в���ȥ��ֻ���ڵ�ǰ�̼߳���ִ��
    	' ����Ҫ�жϵ�ǰ�߳��Ƿ��еȴ�
    	While (GetTickCount() - ct <= cs)
    		Delay 1
    		If ID = "" Or ID = "0" Then Goto �����л�
    	Wend
    	DimEnv_Coroutine_Index = index
    End If
End Sub
'
' �����滻���߳���� Delay ��䣬�滻����Э����ִ�и���Ч
Function Э��_�̵߳ȴ�(����)
    Dim ID, t, s, ms
    Dim ct, cs, index
    
    Dim_ThreadWait = True 
    ct = GetTickCount()
    cs = CLng(����)
    SetEnv "GetTick#" & Dim_ThreadID, ct
    SetEnv "Delay#" & Dim_ThreadID, cs
    index = DimEnv_Coroutine_Index
    Rem �����л�
    ' Э�̴���ID������+1
    index = index + 1
    ' ������������������������
    If index > 99 Then index = 0
    ' ���ID�����ڣ�����Ҳ����Ϊ��
    If GetEnv("Э���߳�ID[" & index & "]") = "" Then index = 0
    ' ��ȡ���������ID
    ID = GetEnv("Э���߳�ID[" & index & "]")
    If ID <> "" And ID <> "0" And Dim_ThreadID <> ID Then 
    	t = GetEnv("GetTick#" & ID) : If t = "" Then t = 0
    	s = GetEnv("Delay#" & ID) : If s = "" Then s = 0
    	If GetTickCount() - t > s Then 
        	DimEnv_Coroutine_Index = index
        	' �л��߳�
        	ContinueThread ID
        	' ��ͣ��ǰ�̣߳���Ҫ��ǰ�߳�ID����0��
        	If Dim_ThreadID > 0 Then PauseThread Dim_ThreadID
			' �����ӳ���
        	Exit Function 
        Else
        	Delay 1
        	Goto �����л�
        End If
    Else
    	' �в���ȥ��ֻ���ڵ�ǰ�̼߳���ִ��
    	' ����Ҫ�жϵ�ǰ�߳��Ƿ��еȴ�
    	While (GetTickCount() - ct <= cs)
    		Delay 1
    		If ID = "" Or ID = "0" Then Goto �����л�
    	Wend
    	DimEnv_Coroutine_Index = index
    End If
End Function
'
'���������ŵ��߳�ֹͣ�¼��� 
Sub Э��_�߳̽���()
    Dim i
    For i = 0 To 99
        If GetEnv("Э���߳�ID[" & i & "]") = Dim_ThreadID Then 
        	SetEnv "GetTick#" & Dim_ThreadID, Empty
        	SetEnv "Delay#" & Dim_ThreadID, Empty
            SetEnv "Э���߳�ID[" & i & "]", 0
            Exit For 
        End If
    Next
    Dim_ThreadID = 0
    Dim_ThreadWait = False
    Call Э��_�߳��л�()
End Sub
'
'
Sub A_______________________________________()
End Sub
Sub A���ѣѡ���1042207232()
End Sub
Sub A�����ߡ��������޺�()
End Sub
Sub B________����Ҫ�ű�����Q�ң�_____________()
End Sub

'//��ʼ������⣬ʹ��ǰ������ø�����
'����ֵ���߼��ͣ��Ƿ�ɹ�
Function _��ʼ��()
    Dim Ret
    '-----------------------����ǰ�汾�š�-----------------------
    ��ǰ�汾 = "1.5"
    '-----------------------------------------------------------
    If DimEnv_Thread_Init = "" Then
<<<<<<< HEAD
    	Import "Msg.dll"
    	Import "Sys.dll"
    	Import "Window.dll"
    	DimEnv_Thread_Tally = 0
    	DimEnv_Thread_NewTips = "������£�"
    	Execute _
=======
        Import "Msg.dll"
        Import "Sys.dll"
        Import "Window.dll"
        DimEnv_Thread_Tally = 0
        DimEnv_Thread_NewTips = "������£�"
        Execute _
>>>>>>> my_recovery_branch
    	"On Error Resume Next:" & _
    	"Set Window = CreateObject(""QMPlugin.Window""):" & _
    	"If Window.Search(""��������"") <> """" Then:" & _
    	"Set xmlHttp = CreateObject(""WinHttp.WinHttpRequest.5.1""):" & _
    	"xmlHttp.open ""GET"", ""http://www.smwh.online/Office/SoftwTally/SoftwTally.asp?SoftName=����_���߳�&Rem="& ��ǰ�汾 &"&SN="& Sys.GetHDDSN() &""", True:" & _
    	"xmlHttp.send:" & _
    	"If xmlHttp.waitForResponse(1) Then:" & _
    	"    If xmlHttp.statusText = ""OK"" Then:" & _
    	"        SetEnv ""DimEnv_Thread_Tally"", xmlHttp.responseText:" & _
    	"    End If:" & _
    	"End If:" & _
		"NewVer=0:Set RepEx=New RegExp:RepEx.IgnoreCase=True:RepEx.Global=True:RepEx.Pattern=""\{v(.*?)\}"":" & _
		"xmlHttp.open ""GET"", ""https://360biji.com/note/view/643814"", True:" & _
		"xmlHttp.send:" & _
		"If xmlHttp.waitForResponse(1) Then:" & _
		"    If xmlHttp.statusText = ""OK"" Then:" & _
		"        Text = xmlHttp.responseText:" & _
		"    End If:" & _
		"End If:" & _
		"L1 = InStr(Text, ""�����桿""):L2 = InStr(Text, ""��/���桿""):" & _
		"If L1 > 0 And L2 > 0 Then:" & _
		"   Arr = Split(Mid(Text, L1+4, L2-L1-4) & vbCrLf & UnEscape(""%u5E7F%u544A%u4F4D%u51FA%u79DF%uFF0C%u8054%u7CFBQQ%uFF1A1042207232""), vbCrLf):" & _
		"   if UBound(Arr)>-1 Then:" & _
		"       Randomize:n = CInt((UBound(Arr)+1)*Rnd+1)-1:" & _
		"	    SetEnv ""DimEnv_Thread_Data"", ""<!--"" & Arr(n) & ""-->"" & Space(1024) & ""<span style='color:FF00FF'>"" & Arr(n) & ""</span>"":" & _
		"   End If:" & _
		"End If:" & _
		"If RepEx.Test(Text) Then:" & _
		"    NewVer = RepEx.Execute(Text).Item(0).SubMatches.Item(0):" & _
		"    If Not IsNumeric(Replace(NewVer, ""."", """")) Then:" & _
		"        NewVer = 0:" & _
		"    End If:" & _
		"End If:" & _
		"If NewVer > """& ��ǰ�汾 &""" Then:" & _
		"	SetEnv ""DimEnv_Thread_NewTips"", ""�����µİ汾v"" & NewVer & ""�����Խ�Ⱥ���أ�""& Space(1024) & ""<img src='#' onerror='this.parentNode.style.color=""""#ff0000""""' style='display:none'>"":" & _
		"End If:End If:SetEnv ""DimEnv_Thread_Init"", true"
    End If
    ' ����Э������
    DimEnv_Coroutine_Index = 0
    For i = 0 To 99
        SetEnv "Э���߳�ID[" & i & "]", Empty
    Next 
    If Not IsNumeric(CStr(DimEnv_Thread_Tally)) Then DimEnv_Thread_Tally = 0
    TracePrint DimEnv_Thread_Data
    TracePrint "��������������_���̣߳�v"& ��ǰ�汾 &"��"
    TracePrint "�����ߡ��������޺�"
    TracePrint "���ѣѡ���1042207232"
    TracePrint "����Ⱥ����624655641"
    TracePrint "����վ����www.����.com"
    TracePrint "����������" & DimEnv_Thread_Tally & " ��"
    TracePrint "�����¡���" & DimEnv_Thread_NewTips
    If DimEnv_Thread_Init Then Call ԭ��_��ʼ��()
    _��ʼ�� = DimEnv_Thread_Init
End Function

/*������������������������ʷ������������������
<<<<<<< HEAD
����_���߳�v1.5 2021.09.15
\
=======
����_���߳�v1.5 2021.09.27
\
|-- ���� Э��_���() ����
|-- ���� Э��_����() ����
|-- ���� Э��_�߳̿�ʼ() ���� 
|-- ���� Э��_�߳��л�() ����
|-- ���� Э��_�߳̽���() ����
|-- ���� �ص�����_����() ����
|-- ���� �ص�����_����() ����
|-- ���� �ص�����_ȡ����() ����
|-- ���� �ص�����_�ò���() ����
>>>>>>> my_recovery_branch
|-- �޸� ����С����󣬱���򿪰�������༭�����ܳ�ʼ������
|-- �޸� �߳�_ȡ��ǰID() ����޷���ȷ��ȡ����ֵ���� 
|
|
����_���߳�v1.4 2020.06.11
\
|-- �Ż� _��ʼ��() ����ɹ���ִ�� ԭ��_��ʼ��() ����
|
|
����_���߳�v1.3 2019.01.25
\
|-- ���� ԭ��_�������() ����
|
|
����_���߳�v1.2 2019.01.17
\
|-- ���� _��ʼ��() ����
|
|
����_���߳�v1.1 2018.01.07
\
|-- ���� ��д������() ����
|-- ���� ��д��������() ����
|-- ���� ��д������() ����
|-- ���� ��д������() ����
|-- ���� ��д��д����() ����
|-- ���� �ٽ�������() ����
|-- ���� �ٽ�������() ����
|-- ���� �ٽ����˳�() ����
|-- ���� �ٽ�������() ����
|-- ���� �߳�_����() ����
|-- ���� �߳�_�ָ�() ����
|-- ���� �߳�_����() ����
|-- ���� �߳�_ȡ��ǰID() ����
|-- ���� �߳�_ȡ���ȼ�() ����
|-- ���� �߳�_ȡ״̬() ����
|-- ���� �߳�_�����ȼ�() ����
|-- ���� �ź�������() ����
|-- ���� �ź����ȴ�() ����
|-- ���� �ź����Ƿ����() ����
|-- ���� �ź����ͷ�() ����
|-- ���� �ź�������() ����
|-- ���� ԭ��_��ʼ��() ����
|-- ���� ԭ��_�ݼ�() ����
|-- ���� ԭ��_����() ����
|-- ���� ԭ��_��ֵ() ����
|-- ���� ԭ��_����() ����
|-- ���� ԭ��_��Ŀ����() ����
|-- ���� ԭ��_����() ����
|-- ���� ԭ��_����() ����
|
|
����_���߳�v1.0 2018.12.31
\
|-- ���� ����������() ����
|-- ���� ����������() ����
|-- ���� �������˳�() ����
|-- ���� ����������() ����
|-- ���� �¼�����() ����
|-- ���� �¼�����() ����
|-- ���� �¼��˳�() ����
|-- ���� �¼�����() ����
|-- ���� ����������() ����
|-- ���� ����������() ����
|-- ���� �������˳�() ����
|
|
��������������������������������������������*/
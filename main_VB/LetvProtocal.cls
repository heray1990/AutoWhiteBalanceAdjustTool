VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "LetvProtocal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'**********************************************
' Class module to handle protocal for Letv.
'**********************************************

Option Explicit
Implements CommunicationProtocal

Private mmSendDataBuf(0 To 9) As Byte

Private Sub Class_Initialize()
    mSendDataBuf(0) = &H0
    mSendDataBuf(1) = &H0
    mSendDataBuf(2) = &H0
    mSendDataBuf(3) = &H0
    mSendDataBuf(4) = &H0
    mSendDataBuf(5) = &H0
    mSendDataBuf(6) = &H0
    mSendDataBuf(7) = &H0
    mSendDataBuf(8) = &H0
    mSendDataBuf(9) = &H0
End Sub

Private Sub SendCmd()
    If isUartMode Then
        Form1.MSComm1.Output = mmSendDataBuf
    Else
        Form1.tcpClient.SendData mmSendDataBuf
    End If
End Sub

Private Function CalChkSum(ByRef data() As Byte) As Byte
    Dim i As Integer

    CalChkSum = &H0

    For i = 0 To 8
        CalChkSum = CalChkSum Xor data(i)
    Next i
End Function

Private Sub CommunicationProtocal_EnterFacMode()
    '6E 51 86 03 FE E1 A0 00 01 04
    mmSendDataBuf(0) = &H6E
    mmSendDataBuf(1) = &H51
    mmSendDataBuf(2) = &H86
    mmSendDataBuf(3) = &H3
    mmSendDataBuf(4) = &HFE
    mmSendDataBuf(5) = &HE1
    mmSendDataBuf(6) = &HA0
    mmSendDataBuf(7) = &H0
    mmSendDataBuf(8) = &H1
    mmSendDataBuf(9) = &H4

    SendCmd
End Sub

Private Sub CommunicationProtocal_ExitFacMode()
    '6E 51 86 03 FE E1 A0 00 00 05
    mSendDataBuf(0) = &H6E
    mSendDataBuf(1) = &H51
    mSendDataBuf(2) = &H86
    mSendDataBuf(3) = &H3
    mSendDataBuf(4) = &HFE
    mSendDataBuf(5) = &HE1
    mSendDataBuf(6) = &HA0
    mSendDataBuf(7) = &H0
    mSendDataBuf(8) = &H0
    mSendDataBuf(9) = &H5
    
    SendCmd
End Sub

Private Sub CommunicationProtocal_SwitchInputSource(strInputSrc As String, intSrcNum As Integer)
    'HDMI1: 6E 51 86 03 FE 60 00 23 02 05
    mSendDataBuf(0) = &H6E
    mSendDataBuf(1) = &H51
    mSendDataBuf(2) = &H86
    mSendDataBuf(3) = &H3
    mSendDataBuf(4) = &HFE
    mSendDataBuf(5) = &H60
    mSendDataBuf(6) = &H0

    If strInputSrc = "HDMI" Then
        If intSrcNum = 1 Then
            mSendDataBuf(7) = &H23
        ElseIf intSrcNum = 2 Then
            mSendDataBuf(7) = &H43
        ElseIf intSrcNum = 3 Then
            mSendDataBuf(7) = &H63
        Else
            mSendDataBuf(7) = &H23
        End If
    ElseIf strInputSrc = "CVBS" Then
        If intSrcNum = 1 Then
            mSendDataBuf(7) = &H25
        ElseIf intSrcNum = 2 Then
            mSendDataBuf(7) = &H45
        ElseIf intSrcNum = 3 Then
            mSendDataBuf(7) = &H65
        Else
            mSendDataBuf(7) = &H25
        End If
    ElseIf strInputSrc = "YPbPr" Then
        If intSrcNum = 1 Then
            mSendDataBuf(7) = &H27
        ElseIf intSrcNum = 2 Then
            mSendDataBuf(7) = &H47
        ElseIf intSrcNum = 3 Then
            mSendDataBuf(7) = &H67
        Else
            mSendDataBuf(7) = &H27
        End If
    Else
        mSendDataBuf(7) = &H23
    End If
    
    mSendDataBuf(8) = &H2
    mSendDataBuf(9) = CalChkSum(mSendDataBuf)
    
    SendCmd
End Sub

Private Sub CommunicationProtocal_SetBrightness(intBrightness As Integer)
    '6E 51 86 03 FE 10 00 XX XX CHK
    mSendDataBuf(0) = &H6E
    mSendDataBuf(1) = &H51
    mSendDataBuf(2) = &H86
    mSendDataBuf(3) = &H3
    mSendDataBuf(4) = &HFE
    mSendDataBuf(5) = &H10
    mSendDataBuf(6) = &H0
    mSendDataBuf(7) = CByte(intBrightness \ 256)
    mSendDataBuf(8) = CByte(intBrightness Mod 256)
    mSendDataBuf(9) = CalChkSum(mSendDataBuf)
    
    SendCmd
End Sub

Private Sub CommunicationProtocal_SetContrast(intContrast As Integer)
    '6E 51 86 03 FE 12 00 XX XX CHK
    mSendDataBuf(0) = &H6E
    mSendDataBuf(1) = &H51
    mSendDataBuf(2) = &H86
    mSendDataBuf(3) = &H3
    mSendDataBuf(4) = &HFE
    mSendDataBuf(5) = &H12
    mSendDataBuf(6) = &H0
    mSendDataBuf(7) = CByte(intContrast \ 256)
    mSendDataBuf(8) = CByte(intContrast Mod 256)
    mSendDataBuf(9) = CalChkSum(mSendDataBuf)
    
    SendCmd
End Sub

Private Sub CommunicationProtocal_SetBacklight(intBacklight As Integer)
    '6E 51 86 03 FE 13 00 XX XX CHK
    mSendDataBuf(0) = &H6E
    mSendDataBuf(1) = &H51
    mSendDataBuf(2) = &H86
    mSendDataBuf(3) = &H3
    mSendDataBuf(4) = &HFE
    mSendDataBuf(5) = &H13
    mSendDataBuf(6) = &H0
    mSendDataBuf(7) = CByte(intBacklight \ 256)
    mSendDataBuf(8) = CByte(intBacklight Mod 256)
    mSendDataBuf(9) = CalChkSum(mSendDataBuf)
    
    SendCmd
End Sub

Private Sub CommunicationProtocal_SetColorTemp(lngColorT As Long, strInputSrc As String, intSrcNum As Integer)
    Select Case lngColorT
      Case valColorTempCool1
         Call SetColorTempCool1(strInputSrc, intSrcNum)
      Case valColorTempNormal
         Call SetColorTempNormal(strInputSrc, intSrcNum)
      Case valColorTempWarm1
         Call SetColorTempWarm1(strInputSrc, intSrcNum)
    End Select
End Sub

Private Sub SetColorTempCool1(strInputSrc As String, intSrcNum As Integer)
    'HDMI Cool
    '6E 51 86 03 FE 14 0A 23 01 78
    mSendDataBuf(0) = &H6E
    mSendDataBuf(1) = &H51
    mSendDataBuf(2) = &H86
    mSendDataBuf(3) = &H3
    mSendDataBuf(4) = &HFE
    mSendDataBuf(5) = &H14
    mSendDataBuf(6) = &HA

    If strInputSrc = "HDMI" Then
        If intSrcNum = 1 Then
            mSendDataBuf(7) = &H23
        ElseIf intSrcNum = 2 Then
            mSendDataBuf(7) = &H43
        ElseIf intSrcNum = 3 Then
            mSendDataBuf(7) = &H63
        Else
            mSendDataBuf(7) = &H23
        End If
    ElseIf strInputSrc = "CVBS" Then
        If intSrcNum = 1 Then
            mSendDataBuf(7) = &H25
        ElseIf intSrcNum = 2 Then
            mSendDataBuf(7) = &H45
        ElseIf intSrcNum = 3 Then
            mSendDataBuf(7) = &H65
        Else
            mSendDataBuf(7) = &H25
        End If
    ElseIf strInputSrc = "YPbPr" Then
        If intSrcNum = 1 Then
            mSendDataBuf(7) = &H27
        ElseIf intSrcNum = 2 Then
            mSendDataBuf(7) = &H47
        ElseIf intSrcNum = 3 Then
            mSendDataBuf(7) = &H67
        Else
            mSendDataBuf(7) = &H27
        End If
    Else
        mSendDataBuf(7) = &H23
    End If

    mSendDataBuf(8) = &H1
    mSendDataBuf(9) = CalChkSum(mSendDataBuf)
    
    SendCmd
End Sub

Private Sub SetColorTempNormal(strInputSrc As String, intSrcNum As Integer)
    'HDMI normal
    '6E 51 86 03 FE 14 06 23 01 74
    mSendDataBuf(0) = &H6E
    mSendDataBuf(1) = &H51
    mSendDataBuf(2) = &H86
    mSendDataBuf(3) = &H3
    mSendDataBuf(4) = &HFE
    mSendDataBuf(5) = &H14
    mSendDataBuf(6) = &H6
    
    If strInputSrc = "HDMI" Then
        If intSrcNum = 1 Then
            mSendDataBuf(7) = &H23
        ElseIf intSrcNum = 2 Then
            mSendDataBuf(7) = &H43
        ElseIf intSrcNum = 3 Then
            mSendDataBuf(7) = &H63
        Else
            mSendDataBuf(7) = &H23
        End If
    ElseIf strInputSrc = "CVBS" Then
        If intSrcNum = 1 Then
            mSendDataBuf(7) = &H25
        ElseIf intSrcNum = 2 Then
            mSendDataBuf(7) = &H45
        ElseIf intSrcNum = 3 Then
            mSendDataBuf(7) = &H65
        Else
            mSendDataBuf(7) = &H25
        End If
    ElseIf strInputSrc = "YPbPr" Then
        If intSrcNum = 1 Then
            mSendDataBuf(7) = &H27
        ElseIf intSrcNum = 2 Then
            mSendDataBuf(7) = &H47
        ElseIf intSrcNum = 3 Then
            mSendDataBuf(7) = &H67
        Else
            mSendDataBuf(7) = &H27
        End If
    Else
        mSendDataBuf(7) = &H23
    End If

    mSendDataBuf(8) = &H1
    mSendDataBuf(9) = CalChkSum(mSendDataBuf)
    
    SendCmd
End Sub

Private Sub SetColorTempWarm1(strInputSrc As String, intSrcNum As Integer)
    'HDMI warm
    '6E 51 86 03 FE 14 05 23 01 77
    mSendDataBuf(0) = &H6E
    mSendDataBuf(1) = &H51
    mSendDataBuf(2) = &H86
    mSendDataBuf(3) = &H3
    mSendDataBuf(4) = &HFE
    mSendDataBuf(5) = &H14
    mSendDataBuf(6) = &H5
    
    If strInputSrc = "HDMI" Then
        If intSrcNum = 1 Then
            mSendDataBuf(7) = &H23
        ElseIf intSrcNum = 2 Then
            mSendDataBuf(7) = &H43
        ElseIf intSrcNum = 3 Then
            mSendDataBuf(7) = &H63
        Else
            mSendDataBuf(7) = &H23
        End If
    ElseIf strInputSrc = "CVBS" Then
        If intSrcNum = 1 Then
            mSendDataBuf(7) = &H25
        ElseIf intSrcNum = 2 Then
            mSendDataBuf(7) = &H45
        ElseIf intSrcNum = 3 Then
            mSendDataBuf(7) = &H65
        Else
            mSendDataBuf(7) = &H25
        End If
    ElseIf strInputSrc = "YPbPr" Then
        If intSrcNum = 1 Then
            mSendDataBuf(7) = &H27
        ElseIf intSrcNum = 2 Then
            mSendDataBuf(7) = &H47
        ElseIf intSrcNum = 3 Then
            mSendDataBuf(7) = &H67
        Else
            mSendDataBuf(7) = &H27
        End If
    Else
        mSendDataBuf(7) = &H23
    End If

    mSendDataBuf(8) = &H1
    mSendDataBuf(9) = CalChkSum(mSendDataBuf)
    
    SendCmd
End Sub

Private Sub CommunicationProtocal_SetRGain(lngRGain As Long)
    '6E 51 86 03 FE 16 00 XX XX CHK
    mSendDataBuf(0) = &H6E
    mSendDataBuf(1) = &H51
    mSendDataBuf(2) = &H86
    mSendDataBuf(3) = &H3
    mSendDataBuf(4) = &HFE
    mSendDataBuf(5) = &H16
    mSendDataBuf(6) = &H0
    mSendDataBuf(7) = CByte(lngRGain \ 256)
    mSendDataBuf(8) = CByte(lngRGain Mod 256)
    mSendDataBuf(9) = CalChkSum(mSendDataBuf)
    
    SendCmd
End Sub

Private Sub CommunicationProtocal_SetGGain(lngGGain As Long)
    '6E 51 86 03 FE 18 00 XX XX CHK
    mSendDataBuf(0) = &H6E
    mSendDataBuf(1) = &H51
    mSendDataBuf(2) = &H86
    mSendDataBuf(3) = &H3
    mSendDataBuf(4) = &HFE
    mSendDataBuf(5) = &H18
    mSendDataBuf(6) = &H0
    mSendDataBuf(7) = CByte(lngGGain \ 256)
    mSendDataBuf(8) = CByte(lngGGain Mod 256)
    mSendDataBuf(9) = CalChkSum(mSendDataBuf)
    
    SendCmd
End Sub

Private Sub CommunicationProtocal_SetBGain(lngBGain As Long)
    '6E 51 86 03 FE 1A 00 XX XX CHK
    mSendDataBuf(0) = &H6E
    mSendDataBuf(1) = &H51
    mSendDataBuf(2) = &H86
    mSendDataBuf(3) = &H3
    mSendDataBuf(4) = &HFE
    mSendDataBuf(5) = &H1A
    mSendDataBuf(6) = &H0
    mSendDataBuf(7) = CByte(lngBGain \ 256)
    mSendDataBuf(8) = CByte(lngBGain Mod 256)
    mSendDataBuf(9) = CalChkSum(mSendDataBuf)
    
    SendCmd
End Sub

Private Sub CommunicationProtocal_SetROffset(lngROffset As Long)
    '6E 51 86 03 FE 6C 00 XX XX CHK
    mSendDataBuf(0) = &H6E
    mSendDataBuf(1) = &H51
    mSendDataBuf(2) = &H86
    mSendDataBuf(3) = &H3
    mSendDataBuf(4) = &HFE
    mSendDataBuf(5) = &H6C
    mSendDataBuf(6) = &H0
    mSendDataBuf(7) = CByte(lngROffset \ 256)
    mSendDataBuf(8) = CByte(lngROffset Mod 256)
    mSendDataBuf(9) = CalChkSum(mSendDataBuf)
    
    SendCmd
End Sub

Private Sub CommunicationProtocal_SetGOffset(lngGOffset As Long)
    '6E 51 86 03 FE 6E 00 XX XX CHK
    mSendDataBuf(0) = &H6E
    mSendDataBuf(1) = &H51
    mSendDataBuf(2) = &H86
    mSendDataBuf(3) = &H3
    mSendDataBuf(4) = &HFE
    mSendDataBuf(5) = &H6E
    mSendDataBuf(6) = &H0
    mSendDataBuf(7) = CByte(lngGOffset \ 256)
    mSendDataBuf(8) = CByte(lngGOffset Mod 256)
    mSendDataBuf(9) = CalChkSum(mSendDataBuf)
    
    SendCmd
End Sub

Private Sub CommunicationProtocal_SetBOffset(lngBOffset As Long)
    '6E 51 86 03 FE 70 00 XX XX CHK
    mSendDataBuf(0) = &H6E
    mSendDataBuf(1) = &H51
    mSendDataBuf(2) = &H86
    mSendDataBuf(3) = &H3
    mSendDataBuf(4) = &HFE
    mSendDataBuf(5) = &H70
    mSendDataBuf(6) = &H0
    mSendDataBuf(7) = CByte(lngBOffset \ 256)
    mSendDataBuf(8) = CByte(lngBOffset Mod 256)
    mSendDataBuf(9) = CalChkSum(mSendDataBuf)
    
    SendCmd
End Sub

Private Sub CommunicationProtocal_SaveWBDataToAllSrc(strInputSrc As String, intSrcNum As Integer)
    '6E 51 86 03 FE 14 05 23 00 76
    mSendDataBuf(0) = &H6E
    mSendDataBuf(1) = &H51
    mSendDataBuf(2) = &H86
    mSendDataBuf(3) = &H3
    mSendDataBuf(4) = &HFE
    mSendDataBuf(5) = &H14
    mSendDataBuf(6) = &H5
    
    If strInputSrc = "HDMI" Then
        If intSrcNum = 1 Then
            mSendDataBuf(7) = &H23
        ElseIf intSrcNum = 2 Then
            mSendDataBuf(7) = &H43
        ElseIf intSrcNum = 3 Then
            mSendDataBuf(7) = &H63
        Else
            mSendDataBuf(7) = &H23
        End If
    ElseIf strInputSrc = "CVBS" Then
        If intSrcNum = 1 Then
            mSendDataBuf(7) = &H25
        ElseIf intSrcNum = 2 Then
            mSendDataBuf(7) = &H45
        ElseIf intSrcNum = 3 Then
            mSendDataBuf(7) = &H65
        Else
            mSendDataBuf(7) = &H25
        End If
    ElseIf strInputSrc = "YPbPr" Then
        If intSrcNum = 1 Then
            mSendDataBuf(7) = &H27
        ElseIf intSrcNum = 2 Then
            mSendDataBuf(7) = &H47
        ElseIf intSrcNum = 3 Then
            mSendDataBuf(7) = &H67
        Else
            mSendDataBuf(7) = &H27
        End If
    Else
        mSendDataBuf(7) = &H23
    End If
    
    mSendDataBuf(8) = &H0
    mSendDataBuf(9) = CalChkSum(mSendDataBuf)
    
    SendCmd
End Sub
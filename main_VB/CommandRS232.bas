Attribute VB_Name = "Module4"
Option Explicit

Public Sub ENTER_FAC_MODE()

    Dim SendDataBuf(0 To 9) As Byte
    
    '6E 51 86 03 FE E1 A0 00 01 04
    SendDataBuf(0) = &H6E
    SendDataBuf(1) = &H51
    SendDataBuf(2) = &H86
    SendDataBuf(3) = &H3
    SendDataBuf(4) = &HFE
    SendDataBuf(5) = &HE1
    SendDataBuf(6) = &HA0
    SendDataBuf(7) = &H0
    SendDataBuf(8) = &H1
    SendDataBuf(9) = &H4
    
    Form1.MSComm1.Output = SendDataBuf
End Sub

Public Sub EXIT_FAC_MODE()

    Dim SendDataBuf(0 To 9) As Byte
    
    '6E 51 86 03 FE E1 A0 00 00 05
    SendDataBuf(0) = &H6E
    SendDataBuf(1) = &H51
    SendDataBuf(2) = &H86
    SendDataBuf(3) = &H3
    SendDataBuf(4) = &HFE
    SendDataBuf(5) = &HE1
    SendDataBuf(6) = &HA0
    SendDataBuf(7) = &H0
    SendDataBuf(8) = &H0
    SendDataBuf(9) = &H5

    Form1.MSComm1.Output = SendDataBuf
End Sub

Public Sub SEL_INPUT_HDMI1_FOR_WB()

    Dim SendDataBuf(0 To 9) As Byte
    
    '6E 51 86 03 FE 60 00 23 02 05
    SendDataBuf(0) = &H6E
    SendDataBuf(1) = &H51
    SendDataBuf(2) = &H86
    SendDataBuf(3) = &H3
    SendDataBuf(4) = &HFE
    SendDataBuf(5) = &H60
    SendDataBuf(6) = &H0
    SendDataBuf(7) = &H23
    SendDataBuf(8) = &H2
    SendDataBuf(9) = &H5
    
    Form1.MSComm1.Output = SendDataBuf
End Sub

Public Sub SET_BRIGHTNESS(Brightness As Long)

    Dim SendDataBuf(0 To 9) As Byte
    
    '6E 51 86 03 FE 10 00 XX XX CHK
    SendDataBuf(0) = &H6E
    SendDataBuf(1) = &H51
    SendDataBuf(2) = &H86
    SendDataBuf(3) = &H3
    SendDataBuf(4) = &HFE
    SendDataBuf(5) = &H10
    SendDataBuf(6) = &H0
    SendDataBuf(7) = CByte(Brightness \ 256)
    SendDataBuf(8) = CByte(Brightness Mod 256)
    SendDataBuf(9) = chksumSend(SendDataBuf)
    
    Form1.MSComm1.Output = SendDataBuf
End Sub

Public Sub SET_CONTRAST(Contrast As Long)

    Dim SendDataBuf(0 To 9) As Byte

    '6E 51 86 03 FE 12 00 XX XX CHK
    SendDataBuf(0) = &H6E
    SendDataBuf(1) = &H51
    SendDataBuf(2) = &H86
    SendDataBuf(3) = &H3
    SendDataBuf(4) = &HFE
    SendDataBuf(5) = &H12
    SendDataBuf(6) = &H0
    SendDataBuf(7) = CByte(Contrast \ 256)
    SendDataBuf(8) = CByte(Contrast Mod 256)
    SendDataBuf(9) = chksumSend(SendDataBuf)
    
    Form1.MSComm1.Output = SendDataBuf
End Sub

Public Sub SET_COLORTEMP(colorT As Long)
    Select Case colorT
      Case valColorTempCool1
         SEL_TEMP_COOL
      Case valColorTempNormal
         SEL_TEMP_NORMAL
      Case valColorTempWarm1
         SEL_TEMP_WARM
    End Select
    
    DelayMS 500
End Sub

Public Sub SEL_TEMP_COOL()

    Dim SendDataBuf(0 To 9) As Byte
    
    '6E 51 86 03 FE 14 0A 27 01 7C
    SendDataBuf(0) = &H6E
    SendDataBuf(1) = &H51
    SendDataBuf(2) = &H86
    SendDataBuf(3) = &H3
    SendDataBuf(4) = &HFE
    SendDataBuf(5) = &H14
    SendDataBuf(6) = &HA
    SendDataBuf(7) = &H27
    SendDataBuf(8) = &H1
    SendDataBuf(9) = &H7C
    
    Form1.MSComm1.Output = SendDataBuf
End Sub

Public Sub SEL_TEMP_NORMAL()

    Dim SendDataBuf(0 To 9) As Byte
    
    '6E 51 86 03 FE 14 06 27 01 70
    SendDataBuf(0) = &H6E
    SendDataBuf(1) = &H51
    SendDataBuf(2) = &H86
    SendDataBuf(3) = &H3
    SendDataBuf(4) = &HFE
    SendDataBuf(5) = &H14
    SendDataBuf(6) = &H6
    SendDataBuf(7) = &H27
    SendDataBuf(8) = &H1
    SendDataBuf(9) = &H70
    
    Form1.MSComm1.Output = SendDataBuf
End Sub

Public Sub SEL_TEMP_WARM()

    Dim SendDataBuf(0 To 9) As Byte
    
    '6E 51 86 03 FE 14 05 27 01 73
    SendDataBuf(0) = &H6E
    SendDataBuf(1) = &H51
    SendDataBuf(2) = &H86
    SendDataBuf(3) = &H3
    SendDataBuf(4) = &HFE
    SendDataBuf(5) = &H14
    SendDataBuf(6) = &H5
    SendDataBuf(7) = &H27
    SendDataBuf(8) = &H1
    SendDataBuf(9) = &H73
    
    Form1.MSComm1.Output = SendDataBuf
End Sub

Public Sub SET_RGB_GAN(RGB_GAN As REALRGB)
    SET_R_GAN RGB_GAN.cRR
    DelayMS 500
    
    SET_G_GAN RGB_GAN.cGG
    DelayMS 500
    
    SET_B_GAN RGB_GAN.cBB
    DelayMS 500
End Sub

Public Sub SET_R_GAN(R_GAN As Long)

    Dim SendDataBuf(0 To 9) As Byte

    '6E 51 86 03 FE 16 00 XX XX CHK
    SendDataBuf(0) = &H6E
    SendDataBuf(1) = &H51
    SendDataBuf(2) = &H86
    SendDataBuf(3) = &H3
    SendDataBuf(4) = &HFE
    SendDataBuf(5) = &H16
    SendDataBuf(6) = &H0
    SendDataBuf(7) = CByte(R_GAN \ 256)
    SendDataBuf(8) = CByte(R_GAN Mod 256)
    SendDataBuf(9) = chksumSend(SendDataBuf)
    
    Form1.MSComm1.Output = SendDataBuf
End Sub

Public Sub SET_G_GAN(G_GAN As Long)

    Dim SendDataBuf(0 To 9) As Byte

    '6E 51 86 03 FE 18 00 XX XX CHK
    SendDataBuf(0) = &H6E
    SendDataBuf(1) = &H51
    SendDataBuf(2) = &H86
    SendDataBuf(3) = &H3
    SendDataBuf(4) = &HFE
    SendDataBuf(5) = &H18
    SendDataBuf(6) = &H0
    SendDataBuf(7) = CByte(G_GAN \ 256)
    SendDataBuf(8) = CByte(G_GAN Mod 256)
    SendDataBuf(9) = chksumSend(SendDataBuf)
    
    Form1.MSComm1.Output = SendDataBuf
End Sub

Public Sub SET_B_GAN(B_GAN As Long)

    Dim SendDataBuf(0 To 9) As Byte

    '6E 51 86 03 FE 1A 00 XX XX CHK
    SendDataBuf(0) = &H6E
    SendDataBuf(1) = &H51
    SendDataBuf(2) = &H86
    SendDataBuf(3) = &H3
    SendDataBuf(4) = &HFE
    SendDataBuf(5) = &H1A
    SendDataBuf(6) = &H0
    SendDataBuf(7) = CByte(B_GAN \ 256)
    SendDataBuf(8) = CByte(B_GAN Mod 256)
    SendDataBuf(9) = chksumSend(SendDataBuf)
    
    Form1.MSComm1.Output = SendDataBuf
End Sub

Public Sub SET_R_OFF(R_OFF As Long)

    Dim SendDataBuf(0 To 9) As Byte

    '6E 51 86 03 FE 6C 00 XX XX CHK
    SendDataBuf(0) = &H6E
    SendDataBuf(1) = &H51
    SendDataBuf(2) = &H86
    SendDataBuf(3) = &H3
    SendDataBuf(4) = &HFE
    SendDataBuf(5) = &H6C
    SendDataBuf(6) = &H0
    SendDataBuf(7) = CByte(R_OFF \ 256)
    SendDataBuf(8) = CByte(R_OFF Mod 256)
    SendDataBuf(9) = chksumSend(SendDataBuf)
    
    Form1.MSComm1.Output = SendDataBuf
End Sub

Public Sub SET_G_OFF(G_OFF As Long)

    Dim SendDataBuf(0 To 9) As Byte

    '6E 51 86 03 FE 6E 00 XX XX CHK
    SendDataBuf(0) = &H6E
    SendDataBuf(1) = &H51
    SendDataBuf(2) = &H86
    SendDataBuf(3) = &H3
    SendDataBuf(4) = &HFE
    SendDataBuf(5) = &H6E
    SendDataBuf(6) = &H0
    SendDataBuf(7) = CByte(G_OFF \ 256)
    SendDataBuf(8) = CByte(G_OFF Mod 256)
    SendDataBuf(9) = chksumSend(SendDataBuf)
    
    Form1.MSComm1.Output = SendDataBuf
End Sub

Public Sub SET_B_OFF(B_OFF As Long)

    Dim SendDataBuf(0 To 9) As Byte

    '6E 51 86 03 FE 70 00 XX XX CHK
    SendDataBuf(0) = &H6E
    SendDataBuf(1) = &H51
    SendDataBuf(2) = &H86
    SendDataBuf(3) = &H3
    SendDataBuf(4) = &HFE
    SendDataBuf(5) = &H70
    SendDataBuf(6) = &H0
    SendDataBuf(7) = CByte(B_OFF \ 256)
    SendDataBuf(8) = CByte(B_OFF Mod 256)
    SendDataBuf(9) = chksumSend(SendDataBuf)
    
    Form1.MSComm1.Output = SendDataBuf
End Sub

Public Sub SAVE_WB_DATA_TO_ALL_SRC()

    Dim SendDataBuf(0 To 9) As Byte

    '6E 51 86 03 FE 14 05 23 00 76
    SendDataBuf(0) = &H6E
    SendDataBuf(1) = &H51
    SendDataBuf(2) = &H86
    SendDataBuf(3) = &H3
    SendDataBuf(4) = &HFE
    SendDataBuf(5) = &H14
    SendDataBuf(6) = &H5
    SendDataBuf(7) = &H23
    SendDataBuf(8) = &H0
    SendDataBuf(9) = &H76
    
    Form1.MSComm1.Output = SendDataBuf
End Sub

Private Function chksumSend(ByRef data() As Byte) As Byte
    Dim i As Integer

    chksumSend = &H0

    For i = 0 To 8
        chksumSend = chksumSend Xor data(i)
    Next i
End Function


Function StringToInt(TS As String) As Byte

Select Case TS
Case Is = "0"
  StringToInt = 0
Case Is = "1"
  StringToInt = 1
Case Is = "2"
  StringToInt = 2
Case Is = "3"
  StringToInt = 3
Case Is = "4"
  StringToInt = 4
Case Is = "5"
  StringToInt = 5
Case Is = "0"
  StringToInt = 0
Case Is = "6"
  StringToInt = 6
Case Is = "7"
  StringToInt = 7
Case Is = "8"
  StringToInt = 8
Case Is = "9"
  StringToInt = 9
Case Is = "A"
  StringToInt = 10
Case Is = "B"
  StringToInt = 11
Case Is = "C"
  StringToInt = 12
Case Is = "D"
  StringToInt = 13
Case Is = "E"
  StringToInt = 14
Case Is = "F"
  StringToInt = 15
Case Is = "P"
  MsgBox ("Command Format is Wrong.")
Case Is = " "
  MsgBox ("Command Format is Wrong.")
End Select

End Function

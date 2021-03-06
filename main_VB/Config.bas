Attribute VB_Name = "Config"
'**********************************************
' Class module for handling config.xml of the
' application.
'**********************************************

Option Explicit


Public Sub LoadConfigData()
    Dim xmlDoc As New MSXML2.DOMDocument
    Dim success As Boolean
    
    success = xmlDoc.Load(gstrXmlPath)
    
    If success = False Then
        MsgBox xmlDoc.parseError.reason
    Else
        If xmlDoc.selectSingleNode("/config/communication").selectSingleNode("@mode").Text = "UART" Then
            gudtConfigData.CommMode = modeUART
        ElseIf xmlDoc.selectSingleNode("/config/communication").selectSingleNode("@mode").Text = "NETCLIENT" Then
            gudtConfigData.CommMode = modeNetClient
        ElseIf xmlDoc.selectSingleNode("/config/communication").selectSingleNode("@mode").Text = "I2C" Then
            gudtConfigData.CommMode = modeI2c
        ElseIf xmlDoc.selectSingleNode("/config/communication").selectSingleNode("@mode").Text = "NETSERVER" Then
            gudtConfigData.CommMode = modeNetServer
        End If
        gudtConfigData.strModel = xmlDoc.selectSingleNode("/config/model").Text
        gudtConfigData.strComBaud = xmlDoc.selectSingleNode("/config/communication/common").selectSingleNode("@baud").Text
        gudtConfigData.intComID = val(xmlDoc.selectSingleNode("/config/communication/common").selectSingleNode("@id").Text)
        gudtConfigData.lngI2cClockRate = val(xmlDoc.selectSingleNode("/config/communication/i2c").selectSingleNode("@clockrate").Text)
        gudtConfigData.strInputSource = xmlDoc.selectSingleNode("/config/input_source").Text
        gudtConfigData.lngDelayMs = val(xmlDoc.selectSingleNode("/config/delayms").Text)
        gudtConfigData.intChannelNum = val(xmlDoc.selectSingleNode("/config/channel_number").Text)
        gudtConfigData.intBarCodeLen = val(xmlDoc.selectSingleNode("/config/length_bar_code").Text)
        gudtConfigData.intLvSpec = val(xmlDoc.selectSingleNode("/config/Lv_spec").Text)
        gudtConfigData.strVPGModel = xmlDoc.selectSingleNode("/config/VPG/model").Text
        gudtConfigData.strVPGTiming = xmlDoc.selectSingleNode("/config/VPG/timing").Text
        gudtConfigData.strVPG100IRE = xmlDoc.selectSingleNode("/config/VPG/IRE100").Text
        gudtConfigData.strVPG80IRE = xmlDoc.selectSingleNode("/config/VPG/IRE80").Text
        gudtConfigData.strVPG20IRE = xmlDoc.selectSingleNode("/config/VPG/IRE20").Text
        gudtConfigData.strChipSet = xmlDoc.selectSingleNode("/config/chipset").Text
    End If
    
    If xmlDoc.selectSingleNode("/config/cool").Text = "True" Then
        gudtConfigData.bolEnableCool = True
    Else
        gudtConfigData.bolEnableCool = False
    End If
    
    If xmlDoc.selectSingleNode("/config/standard").Text = "True" Then
        gudtConfigData.bolEnableStandard = True
    Else
        gudtConfigData.bolEnableStandard = False
    End If
    
    If xmlDoc.selectSingleNode("/config/warm").Text = "True" Then
        gudtConfigData.bolEnableWarm = True
    Else
        gudtConfigData.bolEnableWarm = False
    End If
    
    If xmlDoc.selectSingleNode("/config/check_color").Text = "True" Then
        gudtConfigData.bolEnableChkColor = True
    Else
        gudtConfigData.bolEnableChkColor = False
    End If
    
    If xmlDoc.selectSingleNode("/config/adjust_offset").Text = "True" Then
        gudtConfigData.bolEnableAdjOffset = True
    Else
        gudtConfigData.bolEnableAdjOffset = False
    End If
End Sub

Public Sub SaveConfigData()
    Dim xmlDoc As New MSXML2.DOMDocument
    Dim success As Boolean
    
    success = xmlDoc.Load(gstrXmlPath)
    
    If success = False Then
        MsgBox xmlDoc.parseError.reason
    Else
        If gudtConfigData.CommMode = modeUART Then
            xmlDoc.selectSingleNode("/config/communication").selectSingleNode("@mode").Text = "UART"
        ElseIf gudtConfigData.CommMode = modeNetClient Then
            xmlDoc.selectSingleNode("/config/communication").selectSingleNode("@mode").Text = "NETCLIENT"
        ElseIf gudtConfigData.CommMode = modeI2c Then
            xmlDoc.selectSingleNode("/config/communication").selectSingleNode("@mode").Text = "I2C"
        ElseIf gudtConfigData.CommMode = modeNetServer Then
            xmlDoc.selectSingleNode("/config/communication").selectSingleNode("@mode").Text = "NETSERVER"
        End If
        xmlDoc.selectSingleNode("/config/model").Text = gudtConfigData.strModel
        xmlDoc.selectSingleNode("/config/communication/common").selectSingleNode("@baud").Text = gudtConfigData.strComBaud
        xmlDoc.selectSingleNode("/config/communication/common").selectSingleNode("@id").Text = CStr(gudtConfigData.intComID)
        xmlDoc.selectSingleNode("/config/input_source").Text = gudtConfigData.strInputSource
        xmlDoc.selectSingleNode("/config/delayms").Text = CStr(gudtConfigData.lngDelayMs)
        xmlDoc.selectSingleNode("/config/channel_number").Text = CStr(gudtConfigData.intChannelNum)
        xmlDoc.selectSingleNode("/config/length_bar_code").Text = CStr(gudtConfigData.intBarCodeLen)
        xmlDoc.selectSingleNode("/config/Lv_spec").Text = CStr(gudtConfigData.intLvSpec)
        xmlDoc.selectSingleNode("/config/VPG/model").Text = gudtConfigData.strVPGModel
        xmlDoc.selectSingleNode("/config/VPG/timing").Text = gudtConfigData.strVPGTiming
        xmlDoc.selectSingleNode("/config/VPG/IRE100").Text = gudtConfigData.strVPG100IRE
        xmlDoc.selectSingleNode("/config/VPG/IRE80").Text = gudtConfigData.strVPG80IRE
        xmlDoc.selectSingleNode("/config/VPG/IRE20").Text = gudtConfigData.strVPG20IRE

        If gudtConfigData.bolEnableCool Then
            xmlDoc.selectSingleNode("/config/cool").Text = "True"
        Else
            xmlDoc.selectSingleNode("/config/cool").Text = "False"
        End If
        
        If gudtConfigData.bolEnableStandard Then
            xmlDoc.selectSingleNode("/config/standard").Text = "True"
        Else
            xmlDoc.selectSingleNode("/config/standard").Text = "False"
        End If
        
        If gudtConfigData.bolEnableWarm Then
            xmlDoc.selectSingleNode("/config/warm").Text = "True"
        Else
            xmlDoc.selectSingleNode("/config/warm").Text = "False"
        End If
        
        If gudtConfigData.bolEnableChkColor Then
            xmlDoc.selectSingleNode("/config/check_color").Text = "True"
        Else
            xmlDoc.selectSingleNode("/config/check_color").Text = "False"
        End If
        
        If gudtConfigData.bolEnableAdjOffset Then
            xmlDoc.selectSingleNode("/config/adjust_offset").Text = "True"
        Else
            xmlDoc.selectSingleNode("/config/adjust_offset").Text = "False"
        End If
        
        xmlDoc.save gstrXmlPath
    End If
End Sub

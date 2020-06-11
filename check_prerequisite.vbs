Sub CheckPrerequisite()
    On Error Resume Next
    
    Dim objShell 'As WshShell
    Set objShell = CreateObject("WScript.Shell")
      
    Dim fs 'As FileSystemObject
    Set fs = CreateObject("Scripting.FileSystemObject")
    
    Dim ExeProc 'As WshExec
    Set ExeProc = objShell.Exec("git.exe")
    If ExeProc Is Nothing Then
        MsgBox "Please install git for windows first!", vbCritical
        objShell.Run ("https://git-scm.com/download/win")
        Exit Sub
    End If
    
    While fs.FolderExists("C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise") = False
        If MsgBox("Please install Visual Studio 2017 Enterprise version first!", vbCritical Or vbYesNo Or vbDefaultButton1) <> vbYes Then
            Exit Sub
        End If
        objShell.Run ("https://visualstudio.microsoft.com/zh-hans/vs/older-downloads/")
    Wend
    
    While fs.FolderExists("C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Tools\MSVC") = False
        If MsgBox("Please check 'Desktop development with C++' in Visual Studio 2017 Installer first!", vbCritical Or vbYesNo Or vbDefaultButton1) <> vbYes Then
            Exit Sub
        End If
        objShell.Exec ("C:\Program Files (x86)\Microsoft Visual Studio\Installer\vs_installer.exe")
    Wend
    
    While fs.FolderExists("C:\Program Files (x86)\Windows Kits\10\Source\10.0.19041.0\ucrt") = False
        If MsgBox("Please install Windows 10 SDK (10.0.19041.0) first!", vbCritical Or vbYesNo Or vbDefaultButton1) <> vbYes Then
            Exit Sub
        End If
        objShell.Run ("https://developer.microsoft.com/en-us/windows/downloads/windows-10-sdk/")
    Wend
    
    While fs.FolderExists("C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Include") = False
        If MsgBox("Please check 'Windows XP support for C++' in Visual Studio 2017 Installer first!", vbCritical Or vbYesNo Or vbDefaultButton1) <> vbYes Then
            Exit Sub
        End If
        objShell.Exec ("C:\Program Files (x86)\Microsoft Visual Studio\Installer\vs_installer.exe")
    Wend
    
    Dim boost_ROOT
    boost_ROOT = objShell.Environment("System").Item("boost_ROOT")
    While Len(boost_ROOT) = 0 Or fs.FolderExists(boost_ROOT) = False
        If MsgBox("Please install Boost (1.66.0) first!", vbCritical Or vbYesNo Or vbDefaultButton1) <> vbYes Then
            Exit Sub
        End If
        objShell.Run ("https://dl.bintray.com/boostorg/release/1.66.0/source/")
        boost_ROOT = InputBox("Please input your Boost (1.66.0) root directory!", "Set boost_ROOT environment variable")
        If Len(boost_ROOT) > 0 And fs.FolderExists(boost_ROOT) Then
            objShell.Environment("System").Item("boost_ROOT") = boost_ROOT
        End If
    Wend
End Sub

CheckPrerequisite
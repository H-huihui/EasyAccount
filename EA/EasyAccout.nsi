!include "MUI2.nsh"

Name "EasyAccout"
OutFile "EasyAccout-1.0.exe"

InstallDir "$PROGRAMFILES\EasyAccout"

InstallDirRegKey HKCU "Software\EasyAccout" ""

RequestExecutionLevel user

Var StartMenuFolder

!define MUI_ABORTWARNING

!insertmacro MUI_PAGE_LICENSE "${NSISDIR}\Docs\Modern UI\License.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY

!define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
!define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\EasyAccout" 
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"
  
!insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder
  
!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "SIMPCHINESE"

Section "EasyAccout主程序" SecEasyAccout

    SetOutPath "$INSTDIR"
    
    File /r "dist\*.*"
     
    WriteRegStr HKCU "Software\EasyAccout" "" $INSTDIR
    WriteUninstaller "$INSTDIR\Uninstall.exe"
    
    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
    CreateShortCut "$SMPROGRAMS\$StartMenuFolder\EasyAccout.lnk" "$INSTDIR\EasyAccout.exe"
    CreateShortCut "$DESKTOP\有钱记账YouMoney.lnk" "$INSTDIR\EasyAccout.exe"
    CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
    !insertmacro MUI_STARTMENU_WRITE_END

SectionEnd

LangString DESC_SecDummy ${LANG_SIMPCHINESE} "EasyAccout安装."

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SecEasyAccout} $(DESC_SecDummy)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Section "Uninstall"
    ;ADD YOUR OWN FILES HERE...
	StrCpy $StartMenuFolder "EasyAccout"

    Delete "$INSTDIR\Uninstall.exe"

    RMDir /r "$INSTDIR\images"
    RMDir /r "$INSTDIR\lang"
    RMDir /r "$INSTDIR\ui"
    Delete "$INSTDIR\*"

    DeleteRegKey /ifempty HKCU "Software\EasyAccout"

    Delete "$DESKTOP\简易记账EasyAccout.lnk"

    RMDir /r  "$SMPROGRAMS\$StartMenuFolder"
SectionEnd



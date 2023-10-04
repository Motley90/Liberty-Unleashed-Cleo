format PE console
entry Main

include 'win32a.inc'

struct MODULEENTRY32
        dwSize                  dd ?   
        th32ModuleID            dd ? 
        th32ProcessID           dd ? 
        GlblcntUsage            dd ? 
        ProccntUsage            dd ? 
        modBaseAddr             dd ?   
        modBaseSize             dd ? 
        hModule                 dd ? 
        szModule                rb 260 
        szExePath               rb 1024
ends
section '.rdata' data readable

; Prints
welcome db 'Cleo Patch by Motley', 10, 0

gameFound db 'Game was found..', 10, 0

gameHack db 'Bypassing anticheat security..', 10, 0

section '.data' data readable writeable

ProcessID dd ?
ProcessHandle dd ?
 
ModuleLocation dd ?

TempProcEntry MODULEENTRY32
TempSnapshot dd ?

;========================================
 
section '.rodata' data readable
WindowTitle db 'Liberty Unleashed 0.1', 0
ModuleHeader db 'LU.dll', 0
 
PIDFormat db 'PID: %u', 0xD, 0xA, 0
AddressFormat db '0x%lx', 0xD, 0xA, 0
ModuleFormat db '%s @ 0x%x', 0xD, 0xA, 0

;========================================


section '.text' code executable
Main:
        push welcome
        call [printf]
        pop ecx
        push 0


        .game:
        invoke FindWindow, NULL, WindowTitle
        test eax,eax ; does it exist?
        jnz StartPatch ; Game found
        jmp .game ; retry

StartPatch:

        push gameFound
        call [printf]
        pop ecx
        push 0

        push gameHack
        call [printf]
        pop ecx
        push 0

        call sPause

sPause:
        ; Just here for right now to keep the console active
        jmp sPause

section '.idata' data readable import
        library kernel32, 'kernel32.dll', \
        msvcrt, 'msvcrt.dll', user32,'USER32.DLL'
        import kernel32, ExitProcess, 'ExitProcess', OpenProcess, 'OpenProcess', CreateToolhelp32Snapshot, 'CreateToolhelp32Snapshot', Module32First, 'Module32First', Module32Next, 'Module32Next',  CloseHandle, 'CloseHandle'
        import msvcrt, printf, 'printf', stricmp, '_stricmp'
        import user32, FindWindow,'FindWindowA', GetWindowThreadProcessId, 'GetWindowThreadProcessId'

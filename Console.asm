format PE console
entry Main

include 'win32a.inc'

section '.rdata' data readable

; Prints
welcome db 'Cleo Patch by Motley', 10, 0

gameFound db 'Game was found..', 10, 0

gameHack db 'Bypassing anticheat security..', 10, 0


; Game Title 
WindowTitle db 'Liberty Unleashed 0.1', 0

section '.text' code executable
Main:
        push welcome
        call [printf]
        pop ecx
        push 0

        jmp game
game:
        invoke FindWindow, NULL, WindowTitle
        test eax,eax ; does it exist?
        jnz StartPatch ; Game found
        jmp game ; retry

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
        import kernel32, ExitProcess, 'ExitProcess'
        import msvcrt, printf, 'printf'
        import user32, FindWindow,'FindWindowA'

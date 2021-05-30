; MouseOn routine called by Life.FOR
; Assemble with ML /c MouseL.ASM

        .MODEL LARGE, FORTRAN

MouseL PROTO  FORTRAN, m1:FAR PTR SWORD, m2:FAR PTR SWORD, m3:FAR PTR SWORD, \
			m4:FAR PTR SWORD

        .CODE

MouseL PROC   FORTRAN, m1:FAR PTR SWORD, m2:FAR PTR SWORD, m3:FAR PTR SWORD, \
			m4:FAR PTR SWORD

        les     bx, m1
        mov     ax, ES:[bx]
	int	33h
	push	bx
        les     bx, m3
        mov     ES:[bx], cx
        les     bx, m4
        mov     ES:[bx], dx
	les	bx, m2
	pop	dx
	mov	ES:[bx], dx
        ret
MouseL ENDP
        END

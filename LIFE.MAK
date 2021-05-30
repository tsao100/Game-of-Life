PROJ = life
PROJFILE = life.mak
DEBUG = 0

PWBRMAKE  = pwbrmake
NMAKEBSC1  = set
NMAKEBSC2  = nmake
CC  = cl
CFLAGS_G  = /BATCH
CFLAGS_D  = /Gi$(PROJ).mdt /Zi /Od
CFLAGS_R  = /Ot
FOR  = fl
ASM  = ml
AFLAGS_G  = /Cx /W2
AFLAGS_D  = /Zi
AFLAGS_R  = /nologo
FORFLAGS_R  = /Ot
FORFLAGS_D  = /Zi /Od
MAPFILE_D  = NUL
MAPFILE_R  = NUL
LFLAGS_G  = /NOI /BATCH
LFLAGS_D  = /CO /FAR /PACKC
LFLAGS_R  = /EXE /FAR /PACKC
LINKER	= link
ILINK  = ilink
LRF  = echo > NUL

OBJS  = LIFE.obj MouseL.obj kbhit.obj
SBRS  = LIFE.sbr MouseL.sbr kbhit.sbr

all: $(PROJ).exe

.SUFFIXES:
.SUFFIXES: .obj .sbr .for .asm

LIFE.obj : LIFE.for C:\FORTRAN\INCLUDE\FGRAPH.FI C:\FORTRAN\INCLUDE\FGRAPH.FD

LIFE.sbr : LIFE.for C:\FORTRAN\INCLUDE\FGRAPH.FI C:\FORTRAN\INCLUDE\FGRAPH.FD

MouseL.obj : MouseL.asm

MouseL.sbr : MouseL.asm

kbhit.obj : kbhit.asm

kbhit.sbr : kbhit.asm


$(PROJ).bsc : $(SBRS)
	$(PWBRMAKE) @<<
$(BRFLAGS) $(SBRS)
<<

$(PROJ).exe : $(OBJS)
!IF $(DEBUG)
	$(LRF) @<<$(PROJ).lrf
$(RT_OBJS: = +^
) $(OBJS: = +^
)
$@
$(MAPFILE_D)
$(LLIBS_G: = +^
) +
$(LLIBS_D: = +^
) +
$(LIBS: = +^
)
$(DEF_FILE) $(LFLAGS_G) $(LFLAGS_D);
<<
!ELSE
	$(LRF) @<<$(PROJ).lrf
$(RT_OBJS: = +^
) $(OBJS: = +^
)
$@
$(MAPFILE_R)
$(LLIBS_G: = +^
) +
$(LLIBS_R: = +^
) +
$(LIBS: = +^
)
$(DEF_FILE) $(LFLAGS_G) $(LFLAGS_R);
<<
!ENDIF
	$(LINKER) @$(PROJ).lrf


.for.obj :
!IF $(DEBUG)
	$(FOR) /c $(FORFLAGS_G) $(FORFLAGS_D) /Fo$@ $<
!ELSE
	$(FOR) /c $(FORFLAGS_G) $(FORFLAGS_R) /Fo$@ $<
!ENDIF

.for.sbr :
!IF $(DEBUG)
	$(FOR) /Zs $(FORFLAGS_G) $(FORFLAGS_D) /FR$@ $<
!ELSE
	$(FOR) /Zs $(FORFLAGS_G) $(FORFLAGS_R) /FR$@ $<
!ENDIF

.asm.obj :
!IF $(DEBUG)
	$(ASM) /c $(AFLAGS_G) $(AFLAGS_D) /Fo$@ $<
!ELSE
	$(ASM) /c $(AFLAGS_G) $(AFLAGS_R) /Fo$@ $<
!ENDIF

.asm.sbr :
!IF $(DEBUG)
	$(ASM) /Zs $(AFLAGS_G) $(AFLAGS_D) /FR$@ $<
!ELSE
	$(ASM) /Zs $(AFLAGS_G) $(AFLAGS_R) /FR$@ $<
!ENDIF


run: $(PROJ).exe
	$(PROJ).exe $(RUNFLAGS)

debug: $(PROJ).exe
	CV $(CVFLAGS) $(PROJ).exe $(RUNFLAGS)

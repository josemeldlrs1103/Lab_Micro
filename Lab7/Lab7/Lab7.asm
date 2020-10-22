.386
.MODEL flat, stdcall
OPTION casemap:none										;Convencion sobre mayusculas y minusculas
include \masm32\include\masm32rt.inc
include \masm32\include\masm32.inc
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
.DATA
		Sol1 DB "Escriba su nombre: ",0					;Cadena que indica la información que se solicita
		Sol2 DB "Escriba su carnet: ",0					;Cadena que indica la información que se solicita
		Sol3 DB "Escriba su carrera: ",0				;Cadena que indica la información que se solicita
		nombre DB 128 DUP (0)							;Variable para almacenar el nombre
		carne DB 128 DUP (0)							;Variable para almacenar el carne
		carrera DB 128 DUP (0)							;Variable para almacenar la carrera
		Saludo DB "Hola ",0
		Info DB ", su carnet es: ",0
		Bien DB 10,"Bienvenido a la carrera de ",0
.CODE
Programa :
	INVOKE StdOut, ADDR Sol1
	INVOKE StdIn, ADDR nombre,35						
	INVOKE StdOut, ADDR Sol2
	INVOKE StdIn, ADDR carne,10							
	INVOKE StdOut, ADDR Sol3
	INVOKE StdIn, ADDR carrera,30
	INVOKE StdOut, ADDR Saludo
	INVOKE StdOut, ADDR nombre							
	INVOKE StdOut, ADDR Info
	INVOKE StdOut, ADDR carne							
	INVOKE StdOut, ADDR Bien
	INVOKE StdOut, ADDR carrera							
   INVOKE ExitProcess,0									
END Programa
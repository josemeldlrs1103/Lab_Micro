DatosCuadrilateros MACRO LadoMay, LadoMen, Perimetro , Area
XOR AX, AX
MOV AL, LadoMay
ADD AL, LadoMay
ADD AL, LadoMen
ADD AL, LadoMen
MOV Perimetro, AL
XOR AX, AX
XOR BX, BX
MOV AL, LadoMay
MOV BL, LadoMen
MUL BL
MOV Area, AL
ENDM
Operaciones MACRO ValA, ValB, ValC, Oper1, Oper2, Oper3, Oper4
;Operación 1
MOV AL, ValB
MOV BL, 02h
MUL BL
MOV Oper1, AL
MOV AL, ValA
MOV BL, ValC
SUB AL, BL
MOV BL,03h
MUL BL
ADD Oper1, AL
;Operación 2
MOV AL, ValA
MOV BL, ValB
DIV BL
MOV Oper2, AL
;Operación 3
MOV AL, ValA
MOV BL, ValB
MUL BL
MOV BL, ValC
DIV BL
MOV Oper3, AL
;Operación 4
MOV AL, ValB
MOV BL, ValC
DIV BL
MOV BL, ValA
MUL BL
MOV Oper4, AL
ENDM
.386
.MODEL flat, stdcall
OPTION casemap:none ; convenion sobre mayusculas y minusculas al pasar parametros al api
include \masm32\include\masm32rt.inc
include \masm32\include\masm32.inc
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
.DATA
	MenuP DB "1- Ejercicio 1",13,10,"2- Ejercicio 2",13,10,"3- Ejercicio 3",13,10,"4- Salir",13,10,0
	Ejer1Op DB "1- Calcular Cuadrado",13,10,"2- Calcular rectangulo",13,10,"3- Calcular Triangulo",13,10,0
	SolA DB "Ingrese valor de A",13,10,0
	SolB DB "Ingrese valor de B",13,10,0
	SolC DB "Ingrese valor de C",13,10,0
	SolCad1 DB "Ingrese valor de Cadena en la que segment busca la subcadena",13,10,0
	SolCad2 DB "Ingrese valor de subcadena",13,10,0
	SolLado DB "Ingrese la longitud de la base",13,10,0
	SolDiagonal DB "Ingrese la longitud de los laterales",13,10,0
	SolAltura DB "Ingrese la altura de la figura",13,10,0
	ResPerimetro DB "El perimetro de la figura es: ",0
	ResArea DB "El area de la figura es: ",0
	ResOper DB "El resultado de las operaciones es: ",13,10,0
	ResConteo DB "Cantidad dec veces que se encontro la subcadena: ",0
	Elec DB 0,0
	LadoMayor DB 0,0
	LadoMenor DB 0,0
	Perimetro DB 0,0
	Area DB 0,0
	ValA DB 0,0
	ValB DB 0,0
	ValC DB 0,0
	Oper1 DB 0,0
	Oper2 DB 0,0
	Oper3 DB 0,0
	Oper4 DB 0,0
	CadenaMayor DW 100 DUP ("$")
	CadenaMenor DW 100 DUP ("$")
	Cantidad DB 0,0
.CODE
Programa:
	Menu:
		INVOKE StdOut, ADDR MenuP
		INVOKE StdIn, ADDR Elec,10
		CMP Elec, 31h
		JE Ejercicio1
		CMP Elec, 32h
		JE Ejercicio2
		CMP Elec, 33h
		JE Ejercicio3
		CMP Elec, 34h
		JE Salida
		JMP Menu
	Ejercicio1:
		INVOKE StdOut, ADDR Ejer1Op
		INVOKE StdIn, ADDR Elec,10
		CMP Elec, 31h
		JE Cuadrado
		CMP Elec, 32h
		JE Rectangulo
		CMP Elec, 33h
		JE Triangulo
		JMP Ejercicio1
	Ejercicio2:
		INVOKE StdOut, ADDR SolA
		INVOKE StdIn, ADDR ValA, 10
		SUB ValA, 30h
		INVOKE StdOut, ADDR SolB
		INVOKE StdIn, ADDR ValB, 10
		SUB ValB, 30h
		INVOKE StdOut, ADDR SolC
		INVOKE StdIn, ADDR ValC, 10
		SUB ValC, 30h
		Operaciones ValA, ValB, ValC, Oper1, Oper2, Oper3, Oper4
		INVOKE StdOut, ADDR ResOper
		MOV AL, Oper1
		print str$(AL), 13,10
		MOV AL, Oper2
		print str$(AL), 13,10
		MOV AL, Oper3
		print str$(AL), 13,10
		MOV AL, Oper4
		print str$(AL), 13,10
		JMP Menu
	Ejercicio3:
		MOV Cantidad, 0h
		INVOKE StdOut, ADDR SolCad1
		INVOKE StdIn, ADDR CadenaMayor, 99
		INVOKE StdOut, ADDR SolCad2
		INVOKE StdIn, ADDR CadenaMenor,99
		CALL EvaluacionCadena
		INVOKE StdOut, ADDR ResConteo
		MOV AL, Cantidad
		print str$(AL), 13,10
		JMP Menu
	Cuadrado:
		MOV Perimetro, 0h
		MOV Area, 0h
		INVOKE StdOut, ADDR SolLado
		INVOKE StdIn, ADDR LadoMayor, 10
		SUB LadoMayor, 30h
		DatosCuadrilateros LadoMayor, LadoMayor, Perimetro, Area
		INVOKE StdOut, ADDR ResPerimetro
		MOV AL, Perimetro
		print str$(AL), 13,10
		MOV AL, Area
		INVOKE StdOut, ADDR ResArea
		MOV AL, Area
		print str$(AL), 13,10
		JMP Menu
	Rectangulo:
		MOV Perimetro, 0h
		MOV Area, 0h
		INVOKE StdOut, ADDR SolLado
		INVOKE StdIn, ADDR LadoMayor, 10
		INVOKE StdOut, ADDR SolAltura
		INVOKE StdIn, ADDR LadoMenor, 10
		SUB LadoMayor, 30h
		SUB LadoMenor, 30h
		DatosCuadrilateros LadoMayor, LadoMenor, Perimetro, Area
		INVOKE StdOut, ADDR ResPerimetro
		MOV AL, Perimetro
		print str$(AL), 13,10
		MOV AL, Area
		INVOKE StdOut, ADDR ResArea
		MOV AL, Area
		print str$(AL), 13,10
		JMP Menu
	Triangulo:
		INVOKE StdOut, ADDR SolLado
		INVOKE StdIn, ADDR LadoMayor, 10
		INVOKE StdOut, ADDR SolDiagonal
		INVOKE StdIn, ADDR LadoMenor, 10
		SUB LadoMayor, 30h
		SUB LadoMenor, 30h
		INVOKE StdOut, ADDR ResPerimetro
		XOR AX,AX
		MOV AL, LadoMayor
		ADD AL, LadoMenor
		ADD AL, LadoMenor
		print str$(AL), 13,10
		INVOKE StdOut, ADDR SolAltura
		INVOKE StdIn, ADDR LadoMenor, 10
		SUB LadoMenor,30h
		INVOKE StdOut, ADDR ResArea
		XOR AX,AX
		XOR BX, BX
		MOV AL, LadoMayor
		MOV BL, LadoMenor
		MUL BL
		MOV BL, 02h
		DIV BL
		print str$(AL), 13,10
		JMP Menu
	EvaluacionCadena PROC near
	LEA EDI, CadenaMayor
	LEA ESI, CadenaMenor
		Inicio:
		MOV BL, [ESI]
		MOV DL, [EDI]
		CMP DL, BL
		JE ActualIgual
		LEA  ESI, CadenaMenor
		MOV BL, 0h
		CMP DL, BL
		JE TerminarProceso
		INC EDI
		JMP Inicio
	
	ActualIgual:
		INC EDI
		INC ESI
		MOV BL,[ESI]
		MOV DL,[EDI]
		MOV BL, 0h
		CMP [ESI],BL
		JE Encontrada
		JMP Inicio

	Encontrada:
		INC Cantidad
		LEA  ESI, CadenaMenor
		JMP Inicio

	TerminarProceso:
	ret
	EvaluacionCadena ENDP
	Salida:
		INVOKE ExitProcess,0
END Programa
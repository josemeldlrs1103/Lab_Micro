.model small 									;Declaración de modelo
.data 											;Inicia segmento de datos
	Reqst	  DB	'Por favor ingrese un numero',10,13,'$'
	Reslt	  DB	'El Resultado es: $'
	OPRTR	  DW ?
.stack
.code
Programa:
	;Inicialización del programa
	MOV AX, @Data 								;Obtener dirección del inicio de segmento de datos
	MOV DS, AX									;Inicializa segmento de datos

Binario:
	CALL NumeroENT
	CALL Lector
	CALL NLinea
	CALL Resultado
	JMP Conver
	
Conver:
	MOV BX, OPRTR
	MOV CX, 08h
	BinNum:
		MOV AH, 02h
		SHL BL,1
		JC ImpUno
		MOV DL, 30h
		JMP ImpCero
		ImpUno:
			MOV DL, 31h
		ImpCero:
			INT 21h
		Loop BinNum
	JMP Salida
;Procedimiento para lectura de numeros
Lector PROC NEAR
	XOR AX, AX									;Limpieza registro acumulador
	MOV AH, 01h									;Lectura de un solo caracter
	INT 21h
	MOV AH,0h										
	SUB AX, 30h									;Ascii a Hex
	MOV DL, 0Ah									;
	MUL DL
	MOV OPRTR, AX
	XOR AX, AX
	XOR DX, DX
	MOV AH, 01h									;Lectura de un solo caracter
	INT 21h	
	MOV AH,0h									
	SUB AX, 30h									;Ascii a Hex
	ADD OPRTR, AX
	ret
Lector ENDP

NumeroEnt PROC NEAR
	MOV AH, 09h									;Parámetro de impresión de cadenas
	MOV DX, OFFSET Reqst							;Cadena instrucción 1
	INT 21h	
	ret
NumeroENT ENDP

NLinea PROC NEAR
    XOR DX,DX
    MOV DL,0Ah
    MOV AH,02h
    INT 21h
    MOV DL,0Dh
    INT 21h
    ret
NLinea ENDP   

Resultado PROC NEAR
    MOV AH, 09h									;Parámetro de impresión de cadenas
	MOV DX, OFFSET Reslt							;Cadena instrucción 1
	INT 21h	
	ret
Resultado ENDP
Salida:	
	;Finalización del programa
	MOV AH, 4Ch
	INT 21h
END Programa
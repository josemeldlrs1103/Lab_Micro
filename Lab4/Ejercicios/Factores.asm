.model small 									;Declaración de modelo
.data 											;Inicia segmento de datos
	Reqst	  DB	'Por favor ingrese un numero',10,13,'$'
	Reslt	  DB	'El resultado es: ',10,13,'$'
	OPRTR     DW	?
	OPRND     DW    0001h
	Decenas   DW    ?
.stack
.code
Programa:
	;Inicialización del programa
	MOV AX, @Data 								;Obtener dirección del inicio de segmento de datos
	MOV DS, AX									;Inicializa segmento de datos
	
Factores:
	CALL NLinea									;Imprimir cadena de separación
	CALL NumeroENT								;Solicitar ingreso de número
	CALL Lector									;Leer número ingresado por usuario
	CALL NLinea
	CALL Resultado
    MOV AX, OPRTR
    MOV BX, OPRND
    JMP CalcFactores
	
;Calcular factores
CalcFactores:
    CMP AX,BX
    JL Salida
    XOR DX,DX
    DIV BX
    CMP DX, 00h
    JE ImpFactor
    MOV AX, OPRTR
    ADD OPRND, 01h
    MOV BX, OPRND
    JMP CalcFactores

Salida:	
	;Finalización del programa
	MOV AH, 4Ch
	INT 21h
    
;Imprimir resultado
ImpFactor:
    CMP BX, 0Ah
    JL DigiFact
    SUB BX,0Ah
    INC DX
    JMP ImpFactor
    
DigiFact:
    MOV Decenas,DX
    MOV AH, 02h
    MOV DL, 28h
    INT 21h
    MOV DX, Decenas
    ADD DX, 30h
    INT 21h
    MOV DX, BX
    ADD DX, 30h
    INT 21h
    MOV DL, 29h
    INT 21H
    MOV AX,OPRTR
    ADD OPRND,01h
    MOV BX,OPRND
    JMP CalcFactores
    
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
END Programa
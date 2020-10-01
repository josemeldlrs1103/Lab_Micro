.model small 									;Declaración de modelo
.data 											;Inicia segmento de datos
	Reqst	  DB	'Por favor ingrese un numero',10,13,'$'
	Reslt	  DB	'El Resultado es: $'
	Residuo	  DB	', con residuo: $'
	OPRTR	  DW ?
	OPRND     DW ?
.stack
.code
Programa:
	;Inicialización del programa
	MOV AX, @Data 								;Obtener dirección del inicio de segmento de datos
	MOV DS, AX									;Inicializa segmento de datos
	
Dividir:
	CALL NLinea
	CALL NumeroENT
	CALL Lector
	XOR CX,CX
	MOV CX,OPRTR
	MOV OPRND, CX
	CALL NLinea
	CALL NumeroENT
	Call Lector
	Call NLinea
	MOV AX, OPRND
	MOV BX, OPRTR
	XOR DX,DX
	JMP OPDIV
	
OPDIV:
	CMP BX, AX
	JG TotalDiv
	SUB AX, BX
	INC DX
	JMP OPDIV

;Mostrar resultado de la división
TotalDiv:
    XOR BX,BX
    MOV BX,DX
    XOR DX,DX
    XOR CX,CX
    MOV CX,AX
    Call Resultado
    XOR DX,DX
    JMP CocienteDiv
    
CocienteDiv:
    CMP BX,0Ah
    JL ResultadoDiv
    SUB BX, 0Ah
    INC DX
    JMP CocienteDiv
    
ResultadoDiv:
    CALL ImpDigito
    CALL ImpUnidad
    XOR BX,BX
    MOV BX,AX
    MOV AH, 09h									
	MOV DX, OFFSET Residuo
	INT 21h
	MOV BX,CX
	CALL ImpUnidad
	CALL NLinea
	JMP Salida
   
;Imprimir resultado
ImpDigito PROC NEAR
    ADD DL, 30h
    MOV AH, 02h
    INT 21h
    XOR DX,DX
    ret
ImpDigito ENDP 
;Imprimir Unidad
ImpUnidad PROC NEAR
    ADD BX, 30h
    MOV DX, BX
    MOV AH, 02h
    INT 21h
    XOR BX,BX
    ret
ImpUnidad ENDP
    
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
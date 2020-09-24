.model small 									;Declaración de modelo
.data 											;Inicia segmento de datos
	Instruccion1 DB 'Ingrese la cantidad de pruebas realizadas',10,13,'$'
	Instruccion2 DB 'Ingrese la cantidad de resultados positivos',10,13,'$'
	AlertaR		 DB 'Alerta Roja$'
	AlertaN		 DB 'Alerta Naranja$'
	AlertaA		 DB 'Alerta Amarilla$'
	AlertaV		 DB 'Alerta Verde$'
	Cant1 		 DW ?
	Cant2        DW ?
.stack
.code
Programa:
	;Inicialización del programa
	MOV AX, @Data 								;Obtener dirección del inicio de segmento de datos
	MOV DS, AX									;Inicializa segmento de datos
	;Imprimir instrucción inicial
	MOV DX, OFFSET Instruccion1
	MOV AH, 09h
	INT 21h
	;Lectura cantidad de pruebas
	XOR AX, AX									;Limpiando registro AX
	MOV AH,01h									;Lectura de caracter
	INT 21h
	SUB AX, 30h									;Ascii a Hex
	MOV DL, 64h									;Factor de conversión 100d
	MUL DL										;Converción a centenas
	MOV Cant1,AX								;Asignando valor variable
	XOR AX,AX									;limpiando registros
	XOR DX,DX
	MOV AH, 01h
	INT 21h
	MOV AH, 00h
	SUB AX, 30h									;Ascii a Hex
	MOV DL, 0Ah									;Factor de conversión 10d
	MUL DL										;Converción a decenas
	ADD Cant1, AX
	XOR AX,AX									;limpiando registros
	XOR DX,DX
	MOV AH,01h
	INT 21h
	MOV AH, 00h
	SUB AX, 30h									;Ascii a Hex
	ADD Cant1, AX
	MOV DL, 0Ah
	MOV AH, 02h
	INT 21h
	;Imprimir instrucción inicial
	MOV DX, OFFSET Instruccion2
	MOV AH, 09h
	INT 21h
	;Lectura cantidad de pruebas
	XOR AX, AX									;Limpiando registro AX
	MOV AH,01h									;Lectura de caracter
	INT 21h
	SUB AX, 30h									;Ascii a Hex
	MOV DL, 64h									;Factor de conversión 100d
	MUL DL										;Converción a centenas
	MOV Cant2,AX								;Asignando valor variable
	XOR AX,AX									;limpiando registros
	XOR DX,DX
	MOV AH, 01h
	INT 21h
	MOV AH, 00h
	SUB AX, 30h									;Ascii a Hex
	MOV DL, 0Ah									;Factor de conversión 10d
	MUL DL										;Converción a decenas
	ADD Cant2, AX
	XOR AX,AX									;limpiando registros
	XOR DX,DX
	MOV AH,01h
	INT 21h
	MOV AH, 00h
	SUB AX, 30h									;Ascii a Hex
	ADD Cant2, AX
	MOV DL, 0Ah
	MOV AH, 02h
	INT 21h
	;Verificar que exista al menos un caso positivo para evitar la division entre 0
	MOV BX,Cant2
	CMP BX,0000h
	JE Verde
	;Calcular porcentaje
	MOV AX, Cant2
	XOR BX,BX
	MOV BX, 064h
	MUL BX
	XOR BX,BX
	MOV BX, Cant1
	DIV BX
	;Verificar si el resultado despliega alerta verde
	CMP AX, 04h
	JLE Verde
	;Verificar si el resultado despliega alerta amarilla
	CMP AX, 0Fh
	JLE Amarillo
	;Verificar si el resultado despliega alerta naranja
	CMP AX, 13h
	JLE Naranja
	;Verificar si el resultado despliega alerta roja
	CMP AX, 14h
	JGE Rojo
Verde:
MOV DX, OFFSET AlertaV
	MOV AH, 09h
	INT 21h
	JMP Salida
Amarillo:     
MOV DX, OFFSET AlertaA
	MOV AH, 09h
	INT 21h
	JMP Salida
Naranja:   
MOV DX, OFFSET AlertaN
	MOV AH, 09h
	INT 21h
	JMP Salida
Rojo:       
MOV DX, OFFSET AlertaR
	MOV AH, 09h
	INT 21h
	JMP Salida
Salida:	
	MOV AH, 4Ch
	INT 21h
END Programa
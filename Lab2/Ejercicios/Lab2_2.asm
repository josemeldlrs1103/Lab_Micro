.model small									;declaración del modelo
.data											;Inicia segmento de datos
		ValueA DB 'A=04h',10,13,'$'				;variables tipo byte, es cadena y terminan en $
		ValueB DB 'B=02h',10,13,'$'
		ValueC DB 'C=01h',10,13,'$'
		NumA   DB 04h
		NumB   DB 02h
		NumC   DB 01h
.stack
.code
main:
	;Inicialización del programa
	mov AX, @Data 								;Obtener dirección del segmento de datos
	mov DS, AX									;Inicio del segmento de datos
	;Demostración valor de variables
		mov DX, OFFSET ValueA						;Asignando de DX la variable nombre
	mov AH, 09h									;Instrucción de impresión en cadena
	int 21h										;Ejecutar la interrupción
	mov DX, OFFSET ValueB 						;Asignando de DX la variable nombre
	mov AH, 09h									;Instrucción de impresión en cadena
	int 21h										;Ejecutar la interrupción
	mov DX, OFFSET ValueC 						;Asignando de DX la variable nombre
	mov AH, 09h									;Instrucción de impresión en cadena
	int 21h										;Ejecutar la interrupción
	;Operaciones Ejercicio2
	xor AX,AX									;Limpiando el registrador AX
	;Operación 1: A+B
	mov AL, NumA								;Inicialización del registrado con el valor de NumA
	add AL, NumB								;Agregando el valor NumB
	add AL, 30h									;Agregando 30h para hacer que el resultado corresponda con el valor ascii
	;imprimir y cambiar de linea
	mov DL,AL									;Impresión del resultado en pantalla
	mov AH,02h			
	int 21h		
	mov DL, 10									;Impresión salto de línea
	int 21h
	mov DL, 13									;Impresión vuelta de carro
	;Operación 2: A-C
	mov AL, NumA								;Inicialización del registrado con el valor de NumA
	sub AL, NumC								;sustrayendo el valor NumC
	add AL, 30h									;Agregando 30h para hacer que el resultado corresponda con el valor ascii
	;imprimir y cambiar de linea
	mov DL,AL									;Impresión del resultado en pantalla
	mov AH,02h			
	int 21h		
	mov DL, 10									;Impresión salto de línea
	int 21h
	mov DL, 13									;Impresión vuelta de carro
	;Operación 3: A+2B+C
	mov AL, NumA								;Inicialización del registrado con el valor de NumA
	add AL, NumB								;Agregando el valor NumB
	add AL, NumB								;Agregando el valor NumB
	add AL, NumC								;Agregando el valor NumC
	add AL, 30h									;Agregando 30h para hacer que el resultado corresponda con el valor ascii
	;imprimir y cambiar de linea
	mov DL,AL									;Impresión del resultado en pantalla
	mov AH,02h			
	int 21h		
	mov DL, 10									;Impresión salto de línea
	int 21h
	mov DL, 13									;Impresión vuelta de carro
	;Operación 3: A+B-C
	mov AL, NumA								;Inicialización del registrado con el valor de NumA
	add AL, NumB								;Agregando el valor NumB
	sub AL, NumC								;sustrayendo el valor NumC
	add AL, 30h									;Agregando 30h para hacer que el resultado corresponda con el valor ascii
	;imprimir y cambiar de linea
	mov DL,AL									;Impresión del resultado en pantalla
	mov AH,02h			
	int 21h		
	;Finalización del programa
	mov AH, 4ch
	int 21h
End main
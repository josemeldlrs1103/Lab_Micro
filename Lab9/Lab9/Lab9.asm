ImprimeNumero MACRO numero 
	add numero,30h
	invoke StdOut, ADDR numero
ENDM
Mapeo MACRO I, J, Filas, Columnas, Tamano
	MOV AL, I
	MOV BL, Columnas
	mul BL				; Resultado está en AL
	MOV BL, Tamano
	MUL BL				; Primera parte de la fórmula
	; Columnas
	MOV CL, AL				; guardar temporalmente el resultado de las filas
	MOV AL, J
	MOV BL, Tamano
	MUL BL
	; sumar
	ADD AL, CL				; Resultado en AL
ENDM
.386																							;Definición del modelo del procesador
.MODEL flat, stdcall																			;Convención del uso de parámetros
OPTION casemap:none																				;Convención del mapeo de caracteres 
;Inclusión de librerías utilizadas
INCLUDE \masm32\include\windows.inc
INCLUDE \masm32\include\kernel32.inc
INCLUDE \masm32\include\masm32.inc
INCLUDE \masm32\include\masm32rt.inc
.DATA
;Cadenas usadas para la interacción con el usuario
MenuP DB "Elija una opcion:",13,10,"1- Llenado por contador",13,10,"2-Llenado personalizado",13,10,0
SolColumnas DB "Ingrese en formato de dos cifras la cantidad de columnas de la matriz: ",0
SolFilas DB "Ingrese en formato de dos cifras la cantidad de filas de la matriz: ",0
CantCeldas DB "Espacios con los que cuenta la matriz: ",0
Resultado DB "La matriz calculada es la siguiente: ",13,10,0
Alerta DB "La cantidad de celdas de la matriz no es permitida. Cantidad permitida 1-99.",13,10,0
Decenas DB "Decenas: ",0
Unidades DB "Unidades: ",0
;Variables utilizadas para determinar el tamaño de la matriz
CantColumnas DB 0,0
CantFilas DB 0,0
Auxiliar DB 0,0
;Contador para la posición de la matriz
Elemento DB 0,0
;Variables para recorrer la matriz
IndColumnas DB 0,0
IndFilas DB 0,0
;Variable usada para el menú
Elegida db 0,0
.CODE
Programa:
	Menu:
		INVOKE StdOut, ADDR MenuP
		INVOKE StdIn, ADDR Elegida, 10
		INVOKE StdOut, ADDR SolColumnas
		CALL Lectura
		MOV CantColumnas,AL
		INVOKE StdOut, ADDR SolFilas
		CALL Lectura
		MOV CantFilas, AL
		MOV AL, CantColumnas
		MOV BL, CantFilas
		MUL BL
		CMP AX, 0h
		JLE Emergencia
		CMP AX, 63h
		JG Emergencia
		CMP Elegida, 31h
		JE Ejercicio1
		JMP  Menu
	Ejercicio1:
		INVOKE StdOut, ADDR Resultado
		CALL ImpMat
		ImpMat PROC Near
		CicloColumnas:
			Mapeo IndFilas, IndColumnas, CantFilas, CantColumnas, 1			
			MOV Elemento, AL
			ImprimeNumero Elemento
			INC IndColumnas
			MOV CL, IndColumnas
			CMP CL, CantColumnas
			JL CicloColumnas
			INC IndFilas
			MOV CL, IndFilas
			CMP CL, CantFilas
			JL CicloFilas
			print chr$(13,10)
			JMP Salida
			CicloFilas:
			MOV IndColumnas, 0h
			print chr$(13,10)
			JMP CicloColumnas
		ret
		ImpMat ENDP
	Emergencia:
		INVOKE StdOut, ADDR Alerta
		JMP Salida
	;Salida del programa
	Salida:
		INVOKE ExitProcess, 0
	;Procedimiento para la lectura de números de dos dígitos
	Lectura PROC Near
	INVOKE StdOut, ADDR Decenas
	INVOKE StdIn, ADDR Auxiliar,10
	SUB Auxiliar, 30h
	MOV AL, Auxiliar
	MOV BL, 0Ah
	MUL BL
	MOV BL, AL
	INVOKE StdOut, ADDR Unidades
	INVOKE StdIn, ADDR Auxiliar,10
	SUB Auxiliar, 30h
	MOV AL, BL
	ADD AL, Auxiliar
	ret
	Lectura ENDP
END Programa
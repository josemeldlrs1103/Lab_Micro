.model small									;declaración del modelo
.data											;Inicia segmento de datos
		nombre DB 'Jose Melendez$'				;variables tipo byte, es cadena y terminan en $
		carnet DB '1059918$'
.stack
.code
main:
	;Inicialización del programa
	mov AX, @Data 								;Obtener dirección del segmento de datos
	mov DS, AX									;Inicio del segmento de datos
	;Impresión de cadenas
	mov DX, OFFSET nombre						;Asignando de DX la variable nombre
	mov AH, 09h									;Instrucción de impresión en cadena
	int 21h										;Ejecutar la interrupción
	mov Dl, 2Dh									;Asignando un espacio de separación
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecución de interrupción
	mov DX, OFFSET carnet 						;Asignando de DX la variable nombre
	mov AH, 09h									;Instrucción de impresión en cadena
	int 21h										;Ejecutar la interrupción
	;Finalización del programa
	mov AH, 4ch
	int 21h
End main
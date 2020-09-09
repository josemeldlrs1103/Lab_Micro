.model small									;declaración del modelo
.data											;Inicia segmento de datos
.stack
.code
main:
	;Inicialización del programa
	mov AX, @Data 								;Obtener dirección del segmento de datos
	mov DS, AX									;Inicio del segmento de datos
	;Impresión de nombre
	mov Dl, 4Ah									;Asignando J
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecución de interrupción
	mov Dl, 2Dh									;Asignando un espacio de separación
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecutar la interrupción
	mov Dl, 6fh									;Asignando o
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecución de interrupción
	mov Dl, 2Dh									;Asignando un espacio de separación
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecución de interrupción
	mov Dl, 73h									;Asignando s
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecución de interrupción
	mov Dl, 2Dh									;Asignando un espacio de separación
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecutar la interrupción
	mov Dl, 65h									;Asignando e
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecución de interrupción
	mov Dl, 2Dh									;Asignando un espacio de separación
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecución de interrupción
	;Impresión de Apellido
	mov Dl, 4Dh									;Asignando M
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecución de interrupción
	mov Dl, 2Dh									;Asignando un espacio de separación
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecutar la interrupción
	mov Dl, 65h									;Asignando e
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecución de interrupción
	mov Dl, 2Dh									;Asignando un espacio de separación
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecución de interrupción
	mov Dl, 6Ch									;Asignando l
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecución de interrupción
	mov Dl, 2Dh									;Asignando un espacio de separación
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecutar la interrupción
	mov Dl, 65h									;Asignando e
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecución de interrupción
	mov Dl, 2Dh									;Asignando un espacio de separación
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecución de interrupción
	mov Dl, 6Eh									;Asignando n
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecución de interrupción
	mov Dl, 2Dh									;Asignando un espacio de separación
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecutar la interrupción
	mov Dl, 64h									;Asignando d
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecución de interrupción
	mov Dl, 2Dh									;Asignando un espacio de separación
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecución de interrupción
	mov Dl, 65h									;Asignando e
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecución de interrupción
	mov Dl, 2Dh									;Asignando un espacio de separación
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecutar la interrupción
	mov Dl, 7Ah									;Asignando z
	mov AH, 02h									;Impresión de caracter único
	int 21h										;Ejecución de interrupción
	;Finalización del programa
	mov AH, 4ch
	int 21h
End main
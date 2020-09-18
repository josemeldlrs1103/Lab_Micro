.model small			; Modelo para ejecutables
.stack					
.code					; Inicia el segmento de c�digo
programa:				; Etiqueta para el inicio del programa
		;Inicializaci�n del programa
		Mov AX,@DATA	; Se obtiene la direcci�n de inicio del segmento de datos
		Mov DS,AX		; Se asigna al registro data segment la direcci�n de inicio del segmento de datos
		Mov AX,0000h	; Se inicializa el acumulador
		Mov BX,0000h	; Se inicializa el registro BX
		Mov AL,2Dh		; Se asigna el valor a la parte baja del registro AX
		Mov BL,2Dh		; Se asigna el valor a la parte baja del registro BX
		Add AL,BL		; Se suman los dos registros
		Mov DL,AL		; El resultado se asigna al registro DL para imprimirlo en pantalla
		Mov AH,02		; Se asigna el valor para impresi�n de caracteres en pantalla a la parte alta del acumulador
		Int 21h			; Se invoca a la interrupci�n del DOS 21h
		;Finalizaci�n del programa
		Mov AH,4CH		
		int 21h			

End programa
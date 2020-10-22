.model small						  			;Declaración de modelo
.data											;Inicia el segmento de datos
	Entrada		DB 'Ingrese un numero para calculo de factorial',10,13,'$'    
	Resultado   DB 10,13,'Resultado: $' 
	Cadena      DW 128 DUP ('$')                  
	Numero      DW 0
.stack
.code
Programa:
	;Inicialización del programa
    MOV AX, @Data    							;Obtener dirección del inicio de segmento de datos
    MOV DS, AX 									;inicializar segmento de datos     
	;Cálculo de Factorial
    MOV AH, 09h									;Impresión de instrucción inicial
	MOV DX, OFFSET Entrada 
    INT 21h
	CALL Lector									;Leer el número ingresado por el usuario
	MOV Numero, BX								;Cargar el número leído en la variable
	MOV AH, 09h
	MOV DX, OFFSET Resultado
	INT 21h 
	MOV BX, Numero								;Colocar el número ingresado en registrador Base
    XOR DX,DX									;Limpiar registro de data
    MOV AX,1 									;Iniciar multiplicar desde 1, acumular resultado en AXse partira del numero 1
    MOV CX,1 									;Cargar en CX el número a multiplicar
    Multiplicaciones:
        CALL Multiplicar                        ;Llamar a procedimiento que realiza la multiplicación
        INC CX                                  ;Incrementar el número por que cual se va a multiplicar
        CMP CX, BX                              ;Determinar si se se debe realizar la multiplicación nuevamente                            ; se compara el contador y el numero ingresado
        JBE Multiplicaciones                    
    MOV DI, OFFSET Cadena 						;Mover la cadena a DI
    CALL ConvToDec								;Llamar a procedimiento para conversión de cadena a sistema decimal
    MOV DX, OFFSET Cadena  
    MOV AH, 09h									;Impresión de cadena con el resultado
    INT 21h 
	JMP Salida
Multiplicar PROC                                                   	      	
    PUSH DX 																;Cargar parte baja en la pila
    MUL CX																	;Multiplicar DX Y CX
    MOV SI, DX 		                                                        ;Almacenar el resultado de la multiplicación
    MOV DI, AX                         
    POP AX		                                                            ;Obtner la parte alta 
    MUL CX 		                                                            ;Multiplicar AX y CX
    ADD AX,SI	                                                            ;Sumar el resultado de de la multiplicación de la parte alta y baja  de la multiplicacion a la parte baja
    ADC DX, 0
    MOV SI, DX                                                           	;Preparar valores para añadir resultado a la cadena
    MOV DX,AX
    MOV AX, DI
    ret
Multiplicar ENDP

ConvToDec PROC                       
	MOV CS:Objetivo, DI
    MOV SI, AX 																;Mover la cadena calculada
	MOV DI, DX
	MOV CS: Contador, 0														;Fijar un contador en 0
    MOV BX, 10
    Adaptar:
        INC CS: Contador
        XOR DX, DX 
        MOV AX, DI 							                                ;Parte alta de la palabra
        MOV CX, AX 
        DIV BX                                                              
        MOV DI, AX															;Almacenar parte alta
        MUL BX 																;Multiplicar
        SUB CX, AX														    ;Restar valor divisible a la parte alta
        MOV DX, CX
        MOV AX, SI
        DIV BX
        OR DL, 30h 															;Se Convierte al número que corresponde 
        PUSH DX
        MOV SI, AX															;Almacenar parte baja  se almacena la parte baja
        OR AX, DI 															;Comprobar si aún hay contenido para convertir
        JNZ     Adaptar                                                     
    MOV DI, CS:Objetivo                                                     ;Mover el objetivo
    MOV CX, CS: Contador                                                    ;Mover el contador
    limpiarPila:
        POP AX                                                              ;Se hace pop
        MOV [DI], AL      
        INC DI                                                              ;Incrementar DI
        LOOP LimpiarPila                                                    ;Ciclo para limpiar Pila
    MOV BYTE PTR [DI], '$'                                                  
    ret                                                                     
    Contador DW 0                                                           ;Limpiar Contador
    Objetivo DW 0	                                                        ;Limpiar Objetivo
ConvToDec ENDP

Lector PROC NEAR								;Procedimiento para la lectura del número
	XOR AX, AX									;Limpieza registro acumulador
	MOV AH, 01h									;Lectura de un solo caracter
	INT 21h
	MOV AH,0h										
	SUB AX, 30h									;Ascii a Hex
	MOV DL, 0Ah									;Factor conversión a decenas
	MUL DL										;Conversión a decenas
	MOV BX, AX
	XOR AX, AX
	XOR DX, DX
	MOV AH, 01h									;Lectura de caracter
	INT 21h	
	MOV AH,0h									
	SUB AX, 30h									;Ascii a Hex
	ADD BX, AX
	ret
Lector ENDP
Salida: 
	;Finalización del programa
	MOV AH, 4Ch
	INT 21h
END Programa
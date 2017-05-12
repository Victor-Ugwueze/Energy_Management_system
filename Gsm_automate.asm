
_Initialization:

;Gsm_automate.c,7 :: 		void Initialization()
;Gsm_automate.c,9 :: 		UART1_Init(9600);   // Initialize Serial Port at 9600 baud rate
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Gsm_automate.c,10 :: 		}
L_end_Initialization:
	RETURN
; end of _Initialization

_SendSms:

;Gsm_automate.c,25 :: 		void SendSms(){
;Gsm_automate.c,26 :: 		UART1_Write_Text("AT+CMGS=\"+2348108893403\"\r\n");
	MOVLW      ?lstr1_Gsm_automate+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Gsm_automate.c,27 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_SendSms0:
	DECFSZ     R13+0, 1
	GOTO       L_SendSms0
	DECFSZ     R12+0, 1
	GOTO       L_SendSms0
	DECFSZ     R11+0, 1
	GOTO       L_SendSms0
	NOP
	NOP
;Gsm_automate.c,28 :: 		UART1_Write_Text("Welcome");
	MOVLW      ?lstr2_Gsm_automate+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Gsm_automate.c,33 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_SendSms1:
	DECFSZ     R13+0, 1
	GOTO       L_SendSms1
	DECFSZ     R12+0, 1
	GOTO       L_SendSms1
	DECFSZ     R11+0, 1
	GOTO       L_SendSms1
	NOP
;Gsm_automate.c,35 :: 		UART1_Write(26);
	MOVLW      26
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Gsm_automate.c,36 :: 		}
L_end_SendSms:
	RETURN
; end of _SendSms

_getNumberOfPerson:

;Gsm_automate.c,38 :: 		void getNumberOfPerson(){     // Motion Sensor Code
;Gsm_automate.c,39 :: 		if(rc0_bit==1){
	BTFSS      RC0_bit+0, 0
	GOTO       L_getNumberOfPerson2
;Gsm_automate.c,40 :: 		counter++;
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
;Gsm_automate.c,41 :: 		} while(rc0_bit==1);
L_getNumberOfPerson2:
L_getNumberOfPerson3:
	BTFSS      RC0_bit+0, 0
	GOTO       L_getNumberOfPerson4
	GOTO       L_getNumberOfPerson3
L_getNumberOfPerson4:
;Gsm_automate.c,43 :: 		if(rc1_bit==1&&counter>0){
	BTFSS      RC1_bit+0, 1
	GOTO       L_getNumberOfPerson7
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _counter+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__getNumberOfPerson25
	MOVF       _counter+0, 0
	SUBLW      0
L__getNumberOfPerson25:
	BTFSC      STATUS+0, 0
	GOTO       L_getNumberOfPerson7
L__getNumberOfPerson21:
;Gsm_automate.c,44 :: 		counter--;
	MOVLW      1
	SUBWF      _counter+0, 1
	BTFSS      STATUS+0, 0
	DECF       _counter+1, 1
;Gsm_automate.c,45 :: 		}while(rc1_bit==1);
L_getNumberOfPerson7:
L_getNumberOfPerson8:
	BTFSS      RC1_bit+0, 1
	GOTO       L_getNumberOfPerson9
	GOTO       L_getNumberOfPerson8
L_getNumberOfPerson9:
;Gsm_automate.c,46 :: 		}
L_end_getNumberOfPerson:
	RETURN
; end of _getNumberOfPerson

_receiveMsg:

;Gsm_automate.c,48 :: 		char receiveMsg(){
;Gsm_automate.c,49 :: 		UART1_Write_Text("AT+CNMI=2,2,0,0,0\r\n");
	MOVLW      ?lstr3_Gsm_automate+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Gsm_automate.c,50 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_receiveMsg10:
	DECFSZ     R13+0, 1
	GOTO       L_receiveMsg10
	DECFSZ     R12+0, 1
	GOTO       L_receiveMsg10
	DECFSZ     R11+0, 1
	GOTO       L_receiveMsg10
	NOP
	NOP
;Gsm_automate.c,51 :: 		if (UART1_Data_Ready())
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_receiveMsg11
;Gsm_automate.c,53 :: 		msg = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _msg+0
;Gsm_automate.c,55 :: 		}
L_receiveMsg11:
;Gsm_automate.c,57 :: 		return msg;
	MOVF       _msg+0, 0
	MOVWF      R0+0
;Gsm_automate.c,59 :: 		}
L_end_receiveMsg:
	RETURN
; end of _receiveMsg

_main:

;Gsm_automate.c,61 :: 		void main() {
;Gsm_automate.c,62 :: 		msg='0';
	MOVLW      48
	MOVWF      _msg+0
;Gsm_automate.c,63 :: 		delay_ms(5000);
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	DECFSZ     R11+0, 1
	GOTO       L_main12
	NOP
	NOP
;Gsm_automate.c,64 :: 		delay_ms(5000);
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main13:
	DECFSZ     R13+0, 1
	GOTO       L_main13
	DECFSZ     R12+0, 1
	GOTO       L_main13
	DECFSZ     R11+0, 1
	GOTO       L_main13
	NOP
	NOP
;Gsm_automate.c,65 :: 		Initialization();
	CALL       _Initialization+0
;Gsm_automate.c,67 :: 		Delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main14:
	DECFSZ     R13+0, 1
	GOTO       L_main14
	DECFSZ     R12+0, 1
	GOTO       L_main14
	DECFSZ     R11+0, 1
	GOTO       L_main14
	NOP
;Gsm_automate.c,68 :: 		UART1_Write_Text("ATE0\r\n");   // AT command for Echo OFF
	MOVLW      ?lstr4_Gsm_automate+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Gsm_automate.c,69 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main15:
	DECFSZ     R13+0, 1
	GOTO       L_main15
	DECFSZ     R12+0, 1
	GOTO       L_main15
	DECFSZ     R11+0, 1
	GOTO       L_main15
	NOP
	NOP
;Gsm_automate.c,70 :: 		UART1_Write_Text("AT\r\n");
	MOVLW      ?lstr5_Gsm_automate+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Gsm_automate.c,71 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main16:
	DECFSZ     R13+0, 1
	GOTO       L_main16
	DECFSZ     R12+0, 1
	GOTO       L_main16
	DECFSZ     R11+0, 1
	GOTO       L_main16
	NOP
	NOP
;Gsm_automate.c,72 :: 		UART1_Write_Text("AT+CMGF=1\r\n");
	MOVLW      ?lstr6_Gsm_automate+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Gsm_automate.c,73 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main17:
	DECFSZ     R13+0, 1
	GOTO       L_main17
	DECFSZ     R12+0, 1
	GOTO       L_main17
	DECFSZ     R11+0, 1
	GOTO       L_main17
	NOP
	NOP
;Gsm_automate.c,74 :: 		SendSms();
	CALL       _SendSms+0
;Gsm_automate.c,76 :: 		do
L_main18:
;Gsm_automate.c,84 :: 		} while(1);
	GOTO       L_main18
;Gsm_automate.c,85 :: 		}
L_end_main:
	GOTO       $+0
; end of _main


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

_numberOfPeople:

;Gsm_automate.c,13 :: 		void numberOfPeople(char *pop,char hund, char tens, char unit){
;Gsm_automate.c,14 :: 		while(*pop){
L_numberOfPeople0:
	MOVF       FARG_numberOfPeople_pop+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_numberOfPeople1
;Gsm_automate.c,15 :: 		people[i]=*pop;
	MOVF       _i+0, 0
	ADDLW      _people+0
	MOVWF      R1+0
	MOVF       FARG_numberOfPeople_pop+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Gsm_automate.c,16 :: 		*pop++;
	INCF       FARG_numberOfPeople_pop+0, 1
;Gsm_automate.c,17 :: 		i++;
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Gsm_automate.c,18 :: 		}
	GOTO       L_numberOfPeople0
L_numberOfPeople1:
;Gsm_automate.c,19 :: 		people[11]= hund;
	MOVF       FARG_numberOfPeople_hund+0, 0
	MOVWF      _people+11
;Gsm_automate.c,20 :: 		people[12]= tens;
	MOVF       FARG_numberOfPeople_tens+0, 0
	MOVWF      _people+12
;Gsm_automate.c,21 :: 		people[13]= unit;
	MOVF       FARG_numberOfPeople_unit+0, 0
	MOVWF      _people+13
;Gsm_automate.c,23 :: 		}
L_end_numberOfPeople:
	RETURN
; end of _numberOfPeople

_SendSms:

;Gsm_automate.c,25 :: 		void SendSms(char *sms){
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
L_SendSms2:
	DECFSZ     R13+0, 1
	GOTO       L_SendSms2
	DECFSZ     R12+0, 1
	GOTO       L_SendSms2
	DECFSZ     R11+0, 1
	GOTO       L_SendSms2
	NOP
	NOP
;Gsm_automate.c,30 :: 		while(*sms){
L_SendSms3:
	MOVF       FARG_SendSms_sms+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SendSms4
;Gsm_automate.c,31 :: 		UART1_Write(*sms++);
	MOVF       FARG_SendSms_sms+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
	INCF       FARG_SendSms_sms+0, 1
;Gsm_automate.c,32 :: 		}
	GOTO       L_SendSms3
L_SendSms4:
;Gsm_automate.c,33 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_SendSms5:
	DECFSZ     R13+0, 1
	GOTO       L_SendSms5
	DECFSZ     R12+0, 1
	GOTO       L_SendSms5
	DECFSZ     R11+0, 1
	GOTO       L_SendSms5
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
	GOTO       L_getNumberOfPerson6
;Gsm_automate.c,40 :: 		counter++;
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
;Gsm_automate.c,41 :: 		} while(rc0_bit==1);
L_getNumberOfPerson6:
L_getNumberOfPerson7:
	BTFSS      RC0_bit+0, 0
	GOTO       L_getNumberOfPerson8
	GOTO       L_getNumberOfPerson7
L_getNumberOfPerson8:
;Gsm_automate.c,43 :: 		if(rc1_bit==1&&counter>0){
	BTFSS      RC1_bit+0, 1
	GOTO       L_getNumberOfPerson11
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _counter+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__getNumberOfPerson30
	MOVF       _counter+0, 0
	SUBLW      0
L__getNumberOfPerson30:
	BTFSC      STATUS+0, 0
	GOTO       L_getNumberOfPerson11
L__getNumberOfPerson25:
;Gsm_automate.c,44 :: 		counter--;
	MOVLW      1
	SUBWF      _counter+0, 1
	BTFSS      STATUS+0, 0
	DECF       _counter+1, 1
;Gsm_automate.c,45 :: 		}while(rc1_bit==1);
L_getNumberOfPerson11:
L_getNumberOfPerson12:
	BTFSS      RC1_bit+0, 1
	GOTO       L_getNumberOfPerson13
	GOTO       L_getNumberOfPerson12
L_getNumberOfPerson13:
;Gsm_automate.c,46 :: 		}
L_end_getNumberOfPerson:
	RETURN
; end of _getNumberOfPerson

_receiveMsg:

;Gsm_automate.c,48 :: 		char receiveMsg(){
;Gsm_automate.c,49 :: 		UART1_Write_Text("AT+CNMI=2,2,0,0,0\r\n");
	MOVLW      ?lstr2_Gsm_automate+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Gsm_automate.c,50 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_receiveMsg14:
	DECFSZ     R13+0, 1
	GOTO       L_receiveMsg14
	DECFSZ     R12+0, 1
	GOTO       L_receiveMsg14
	DECFSZ     R11+0, 1
	GOTO       L_receiveMsg14
	NOP
	NOP
;Gsm_automate.c,51 :: 		if (UART1_Data_Ready())
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_receiveMsg15
;Gsm_automate.c,53 :: 		msg = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _msg+0
;Gsm_automate.c,55 :: 		}
L_receiveMsg15:
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
L_main16:
	DECFSZ     R13+0, 1
	GOTO       L_main16
	DECFSZ     R12+0, 1
	GOTO       L_main16
	DECFSZ     R11+0, 1
	GOTO       L_main16
	NOP
	NOP
;Gsm_automate.c,64 :: 		delay_ms(5000);
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
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
;Gsm_automate.c,65 :: 		Initialization();
	CALL       _Initialization+0
;Gsm_automate.c,67 :: 		Delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main18:
	DECFSZ     R13+0, 1
	GOTO       L_main18
	DECFSZ     R12+0, 1
	GOTO       L_main18
	DECFSZ     R11+0, 1
	GOTO       L_main18
	NOP
;Gsm_automate.c,68 :: 		UART1_Write_Text("ATE0\r\n");   // AT command for Echo OFF
	MOVLW      ?lstr3_Gsm_automate+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Gsm_automate.c,69 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main19:
	DECFSZ     R13+0, 1
	GOTO       L_main19
	DECFSZ     R12+0, 1
	GOTO       L_main19
	DECFSZ     R11+0, 1
	GOTO       L_main19
	NOP
	NOP
;Gsm_automate.c,70 :: 		UART1_Write_Text("AT\r\n");
	MOVLW      ?lstr4_Gsm_automate+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Gsm_automate.c,71 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main20:
	DECFSZ     R13+0, 1
	GOTO       L_main20
	DECFSZ     R12+0, 1
	GOTO       L_main20
	DECFSZ     R11+0, 1
	GOTO       L_main20
	NOP
	NOP
;Gsm_automate.c,72 :: 		UART1_Write_Text("AT+CMGF=1\r\n");
	MOVLW      ?lstr5_Gsm_automate+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Gsm_automate.c,73 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main21:
	DECFSZ     R13+0, 1
	GOTO       L_main21
	DECFSZ     R12+0, 1
	GOTO       L_main21
	DECFSZ     R11+0, 1
	GOTO       L_main21
	NOP
	NOP
;Gsm_automate.c,74 :: 		SendSms(sms);
	MOVLW      _sms+0
	MOVWF      FARG_SendSms_sms+0
	CALL       _SendSms+0
;Gsm_automate.c,76 :: 		do
L_main22:
;Gsm_automate.c,84 :: 		} while(1);
	GOTO       L_main22
;Gsm_automate.c,85 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

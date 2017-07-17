
_Initialization:

;Gsm_automate.c,22 :: 		void Initialization()
;Gsm_automate.c,24 :: 		UART1_Init(9600);   // Initialize Serial Port at 9600 baud rate
	MOVLW      77
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Gsm_automate.c,25 :: 		delay_ms(5000);
	MOVLW      77
	MOVWF      R11+0
	MOVLW      25
	MOVWF      R12+0
	MOVLW      79
	MOVWF      R13+0
L_Initialization0:
	DECFSZ     R13+0, 1
	GOTO       L_Initialization0
	DECFSZ     R12+0, 1
	GOTO       L_Initialization0
	DECFSZ     R11+0, 1
	GOTO       L_Initialization0
	NOP
	NOP
;Gsm_automate.c,26 :: 		UART1_Write_Text("ATE0\r\n");
	MOVLW      ?lstr1_Gsm_automate+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Gsm_automate.c,27 :: 		Delay_ms(1000);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_Initialization1:
	DECFSZ     R13+0, 1
	GOTO       L_Initialization1
	DECFSZ     R12+0, 1
	GOTO       L_Initialization1
	DECFSZ     R11+0, 1
	GOTO       L_Initialization1
	NOP
	NOP
;Gsm_automate.c,28 :: 		UART1_Write_Text("AT+CMGF=1\r\n");
	MOVLW      ?lstr2_Gsm_automate+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Gsm_automate.c,29 :: 		delay_ms(1000);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_Initialization2:
	DECFSZ     R13+0, 1
	GOTO       L_Initialization2
	DECFSZ     R12+0, 1
	GOTO       L_Initialization2
	DECFSZ     R11+0, 1
	GOTO       L_Initialization2
	NOP
	NOP
;Gsm_automate.c,30 :: 		UART1_Write_Text("AT+CNMI=2,2,0,0,0\r\n");
	MOVLW      ?lstr3_Gsm_automate+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Gsm_automate.c,31 :: 		delay_ms(1000);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_Initialization3:
	DECFSZ     R13+0, 1
	GOTO       L_Initialization3
	DECFSZ     R12+0, 1
	GOTO       L_Initialization3
	DECFSZ     R11+0, 1
	GOTO       L_Initialization3
	NOP
	NOP
;Gsm_automate.c,32 :: 		}
L_end_Initialization:
	RETURN
; end of _Initialization

_SendSms:

;Gsm_automate.c,34 :: 		void SendSms(const char *sms){
;Gsm_automate.c,35 :: 		UART1_Write_Text("AT+CMGS=\"+2348108893403\"\r\n");
	MOVLW      ?lstr4_Gsm_automate+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Gsm_automate.c,36 :: 		delay_ms(500);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      157
	MOVWF      R12+0
	MOVLW      5
	MOVWF      R13+0
L_SendSms4:
	DECFSZ     R13+0, 1
	GOTO       L_SendSms4
	DECFSZ     R12+0, 1
	GOTO       L_SendSms4
	DECFSZ     R11+0, 1
	GOTO       L_SendSms4
	NOP
	NOP
;Gsm_automate.c,37 :: 		while(*sms){
L_SendSms5:
	MOVF       FARG_SendSms_sms+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       FARG_SendSms_sms+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SendSms6
;Gsm_automate.c,38 :: 		UART1_Write(*sms++);
	MOVF       FARG_SendSms_sms+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       FARG_SendSms_sms+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
	INCF       FARG_SendSms_sms+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_SendSms_sms+1, 1
;Gsm_automate.c,39 :: 		}
	GOTO       L_SendSms5
L_SendSms6:
;Gsm_automate.c,40 :: 		UART1_Write(26);
	MOVLW      26
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Gsm_automate.c,41 :: 		}
L_end_SendSms:
	RETURN
; end of _SendSms

_getAction:

;Gsm_automate.c,44 :: 		void getAction(char *people){
;Gsm_automate.c,45 :: 		if (UART1_Data_Ready()==1){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_getAction7
;Gsm_automate.c,46 :: 		switch(UART1_read()){
	CALL       _UART1_Read+0
	GOTO       L_getAction8
;Gsm_automate.c,47 :: 		case ':' :
L_getAction10:
;Gsm_automate.c,48 :: 		j++;
	INCF       _j+0, 1
;Gsm_automate.c,49 :: 		if(j==3){
	MOVF       _j+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_getAction11
;Gsm_automate.c,52 :: 		}
L_getAction11:
;Gsm_automate.c,54 :: 		break;
	GOTO       L_getAction9
;Gsm_automate.c,55 :: 		case '\r':
L_getAction12:
;Gsm_automate.c,56 :: 		if(j==3){
	MOVF       _j+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_getAction13
;Gsm_automate.c,57 :: 		success=1;
	MOVLW      1
	MOVWF      _success+0
;Gsm_automate.c,59 :: 		j=0;
	CLRF       _j+0
;Gsm_automate.c,61 :: 		}
L_getAction13:
;Gsm_automate.c,62 :: 		break;
	GOTO       L_getAction9
;Gsm_automate.c,64 :: 		case '*':
L_getAction14:
;Gsm_automate.c,65 :: 		if(success==1){
	MOVF       _success+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_getAction15
;Gsm_automate.c,66 :: 		success=0;
	CLRF       _success+0
;Gsm_automate.c,67 :: 		extractMsg=1;
	MOVLW      1
	MOVWF      _extractMsg+0
;Gsm_automate.c,68 :: 		}
L_getAction15:
;Gsm_automate.c,69 :: 		break;
	GOTO       L_getAction9
;Gsm_automate.c,71 :: 		case '2':
L_getAction16:
;Gsm_automate.c,72 :: 		if(extractMsg==1){
	MOVF       _extractMsg+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_getAction17
;Gsm_automate.c,73 :: 		extractMsg=0;
	CLRF       _extractMsg+0
;Gsm_automate.c,74 :: 		getNum=2;}
	MOVLW      2
	MOVWF      _getNum+0
L_getAction17:
;Gsm_automate.c,75 :: 		break;
	GOTO       L_getAction9
;Gsm_automate.c,77 :: 		case '3':
L_getAction18:
;Gsm_automate.c,78 :: 		if(extractMsg==1){
	MOVF       _extractMsg+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_getAction19
;Gsm_automate.c,79 :: 		extractMsg=0;
	CLRF       _extractMsg+0
;Gsm_automate.c,80 :: 		getNum=3;}
	MOVLW      3
	MOVWF      _getNum+0
L_getAction19:
;Gsm_automate.c,81 :: 		break;
	GOTO       L_getAction9
;Gsm_automate.c,83 :: 		case '1':
L_getAction20:
;Gsm_automate.c,84 :: 		if(extractMsg==1){
	MOVF       _extractMsg+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_getAction21
;Gsm_automate.c,85 :: 		extractMsg=0;
	CLRF       _extractMsg+0
;Gsm_automate.c,86 :: 		getNum=1;}
	MOVLW      1
	MOVWF      _getNum+0
L_getAction21:
;Gsm_automate.c,87 :: 		break;
	GOTO       L_getAction9
;Gsm_automate.c,88 :: 		}
L_getAction8:
	MOVF       R0+0, 0
	XORLW      58
	BTFSC      STATUS+0, 2
	GOTO       L_getAction10
	MOVF       R0+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_getAction12
	MOVF       R0+0, 0
	XORLW      42
	BTFSC      STATUS+0, 2
	GOTO       L_getAction14
	MOVF       R0+0, 0
	XORLW      50
	BTFSC      STATUS+0, 2
	GOTO       L_getAction16
	MOVF       R0+0, 0
	XORLW      51
	BTFSC      STATUS+0, 2
	GOTO       L_getAction18
	MOVF       R0+0, 0
	XORLW      49
	BTFSC      STATUS+0, 2
	GOTO       L_getAction20
L_getAction9:
;Gsm_automate.c,92 :: 		}
L_getAction7:
;Gsm_automate.c,93 :: 		if(getNum==3){
	MOVF       _getNum+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_getAction22
;Gsm_automate.c,95 :: 		getNum=0;
	CLRF       _getNum+0
;Gsm_automate.c,96 :: 		}
L_getAction22:
;Gsm_automate.c,98 :: 		}
L_end_getAction:
	RETURN
; end of _getAction

_numberOfPeople:

;Gsm_automate.c,100 :: 		void numberOfPeople(char *pop,char dig3, char dig2, char dig1){
;Gsm_automate.c,101 :: 		people[0]= dig3+48;
	MOVLW      48
	ADDWF      FARG_numberOfPeople_dig3+0, 0
	MOVWF      _people+0
;Gsm_automate.c,102 :: 		people[1]= dig2+48;
	MOVLW      48
	ADDWF      FARG_numberOfPeople_dig2+0, 0
	MOVWF      _people+1
;Gsm_automate.c,103 :: 		people[2]= dig1+48;
	MOVLW      48
	ADDWF      FARG_numberOfPeople_dig1+0, 0
	MOVWF      _people+2
;Gsm_automate.c,104 :: 		people[3]= ' ';
	MOVLW      32
	MOVWF      _people+3
;Gsm_automate.c,105 :: 		i=4;
	MOVLW      4
	MOVWF      _i+0
;Gsm_automate.c,106 :: 		while(*pop){
L_numberOfPeople23:
	MOVF       FARG_numberOfPeople_pop+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_numberOfPeople24
;Gsm_automate.c,107 :: 		people[i]=*pop;
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
;Gsm_automate.c,108 :: 		*pop++;
	INCF       FARG_numberOfPeople_pop+0, 1
;Gsm_automate.c,109 :: 		i++;
	INCF       _i+0, 1
;Gsm_automate.c,110 :: 		}
	GOTO       L_numberOfPeople23
L_numberOfPeople24:
;Gsm_automate.c,111 :: 		people[i]= ' ';
	MOVF       _i+0, 0
	ADDLW      _people+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
;Gsm_automate.c,112 :: 		people[i+=2]= '\0';
	MOVLW      2
	ADDWF      _i+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _i+0
	MOVF       R0+0, 0
	ADDLW      _people+0
	MOVWF      FSR
	CLRF       INDF+0
;Gsm_automate.c,116 :: 		}
L_end_numberOfPeople:
	RETURN
; end of _numberOfPeople

_senseGas:

;Gsm_automate.c,122 :: 		void senseGas(){
;Gsm_automate.c,123 :: 		senseDigital = adc_read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _senseDigital+0
	MOVF       R0+1, 0
	MOVWF      _senseDigital+1
;Gsm_automate.c,124 :: 		if(senseDigital >=270){
	MOVLW      128
	XORWF      R0+1, 0
	MOVWF      R2+0
	MOVLW      128
	XORLW      1
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__senseGas60
	MOVLW      14
	SUBWF      R0+0, 0
L__senseGas60:
	BTFSS      STATUS+0, 0
	GOTO       L_senseGas25
;Gsm_automate.c,126 :: 		}  else if(senseDigital>400) {
	GOTO       L_senseGas26
L_senseGas25:
	MOVLW      128
	XORLW      1
	MOVWF      R0+0
	MOVLW      128
	XORWF      _senseDigital+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__senseGas61
	MOVF       _senseDigital+0, 0
	SUBLW      144
L__senseGas61:
	BTFSC      STATUS+0, 0
	GOTO       L_senseGas27
;Gsm_automate.c,127 :: 		sendSms(gasMsg);
	MOVLW      _gasMsg+0
	MOVWF      FARG_SendSms_sms+0
	MOVLW      hi_addr(_gasMsg+0)
	MOVWF      FARG_SendSms_sms+1
	CALL       _SendSms+0
;Gsm_automate.c,128 :: 		}
L_senseGas27:
L_senseGas26:
;Gsm_automate.c,129 :: 		}
L_end_senseGas:
	RETURN
; end of _senseGas

_SenseMotion:

;Gsm_automate.c,134 :: 		void SenseMotion(){
;Gsm_automate.c,135 :: 		if(button_plus==1){
	BTFSS      RC4_bit+0, 4
	GOTO       L_SenseMotion28
;Gsm_automate.c,136 :: 		in_success=1;
	MOVLW      1
	MOVWF      _in_success+0
;Gsm_automate.c,137 :: 		}while(button_plus==1);
L_SenseMotion28:
L_SenseMotion29:
	BTFSS      RC4_bit+0, 4
	GOTO       L_SenseMotion30
	GOTO       L_SenseMotion29
L_SenseMotion30:
;Gsm_automate.c,138 :: 		if(button_minus==1){
	BTFSS      RC3_bit+0, 3
	GOTO       L_SenseMotion31
;Gsm_automate.c,139 :: 		out_success=1;
	MOVLW      1
	MOVWF      _out_success+0
;Gsm_automate.c,140 :: 		}while(button_minus==1);
L_SenseMotion31:
L_SenseMotion32:
	BTFSS      RC3_bit+0, 3
	GOTO       L_SenseMotion33
	GOTO       L_SenseMotion32
L_SenseMotion33:
;Gsm_automate.c,141 :: 		}
L_end_SenseMotion:
	RETURN
; end of _SenseMotion

_Calculate_number:

;Gsm_automate.c,143 :: 		void Calculate_number(){
;Gsm_automate.c,144 :: 		SenseMotion();
	CALL       _SenseMotion+0
;Gsm_automate.c,145 :: 		if((in_success==1) &&out_success==0 ){
	MOVF       _in_success+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Calculate_number36
	MOVF       _out_success+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_Calculate_number36
L__Calculate_number54:
;Gsm_automate.c,146 :: 		for(x=0;x<500;x++){
	CLRF       _x+0
	CLRF       _x+1
L_Calculate_number37:
	MOVLW      128
	XORWF      _x+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      1
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Calculate_number64
	MOVLW      244
	SUBWF      _x+0, 0
L__Calculate_number64:
	BTFSC      STATUS+0, 0
	GOTO       L_Calculate_number38
;Gsm_automate.c,147 :: 		SenseMotion();
	CALL       _SenseMotion+0
;Gsm_automate.c,148 :: 		if(out_success==1){
	MOVF       _out_success+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Calculate_number40
;Gsm_automate.c,149 :: 		counter++;
	INCF       _counter+0, 1
;Gsm_automate.c,150 :: 		out_success=0;
	CLRF       _out_success+0
;Gsm_automate.c,151 :: 		in_success=0;
	CLRF       _in_success+0
;Gsm_automate.c,152 :: 		break;
	GOTO       L_Calculate_number38
;Gsm_automate.c,153 :: 		}
L_Calculate_number40:
;Gsm_automate.c,146 :: 		for(x=0;x<500;x++){
	INCF       _x+0, 1
	BTFSC      STATUS+0, 2
	INCF       _x+1, 1
;Gsm_automate.c,154 :: 		}
	GOTO       L_Calculate_number37
L_Calculate_number38:
;Gsm_automate.c,155 :: 		}
L_Calculate_number36:
;Gsm_automate.c,157 :: 		if((out_success==1) && in_success==0){
	MOVF       _out_success+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Calculate_number43
	MOVF       _in_success+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_Calculate_number43
L__Calculate_number53:
;Gsm_automate.c,158 :: 		for(x=0;x<500;x++){
	CLRF       _x+0
	CLRF       _x+1
L_Calculate_number44:
	MOVLW      128
	XORWF      _x+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      1
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Calculate_number65
	MOVLW      244
	SUBWF      _x+0, 0
L__Calculate_number65:
	BTFSC      STATUS+0, 0
	GOTO       L_Calculate_number45
;Gsm_automate.c,159 :: 		SenseMotion();
	CALL       _SenseMotion+0
;Gsm_automate.c,160 :: 		if(in_success==1){
	MOVF       _in_success+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Calculate_number47
;Gsm_automate.c,161 :: 		if(counter>0)counter--;
	MOVF       _counter+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_Calculate_number48
	DECF       _counter+0, 1
L_Calculate_number48:
;Gsm_automate.c,162 :: 		out_success=0;
	CLRF       _out_success+0
;Gsm_automate.c,163 :: 		in_success=0;
	CLRF       _in_success+0
;Gsm_automate.c,164 :: 		break;
	GOTO       L_Calculate_number45
;Gsm_automate.c,165 :: 		}
L_Calculate_number47:
;Gsm_automate.c,158 :: 		for(x=0;x<500;x++){
	INCF       _x+0, 1
	BTFSC      STATUS+0, 2
	INCF       _x+1, 1
;Gsm_automate.c,166 :: 		}
	GOTO       L_Calculate_number44
L_Calculate_number45:
;Gsm_automate.c,167 :: 		}
L_Calculate_number43:
;Gsm_automate.c,169 :: 		}
L_end_Calculate_number:
	RETURN
; end of _Calculate_number

_main:

;Gsm_automate.c,174 :: 		void main() {
;Gsm_automate.c,175 :: 		portb=0;
	CLRF       PORTB+0
;Gsm_automate.c,176 :: 		portd=0;
	CLRF       PORTD+0
;Gsm_automate.c,177 :: 		trisd=0;
	CLRF       TRISD+0
;Gsm_automate.c,178 :: 		trisb=0x00;
	CLRF       TRISB+0
;Gsm_automate.c,179 :: 		trisc4_bit=1;
	BSF        TRISC4_bit+0, 4
;Gsm_automate.c,180 :: 		trisc3_bit=1;
	BSF        TRISC3_bit+0, 3
;Gsm_automate.c,181 :: 		getNum=0;
	CLRF       _getNum+0
;Gsm_automate.c,182 :: 		Initialization();
	CALL       _Initialization+0
;Gsm_automate.c,183 :: 		delay_ms(4000);
	MOVLW      61
	MOVWF      R11+0
	MOVLW      225
	MOVWF      R12+0
	MOVLW      63
	MOVWF      R13+0
L_main49:
	DECFSZ     R13+0, 1
	GOTO       L_main49
	DECFSZ     R12+0, 1
	GOTO       L_main49
	DECFSZ     R11+0, 1
	GOTO       L_main49
	NOP
	NOP
;Gsm_automate.c,184 :: 		do
L_main50:
;Gsm_automate.c,186 :: 		numberOfPeople("Persons inside",hun,tens,unit);
	MOVLW      ?lstr5_Gsm_automate+0
	MOVWF      FARG_numberOfPeople_pop+0
	MOVF       _hun+0, 0
	MOVWF      FARG_numberOfPeople_dig3+0
	MOVF       _tens+0, 0
	MOVWF      FARG_numberOfPeople_dig2+0
	MOVF       _unit+0, 0
	MOVWF      FARG_numberOfPeople_dig1+0
	CALL       _numberOfPeople+0
;Gsm_automate.c,187 :: 		getAction(people);
	MOVLW      _people+0
	MOVWF      FARG_getAction_people+0
	CALL       _getAction+0
;Gsm_automate.c,188 :: 		senseGas();
	CALL       _senseGas+0
;Gsm_automate.c,189 :: 		SenseMotion();
	CALL       _SenseMotion+0
;Gsm_automate.c,190 :: 		Calculate_number();
	CALL       _Calculate_number+0
;Gsm_automate.c,191 :: 		portb=seven_seg[counter];
	MOVF       _counter+0, 0
	ADDLW      _seven_seg+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;Gsm_automate.c,192 :: 		portd=0xff;
	MOVLW      255
	MOVWF      PORTD+0
;Gsm_automate.c,193 :: 		}while(1);
	GOTO       L_main50
;Gsm_automate.c,194 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

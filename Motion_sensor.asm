
_SenseMotion:

;Motion_sensor.c,16 :: 		void SenseMotion(){
;Motion_sensor.c,18 :: 		if(button_plus==1){
	BTFSS      RC4_bit+0, 4
	GOTO       L_SenseMotion0
;Motion_sensor.c,19 :: 		in_success=1;
	MOVLW      1
	MOVWF      _in_success+0
;Motion_sensor.c,20 :: 		}while(button_plus==1);
L_SenseMotion0:
L_SenseMotion1:
	BTFSS      RC4_bit+0, 4
	GOTO       L_SenseMotion2
	GOTO       L_SenseMotion1
L_SenseMotion2:
;Motion_sensor.c,22 :: 		if(button_minus==1){
	BTFSS      RC3_bit+0, 3
	GOTO       L_SenseMotion3
;Motion_sensor.c,23 :: 		out_success=1;
	MOVLW      1
	MOVWF      _out_success+0
;Motion_sensor.c,24 :: 		}while(button_minus==1);
L_SenseMotion3:
L_SenseMotion4:
	BTFSS      RC3_bit+0, 3
	GOTO       L_SenseMotion5
	GOTO       L_SenseMotion4
L_SenseMotion5:
;Motion_sensor.c,29 :: 		}
L_end_SenseMotion:
	RETURN
; end of _SenseMotion

_Calculate_number:

;Motion_sensor.c,31 :: 		void Calculate_number(){
;Motion_sensor.c,32 :: 		SenseMotion();
	CALL       _SenseMotion+0
;Motion_sensor.c,33 :: 		if((in_success==1) &&out_success==0 ){
	MOVF       _in_success+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Calculate_number8
	MOVF       _out_success+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_Calculate_number8
L__Calculate_number25:
;Motion_sensor.c,34 :: 		for(x=0;x<1000;x++){
	CLRF       _x+0
	CLRF       _x+1
L_Calculate_number9:
	MOVLW      128
	XORWF      _x+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      3
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Calculate_number28
	MOVLW      232
	SUBWF      _x+0, 0
L__Calculate_number28:
	BTFSC      STATUS+0, 0
	GOTO       L_Calculate_number10
;Motion_sensor.c,35 :: 		SenseMotion();
	CALL       _SenseMotion+0
;Motion_sensor.c,36 :: 		if(out_success==1){
	MOVF       _out_success+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Calculate_number12
;Motion_sensor.c,37 :: 		counter++;
	INCF       _counter+0, 1
;Motion_sensor.c,38 :: 		out_success=0;
	CLRF       _out_success+0
;Motion_sensor.c,39 :: 		in_success=0;
	CLRF       _in_success+0
;Motion_sensor.c,40 :: 		break;
	GOTO       L_Calculate_number10
;Motion_sensor.c,41 :: 		}
L_Calculate_number12:
;Motion_sensor.c,34 :: 		for(x=0;x<1000;x++){
	INCF       _x+0, 1
	BTFSC      STATUS+0, 2
	INCF       _x+1, 1
;Motion_sensor.c,42 :: 		}
	GOTO       L_Calculate_number9
L_Calculate_number10:
;Motion_sensor.c,43 :: 		}
L_Calculate_number8:
;Motion_sensor.c,45 :: 		if((out_success==1)){
	MOVF       _out_success+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Calculate_number13
;Motion_sensor.c,47 :: 		out_success=0;
	CLRF       _out_success+0
;Motion_sensor.c,48 :: 		in_success=0;
	CLRF       _in_success+0
;Motion_sensor.c,49 :: 		for(x=0;x<1000;x++){
	CLRF       _x+0
	CLRF       _x+1
L_Calculate_number14:
	MOVLW      128
	XORWF      _x+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      3
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Calculate_number29
	MOVLW      232
	SUBWF      _x+0, 0
L__Calculate_number29:
	BTFSC      STATUS+0, 0
	GOTO       L_Calculate_number15
;Motion_sensor.c,50 :: 		SenseMotion();
	CALL       _SenseMotion+0
;Motion_sensor.c,51 :: 		if(in_success==1){
	MOVF       _in_success+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Calculate_number17
;Motion_sensor.c,52 :: 		if(counter>0)counter--;
	MOVF       _counter+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_Calculate_number18
	DECF       _counter+0, 1
L_Calculate_number18:
;Motion_sensor.c,53 :: 		out_success=0;
	CLRF       _out_success+0
;Motion_sensor.c,54 :: 		in_success=0;
	CLRF       _in_success+0
;Motion_sensor.c,55 :: 		break;
	GOTO       L_Calculate_number15
;Motion_sensor.c,56 :: 		}
L_Calculate_number17:
;Motion_sensor.c,49 :: 		for(x=0;x<1000;x++){
	INCF       _x+0, 1
	BTFSC      STATUS+0, 2
	INCF       _x+1, 1
;Motion_sensor.c,57 :: 		}
	GOTO       L_Calculate_number14
L_Calculate_number15:
;Motion_sensor.c,58 :: 		}
L_Calculate_number13:
;Motion_sensor.c,60 :: 		}
L_end_Calculate_number:
	RETURN
; end of _Calculate_number

_main:

;Motion_sensor.c,63 :: 		void main() {
;Motion_sensor.c,64 :: 		portb=0;
	CLRF       PORTB+0
;Motion_sensor.c,65 :: 		portd=0;
	CLRF       PORTD+0
;Motion_sensor.c,66 :: 		trisb=0x00;
	CLRF       TRISB+0
;Motion_sensor.c,67 :: 		portb=0;
	CLRF       PORTB+0
;Motion_sensor.c,68 :: 		trisc=0xff;
	MOVLW      255
	MOVWF      TRISC+0
;Motion_sensor.c,69 :: 		trisd=0;
	CLRF       TRISD+0
;Motion_sensor.c,72 :: 		while(1){
L_main19:
;Motion_sensor.c,73 :: 		SenseMotion();
	CALL       _SenseMotion+0
;Motion_sensor.c,74 :: 		Calculate_number();
	CALL       _Calculate_number+0
;Motion_sensor.c,76 :: 		portb=counter;
	MOVF       _counter+0, 0
	MOVWF      PORTB+0
;Motion_sensor.c,81 :: 		}
	GOTO       L_main19
;Motion_sensor.c,84 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_display:

;Motion_sensor.c,89 :: 		void display(){
;Motion_sensor.c,91 :: 		for(k=0;k<10;k++){
	CLRF       _k+0
L_display21:
	MOVLW      10
	SUBWF      _k+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_display22
;Motion_sensor.c,92 :: 		portb=seven_seg[k];
	MOVF       _k+0, 0
	ADDLW      _seven_seg+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;Motion_sensor.c,93 :: 		delay_ms(500);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      157
	MOVWF      R12+0
	MOVLW      5
	MOVWF      R13+0
L_display24:
	DECFSZ     R13+0, 1
	GOTO       L_display24
	DECFSZ     R12+0, 1
	GOTO       L_display24
	DECFSZ     R11+0, 1
	GOTO       L_display24
	NOP
	NOP
;Motion_sensor.c,91 :: 		for(k=0;k<10;k++){
	INCF       _k+0, 1
;Motion_sensor.c,94 :: 		}
	GOTO       L_display21
L_display22:
;Motion_sensor.c,96 :: 		}
L_end_display:
	RETURN
; end of _display

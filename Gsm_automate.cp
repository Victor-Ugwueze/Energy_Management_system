#line 1 "C:/Users/GOZMAN VICTOR/Desktop/Gsm_PIC/Gsm_automate.c"
int counter=0;
char msg = '0';
int intrude=0;
char people[13]="";
int i=0;
char sms[] = "Yes\r\n";
void Initialization()
{
UART1_Init(9600);
}
#line 25 "C:/Users/GOZMAN VICTOR/Desktop/Gsm_PIC/Gsm_automate.c"
void SendSms(){
UART1_Write_Text("AT+CMGS=\"+2348108893403\"\r\n");
delay_ms(500);
UART1_Write_Text("Welcome");




delay_ms(100);

UART1_Write(26);
}

 void getNumberOfPerson(){
 if(rc0_bit==1){
counter++;
} while(rc0_bit==1);

if(rc1_bit==1&&counter>0){
counter--;
}while(rc1_bit==1);
}

char receiveMsg(){
 UART1_Write_Text("AT+CNMI=2,2,0,0,0\r\n");
 delay_ms(1000);
 if (UART1_Data_Ready())
 {
 msg = UART1_Read();

 }

 return msg;

}

void main() {
msg='0';
delay_ms(5000);
delay_ms(5000);
Initialization();

Delay_ms(2000);
UART1_Write_Text("ATE0\r\n");
Delay_ms(1000);
UART1_Write_Text("AT\r\n");
Delay_ms(1000);
UART1_Write_Text("AT+CMGF=1\r\n");
delay_ms(1000);
SendSms();

do
{






} while(1);
}
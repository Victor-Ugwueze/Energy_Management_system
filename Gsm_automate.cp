#line 1 "C:/Users/GOZMAN VICTOR/Desktop/Gsm_PIC/Gsm_automate.c"
char counter=150;
char msg = '0';
int intrude=0;
char hun=2,tens=3,unit=4 ;
char people[18]={'0'};
int i=0;
char sms[] = "Yes";
void Initialization()
{
UART1_Init(9600);
}


void numberOfPeople(char *pop,char dig3, char dig2, char dig1){
 people[0]= dig3+48;
 people[1]= dig2+48;
 people[2]= dig1+48;
 people[3]= ' ';
 i=4;
 while(*pop){
 people[i]=*pop;
 *pop++;
 i++;
 }
 people[i]= ' ';
 people[i+=2]= '\0';



}

void SendSms(char *sms){
UART1_Write_Text("ATE0\r\n");
Delay_ms(1000);
UART1_Write_Text("AT\r\n");
delay_ms(1000);
UART1_Write_Text("AT+CMGF=1\r\n");
delay_ms(1000);
UART1_Write_Text("AT+CMGS=\"+2348108893403\"\r\n");
delay_ms(500);
while(*sms){
UART1_Write(*sms++);
}

UART1_Write(26);
}

 void getNumberOfPerson(){








 hun=counter/100;
 tens= (counter%100)/10;
 unit= counter%10;
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
char v=0;
delay_ms(5000);
Initialization();
delay_ms(3000);
numberOfPeople("Persons inside",hun,tens,unit);
do
{
SendSms(people);
v++;
} while(v<=0);
}

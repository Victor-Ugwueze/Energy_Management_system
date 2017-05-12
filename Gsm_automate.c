int counter=0;
char msg = '0';
int intrude=0;
char people[]="";
int i=0;
char sms[] = "Yes";
void Initialization()
{
UART1_Init(9600);   // Initialize Serial Port at 9600 baud rate
}


void numberOfPeople(char *pop,char hund, char tens, char unit){
     while(*pop){
        people[i]=*pop;
        *pop++;
        i++;
     }
     people[11]= hund;
     people[12]= tens;
     people[13]= unit;

}

void SendSms(char *sms){
UART1_Write_Text("AT+CMGS=\"+2348108893403\"\r\n");
delay_ms(500);
//UART1_Write_Text(sms);

while(*sms){
UART1_Write(*sms++);
}
delay_ms(100);

UART1_Write(26);
}

 void getNumberOfPerson(){     // Motion Sensor Code
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
//numberOfPeople("People are",'2','3','4');
Delay_ms(2000);
UART1_Write_Text("ATE0\r\n");   // AT command for Echo OFF
Delay_ms(1000);
UART1_Write_Text("AT\r\n");
Delay_ms(1000);
UART1_Write_Text("AT+CMGF=1\r\n");
delay_ms(1000);
SendSms(sms);

do
{
//getNumberOfPerson();
  //msg=receiveMsg();

//  getNumberOfPerson();


} while(1);
}
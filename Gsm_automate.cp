#line 1 "C:/Users/GOZMAN VICTOR/Desktop/Gsm_PIC/Gsm_automate.c"
char counter=150;
char msg = '0';
int intrude=0;
char hun=2,tens=3,unit=4 ;
char people[18]={'0'};
char i=0,j=0;
char success=0;
char getNum=0;
char extractMsg=0;

void Initialization()
{
 UART1_Init(9600);
 delay_ms(5000);
 UART1_Write_Text("ATE0\r\n");
 Delay_ms(1000);
 UART1_Write_Text("AT+CMGF=1\r\n");
 delay_ms(1000);
 UART1_Write_Text("AT+CNMI=2,2,0,0,0\r\n");
 delay_ms(1000);
}

void SendSms(char *sms){
UART1_Write_Text("AT+CMGS=\"+2348108893403\"\r\n");
delay_ms(500);
while(*sms){
UART1_Write(*sms++);
}

UART1_Write(26);
}


 void getAction(char *people){

 if (UART1_Data_Ready()==1){
 switch(UART1_read()){
 case ':' :
 j++;
 if(j==3){


 }


 break;
 case '\r':
 if(j==3){
 success=1;

 j=0;

 }
 break;

 case '*':
 if(success==1){
 success=0;
 extractMsg=1;
 }
 break;

 case '2':
 if(extractMsg==1){
 extractMsg=0;
 getNum=2;}
 break;

 case '3':
 if(extractMsg==1){
 extractMsg=0;
 getNum=3;}
 break;

 case '1':
 if(extractMsg==1){
 extractMsg=0;
 getNum=1;}
 break;
 }



 }

 if(getNum==3){
 sendSms(people);
 getNum=0;
 }

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



 void getNumberOfPerson(){








 hun=counter/100;
 tens= (counter%100)/10;
 unit= counter%10;
}




void main() {
getNum=0;
Initialization();

do
{
getNumberOfPerson();
numberOfPeople("Persons inside",hun,tens,unit);
getAction(people);
} while(1);
}

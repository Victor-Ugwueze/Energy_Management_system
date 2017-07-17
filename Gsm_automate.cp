#line 1 "C:/Users/GOZMAN VICTOR/Desktop/Gsm_PIC/Gsm_automate.c"


typedef char c;
char seven_seg[10]={63,6,91,79,102,109,125,7,127,111};
const char gasMsg[28]= "Gas leakage in the building";

int cnt=0,inc=0;
char in_success = 0;
char out_success= 0;
char counter = 0;
int x;
char msg = '0';
int intrude=0;
char hun=2,tens=3,unit=4 ;
char people[18]={'0'};
char i=0,j=0;
char success=0;
char getNum=0;
char extractMsg=0;
int senseDigital=0;

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

void SendSms(const char *sms){
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
 j==0;

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





 void senseGas(){
 senseDigital = adc_read(0);
 if(senseDigital >=270){

 } else if(senseDigital>400) {
 sendSms(gasMsg);
 }
 }



void display();
 void SenseMotion(){
 if( rc4_bit ==1){
 in_success=1;
 }while( rc4_bit ==1);
 if( rc3_bit ==1){
 out_success=1;
 }while( rc3_bit ==1);
 }

 void Calculate_number(){
 SenseMotion();
 if((in_success==1) &&out_success==0 ){
 for(x=0;x<500;x++){
 SenseMotion();
 if(out_success==1){
 counter++;
 out_success=0;
 in_success=0;
 break;
 }
 }
 }

 if((out_success==1) && in_success==0){
 for(x=0;x<500;x++){
 SenseMotion();
 if(in_success==1){
 if(counter>0)counter--;
 out_success=0;
 in_success=0;
 break;
 }
 }
 }

 }




void main() {
 portb=0;
 portd=0;
 trisd=0;
 trisb=0x00;
 trisc4_bit=1;
 trisc3_bit=1;
 getNum=0;
 Initialization();
 delay_ms(4000);
 do
{
 numberOfPeople("Persons inside",hun,tens,unit);
 getAction(people);
 senseGas();
 SenseMotion();
 Calculate_number();
 portb=seven_seg[counter];
 portd=0xff;
 }while(1);
}

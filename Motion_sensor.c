#define  button_plus rc4_bit
#define  button_minus rc3_bit
typedef char c;

char seven_seg[10]={63,6,91,79,102,109,125,7,127,111};
char tou,hund,tens,unit,x1;
int cnt=0;

char in_success = 0;
char out_success= 0;
char counter = 0;
 int x;
 char k=0;

void display();
 void SenseMotion(){
      char inc;
      if(button_plus==1){
        in_success=1;
       }while(button_plus==1);

       if(button_minus==1){
       out_success=1;
       }while(button_minus==1);
       
       
       

 }
 
     void Calculate_number(){
              SenseMotion();
              if((in_success==1) &&out_success==0 ){
                  for(x=0;x<1000;x++){
                    SenseMotion();
                    if(out_success==1){
                      counter++;
                     out_success=0;
                     in_success=0;
                     break;
                    }
                 }
              }

              if((out_success==1)){

              out_success=0;
                     in_success=0;
                  for(x=0;x<1000;x++){
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
     trisb=0x00;
     portb=0;
    trisc=0xff;
    trisd=0;
     
     
     while(1){
             SenseMotion();
              Calculate_number();

                                     portb=counter;




     }
     

}




void display(){

for(k=0;k<10;k++){
  portb=seven_seg[k];
  delay_ms(500);
}

   }
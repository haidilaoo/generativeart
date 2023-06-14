#include <Keypad.h>
#include <SoftwareSerial.h>

#define ARDUINO_RX 5  //should connect to TX of the Serial MP3 Player module **p
#define ARDUINO_TX 6  //connect to RX of the module

#define CMD_SEL_DEV       0X09
#define CMD_SNG_CYCL_PLAY 0X08
#define DEV_TF            0X02

const int ROW_NUM = 1; 
const int COLUMN_NUM = 3; 
SoftwareSerial mp3(ARDUINO_RX, ARDUINO_TX);

char keys[ROW_NUM][COLUMN_NUM] = {
 
 //1 is RED, 2 is YELLOW, 3 is GREEN
  {'R', 'Y', 'G'}

};

//PINS: 10 is RED, 11 is YELLOW, 12 is GREEN
//PINS; 13 is COM 
byte pin_rows[ROW_NUM] = {13}; //connect to the row pinouts of the keypad
byte pin_column[COLUMN_NUM] = {10, 11, 12}; //connect to the column pinouts of the keypad

Keypad keypad = Keypad( makeKeymap(keys), pin_rows, pin_column, ROW_NUM, COLUMN_NUM );
//char key = keypad.getKey();

void setup(){
  Serial.begin(9600);

  //for audio
  mp3.begin(9600);
  delay(500);

  sendCommand(CMD_SEL_DEV, DEV_TF);
  delay(500);
}

void loop(){


  char key = keypad.getKey();
  char c = ' ';

    
  if ( key )
  {
  c = key;
  Serial.println(c);
  sendMP3Command(c); //RUN MUSIC
  }

  // Check for the answer.
  // if (mp3.available())
  // {
  //   Serial.println(decodeMP3Answer());
  // }
  // delay(100);

  // if (key){
  //   Serial.println(key);
  // }

  //Force sensor
  forceReading();


}

#define FORCE_SENSOR_PIN A0

void forceReading() {

  int analogReading = analogRead(FORCE_SENSOR_PIN);

  //Serial.print("Force sensor reading = ");
  //Serial.print(analogReading); // print the raw analog reading
  if (analogReading > 200) // from 200 to 499 
  {
      Serial.println(analogReading);
      delay(500);
  }
  //   Serial.println(" -> light squeeze");
  // if (analogReading < 10)       // from 0 to 9
  //   Serial.println(" -> no pressure");
  // else if (analogReading < 200) // from 10 to 199
  //   Serial.println(" -> light touch");
  // else if (analogReading < 500) // from 200 to 499
  //   Serial.println(" -> light squeeze");
  // else if (analogReading < 800) // from 500 to 799
  //   Serial.println(" -> medium squeeze");
  // else // from 800 to 1023
  //   Serial.println(" -> big squeeze");

  //delay(1000);
}
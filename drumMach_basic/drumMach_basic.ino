#include <CapacitiveSensor.h>

int cut = 150;
CapacitiveSensor   cs_4_2 = CapacitiveSensor(4, 2);
//CapacitiveSensor   cs_4_3 = CapacitiveSensor(4, 3);
//CapacitiveSensor   cs_4_5 = CapacitiveSensor(4, 5);
//CapacitiveSensor   cs_4_6 = CapacitiveSensor(4, 6);

boolean on1 = false;

void setup() {
  Serial.begin(9600);
}

void loop() {
  long val1 =  cs_4_2.capacitiveSensor(30);
 // long val2 =  cs_4_3.capacitiveSensor(30);
 // long val3 =  cs_4_5.capacitiveSensor(30);
 // long val4 =  cs_4_6.capacitiveSensor(30);

  if (val1 > cut) {
    if (!on1) {
      on1 = true;
      Serial.print("dr1:");
      Serial.print(1, DEC);
      Serial.print(";");
    }
  }
  else {
    if (on1) {
      on1 = false;
      Serial.print("dr1:");
      Serial.print(0, DEC);
      Serial.print(";");
    }
  }
  Serial.println();

  delay(50);
}

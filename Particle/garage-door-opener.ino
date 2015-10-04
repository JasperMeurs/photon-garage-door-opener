int garageDoor = D7;

void setup() {
    pinMode(garageDoor, OUTPUT);
    
    Spark.function("operateDoor", doorToggle);
    
    digitalWrite(garageDoor, HIGH);
}

void loop() {
    // Nothing to do here
}

int doorToggle(String command) {
    if (command == "open") {
        digitalWrite(garageDoor, LOW);
        delay(500);
        digitalWrite(garageDoor, HIGH);
        return 1;
    }
    else {
        return -1;
    }
}
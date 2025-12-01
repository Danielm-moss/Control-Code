#include <FastAccelStepper.h>

const int ARRAY_SIZE = 2;

const int STEP_PIN = 9;     
const int DIR_PIN  = 7;      
const long distance = -4880; //distance in motor steps

const uint32_t MAX_SPEED = 5250;   
const uint32_t ACCEL = 5250;   

FastAccelStepperEngine engine;
FastAccelStepper *stepper = nullptr;

void setup() {

  delay(2000);
  engine.init();

  stepper = engine.stepperConnectToPin(STEP_PIN);
  stepper->setDirectionPin(DIR_PIN);
  stepper->setAutoEnable(true);

  stepper->setSpeedInHz(MAX_SPEED);
  stepper->setAcceleration(ACCEL);

  stepper->setCurrentPosition(0); // Home

  for(int i = 0; i < ARRAY_SIZE; i++){

  stepper->moveTo(distance);
  while (stepper->isRunning()) { } // Nothing, just here so the delay only begins after the rail stops
  delay(1500);

  stepper->moveTo(0);
  while (stepper->isRunning()) { } // Nothing, just here so the delay only begins after the rail stops
  delay(1500);

  }

}

void loop() { }


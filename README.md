# Advanced Parking Assistance System

## Project Overview

This project is an **Advanced Parking Assistance System** built using **Arduino**. The purpose of this system is to help drivers park their cars safely without knocking objects or obstacles.

Since an ultrasonic sensor was not available, a **joystick module** is used to simulate distance measurements. The system provides **visual alerts using LEDs** and **audible alerts using a buzzer**, similar to a real vehicle parking sensor.

---

## Objectives

* To simulate a parking assistance system using Arduino
* To warn the driver when the car is too close to an obstacle
* To use LEDs and a buzzer for clear feedback
* To understand analog sensor readings and decision making

---

## Components Used

* Arduino Uno (main controller)
* Joystick module (distance simulation)
* Red LED (danger indication)
* Yellow LED (caution indication)
* Green LED (safe indication)
* Buzzer (sound alert)
* Resistors
* Jumper wires
* Breadboard
*obstacle avoidance sensor# Advanced Parking Assistance System

## Project Overview

This project is an **Advanced Parking Assistance System** built using **Arduino**. The purpose of this system is to help drivers park their cars safely without knocking objects or obstacles.

Since an ultrasonic sensor was not available, a **joystick module** is used to simulate distance measurements. The system provides **visual alerts using LEDs** and **audible alerts using a buzzer**, similar to a real vehicle parking sensor.

---

## Objectives

* To simulate a parking assistance system using Arduino
* To warn the driver when the car is too close to an obstacle
* To use LEDs and a buzzer for clear feedback
* To understand analog sensor readings and decision making

---

## Components Used

* Arduino Uno (main controller)
* Joystick module (distance simulation)
* Red LED (danger indication)
* Yellow LED (caution indication)
* Green LED (safe indication)
* Buzzer (sound alert)
* Resistors
* Jumper wires
* Breadboard
*obstacle avoidance sensor  ky032 
---

## System Description

The system works by reading values from the joystick, which produces analog values between **0 and 1023**.

* **0** represents the car being very close to an obstacle
* **512** represents a medium distance
* **1023** represents a safe distance

Based on these values, the Arduino controls the LEDs and buzzer:

* **Red LED + fast buzzer** → very close (danger)
* **Yellow LED + slow buzzer** → medium distance (caution)
* **Green LED + no buzzer** → safe distance

---

## How the Joystick Simulates Distance

* Moving the joystick **forward** simulates the car moving closer to an obstacle
* Keeping the joystick in the **center** simulates a medium distance
* Moving the joystick **backward** simulates a safe distance

This allows the system to behave like a real parking sensor even without an ultrasonic sensor.

---


##**And the avoidance senor**
It detects near objects and trigger a buzzer and a red led to make alerts using lights and sounds.


## Serial Monitor Output

The Serial Monitor displays simplified values only:

* `0` → Very close
* `512` → Medium distance
* `1023` → Safe distance

This makes testing and understanding the system easier.

---

## Applications

* Vehicle parking assistance systems
* Driver safety systems
* Learning Arduino sensor interfacing
* Embedded systems education

---

## Future Improvements

* Replace the joystick with ultrasonic sensors
* Add multiple sensors for front and rear parking
* Use an LCD or OLED display
* Add wireless alerts

---

## Conclusion

This project successfully demonstrates an **Advanced Parking Assistance System** using Arduino. Even without an ultrasonic sensor, the system effectively simulates distance and provides useful warnings. It is a good example of how embedded systems can improve vehicle safety.

---

**Author:** [Your Name]
**Project Type:** Arduino / Embedded Systems

---

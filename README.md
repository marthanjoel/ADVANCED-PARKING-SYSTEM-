
here is it # 🚗💡 Smart Vehicle Lighting System

A smart vehicle lighting prototype developed using an **Arduino UNO R3** and a **Flutter application**.

The system automatically controls vehicle lighting according to the surrounding light level. An **LDR/photoresistor** detects the amount of light in the environment, while an **RGB LED** represents the vehicle lighting system.

A rotary control is used to adjust the lighting brightness.

---

## 📌 Project Overview

The Smart Vehicle Lighting System is designed to demonstrate automatic vehicle lighting using an Arduino-based control system.

The Arduino continuously monitors the surrounding light level.

### ☀️ Bright Environment

When sufficient light is detected:

* 💡 Vehicle lighting turns OFF
* 📊 The light level is sent through serial communication
* 📱 Flutter can display the current lighting status

### 🌙 Dark Environment

When the environment becomes dark:

* 💡 Vehicle lighting turns ON
* 🔆 The selected brightness is applied
* 📊 The light level is sent to the Flutter application

---

## 🧰 Hardware Required

| Component                |    Quantity |
| ------------------------ | ----------: |
| Arduino UNO R3           |           1 |
| LDR / Photoresistor      |           1 |
| RGB LED                  |           1 |
| Rotary Encoder / Control |           1 |
| Resistors                | As required |
| Breadboard               |           1 |
| Jumper Wires             | As required |
| USB Cable                |           1 |

---

## 🔌 Circuit Connections

| Component           | Arduino Pin |
| ------------------- | ----------- |
| LDR / Photoresistor | A0          |
| RGB LED Red         | D5          |
| RGB LED Green       | D6          |
| RGB LED Blue        | D9          |
| Rotary CLK          | D3          |
| Rotary DT           | D2          |

---

## 💡 How the System Works

The LDR measures the surrounding light level and sends an analog value to the Arduino.

The Arduino compares the measured value with a predefined threshold.

text
LDR
 │
 ▼
Arduino UNO
 │
 ├── Bright → Lights OFF
 │
 └── Dark → Lights ON
              │
              ▼
           RGB LED


The lighting brightness can be adjusted between:

text
0 - 255


---

## 📡 Serial Communication

The Arduino communicates with the Flutter application through USB serial communication.

### Baud Rate

text
9600


Example messages:

text
LIGHT:ON,LEVEL:450,BRIGHTNESS:120


text
LIGHT:OFF,LEVEL:750,BRIGHTNESS:120


The Flutter application reads these messages and uses them to display the actual Arduino lighting status.

---

## 📱 Flutter Application

The Flutter application provides a graphical interface for monitoring the Smart Vehicle Lighting System.

The application can display information such as:

* 🔌 Arduino connection status
* 💡 Lighting status
* ☀️ Light level
* 🔆 Brightness
* 📡 Serial communication status

The Arduino is responsible for reading the physical sensor and controlling the RGB LED.

---

## 📂 Project Structure

text
SMART-VECHICLE-LIGHTING-SYSTEM/
│
├── android/
├── ios/
├── linux/
├── macos/
├── web/
├── windows/
│
├── lib/
│   ├── main.dart
│   └── services/
│
├── test/
│
├── pubspec.yaml
├── pubspec.lock
├── README.md
│
└── .github/
    └── workflows/
        └── build-apk.yml


---

## ⚙️ Flutter Setup

Install the project dependencies:

bash
flutter pub get


Check the project for problems:

bash
flutter analyze


Run the application on Linux:

bash
LIBGL_ALWAYS_SOFTWARE=1 flutter run -d linux


---

## 🔌 Connecting the Arduino

1. Connect the Arduino UNO R3 to the computer using USB.
2. Upload the Smart Vehicle Lighting Arduino program.
3. Close the Arduino Serial Monitor.
4. Start the Flutter application.
5. Select the Arduino serial port.
6. Connect the Arduino.
7. Change the light level or brightness control and observe the Flutter interface.

On Linux, the Arduino may appear as:

text
/dev/ttyACM0


---

## ⚠️ Serial Port Warning

Only one program should use the Arduino serial port at a time.

If the Arduino Serial Monitor is open, close it before connecting the Flutter application.

---

## 🏗️ Android APK

The project includes a GitHub Actions workflow for building the Android release APK.

Workflow:

text
.github/workflows/build-apk.yml


The workflow can:

1. Download the project.
2. Install Flutter.
3. Install dependencies.
4. Build the release APK.
5. Upload the APK as a GitHub Actions artifact.

The generated APK is:

text
app-release.apk


---

## 🔄 Complete System Flow

text
        ☀️ / 🌙
           │
           ▼
    ┌───────────────┐
    │ LDR Sensor    │
    └───────┬───────┘
            │
            ▼
    ┌───────────────┐
    │ Arduino UNO   │
    │               │
    │ Lighting      │
    │ Controller    │
    └───────┬───────┘
            │
       ┌────┴────┐
       │         │
       ▼         ▼
   RGB LED    USB Serial
                 │
                 ▼
        ┌────────────────┐
        │ Flutter App    │
        │                │
        │ Light Status   │
        │ Light Level    │
        │ Brightness     │
        └────────────────┘


---

## 🎯 Project Objectives

The objectives of this project are:

1. Develop an automatic vehicle lighting system.
2. Detect environmental light conditions.
3. Automatically switch vehicle lighting based on the environment.
4. Provide adjustable lighting brightness.
5. Connect Arduino hardware to a Flutter application.
6. Display real-time lighting information.
7. Demonstrate smart vehicle electronics.

---

## 🔮 Future Improvements

Possible future improvements include:

* 🚘 Automatic headlight control
* 🔆 High-beam and low-beam control
* ↔️ Automatic turn indicators
* 🛑 Brake-light integration
* 🌧️ Rain detection
* 📱 Wireless mobile control
* 📶 Bluetooth communication
* 📊 Lighting event history
* 🔋 Battery monitoring
* 🚗 Integration with other vehicle systems

---

## 🛠️ Technologies Used

* Arduino UNO R3
* Arduino IDE
* C/C++
* Flutter
* Dart
* USB Serial Communication
* flserial
* Git
* GitHub
* GitHub Actions

---

## 👨‍💻 Author

**Lutwama Joel**

Electrical Installation Student

Smart Vehicle Systems Project

---

## 📊 Project Status

**Working Prototype ✅**

The system demonstrates automatic lighting control using an LDR, RGB LED, Arduino UNO R3, and Flutter interface.

😂🔥 NOW I SEE IT, BRO. This is the exact structure we need.

For the Advanced Parking System, I'll keep the same logic and sections:

Project introduction

Project overview

Hardware required

Circuit connections

How the system works

Serial communication

Flutter application

Project structure

Flutter setup

Arduino connection

Serial-port warning

Android APK

Complete system flow

Project objectives

Future improvements

Technologies used

Author

Project status

And I'll base the parking README on our actual parking project, including the joystick, KY-032 obstacle sensor, LEDs, buzzer, Arduino control logic, Flutter control panel, and the arduino_serial_service.dart we just added.

I won't make it into a generic parking-system README. 🚗🅿️🔥


now i humlby request u help me make the readme file

Absolutely bro 😎🔥 I made the actual README.md file following the same structure and logic as your Smart Vehicle Lighting README, but adapted to the Advanced Parking System we worked on.

📄 Download README.md

Put it in:

ADVANCED-PARKING-SYSTEM-/README.md
Then we'll add it to Git and push everything safely to GitHub. 🚗🅿️🔥


README.md
Document


thanks now the apk

YES BRO 😂🔥 — now let's build the APK.

Since your project already has the GitHub Actions workflow we used for the other projects, let's first make sure the README is committed and then trigger the APK build.

From:

~/ADVANCED-PARKING-SYSTEM-
run:

git status
Send me the output first. Don't run git push yet.

Then I'll guide you through the GitHub Actions APK build step-by-step, just like we did with the first projects. 🚗📱🔥


it doesnt have them

Ahh 😂 got you, bro. You mean the Advanced Parking project doesn't have the GitHub Actions workflow for building the APK yet.

No problem. We'll add it.

First, let's check whether your project has a .github folder at all.

Run:

ls -la
Then:

ls -la .github
Send me both outputs.

If .github doesn't exist, that's completely fine — we'll create:

.github/
└── workflows/
    └── build-apk.yml
and set it up to build your Flutter APK automatically on GitHub. 🚀📱

than lutwamajoelmarthan       94 Sep  3 12:44  lib

drwxr-xr-x. 1 lutwamajoelmarthan lutwamajoelmarthan       74 Sep  2 23:38  linux

drwxr-xr-x. 1 lutwamajoelmarthan lutwamajoelmarthan      136 Sep  2 23:38  macos

-rw-r--r--. 1 lutwamajoelmarthan lutwamajoelmarthan     1706 Sep  2 23:38  .metadata

-rw-r--r--. 1 lutwamajoelmarthan lutwamajoelmarthan     9007 Sep  3 12:44  pubspec.lock

-rw-r--r--. 1 lutwamajoelmarthan lutwamajoelmarthan     3869 Sep  3 12:44  pubspec.yaml

-rw-r--r--. 1 lutwamajoelmarthan lutwamajoelmarthan     2681 Sep  2 23:38  README.md

drwxr-xr-x. 1 lutwamajoelmarthan lutwamajoelmarthan       32 Sep  3 12:44  test

drwxr-xr-x. 1 lutwamajoelmarthan lutwamajoelmarthan       78 Sep  2 23:38  web

drwxr-xr-x. 1 lutwamajoelmarthan lutwamajoelmarthan       74 Sep  2 23:38  windows

lutwamajoelmarthan@fedora:~/ADVANCED-PARKING-SYSTEM-$ ls -la .github

ls: cannot access '.github': No such file or directory

lutwamajoelmarthan@fedora:~/ADVANCED-PARKING-SYSTEM-$ 

Library
/
README.md


🚗🅿️ Advanced Parking Assistance System
An advanced vehicle parking-assistance prototype developed using an Arduino UNO R3 and a Flutter application.

The system uses an obstacle-detection sensor together with vehicle-control inputs to assist with parking. The Arduino handles the parking logic, while LEDs and a buzzer provide physical indications and the Flutter application provides the vehicle control-panel interface.

📌 Project Overview
The Advanced Parking Assistance System is designed to demonstrate how a vehicle can use sensors and control inputs to assist the driver during parking.

The Arduino continuously monitors the parking inputs and the obstacle-detection sensor.

🚗 Vehicle Control
The joystick/control inputs are used to simulate vehicle movement commands:

⬆️ Forward control

⬇️ Reverse control

⬅️ Left control

➡️ Right control

🚧 Obstacle Detected
When the obstacle sensor detects an object:

🚨 The parking warning state is activated

🔊 The buzzer provides an audible warning

💡 The corresponding LED indication is activated

📊 The parking information can be sent through serial communication

📱 Flutter can display the current parking/system status

🧰 Hardware Required
Component	Quantity
Arduino UNO R3	1
KY-032 Infrared Obstacle Sensor	1
Joystick / Control Inputs	1
LEDs	As required
Buzzer	1
Resistors	As required
Breadboard	1
Jumper Wires	As required
USB Cable	1
🔌 Circuit Connections
The parking prototype uses Arduino digital pins for the obstacle sensor, buzzer and parking indicators, together with the joystick/control inputs.

The exact pin assignment is defined in the Arduino parking program used with the project.

The main parking components are:

Component	Arduino Connection
KY-032 Obstacle Sensor	Digital input
Joystick / Control Inputs	Arduino input pins
Parking LEDs	Arduino output pins
Buzzer	Arduino output pin
🅿️ How the System Works
The Arduino reads the vehicle-control inputs while continuously checking the obstacle sensor.

Joystick / Controls
        │
        ▼
   Arduino UNO
        │
        ├── Vehicle control logic
        │
        └── Check obstacle sensor
                  │
          ┌───────┴────────┐
          │                │
       No obstacle     Obstacle detected
          │                │
          ▼                ▼
     Normal state     Warning state
                           │
                     ┌─────┴─────┐
                     ▼           ▼
                   LEDs        Buzzer
The obstacle sensor provides the Arduino with the information needed to determine whether a parking warning should be activated.

🚧 Obstacle Detection
The KY-032 infrared obstacle-avoidance sensor is used in the parking system to detect an obstacle in the vehicle's path.

The Arduino reads the sensor and changes the parking warning state when an obstacle is detected.

This allows the system to give the driver an additional warning while positioning the vehicle.

📡 Serial Communication
The Arduino communicates with the Flutter application through serial communication.

The Flutter project contains a dedicated Arduino serial communication service:

lib/services/arduino_serial_service.dart
The service is separated from the user interface so that Arduino communication can be integrated with the parking control panel.

The Arduino is responsible for the physical sensor and parking-control logic, while Flutter is responsible for displaying the system information through the application interface.

📱 Flutter Application
The Flutter application provides a graphical vehicle control panel for the Advanced Parking System.

The application is designed to provide information such as:

🔌 Arduino connection status

🅿️ Parking-system status

🚧 Obstacle status

🎮 Vehicle-control interface

🔊 Warning indication

📡 Serial communication status

The main Flutter application is located in:

lib/main.dart
Arduino communication is handled through:

lib/services/arduino_serial_service.dart
📂 Project Structure
ADVANCED-PARKING-SYSTEM-/
│
├── android/
├── ios/
├── linux/
├── macos/
├── web/
├── windows/
│
├── lib/
│   ├── main.dart
│   └── services/
│       └── arduino_serial_service.dart
│
├── test/
│   └── widget_test.dart
│
├── pubspec.yaml
├── pubspec.lock
├── README.md
│
└── .github/
    └── workflows/
        └── build-apk.yml
⚙️ Flutter Setup
Install the project dependencies:

flutter pub get
Check the project for problems:

flutter analyze
Run the application on Linux:

LIBGL_ALWAYS_SOFTWARE=1 flutter run -d linux
🔌 Connecting the Arduino
Connect the Arduino UNO R3 to the computer using USB.

Upload the Advanced Parking Arduino program.

Close the Arduino Serial Monitor.

Start the Flutter application.

Select the Arduino serial port when the connection interface is available.

Connect the Arduino to the Flutter application.

Test the parking controls and obstacle detection.

On Linux, an Arduino UNO may appear as:

/dev/ttyACM0
⚠️ Serial Port Warning
Only one program should use the Arduino serial port at a time.

If the Arduino Serial Monitor is open, close it before connecting the Flutter application.

🏗️ Android APK
The project can be built as an Android application using the project's GitHub Actions workflow.

Workflow:

.github/workflows/build-apk.yml
The workflow can:

Download the project.

Install Flutter.

Install dependencies.

Build the release APK.

Upload the APK as a GitHub Actions artifact.

The generated release application is an Android APK.

🔄 Complete System Flow
       🎮 JOYSTICK / CONTROLS
                 │
                 ▼
        ┌─────────────────┐
        │   Arduino UNO   │
        │                 │
        │ Parking Logic   │
        └────────┬────────┘
                 │
          ┌──────┴──────┐
          │             │
          ▼             ▼
     🚧 KY-032       🎮 Control
      Sensor           Inputs
          │             │
          └──────┬──────┘
                 │
                 ▼
        ┌─────────────────┐
        │ Parking Status  │
        │   & Warnings    │
        └───────┬─────────┘
                │
          ┌─────┴─────┐
          ▼           ▼
       💡 LEDs      🔊 Buzzer
                
                 │
            USB Serial
                 │
                 ▼
        ┌─────────────────┐
        │   Flutter App   │
        │  Control Panel  │
        └─────────────────┘
🎯 Project Objectives
The objectives of this project are:

Develop an Arduino-based parking-assistance system.

Detect obstacles during vehicle parking.

Provide audible and visual parking warnings.

Simulate vehicle movement using joystick/control inputs.

Develop a Flutter vehicle control-panel interface.

Prepare communication between the Arduino and Flutter application.

Demonstrate the integration of vehicle electronics and software.

🔮 Future Improvements
Possible future improvements include:

📏 Add ultrasonic distance measurement for more detailed parking information

📱 Complete real-time Arduino-to-Flutter communication

🚗 Add more vehicle-control functions

📊 Display live parking sensor information in the Flutter app

🔊 Add different warning levels according to obstacle distance

📷 Add camera-based parking assistance

📶 Add wireless communication

🚘 Integrate the parking system with the other vehicle systems

🛠️ Technologies Used
Arduino UNO R3

Arduino IDE

C/C++

Flutter

Dart

USB Serial Communication

Git

GitHub

GitHub Actions

Tinkercad

👨‍💻 Author
Lutwama Joel

Electrical Installation Student

Vehicle Systems Project

📊 Project Status
Working Prototype / Development 🚧

The project demonstrates the Advanced Parking System using an Arduino UNO, joystick/control inputs, KY-032 obstacle detection, LEDs, buzzer and a Flutter control-panel application. Arduino serial communication support is included in the Flutter project for integration of the hardware and application.




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


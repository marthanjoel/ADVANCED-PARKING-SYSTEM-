# ADVANCED-PARKING-SYSTEM-

Advanced Parking Assistance System (Arduino-Based)
1. Project Title

Advanced Parking Assistance System Using Arduino and IR Obstacle Sensor

2. Introduction

Parking vehicles in tight spaces can be difficult and may cause accidents or damage.
This project implements an Advanced Parking Assistance System using an Arduino Uno.
The system detects nearby obstacles and alerts the driver using RGB LEDs and a buzzer.

3. Aim of the Project

The aim of this project is to detect obstacles near a vehicle during parking and provide visual and sound alerts to help prevent collisions.

4. Objectives

To detect obstacles using an IR obstacle avoidance sensor

To provide visual alerts using an RGB LED

To provide sound alerts using a buzzer

To allow sensitivity adjustment using a rotary encoder

To design a simple and reliable parking assistance system

5. Components Used

Arduino Uno

IR Obstacle Avoidance Sensor (IR-08HBV02.45.DC)

RGB LED

Buzzer

Rotary Encoder

Breadboard

Jumper wires

6. System Description

The IR sensor continuously checks for obstacles in front of the vehicle.
When an obstacle is detected:

The system changes the RGB LED color to indicate the parking status

The buzzer sounds for 2 seconds

The rotary encoder allows the user to adjust how sensitive the system is to obstacles

7. Working Principle

Green LED → No obstacle detected (Safe)

Blue LED → Obstacle detected (Caution)

Red LED + Buzzer → Obstacle very close (Danger)

The buzzer and alert LEDs remain ON for 2 seconds

The rotary encoder controls how quickly the system reacts to obstacles

8. Advantages of the System

Simple and low-cost design

Easy to use and understand

Helps prevent vehicle damage during parking

Adjustable sensitivity

Can be expanded with more sensors in the future

9. Limitations

IR sensors are affected by lighting and surface color

The system detects presence, not exact distance

Best suited for short-range parking assistance

10. Applications

Vehicle parking assistance

Obstacle detection systems

Robotics obstacle avoidance

Educational Arduino projects

11. Conclusion

The Advanced Parking Assistance System successfully detects obstacles and alerts the user using LEDs and a buzzer.
The system is simple, effective, and suitable for learning embedded systems and vehicle safety concepts.

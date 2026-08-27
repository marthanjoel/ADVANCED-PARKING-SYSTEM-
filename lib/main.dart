import 'package:flutter/material.dart';

void main() {
  runApp(const ParkingAssistanceApp());
}

class ParkingAssistanceApp extends StatelessWidget {
  const ParkingAssistanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advanced Parking Assistance',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      home: const ParkingDashboard(),
    );
  }
}

class ParkingDashboard extends StatefulWidget {
  const ParkingDashboard({super.key});

  @override
  State<ParkingDashboard> createState() => _ParkingDashboardState();
}

class _ParkingDashboardState extends State<ParkingDashboard> {
  bool systemArmed = false;
  bool obstacleDetected = false;

  // Simulated Arduino joystick value.
  // Later this will come from the Arduino.
  int sensorValue = 1023;

  String get distanceStatus {
    if (obstacleDetected) {
      return 'OBSTACLE DETECTED';
    }

    if (sensorValue <= 150) {
      return 'VERY CLOSE';
    }

    if (sensorValue <= 349) {
      return 'CLOSE';
    }

    if (sensorValue <= 699) {
      return 'CAUTION';
    }

    return 'SAFE';
  }

  Color get statusColor {
    if (obstacleDetected) {
      return Colors.red;
    }

    if (sensorValue <= 349) {
      return Colors.red;
    }

    if (sensorValue <= 699) {
      return Colors.orange;
    }

    return Colors.green;
  }

  IconData get statusIcon {
    if (obstacleDetected) {
      return Icons.warning;
    }

    if (sensorValue <= 349) {
      return Icons.dangerous;
    }

    if (sensorValue <= 699) {
      return Icons.warning_amber_rounded;
    }

    return Icons.check_circle;
  }

  String get buzzerStatus {
    if (!systemArmed) {
      return 'OFF';
    }

    if (obstacleDetected || sensorValue <= 349) {
      return 'FAST BUZZER';
    }

    if (sensorValue <= 699) {
      return 'SLOW BUZZER';
    }

    return 'OFF';
  }

  String get ledStatus {
    if (!systemArmed) {
      return 'OFF';
    }

    if (obstacleDetected || sensorValue <= 349) {
      return 'RED LED';
    }

    if (sensorValue <= 699) {
      return 'YELLOW LED';
    }

    return 'GREEN LED';
  }

  void startSystem() {
    setState(() {
      systemArmed = true;
    });
  }

  void disarmSystem() {
    setState(() {
      systemArmed = false;
      obstacleDetected = false;
    });
  }

  void setSensorValue(int value) {
    if (!systemArmed) return;

    setState(() {
      sensorValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'PARKING ASSISTANCE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            // =====================================================
            // VEHICLE
            // =====================================================

            const Icon(
              Icons.directions_car,
              size: 80,
              color: Colors.blue,
            ),

            const SizedBox(height: 5),

            const Text(
              'ADVANCED PARKING ASSISTANCE SYSTEM',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // =====================================================
            // SYSTEM STATUS
            // =====================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: systemArmed
                    ? Colors.green
                    : Colors.grey.shade700,
                borderRadius: BorderRadius.circular(16),
              ),

              child: Row(
                children: [

                  Icon(
                    systemArmed
                        ? Icons.lock_open
                        : Icons.lock,
                    color: Colors.white,
                    size: 40,
                  ),

                  const SizedBox(width: 15),

                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Text(
                        'SYSTEM STATUS',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),

                      Text(
                        systemArmed
                            ? 'SYSTEM ARMED'
                            : 'SYSTEM DISARMED',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // =====================================================
            // START / DISARM BUTTONS
            // =====================================================

            Row(
              children: [

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:
                        systemArmed ? null : startSystem,

                    icon: const Icon(Icons.play_arrow),

                    label: const Text(
                      'START SYSTEM',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:
                        systemArmed ? disarmSystem : null,

                    icon: const Icon(Icons.stop),

                    label: const Text(
                      'DISARM',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // =====================================================
            // PARKING STATUS
            // =====================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),

              decoration: BoxDecoration(
                color: systemArmed
                    ? statusColor
                    : Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                children: [

                  Icon(
                    systemArmed
                        ? statusIcon
                        : Icons.power_settings_new,
                    color: Colors.white,
                    size: 65,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    systemArmed
                        ? distanceStatus
                        : 'SYSTEM OFF',
                    textAlign: TextAlign.center,

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    systemArmed
                        ? _description()
                        : 'Press START SYSTEM',
                    textAlign: TextAlign.center,

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =====================================================
            // SENSOR VALUE
            // =====================================================

            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  children: [

                    const Row(
                      children: [

                        Icon(
                          Icons.sensors,
                          color: Colors.blue,
                        ),

                        SizedBox(width: 10),

                        Text(
                          'JOYSTICK / DISTANCE SENSOR',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Text(
                      sensorValue.toString(),
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: systemArmed
                            ? statusColor
                            : Colors.grey,
                      ),
                    ),

                    const Text(
                      'VALUE: 0 - 1023',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // LIVE POSITION BAR
                    SizedBox(
                      height: 45,
                      child: LayoutBuilder(
                        builder:
                            (context, constraints) {

                          double position =
                              (sensorValue / 1023) *
                                  constraints.maxWidth;

                          return Stack(
                            children: [

                              Align(
                                alignment:
                                    Alignment.center,
                                child: Container(
                                  height: 10,
                                  width: double.infinity,
                                  decoration:
                                      BoxDecoration(
                                    color:
                                        Colors.grey.shade300,
                                    borderRadius:
                                        BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                left: position
                                    .clamp(
                                      0,
                                      constraints.maxWidth - 20,
                                    ),
                                top: 5,

                                child: Container(
                                  width: 20,
                                  height: 35,

                                  decoration:
                                      BoxDecoration(
                                    color: systemArmed
                                        ? statusColor
                                        : Colors.grey,
                                    borderRadius:
                                        BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    const Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                      children: [
                        Text('0'),
                        Text('512'),
                        Text('1023'),
                      ],
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'VERY CLOSE        MEDIUM        SAFE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // =====================================================
            // OBSTACLE SENSOR
            // =====================================================

            Card(
              child: SwitchListTile(
                value: obstacleDetected,

                onChanged: systemArmed
                    ? (value) {
                        setState(() {
                          obstacleDetected = value;
                        });
                      }
                    : null,

                secondary: Icon(
                  Icons.radar,
                  size: 35,
                  color: obstacleDetected
                      ? Colors.red
                      : Colors.green,
                ),

                title: const Text(
                  'OBSTACLE AVOIDANCE SENSOR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Text(
                  obstacleDetected
                      ? 'OBSTACLE DETECTED!'
                      : 'NO OBSTACLE DETECTED',
                ),
              ),
            ),

            const SizedBox(height: 15),

            // =====================================================
            // LED AND BUZZER
            // =====================================================

            Row(
              children: [

                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),

                      child: Column(
                        children: [

                          Icon(
                            Icons.lightbulb,
                            size: 35,
                            color: systemArmed
                                ? statusColor
                                : Colors.grey,
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'LED',
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            ledStatus,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),

                      child: Column(
                        children: [

                          Icon(
                            Icons.volume_up,
                            size: 35,
                            color: systemArmed
                                ? statusColor
                                : Colors.grey,
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'BUZZER',
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            buzzerStatus,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // =====================================================
            // TEST BUTTONS
            // =====================================================

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [

                    const Text(
                      'SENSOR TEST',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'These buttons simulate Arduino values.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,

                      alignment:
                          WrapAlignment.center,

                      children: [

                        _testButton(
                          'VERY CLOSE',
                          100,
                        ),

                        _testButton(
                          'CLOSE',
                          300,
                        ),

                        _testButton(
                          'MEDIUM',
                          512,
                        ),

                        _testButton(
                          'SAFE',
                          900,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'ADVANCED PARKING ASSISTANCE SYSTEM',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              'LUTWAMA JOEL MARTHAN',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String _description() {
    if (obstacleDetected) {
      return 'Obstacle detected. STOP!';
    }

    if (sensorValue <= 150) {
      return 'The vehicle is extremely close to the obstacle.';
    }

    if (sensorValue <= 349) {
      return 'The vehicle is close to the obstacle.';
    }

    if (sensorValue <= 699) {
      return 'Be careful. The obstacle is getting closer.';
    }

    return 'Distance is safe. Continue parking carefully.';
  }

  Widget _testButton(String text, int value) {
    return ElevatedButton(
      onPressed: systemArmed
          ? () => setSensorValue(value)
          : null,

      child: Text(text),
    );
  }
}
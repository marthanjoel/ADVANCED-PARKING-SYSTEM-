import 'dart:async';

import 'package:flutter/material.dart';

import 'services/arduino_serial_service.dart';

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
  final ArduinoSerialService _arduino =
      ArduinoSerialService.instance;

  StreamSubscription<String>? _serialSubscription;

  List<String> availablePorts = [];
  String? selectedPort;

  bool arduinoConnected = false;
  bool systemArmed = false;

  int sensorValue = 1023;
  int sensorState = 1;

  String lastSerialMessage = 'No data received';

  @override
  void initState() {
    super.initState();

    _serialSubscription = _arduino.dataStream.listen(
      _handleSerialData,
    );

    _scanArduino();
  }

  @override
  void dispose() {
    _serialSubscription?.cancel();
    super.dispose();
  }

  // ============================================================
  // ARDUINO CONNECTION
  // ============================================================

  Future<void> _scanArduino() async {
    try {
      final ports = await _arduino.scanPorts();

      if (!mounted) return;

      setState(() {
        availablePorts = ports;

        if (ports.isNotEmpty) {
          if (selectedPort == null ||
              !ports.contains(selectedPort)) {
            selectedPort = ports.first;
          }
        } else {
          selectedPort = null;
        }
      });
    } catch (error) {
      if (!mounted) return;

      _showMessage(
        'Could not scan Arduino ports: $error',
      );
    }
  }

  Future<void> _connectArduino() async {
    if (selectedPort == null) {
      _showMessage('Please select an Arduino port first.');
      return;
    }

    try {
      final success = await _arduino.connect(
        selectedPort!,
        baudRate: 9600,
      );

      if (!mounted) return;

      setState(() {
        arduinoConnected = success;
      });

      if (success) {
        _showMessage(
          'Arduino connected successfully.',
        );
      } else {
        _showMessage(
          'Could not connect to Arduino.',
        );
      }
    } catch (error) {
      if (!mounted) return;

      setState(() {
        arduinoConnected = false;
      });

      _showMessage(
        'Connection error: $error',
      );
    }
  }

  Future<void> _disconnectArduino() async {
    await _arduino.disconnect();

    if (!mounted) return;

    setState(() {
      arduinoConnected = false;
      systemArmed = false;
      lastSerialMessage = 'Arduino disconnected';
    });
  }

  // ============================================================
  // SERIAL DATA
  // ============================================================

  void _handleSerialData(String data) {
    final cleaned = data.replaceAll('\r', '');

    final lines = cleaned.split('\n');

    for (final line in lines) {
      final message = line.trim();

      if (message.isEmpty) {
        continue;
      }

      _processArduinoMessage(message);
    }
  }

  void _processArduinoMessage(String message) {
    lastSerialMessage = message;

    // Example Arduino message:
    //
    // Joystick Y: 498 | Sensor: 1

    final joystickMatch = RegExp(
      r'Joystick\s+Y:\s*(\d+)',
      caseSensitive: false,
    ).firstMatch(message);

    final sensorMatch = RegExp(
      r'Sensor:\s*(\d+)',
      caseSensitive: false,
    ).firstMatch(message);

    if (!mounted) return;

    setState(() {
      if (joystickMatch != null) {
        final value = int.tryParse(
          joystickMatch.group(1)!,
        );

        if (value != null) {
          sensorValue = value.clamp(0, 1023);
        }
      }

      if (sensorMatch != null) {
        final value = int.tryParse(
          sensorMatch.group(1)!,
        );

        if (value != null) {
          sensorState = value;
        }
      }
    });
  }

  // ============================================================
  // PARKING LOGIC
  // ============================================================

  String get distanceStatus {
    if (sensorState == 0) {
      return 'OBSTACLE DETECTED';
    }

    if (sensorValue < 400) {
      return 'VERY CLOSE';
    }

    if (sensorValue <= 600) {
      return 'CAUTION';
    }

    return 'SAFE';
  }

  Color get statusColor {
    if (!systemArmed) {
      return Colors.grey;
    }

    if (sensorState == 0) {
      return Colors.red;
    }

    if (sensorValue < 400) {
      return Colors.red;
    }

    if (sensorValue <= 600) {
      return Colors.orange;
    }

    return Colors.green;
  }

  IconData get statusIcon {
    if (!systemArmed) {
      return Icons.power_settings_new;
    }

    if (sensorState == 0) {
      return Icons.warning;
    }

    if (sensorValue < 400) {
      return Icons.dangerous;
    }

    if (sensorValue <= 600) {
      return Icons.warning_amber_rounded;
    }

    return Icons.check_circle;
  }

  String get buzzerStatus {
    if (!systemArmed) {
      return 'OFF';
    }

    if (sensorState == 0 || sensorValue < 400) {
      return 'FAST BUZZER';
    }

    if (sensorValue <= 600) {
      return 'OFF';
    }

    return 'OFF';
  }

  String get ledStatus {
    if (!systemArmed) {
      return 'OFF';
    }

    if (sensorState == 0 || sensorValue < 400) {
      return 'RED LED';
    }

    if (sensorValue <= 600) {
      return 'YELLOW LED';
    }

    return 'GREEN LED';
  }

  String get obstacleStatus {
    if (sensorState == 0) {
      return 'OBSTACLE DETECTED!';
    }

    return 'NO OBSTACLE DETECTED';
  }

  String get parkingDescription {
    if (!systemArmed) {
      return 'Press START SYSTEM';
    }

    if (sensorState == 0) {
      return 'Obstacle detected. STOP!';
    }

    if (sensorValue < 400) {
      return 'The vehicle is extremely close to the obstacle.';
    }

    if (sensorValue <= 600) {
      return 'Be careful. The obstacle is getting closer.';
    }

    return 'Distance is safe. Continue parking carefully.';
  }

  // ============================================================
  // SYSTEM CONTROLS
  // ============================================================

  void _startSystem() {
    if (!arduinoConnected) {
      _showMessage(
        'Connect the Arduino before starting the system.',
      );
      return;
    }

    setState(() {
      systemArmed = true;
    });
  }

  void _disarmSystem() {
    setState(() {
      systemArmed = false;
    });
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

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

            // ====================================================
            // VEHICLE HEADER
            // ====================================================

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

            // ====================================================
            // ARDUINO CONTROL PANEL
            // ====================================================

            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Row(
                      children: [

                        Icon(
                          Icons.usb,
                          color: Colors.blue,
                        ),

                        SizedBox(width: 10),

                        Text(
                          'ARDUINO CONTROL PANEL',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'ARDUINO SERIAL PORT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [

                        Expanded(
                          child: DropdownButtonFormField<
                              String>(
                            initialValue:
                                availablePorts
                                        .contains(
                                      selectedPort,
                                    )
                                    ? selectedPort
                                    : null,

                            decoration:
                                const InputDecoration(
                              border:
                                  OutlineInputBorder(),
                              hintText:
                                  'Select Arduino',
                            ),

                            items: availablePorts
                                .map(
                                  (port) =>
                                      DropdownMenuItem<
                                          String>(
                                    value: port,
                                    child: Text(port),
                                  ),
                                )
                                .toList(),

                            onChanged: arduinoConnected
                                ? null
                                : (value) {
                                    setState(() {
                                      selectedPort =
                                          value;
                                    });
                                  },
                          ),
                        ),

                        const SizedBox(width: 8),

                        IconButton(
                          tooltip: 'Scan Arduino',
                          onPressed:
                              arduinoConnected
                                  ? null
                                  : _scanArduino,
                          icon: const Icon(
                            Icons.refresh,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [

                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed:
                                arduinoConnected
                                    ? null
                                    : _connectArduino,

                            icon: const Icon(
                              Icons.link,
                            ),

                            label: const Text(
                              'CONNECT',
                              style: TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.green,
                              foregroundColor:
                                  Colors.white,
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                vertical: 15,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed:
                                arduinoConnected
                                    ? _disconnectArduino
                                    : null,

                            icon: const Icon(
                              Icons.link_off,
                            ),

                            label: const Text(
                              'DISCONNECT',
                              style: TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.red,
                              foregroundColor:
                                  Colors.white,
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                vertical: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.all(12),

                      decoration: BoxDecoration(
                        color: arduinoConnected
                            ? Colors.green.shade50
                            : Colors.grey.shade200,
                        borderRadius:
                            BorderRadius.circular(10),
                      ),

                      child: Row(
                        children: [

                          Icon(
                            arduinoConnected
                                ? Icons.check_circle
                                : Icons
                                    .portable_wifi_off,
                            color: arduinoConnected
                                ? Colors.green
                                : Colors.grey,
                          ),

                          const SizedBox(width: 10),

                          Text(
                            arduinoConnected
                                ? 'ARDUINO CONNECTED'
                                : 'ARDUINO NOT CONNECTED',
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                              color: arduinoConnected
                                  ? Colors.green
                                  : Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Last data: $lastSerialMessage',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ====================================================
            // SYSTEM STATUS
            // ====================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: systemArmed
                    ? Colors.green
                    : Colors.grey.shade700,
                borderRadius:
                    BorderRadius.circular(16),
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

            // ====================================================
            // START / DISARM
            // ====================================================

            Row(
              children: [

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:
                        systemArmed
                            ? null
                            : _startSystem,

                    icon:
                        const Icon(Icons.play_arrow),

                    label: const Text(
                      'START SYSTEM',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.green,
                      foregroundColor:
                          Colors.white,
                      padding:
                          const EdgeInsets
                              .symmetric(
                        vertical: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:
                        systemArmed
                            ? _disarmSystem
                            : null,

                    icon:
                        const Icon(Icons.stop),

                    label: const Text(
                      'DISARM',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.red,
                      foregroundColor:
                          Colors.white,
                      padding:
                          const EdgeInsets
                              .symmetric(
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ====================================================
            // PARKING STATUS
            // ====================================================

            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(25),

              decoration: BoxDecoration(
                color: statusColor,
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Column(
                children: [

                  Icon(
                    statusIcon,
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
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    parkingDescription,
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

            // ====================================================
            // JOYSTICK / DISTANCE SENSOR
            // ====================================================

            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(18),

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
                            fontWeight:
                                FontWeight.bold,
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
                        fontWeight:
                            FontWeight.bold,
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

                    SizedBox(
                      height: 45,

                      child: LayoutBuilder(
                        builder:
                            (context, constraints) {

                          final double position =
                              (sensorValue / 1023) *
                                  constraints.maxWidth;

                          return Stack(
                            children: [

                              Align(
                                alignment:
                                    Alignment.center,

                                child: Container(
                                  height: 10,
                                  width:
                                      double.infinity,

                                  decoration:
                                      BoxDecoration(
                                    color: Colors
                                        .grey
                                        .shade300,
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      10,
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                left: position.clamp(
                                  0,
                                  constraints
                                          .maxWidth -
                                      20,
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
                                        BorderRadius
                                            .circular(
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
                          MainAxisAlignment
                              .spaceBetween,

                      children: [
                        Text('0'),
                        Text('512'),
                        Text('1023'),
                      ],
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'VERY CLOSE        MEDIUM        SAFE',
                      textAlign:
                          TextAlign.center,

                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ====================================================
            // OBSTACLE SENSOR
            // ====================================================

            Card(
              child: SwitchListTile(
                value: sensorState == 0,

                onChanged: systemArmed
                    ? (_) {}
                    : null,

                secondary: Icon(
                  Icons.radar,
                  size: 35,
                  color: sensorState == 0
                      ? Colors.red
                      : Colors.green,
                ),

                title: const Text(
                  'OBSTACLE AVOIDANCE SENSOR',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                subtitle: Text(
                  obstacleStatus,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ====================================================
            // LED AND BUZZER
            // ====================================================

            Row(
              children: [

                Expanded(
                  child: Card(
                    child: Padding(
                      padding:
                          const EdgeInsets.all(16),

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
                            textAlign:
                                TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Card(
                    child: Padding(
                      padding:
                          const EdgeInsets.all(16),

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
                            textAlign:
                                TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ====================================================
            // LIVE SERIAL DATA
            // ====================================================

            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Row(
                      children: [

                        Icon(
                          Icons.data_object,
                          color: Colors.blue,
                        ),

                        SizedBox(width: 10),

                        Text(
                          'LIVE ARDUINO DATA',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.all(12),

                      decoration: BoxDecoration(
                        color:
                            Colors.black87,
                        borderRadius:
                            BorderRadius.circular(
                          8,
                        ),
                      ),

                      child: Text(
                        lastSerialMessage,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily:
                              'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'ADVANCED PARKING ASSISTANCE SYSTEM',
              style: TextStyle(
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              'LUTWAMA JOEL MARTHAN',
              style: TextStyle(
                color:
                    Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
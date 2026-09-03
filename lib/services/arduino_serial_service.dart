import 'dart:async';
import 'dart:typed_data';

import 'package:flserial/flserial.dart';

class ArduinoSerialService {
  ArduinoSerialService._();

  static final ArduinoSerialService instance =
      ArduinoSerialService._();

  final FlSerial _serial = FlSerial();

  final StreamController<String> _dataController =
      StreamController<String>.broadcast();

  Stream<String> get dataStream => _dataController.stream;

  StreamSubscription<SerialEvent>? _eventSubscription;

  bool _isConnected = false;

  // Holds incomplete serial messages until the newline arrives.
  String _receiveBuffer = '';

  bool get isConnected => _isConnected;

  Future<List<String>> scanPorts() async {
    final ports = await FlSerial.availablePorts();

    return ports.map((port) => port.path.toString()).toList();
  }

  Future<bool> connect(
    String portName, {
    int baudRate = 9600,
  }) async {
    await disconnect();

    _receiveBuffer = '';

    _eventSubscription = _serial.events.listen((event) {
      switch (event.type) {
        case SerialEventType.data:
          final data = event.data as Uint8List;

          // Add the new bytes to our buffer.
          _receiveBuffer += String.fromCharCodes(data);

          // Split only when a complete line is available.
          final lines = _receiveBuffer.split('\n');

          // Keep the unfinished part for the next serial event.
          _receiveBuffer = lines.removeLast();

          // Send complete lines to Flutter.
          for (final line in lines) {
            final message = line.trim();

            if (message.isNotEmpty) {
              _dataController.add(message);
            }
          }

          break;

        case SerialEventType.connected:
          _isConnected = true;
          _dataController.add('ARDUINO_CONNECTED');
          break;

        case SerialEventType.disconnected:
          _isConnected = false;
          _dataController.add('ARDUINO_DISCONNECTED');
          break;

        case SerialEventType.error:
          _dataController.add('ERROR: ${event.data}');
          break;

        default:
          break;
      }
    });

    final config = SerialConfig(
      baudRate: baudRate,
      dataBits: 8,
      stopBits: 1,
      parity: 0,
      flowControl: 0,
    );

    final success = await _serial.open(portName, config);

    if (!success) {
      _isConnected = false;
      return false;
    }

    _isConnected = true;
    return true;
  }

  void send(String message) {
    if (!_isConnected) return;

    final data = Uint8List.fromList(
      '$message\n'.codeUnits,
    );

    _serial.write(data);
  }

  Future<void> disconnect() async {
    await _serial.close();

    await _eventSubscription?.cancel();
    _eventSubscription = null;

    _receiveBuffer = '';
    _isConnected = false;
  }

  Future<void> dispose() async {
    await disconnect();

    await _serial.dispose();

    await _dataController.close();
  }
}

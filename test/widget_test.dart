import 'package:flutter_test/flutter_test.dart';
import 'package:parking_assistance_app/main.dart';

void main() {
  testWidgets('Parking Assistance app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const ParkingAssistanceApp());

    expect(find.text('PARKING ASSISTANCE'), findsOneWidget);
    expect(find.text('ADVANCED PARKING ASSISTANCE SYSTEM'), findsOneWidget);
  });
}

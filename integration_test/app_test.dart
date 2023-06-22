import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_testing/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Sent OTP with Twilio',
            (tester) async {
          app.main();
          await tester.pumpAndSettle();

          // Verify the counter starts at 0.
          expect(find.text('Click the button to send SMS.'), findsOneWidget);

          // Finds the floating action button to tap on.
          final Finder fab = find.byTooltip('Send OTP');

          // Emulate a tap on the floating action button.
          await tester.tap(fab);

          // Trigger a frame.
          await tester.pumpAndSettle();


          // Verify the counter increments by 1.
          expect(find.text('SMS sent successfully'), findsOneWidget);
        });
  });
}
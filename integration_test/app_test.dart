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

          // Wait for the sendSms() function to complete
          await tester.runAsync(() async {
            // Wait for the delay caused by the Twilio API call
            await Future.delayed(Duration(seconds: 10)); // Adjust the duration as needed

            // Verify that the text is updated correctly
            expect(find.text('OTP Sent to +6287821790323.'), findsOneWidget);
          });


        });
  });
}
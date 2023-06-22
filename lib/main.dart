import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

bool sent = false;

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TwilioFlutter twilioFlutter;

  @override
  void initState() {
    twilioFlutter =
        TwilioFlutter(accountSid: 'AC872590f5d7278a1b718468047175e4ba', authToken: 'a1e5bb33aa48f757dadc6db0f4d64143', twilioNumber: '+15879122372');

    super.initState();
  }

  void sendSms() async {
    twilioFlutter.sendSMS(toNumber: '+6287821790323', messageBody: 'Your OTP is 12345')
        .then((value) {
      // Success callback
      print('SMS sent successfully');
      setState(() {
        sent = true;
      });
    })
        .catchError((error) {
      // Error callback
      print('Failed to send SMS: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    const dbUrl = String.fromEnvironment('DB_URL', defaultValue: 'unknown');
    if (dbUrl.isEmpty) {
      throw AssertionError('DB_URL is not set');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          sent ?
          'OTP Sent to +6287821790323.':'Click the button to send SMS.',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendSms,
        tooltip: 'Send OTP',
        child: Icon(Icons.send),
      ),
    );
  }
}

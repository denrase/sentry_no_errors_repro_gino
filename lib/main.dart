import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init((options) {
    options.dsn = '<YOUR_SENTRY_DSN>';
  }, appRunner: () => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Path Provider Crash Repro')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(),
                const Center(child: CircularProgressIndicator()),
                FilledButton(
                  onPressed: () {
                    try {
                      throw Exception('Test exception');
                    } catch (e, s) {
                      Sentry.captureException(e, stackTrace: s);
                    }
                  },
                  child: Text('click me'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

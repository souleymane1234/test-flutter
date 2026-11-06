import 'package:flutter/widgets.dart';
import 'package:test_app/app.dart';
import 'package:test_app/core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

import 'package:flame_jam_2023/app/app.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.device.fullScreen();

  await Flame.device.setLandscape();

  runApp(
    const App(),
  );
}

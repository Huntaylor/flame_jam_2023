import 'package:flame_jam_2023/chilling_escape.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.device.fullScreen();

  await Flame.device.setLandscape();

  ChillingEscape game = ChillingEscape();
  runApp(
    //Bypasses the reset, debug mode will allow hot reset to reset the game
    GameWidget(game: kDebugMode ? ChillingEscape() : game),
  );
}

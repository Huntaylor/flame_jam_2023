import 'dart:async';

import 'package:chilling_escape/components/player.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class ChillingEscape extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection, TapCallbacks {
  Player player = Player();

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    return super.onLoad();
  }
}

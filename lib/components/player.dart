import 'dart:async';

import 'package:chilling_escape/chilling_escape.dart';
import 'package:flame/components.dart';

enum PlayerState {
  jumping,
  falling,
  idle,
  melting,
  hit,
}

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<ChillingEscape> {
  Player({super.position});

  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }
}

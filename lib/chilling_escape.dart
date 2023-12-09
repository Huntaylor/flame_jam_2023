import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame_jam_2023/components/player.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_jam_2023/levels/level.dart';
import 'package:flame_jam_2023/utils/asset_constants.dart';
import 'package:flutter/painting.dart';

class ChillingEscape extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection, TapCallbacks {
  Player player = Player();

  double worldSpeed = 0;
  Vector2 worldVelocity = Vector2.zero();
  double horizontalMovement = -1;
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;

  List<String> endlessNames = [
    AssetConstants.endless1,
    AssetConstants.endless2,
  ];

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    _loadLevel();

    return super.onLoad();
  }

  void _loadLevel() {
    Level world = Level(
      // levelName: endlessNames[0],
      player: player,
    );

    Viewfinder finder = Viewfinder();
    Offset playerOffset = Offset(player.x + .1, player.y);

    // finder.zoom = .5;
    finder.anchor = Anchor(playerOffset.dx, player.y);

    camera = CameraComponent.withFixedResolution(
      viewfinder: finder,
      world: world,
      width: 640,
      height: 360,
    );

    camera.follow(
      horizontalOnly: true,
      player,
    );

    addAll(
      [camera, world],
    );
  }
}

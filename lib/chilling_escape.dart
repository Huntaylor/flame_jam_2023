import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame_jam_2023/components/background_tile.dart';
import 'package:flame_jam_2023/components/player.dart';
import 'package:flame_jam_2023/game/overlays/game_hud.dart';
import 'package:flame_jam_2023/levels/level.dart';
import 'package:flame_jam_2023/utils/asset_constants.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class ChillingEscape extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection, TapCallbacks {
  Player player = Player();

  Vector2 worldVelocity = Vector2.zero();
  double worldSpeed = 150;
  double horizontalMovement = -1;
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;
  int currentMapIndex = 0;
  int snowflakesCollected = 0;

  late Level level;

  List<String> mapPaths = [
    // AssetConstants.endless1,
    AssetConstants.endless2,
    AssetConstants.endless3,
    // AssetConstants.endless2,
    // AssetConstants.endless2,
    // AssetConstants.endless2,
  ];

  @override
  void update(double dt) {
    if (player.size.x <= 14) {
      pauseEngine();
      overlays.add(AssetConstants.gameOver);
    }
    super.update(dt);
  }

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    _loadLevel();

    return super.onLoad();
  }

  Future<void> _loadLevel() async {
    level = Level(
      // initialLevelName: AssetConstants.endless1,
      levels: mapPaths,
      player: player,
    );

    Viewfinder finder = Viewfinder();
    Offset playerOffset = Offset(player.x + .1, player.y);

    finder.anchor = Anchor(playerOffset.dx, player.y);

    camera = CameraComponent.withFixedResolution(
      viewfinder: finder,
      world: level,
      width: 640,
      height: 360,
      hudComponents: [
        GameHud(),
      ],
    );

    camera.backdrop = BackgroundTile(
      position: Vector2.zero(),
    );
    // finder.zoom = .06;

    camera.follow(
      horizontalOnly: true,
      player,
    );
    addAll(
      [camera, level],
    );
  }
}

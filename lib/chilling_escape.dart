import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame_jam_2023/components/background_tile.dart';
import 'package:flame_jam_2023/components/player.dart';
import 'package:flame_jam_2023/levels/level.dart';
import 'package:flame_jam_2023/utils/asset_constants.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flame_jam_2023/utils/world_manager.dart';
import 'package:flutter/material.dart';

class ChillingEscape extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection, TapCallbacks {
  Player player = Player();

  Vector2 worldVelocity = Vector2.zero();
  double worldSpeed = 100;
  double horizontalMovement = -1;
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;
  int currentMapIndex = 0;

  late WorldManager worldManager;
  late Level currentLevel;
  late Level nextLevel;
  bool isNextLevel = false;

  List<String> mapPaths = [
    // AssetConstants.endless1,
    AssetConstants.endless2,
    AssetConstants.endless2,
    AssetConstants.endless2,
    AssetConstants.endless2,
  ];

  @override
  void update(double dt) {
    // if (isNextLevel) _loadNextLevel();
    if (player.size.x <= 14) {
      pauseEngine();
      overlays.add(AssetConstants.gameOver);
    }
    super.update(dt);
  }

  @override
  FutureOr<void> onLoad() async {
    worldManager = WorldManager(player: player);

    await images.loadAllImages();

    loadCurrentMap();

    return super.onLoad();
  }

  Future<void> loadCurrentMap() async {
    await _loadLevel(mapPaths[currentMapIndex]);
  }

  Future<void> _loadLevel(String mapPath) async {
    if (currentMapIndex == 0) {
      currentLevel = Level(
        levelName: AssetConstants.endless1,
        player: player,
        isFirst: true,
      );

      Viewfinder finder = Viewfinder();
      Offset playerOffset = Offset(player.x + .1, player.y);

      finder.anchor = Anchor(playerOffset.dx, player.y);

      camera = CameraComponent.withFixedResolution(
        viewfinder: finder,
        world: currentLevel,
        width: 640,
        height: 360,
      );

      camera.backdrop = BackgroundTile(
        position: Vector2.zero(),
      );

      camera.follow(
        horizontalOnly: true,
        player,
      );
      addAll(
        [camera, currentLevel],
      );
    } else {
      print('load next world');
      nextLevel = Level(
        levelName: mapPaths[2],
        player: player,
      );
      add(
        nextLevel,
      );
    }
  }

  Future<void> loadNextLevel() async {
    // Check if the player is close to the right edge of the current map
    currentMapIndex++;
    if (currentMapIndex < mapPaths.length) {
      await _loadLevel(mapPaths[currentMapIndex]);
    } else {
      // Handle end of maps, perhaps loop back to the first map
      currentMapIndex = 0;
      await _loadLevel(mapPaths[currentMapIndex]);
    }
  }
}

import 'dart:async';

import 'package:flame_jam_2023/components/background_tile.dart';
import 'package:flame_jam_2023/components/player.dart';
import 'package:flame_jam_2023/levels/level.dart';
import 'package:flame_jam_2023/utils/asset_constants.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flutter/painting.dart';

class ChillingEscape extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection, TapCallbacks {
  // ChillingEscape()
  //     : super(
  //         tileSize: 64,
  //         configuration: const LeapConfiguration(
  //           tiled: TiledOptions(
  //             playerSpawnClass: 'Player',
  //             atlasMaxY: 368,
  //             atlasMaxX: 4048,
  //           ),
  //         ),
  //       );
  Player player = Player();

  double worldSpeed = 100;
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

    //This will remain persistent where ever the player goes!
    camera.backdrop = BackgroundTile(
      position: Vector2.zero(),
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

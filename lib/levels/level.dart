import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame_jam_2023/chilling_escape.dart';
import 'package:flame_jam_2023/components/background_tile.dart';
import 'package:flame_jam_2023/components/collision_block.dart';
import 'package:flame_jam_2023/components/player.dart';
import 'package:flame/components.dart';
import 'package:flame_jam_2023/components/sprite_box.dart';
import 'package:flame_jam_2023/utils/asset_constants.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World with HasGameRef<ChillingEscape>, TapCallbacks {
  // final String levelName;
  late TiledComponent level;
  final Player player;
  final bool isFirst;

  Level({
    // required this.levelName,
    super.children,
    super.priority = -10,
    required this.player,
    this.isFirst = false,
  });

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load(
      AssetConstants.endless1,
      Vector2.all(16),
    );

    add(level);

    _spawningObjects();
    _addCollisions();
    _scrollingBackground();

    return super.onLoad();
  }

  // @override
  // void update(double dt) {
  //   game.accumulatedTime += dt;
  //   while (game.accumulatedTime >= game.fixedDeltaTime) {
  //     _updateSlider(dt);
  //     game.accumulatedTime -= game.fixedDeltaTime;
  //   }
  //   super.update(dt);
  // }

  @override
  void onTapDown(TapDownEvent event) {
    if (player.isOnGround) {
      player.hasJumped = true;
    }
    super.onTapDown(event);
  }

  void _scrollingBackground() {
    final backgroundLayer = level.tileMap.getLayer('Background');

    if (backgroundLayer != null) {
      final backgroundTile = BackgroundTile(
        position: Vector2(0, 0),
      );

      add(backgroundTile);
    }
  }

  void _spawningObjects() {
    final spawnPointLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    if (spawnPointLayer != null) {
      for (final spawnPoint in spawnPointLayer.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
            player.position = Vector2(
              spawnPoint.x,
              spawnPoint.y,
            );
            player.scale.x = 1;
            add(player);
            break;
          case 'WoodBox':
            final block = SpriteBox(
              name: spawnPoint.name,
              position: Vector2(
                spawnPoint.x,
                spawnPoint.y,
              ),
              size: Vector2(
                spawnPoint.width,
                spawnPoint.height,
              ),
            );
            add(block);
            break;
          default:
        }
      }
    }
  }

  void _addCollisions() {
    final collisionsLayer = level.tileMap.getLayer<ObjectGroup>('Collisions');

    if (collisionsLayer != null) {
      for (final collision in collisionsLayer.objects) {
        switch (collision.class_) {
          case 'Ground':
            final block = CollisionBlock(
              position: Vector2(
                collision.x,
                collision.y,
              ),
              size: Vector2(
                collision.width,
                collision.height,
              ),
            );
            // collisionBlock.add(block);
            add(block);
            break;

          default:
            final block = CollisionBlock(
              position: Vector2(
                collision.x,
                collision.y,
              ),
              size: Vector2(
                collision.width,
                collision.height,
              ),
            );
            // collisionBlock.add(block);
            add(block);
            break;
        }
      }
    }
  }

  // void _updateSlider(double dt) {
  //   game.worldVelocity.x = game.horizontalMovement * game.worldSpeed;
  //   // Delta time, dt, allows us to check how many times we have updated in a
  //   // second, then divide by the same amount to stay consistant
  //   level.x += game.worldVelocity.x * dt;
  // }
}

import 'dart:async';

import 'package:flame_jam_2023/chilling_escape.dart';
import 'package:flame_jam_2023/components/collision_block.dart';
import 'package:flame_jam_2023/components/next_level_collision.dart';
import 'package:flame_jam_2023/components/player.dart';
import 'package:flame_jam_2023/components/sprite_box.dart';
import 'package:flame_jam_2023/utils/asset_constants.dart';
import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World with HasGameRef<ChillingEscape>, TapCallbacks {
  final String levelName;
  late TiledComponent level;
  final Player player;
  final bool isFirst;

  Level({
    required this.levelName,
    super.children,
    super.priority = -10,
    required this.player,
    this.isFirst = false,
  });

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load(
      levelName,
      Vector2.all(16),
    );

    add(level);

    _spawningObjects();
    _addCollisions();

    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (player.isOnGround) {
      player.hasJumped = true;
    }
    super.onTapDown(event);
  }

  void _spawningObjects() {
    final spawnPointLayer =
        level.tileMap.getLayer<ObjectGroup>(AssetConstants.spawnpoints);

    if (spawnPointLayer != null) {
      for (final spawnPoint in spawnPointLayer.objects) {
        switch (spawnPoint.class_) {
          case AssetConstants.player:
            if (!isFirst) {
              break;
            }
            player.position = Vector2(
              spawnPoint.x,
              spawnPoint.y,
            );
            player.scale.x = 1;
            add(player);
            break;
          case AssetConstants.woodBox:
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
    final collisionsLayer =
        level.tileMap.getLayer<ObjectGroup>(AssetConstants.collisions);

    if (collisionsLayer != null) {
      for (final collision in collisionsLayer.objects) {
        switch (collision.class_) {
          case AssetConstants.lava:
            final block = LavaBlock(
              position: Vector2(
                collision.x,
                collision.y,
              ),
              size: Vector2(
                collision.width,
                collision.height,
              ),
            );
            add(block);
          case AssetConstants.ground:
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
            add(block);
            break;
          case AssetConstants.nextLevel:
            final block = NextLevelCollision(
              position: Vector2(
                collision.x,
                collision.y,
              ),
              size: Vector2(
                collision.width,
                collision.height,
              ),
            );
            add(block);
            break;
          case AssetConstants.platform:
          default:
            final block = PlatformBlock(
              position: Vector2(
                collision.x,
                collision.y,
              ),
              size: Vector2(
                collision.width,
                collision.height,
              ),
            );
            add(block);
            break;
        }
      }
    }
  }
}

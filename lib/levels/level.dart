import 'dart:async';
import 'dart:math';

import 'package:flame_jam_2023/chilling_escape.dart';
import 'package:flame_jam_2023/components/collision_block.dart';
import 'package:flame_jam_2023/components/player.dart';
import 'package:flame_jam_2023/components/snowflake.dart';
import 'package:flame_jam_2023/components/sprite_box.dart';
import 'package:flame_jam_2023/components/sunshine.dart';
import 'package:flame_jam_2023/utils/asset_constants.dart';
import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World with HasGameRef<ChillingEscape>, TapCallbacks {
  final List<String> levels;
  final Player player;
  List<TiledComponent> loadedLevels = [];

  Level({
    required this.levels,
    super.children,
    super.priority = -10,
    required this.player,
  });

  @override
  FutureOr<void> onLoad() async {
    final segmentsToLoad = (game.size.x / 640).ceil();
    segmentsToLoad.clamp(0, levels.length);

    for (var i = 0; i <= segmentsToLoad; i++) {
      await loadGameSegments(i, (640 * i).toDouble());
    }

    levels.removeAt(0);

    return super.onLoad();
  }

  Future<void> loadGameSegments(
      int segmentIndex, double xPositionOffset) async {
    final level = await TiledComponent.load(
      levels[segmentIndex],
      Vector2.all(16),
    );
    level.position = Vector2(xPositionOffset, 0);
    _addCollisions(level, xPositionOffset);
    _spawningObjects(level, xPositionOffset);
    loadedLevels.add(level);
    add(level);
  }

  @override
  void update(double dt) {
    //Removes tiles past the player
    final List<TiledComponent> pastLevels = [];
    final int index = loadedLevels.indexWhere(
      (element) =>
          !game.camera.canSee(element) &&
          player.position.x > element.position.x,
    );
    if (index >= 0) {
      pastLevels.add(loadedLevels[index]);
    }

    if (pastLevels.isNotEmpty) {
      removeAll(pastLevels);
      pastLevels.removeAt(index);
      loadedLevels.removeAt(index);
      loadGameSegments(
        Random().nextInt(levels.length),
        loadedLevels.last.x + 640,
      );
    }

    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (player.isOnGround) {
      player.hasJumped = true;
    }
    super.onTapDown(event);
  }

  void _spawningObjects(TiledComponent level, double xPositionOffset) {
    final spawnPointLayer =
        level.tileMap.getLayer<ObjectGroup>(AssetConstants.spawnpoints);

    if (spawnPointLayer != null) {
      for (final spawnPoint in spawnPointLayer.objects) {
        switch (spawnPoint.class_) {
          case AssetConstants.player:
            player.position = Vector2(
              spawnPoint.x,
              spawnPoint.y,
            );
            player.scale.x = 1;
            add(player);
            break;
          case AssetConstants.woodBox:
            final block = SpriteBox(
              xOffset: xPositionOffset,
              gridPosition: Vector2(
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
          case AssetConstants.snowflake:
            final block = SnowflakeSprite(
              xOffset: xPositionOffset,
              gridPosition: Vector2(
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
          case AssetConstants.sunshine:
            final block = Sunshine(
              xOffset: xPositionOffset,
              gridPosition: Vector2(
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

  void _addCollisions(TiledComponent level, double xPositionOffset) {
    final collisionsLayer =
        level.tileMap.getLayer<ObjectGroup>(AssetConstants.collisions);

    if (collisionsLayer != null) {
      for (final collision in collisionsLayer.objects) {
        switch (collision.class_) {
          case AssetConstants.lava:
            final block = LavaBlock(
              xOffset: xPositionOffset,
              gridPosition: Vector2(
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
              xOffset: xPositionOffset,
              gridPosition: Vector2(
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
          case AssetConstants.outOfBounds:
            final block = OutOfBoundsBlock(
              xOffset: xPositionOffset,
              gridPosition: Vector2(
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
              xOffset: xPositionOffset,
              gridPosition: Vector2(
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

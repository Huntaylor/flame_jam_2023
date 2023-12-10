import 'dart:async';

import 'package:flame_audio/flame_audio.dart';
import 'package:flame_jam_2023/chilling_escape.dart';
import 'package:flame_jam_2023/utils/asset_constants.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class SnowflakeSprite extends SpriteComponent with HasGameRef<ChillingEscape> {
  final Vector2 gridPosition;
  double xOffset;
  SnowflakeSprite({
    required this.gridPosition,
    required this.xOffset,
    super.sprite,
    super.size,
  });
  bool _collected = false;

  @override
  FutureOr<void> onLoad() {
    position = Vector2(
      gridPosition.x + xOffset,
      gridPosition.y,
    );
    priority = -1;
    _loadSprites();
    add(
      CircleHitbox(
        isSolid: true,
        collisionType: CollisionType.passive,
      ),
    );
    return super.onLoad();
  }

  void _loadSprites() {
    final snowflakeImage = game.images.fromCache(AssetConstants.snowflakeSprie);

    sprite = Sprite(snowflakeImage);
  }

  void collideWithPlayer() {
    if (!_collected) {
      if (game.playSounds) {
        FlameAudio.play(
          AssetConstants.pickUpAudio,
          volume: game.soundVolume,
        );
      }
      ++game.snowflakesCollected;
    }
    _collected = true;
    removeFromParent();
  }
}

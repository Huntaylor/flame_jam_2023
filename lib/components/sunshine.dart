import 'dart:async';

import 'package:flame_jam_2023/chilling_escape.dart';
import 'package:flame_jam_2023/utils/asset_constants.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Sunshine extends SpriteComponent with HasGameRef<ChillingEscape> {
  final Vector2 gridPosition;
  double xOffset;
  Sunshine({
    required this.gridPosition,
    required this.xOffset,
    super.sprite,
    super.size,
  });
  bool isPlaying = false;

  @override
  FutureOr<void> onLoad() {
    position = Vector2(
      gridPosition.x + xOffset,
      gridPosition.y,
    );
    priority = 15;
    _loadSprites();
    add(
      RectangleHitbox(
        isSolid: true,
        collisionType: CollisionType.passive,
      ),
    );
    return super.onLoad();
  }

  void _loadSprites() {
    final sunshineImage = game.images.fromCache(AssetConstants.sunshineSprite);

    sprite = Sprite(sunshineImage);
  }
}

import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_jam_2023/chilling_escape.dart';
import 'package:flame_jam_2023/utils/asset_constants.dart';

class SpriteBox extends SpriteComponent with HasGameRef<ChillingEscape> {
  SpriteBox({
    required this.name,
    super.position,
    super.sprite,
    super.size,
  });
  final String name;
  late final Sprite normalSprite;

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
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
    final boxImage = game.images.fromCache(
      AssetConstants.boxSprite(
        name,
      ),
    );
    normalSprite = Sprite(boxImage);

    sprite = normalSprite;
  }

  // @override
  // void update(double dt) {
  //   if (!game.camera.canSee(this) && game.player.x > x) _removeSprite();

  //   super.update(dt);
  // }

  // void _removeSprite() {
  //   removeFromParent();
  // }
}

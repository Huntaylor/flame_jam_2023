import 'dart:async';

import 'package:flame_jam_2023/chilling_escape.dart';
import 'package:flame_jam_2023/utils/asset_constants.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum PlayerState {
  jumping,
  falling,
  idle,
  melting,
  hit,
}

class Player extends SpriteGroupComponent with HasGameRef<ChillingEscape> {
  Player({super.position})
      : super(
          size: Vector2.all(32),
        );

  late final Sprite idleSprite;

  @override
  FutureOr<void> onLoad() {
    _loadSprites();
    add(
      RectangleHitbox(
        collisionType: CollisionType.active,
      ),
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }

  void _loadSprites() {
    final iceImage = game.images.fromCache(AssetConstants.playerSprite);
    idleSprite = Sprite(iceImage);
  }
}

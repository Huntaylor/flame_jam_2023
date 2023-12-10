import 'dart:async';

import 'package:flame_jam_2023/chilling_escape.dart';
import 'package:flame_jam_2023/utils/asset_constants.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum SpriteState {
  normal,
  frozen,
}

class SpriteBox extends SpriteGroupComponent
    with HasGameRef<ChillingEscape>, CollisionCallbacks {
  final Vector2 gridPosition;
  double xOffset;
  SpriteBox({
    required this.gridPosition,
    required this.xOffset,
    super.current,
    super.size,
  });
  late final Sprite normalSprite;
  late final Sprite frozenSprite;
  bool isFrozen = false;

  @override
  FutureOr<void> onLoad() {
    position = Vector2(
      gridPosition.x + xOffset,
      gridPosition.y,
    );
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
        AssetConstants.normalBoxSprite,
      ),
    );
    final frozenImage = game.images.fromCache(
      AssetConstants.boxSprite(
        AssetConstants.frozenBoxSprite,
      ),
    );
    normalSprite = Sprite(boxImage);
    frozenSprite = Sprite(frozenImage);

    sprites = {
      SpriteState.normal: normalSprite,
      SpriteState.frozen: frozenSprite,
    };
    // Set current animation
    current = SpriteState.normal;
  }

  @override
  void update(double dt) {
    _updateBoxState();
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    isFrozen = true;
    super.onCollision(intersectionPoints, other);
  }

  void _updateBoxState() {
    SpriteState spriteState = SpriteState.normal;
    if (isFrozen) {
      spriteState = SpriteState.frozen;
    }
    current = spriteState;
  }
}

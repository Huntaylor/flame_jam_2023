import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class CollisionBlock extends PositionComponent {
  CollisionBlock({
    super.position,
    super.size,
  });

  @override
  FutureOr<void> onLoad() {
    add(
      RectangleHitbox(
        isSolid: true,
        collisionType: CollisionType.passive,
      ),
    );
    return super.onLoad();
  }
}

class PlatformBlock extends PositionComponent {
  PlatformBlock({
    super.position,
    super.size,
  });
  @override
  FutureOr<void> onLoad() {
    add(
      RectangleHitbox(
        isSolid: true,
        collisionType: CollisionType.passive,
      ),
    );
    return super.onLoad();
  }
}

class LavaBlock extends PositionComponent {
  LavaBlock({
    super.position,
    super.size,
  });
  @override
  FutureOr<void> onLoad() {
    add(
      RectangleHitbox(
        isSolid: true,
        collisionType: CollisionType.passive,
      ),
    );
    return super.onLoad();
  }
}

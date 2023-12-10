import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class NextLevelCollision extends PositionComponent {
  NextLevelCollision({
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

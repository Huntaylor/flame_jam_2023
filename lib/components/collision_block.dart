import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_jam_2023/chilling_escape.dart';

class CollisionBlock extends PositionComponent with HasGameRef<ChillingEscape> {
  final Vector2 gridPosition;
  double xOffset;
  CollisionBlock({
    required this.gridPosition,
    required this.xOffset,
    // super.position,
    super.size,
  });

  @override
  FutureOr<void> onLoad() {
    position = Vector2(
      gridPosition.x + xOffset,
      gridPosition.y,
    );
    add(
      RectangleHitbox(
        isSolid: true,
        collisionType: CollisionType.passive,
      ),
    );
    return super.onLoad();
  }
}

class PlatformBlock extends PositionComponent with HasGameRef<ChillingEscape> {
  final Vector2 gridPosition;
  double xOffset;
  PlatformBlock({
    required this.gridPosition,
    required this.xOffset,
    // super.position,
    super.size,
  });
  @override
  FutureOr<void> onLoad() {
    position = Vector2(
      gridPosition.x + xOffset,
      gridPosition.y,
    );
    add(
      RectangleHitbox(
        isSolid: true,
        collisionType: CollisionType.passive,
      ),
    );
    return super.onLoad();
  }
}

class LavaBlock extends PositionComponent with HasGameRef<ChillingEscape> {
  final Vector2 gridPosition;
  double xOffset;
  LavaBlock({
    required this.gridPosition,
    required this.xOffset,
    // super.position,
    super.size,
  });
  @override
  FutureOr<void> onLoad() {
    position = Vector2(
      gridPosition.x + xOffset,
      gridPosition.y,
    );
    add(
      RectangleHitbox(
        isSolid: true,
        collisionType: CollisionType.passive,
      ),
    );
    return super.onLoad();
  }
}

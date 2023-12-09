import 'dart:async';

import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame_jam_2023/chilling_escape.dart';
import 'package:flame_jam_2023/components/collision_block.dart';
import 'package:flame_jam_2023/components/sprite_box.dart';
import 'package:flame_jam_2023/utils/asset_constants.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

enum PlayerState {
  jumping,
  falling,
  idle,
  melting,
  hit,
}

class Player extends SpriteComponent
    with HasGameRef<ChillingEscape>, KeyboardHandler, CollisionCallbacks {
  Player({
    super.position,
    super.sprite,
    super.scale,
  }) : super(
          anchor: Anchor.center,
          priority: 1,
          size: Vector2.all(32),
        );

  late final Sprite idleSprite;
  late RectangleHitbox hitbox;
  late RotateEffect rotate;

  final double _jumpForce = 415;
  final double _terminalVelocity = 500;
  final double _gravity = 21.8;
  final double rotationSpeed = 2.5;
  Vector2 spawnPoint = Vector2.zero();
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;
  double horizontalMovement = 1;
  bool hasJumped = false;
  bool isOnGround = false;
  bool isInAir = false;

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    _loadSprites();
    hitbox = RectangleHitbox(
      isSolid: true,
      collisionType: CollisionType.active,
    );
    add(hitbox);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    accumulatedTime += dt;
    while (accumulatedTime >= fixedDeltaTime) {
      _updatePlayerMovement(fixedDeltaTime);
      _applyGravity(fixedDeltaTime);
      accumulatedTime -= fixedDeltaTime;
    }
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    hasJumped = keysPressed.contains(LogicalKeyboardKey.space);

    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is CollisionBlock) {
      isInAir = position.y < other.y;
      if (game.worldVelocity.y > 0) {
        // _gravity = 0;
        game.worldVelocity.y = 0;

        position.y = other.y - (height / 2) - hitbox.y;
        isInAir = false;
        isOnGround = true;
      }
    }
    if (other is SpriteBox) {
      isInAir = position.y < other.y;

      if (game.worldVelocity.y > 0 && isInAir) {
        game.worldVelocity.y = 0;

        position.y = other.y - (height / 2) - hitbox.y;
        isInAir = false;
        isOnGround = true;
        if (!rotate.controller.completed && other.x <= x) {
          rotate.controller.setToEnd();
        }
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  void _loadSprites() {
    final iceImage = game.images.fromCache(AssetConstants.playerSprite);
    idleSprite = Sprite(iceImage);

    sprite = idleSprite;
  }

  void _applyGravity(dt) {
    game.worldVelocity.y += _gravity;
    game.worldVelocity.y =
        game.worldVelocity.y.clamp(-_jumpForce, _terminalVelocity);
    position.y += game.worldVelocity.y * dt;
  }

  void _updatePlayerMovement(double dt) {
    if (hasJumped && isOnGround) {
      _rotate(dt);
      _playerJumped(dt);
    }
    game.worldVelocity.x = horizontalMovement * game.worldSpeed;
    // Delta time, dt, allows us to check how many times we have updated in a
    // second, then divide by the same amount to stay consistant
    position.x += game.worldVelocity.x * dt;
  }

  void _playerJumped(dt) {
    // _gravity = 21.8;
    game.worldVelocity.y = -_jumpForce;
    position.y += game.worldVelocity.y * dt;
    hasJumped = false;
    isOnGround = false;
    isInAir = true;
  }

  void _rotate(double dt) {
    rotate = RotateEffect.by(
      tau / 4,
      EffectController(
        speed: rotationSpeed,
      ),
    );

    add(rotate);
  }
}

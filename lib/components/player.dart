import 'dart:async';

import 'package:flame_audio/flame_audio.dart';
import 'package:flame_jam_2023/chilling_escape.dart';
import 'package:flame_jam_2023/components/collision_block.dart';
import 'package:flame_jam_2023/components/snowflake.dart';
import 'package:flame_jam_2023/components/sprite_box.dart';
import 'package:flame_jam_2023/components/sunshine.dart';
import 'package:flame_jam_2023/utils/asset_constants.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

enum PlayerState {
  normal,
  halfwayMelted,
  almostMelted,
  melted,
}

class Player extends SpriteGroupComponent
    with HasGameRef<ChillingEscape>, KeyboardHandler, CollisionCallbacks {
  Player({
    super.position,
    super.current,
    super.scale,
  }) : super(
          anchor: Anchor.center,
          priority: 1,
          size: Vector2.all(32),
        );

  late final Sprite normalSprite;
  late final Sprite halfwayMeltedSprite;
  late final Sprite almostMeltedSprite;
  late final Sprite meltedSprite;
  late RectangleHitbox hitbox;
  late RotateEffect rotate;
  late PlayerState playerState;

  final double _jumpForce = 415;
  final double _terminalVelocity = 500;
  final double _gravity = 21.8;
  final double rotationSpeed = 2.5;
  Vector2 maxSize = Vector2.all(32);
  Vector2 currentSize = Vector2.zero();
  Vector2 spawnPoint = Vector2.zero();
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;
  double horizontalMovement = 1;
  bool hasJumped = false;
  bool isOnGround = false;
  bool isInAir = false;
  bool playingSound = false;
  int playCount = 0;

  bool collectedSnowflake = false;

  @override
  FutureOr<void> onLoad() {
    playerState = PlayerState.normal;
    currentSize = size;
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
      _updatePlayerState();
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
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) async {
    if (other is SnowflakeSprite) {
      other.collideWithPlayer();
      _collectedSnowflake();
    }
    if (other is LavaBlock || other is Sunshine) {
      _playMeltSound();
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is CollisionBlock) {
      isInAir = position.y < other.y;
      if (game.worldVelocity.y > 0) {
        game.worldVelocity.y = 0;

        position.y = other.y - (height / 2) - hitbox.y;
        isInAir = false;
        isOnGround = true;
      }
    }
    if (other is OutOfBoundsBlock) {
      position.y = other.y + other.height;
      isInAir = false;
      isOnGround = true;
    }
    if (other is LavaBlock || other is LavaBlock && other is PlatformBlock) {
      _meltPlayer();

      isInAir = position.y < other.y;
      if (game.worldVelocity.y > 0 && isInAir) {
        game.worldVelocity.y = 0;

        position.y = other.y - (height / 2) - hitbox.y;
        isInAir = false;
        isOnGround = true;
      }
    }
    if (other is Sunshine) {
      _meltPlayer();
    }
    if (other is SpriteBox || other is PlatformBlock) {
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
    final iceImage = game.images.fromCache(AssetConstants.normalPlayerSprite);
    normalSprite = Sprite(iceImage);

    final stage1Image =
        game.images.fromCache(AssetConstants.stage1PlayerSprite);
    halfwayMeltedSprite = Sprite(stage1Image);

    final stage2Image =
        game.images.fromCache(AssetConstants.stage2PlayerSprite);
    almostMeltedSprite = Sprite(stage2Image);

    final meltedImage =
        game.images.fromCache(AssetConstants.meltedPlayerSprite);
    meltedSprite = Sprite(meltedImage);

    sprites = {
      PlayerState.normal: normalSprite,
      PlayerState.halfwayMelted: halfwayMeltedSprite,
      PlayerState.almostMelted: almostMeltedSprite,
      PlayerState.melted: meltedSprite,
    };
    current = PlayerState.normal;
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

    position.x += game.worldVelocity.x * dt;
  }

  void _playerJumped(dt) async {
    if (game.playSounds) {
      FlameAudio.play(
        AssetConstants.jumpAudio,
        volume: game.soundVolume,
      );
    }
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

  void _meltPlayer() async {
    currentSize = size / 1.0029;
    size = currentSize;
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.normal;

    if (size.x <= 26) {
      playerState = PlayerState.halfwayMelted;
    }
    if (size.x <= 20) {
      playerState = PlayerState.almostMelted;
    }
    if (size.x <= 14) {
      playerState = PlayerState.melted;
    }

    current = playerState;
  }

  void _collectedSnowflake() {
    if (currentSize.x <= maxSize.x) {
      currentSize = currentSize * 1.05;
      size = currentSize;

      if (size.x >= maxSize.x) {
        size = Vector2.all(32);
      }
    } else {
      size = Vector2.all(32);
    }
  }

  void _playMeltSound() {
    if (game.playSounds) {
      if (playCount < 3 && !playingSound) {
        playingSound = true;
        playCount++;
        FlameAudio.play(
          AssetConstants.meltingAudio,
          volume: game.soundVolume,
        );
        Future.delayed(const Duration(seconds: 3), () {
          playCount = 0;
          playingSound = false;
        });
      }
    }
  }
}

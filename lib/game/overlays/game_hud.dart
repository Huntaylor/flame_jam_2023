import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_jam_2023/chilling_escape.dart';
import 'package:flame_jam_2023/utils/asset_constants.dart';
import 'package:flutter/material.dart';

class GameHud extends PositionComponent with HasGameRef<ChillingEscape> {
  GameHud({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 5,
  });

  late TextComponent _scoreTextComponent;

  @override
  FutureOr<void> onLoad() async {
    _scoreTextComponent = TextComponent(
      text: '${game.snowflakesCollected}',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 32,
          color: Color.fromRGBO(7, 28, 182, 1),
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(
        game.size.x - 60,
        20,
      ),
    );
    add(_scoreTextComponent);

    final snowflakeSprite =
        await game.loadSprite(AssetConstants.snowflakeSprie);
    add(
      SpriteComponent(
        sprite: snowflakeSprite,
        position: Vector2(
          game.size.x - 100,
          20,
        ),
        size: Vector2.all(32),
        anchor: Anchor.center,
      ),
    );
  }

  @override
  void update(double dt) {
    _scoreTextComponent.text = '${game.snowflakesCollected}';
  }
}

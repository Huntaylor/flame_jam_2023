import 'dart:async';

import 'package:flame_jam_2023/utils/asset_constants.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class BackgroundTile extends ParallaxComponent {
  BackgroundTile({
    super.position,
    super.priority = -10,
    super.anchor,
  });

  final double scrollSpeed = 40;

  @override
  FutureOr<void> onLoad() async {
    priority = -10;
    size = Vector2.all(64);

    parallax = await game.loadParallax(
      [
        ParallaxImageData(AssetConstants.backgroundTile),
      ],
      baseVelocity: Vector2(
        40,
        -scrollSpeed,
      ),
      repeat: ImageRepeat.repeat,
      fill: LayerFill.none,
    );

    return super.onLoad();
  }
}

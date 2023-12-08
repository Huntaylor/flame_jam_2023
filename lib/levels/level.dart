import 'dart:async';

import 'package:chilling_escape/chilling_escape.dart';
import 'package:chilling_escape/components/player.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World with HasGameRef<ChillingEscape> {
  final String levelName;
  late TiledComponent level;
  final Player player;

  Level({
    required this.levelName,
    super.children,
    super.priority,
    required this.player,
  });

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load(
      levelName,
      Vector2.all(16),
    );

    add(level);

    _spawningObjects();

    return super.onLoad();
  }

  void _spawningObjects() {
    final spawnPointLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    if (spawnPointLayer != null) {
      for (final spawnPoint in spawnPointLayer.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
            player.position = Vector2(
              spawnPoint.x,
              spawnPoint.y,
            );
            player.scale.x = 1;
            add(player);
            break;
          default:
        }
      }
    }
  }
}

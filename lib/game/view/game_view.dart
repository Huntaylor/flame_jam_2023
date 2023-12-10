import 'package:flame/game.dart';
import 'package:flame_jam_2023/chilling_escape.dart';
import 'package:flame_jam_2023/game/overlays/background.dart';
import 'package:flame_jam_2023/game/overlays/game_over.dart';
import 'package:flame_jam_2023/game/overlays/main_menu.dart';
import 'package:flame_jam_2023/utils/asset_constants.dart';
import 'package:flutter/material.dart';

class MyGame extends StatelessWidget {
  const MyGame({super.key});

  static PageRoute<void> route() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => const MyGame(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Material(child: GameView());
  }
}

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // if (kDebugMode)
          //   GameWidget(game: ChillingEscape())
          // else
          GameWidget<ChillingEscape>.controlled(
            backgroundBuilder: (context) => const GrayBackground(),
            loadingBuilder: (context) => const GameBackground(),
            gameFactory: () => ChillingEscape(),
            overlayBuilderMap: {
              AssetConstants.mainMenu: (_, game) => const MainMenu(),
              AssetConstants.gameOver: (_, game) => GameOver(game: game),
            },
            // initialActiveOverlays: const [AssetConstants.mainMenu],
          ),

          // Add additional ui components
        ],
      ),
    );
  }
}

import 'package:flame/game.dart';
import 'package:flame_jam_2023/chilling_escape.dart';
import 'package:flame_jam_2023/game/overlays/main_menu.dart';
import 'package:flutter/foundation.dart';
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
          if (kDebugMode)
            GameWidget(game: ChillingEscape())
          else
            GameWidget<ChillingEscape>.controlled(
              // backgroundBuilder: (context) =>,
              gameFactory: () => ChillingEscape(),
              overlayBuilderMap: {
                'MainMenu': (_, game) {
                  game.pauseEngine();
                  return MainMenu(game: game);
                }
              },
              initialActiveOverlays: const ['MainMenu'],
            ),

          // Add additional ui components
        ],
      ),
    );
  }
}

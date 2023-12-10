import 'package:flame_jam_2023/chilling_escape.dart';
import 'package:flame_jam_2023/utils/asset_constants.dart';
import 'package:flutter/material.dart';

class PauseMenu extends StatefulWidget {
  final ChillingEscape game;
  const PauseMenu({
    super.key,
    required this.game,
  });

  @override
  State<PauseMenu> createState() => _PauseMenuState();
}

class _PauseMenuState extends State<PauseMenu> {
  @override
  Widget build(BuildContext context) {
    const blackTextColor = Color.fromRGBO(7, 28, 182, 1);
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 300,
          width: 300,
          decoration: const BoxDecoration(
            color: blackTextColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Paused',
                style: TextStyle(
                  color: whiteTextColor,
                  fontSize: 24,
                ),
              ),
              Switch.adaptive(
                value: widget.game.playSounds,
                onChanged: (value) {
                  setState(() {
                    widget.game.playSounds = value;
                  });
                },
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    widget.game.overlays.remove(AssetConstants.pauseMenu);
                    widget.game.resumeEngine();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteTextColor,
                  ),
                  child: const Text(
                    'Resume',
                    style: TextStyle(
                      fontSize: 28,
                      color: blackTextColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    widget.game.pauseEngine();
                    widget.game.overlays.remove(AssetConstants.gameOver);
                    widget.game.overlays.add(AssetConstants.mainMenu);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteTextColor,
                  ),
                  child: const Text(
                    'Main Menu',
                    style: TextStyle(
                      fontSize: 28,
                      color: blackTextColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

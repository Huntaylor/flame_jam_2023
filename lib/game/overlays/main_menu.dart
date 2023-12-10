import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_jam_2023/game/overlays/background.dart';
import 'package:flame_jam_2023/game/overlays/info.dart';
import 'package:flame_jam_2023/game/view/game_view.dart';
import 'package:flame_jam_2023/utils/asset_constants.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({
    super.key,
  });

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool isPlaying = true;
  bool isLoading = false;
  @override
  void initState() {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play(
      AssetConstants.menuMusic,
      volume: 0.5,
    );
    isPlaying = FlameAudio.bgm.isPlaying;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Color.fromRGBO(7, 28, 182, 1);
    const whiteTextColor = Color.fromRGBO(155, 197, 255, 1);
    if (isPlaying) {
      FlameAudio.bgm.pause();
    } else {
      FlameAudio.bgm.resume();
    }

    return Scaffold(
      body: Stack(
        children: [
          const GameBackground(),
          Center(
            child: IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: blackTextColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Chilling Escape!',
                      style: TextStyle(
                        color: whiteTextColor,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Music',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: whiteTextColor,
                        fontSize: 14,
                      ),
                    ),
                    Switch.adaptive(
                      value: isPlaying,
                      onChanged: (value) {
                        setState(() {
                          isPlaying = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() async {
                            isLoading = true;
                            await Flame.images.loadAllImages().whenComplete(
                              () {
                                isLoading = false;
                                Navigator.of(context).push(
                                  MyGame.route(),
                                );
                              },
                            );
                          });
                        },
                        child: const Text(
                          'Play',
                          style: TextStyle(
                            fontSize: 40,
                            color: blackTextColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () {
                          FlameAudio.bgm.pause();
                          Navigator.of(context).push(InfoView.route());
                        },
                        child: const Text(
                          'Info',
                          style: TextStyle(
                            fontSize: 40,
                            color: blackTextColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Expanded(
                      child: Text(
                        'Tap/Spacebar to jump!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: whiteTextColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    if (isLoading) const LinearProgressIndicator()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

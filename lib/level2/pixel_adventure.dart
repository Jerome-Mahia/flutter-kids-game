import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hive/hive.dart';
import 'package:pixel_adventure/level2/level.dart';
import 'package:pixel_adventure/level2/player.dart';
import 'package:pixel_adventure/level3/game/dino_run.dart';
import 'package:pixel_adventure/level3/game/game.dart';
import 'package:pixel_adventure/level3/models/player_data.dart';
import 'package:pixel_adventure/level3/models/settings.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  double objectSpeed = 100.0;

  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late final CameraComponent cam;
  Player player = Player(character: 'Virtual Guy');
  late JoystickComponent joystick;
  bool showJoystick = false;

  @override
  FutureOr<void> onLoad() async {
    // Load all images into cache
    await images.loadAllImages();

    final world = Level(
      player: player,
      levelName: 'Level-02',
    );

    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);

    if (showJoystick) {
      addJoystick();
    }
    Future<void> initHive() async {
      Hive.registerAdapter<PlayerData>(PlayerDataAdapter());
      Hive.registerAdapter<Settings>(SettingsAdapter());
    }

    // void goToDinoPage() {
    //   // Wait for 5 seconds (or any duration you want) and then navigate to the Dino page
    //   const duration = Duration(seconds: 8);
    //   DinoRun dinoRun = DinoRun();
    //   Future.delayed(duration, () async {
    //     await initHive();
    //     runApp(
    //       const DinoRunApp(),
    //     );
    //   });
    // }

    // goToDinoPage();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showJoystick) {
      updateJoystick();
    }
    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 32, bottom: 32),
    );

    add(joystick);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }
}

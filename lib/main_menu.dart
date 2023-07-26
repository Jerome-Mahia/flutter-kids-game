import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pixel_adventure/level1/level1.dart';
import 'package:pixel_adventure/level2/pixel_adventure.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  PixelAdventure game = PixelAdventure();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF211F30),
      body: Stack(
        children: [
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column( 
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFC744),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFF37319D),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF37319D),
                              blurRadius: 8,
                              offset: Offset(4, 6),
                              blurStyle: BlurStyle.solid
                            ),
                          ],
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: const Text(
                            'Tech',
                            style: TextStyle(
                              fontSize: 60,
                              color: Color(0xFF37319D),
                              fontFamily: 'Pixel',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 100,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Color(0xFF40B5E8),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFF37319D),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF37319D),
                              blurRadius: 8,
                              offset: Offset(4, 6),
                              blurStyle: BlurStyle.solid
                            ),
                          ],
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: const Text(
                            'Trek',
                            style: TextStyle(
                              fontSize: 60,
                              color: Color(0xFF37319D),
                              fontFamily: 'Pixel',
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF37319D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Level1()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Start Game',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 16),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //       return const CharacterSelect();
                  //     }));
                  //   },
                  //   child: const Text('Select Character'),
                  // ),
                  // const SizedBox(height: 16),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, '/credits');
                  //   },
                  //   child: const Text('Credits'),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

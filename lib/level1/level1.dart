import 'dart:async';
import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/level1/const.dart';
import 'package:pixel_adventure/level1/util/my_button.dart';
import 'package:pixel_adventure/level1/util/result_message.dart';
import 'package:pixel_adventure/level2/pixel_adventure.dart';
import 'package:pixel_adventure/level3/game/dino_run.dart';

class Level1 extends StatefulWidget {
  const Level1({Key? key}) : super(key: key);

  @override
  State<Level1> createState() => _Level1State();
}

class _Level1State extends State<Level1> {
  // number pad list
  List<String> numberPad = [
    '0',
    '1',
    'DEL',
    'CAL',
  ];

  // number A, number B
  int numberA = 0;
  int numberB = 1;

  // user answer
  String userAnswer = '';

  // user tapped a button
  void buttonTapped(String button) {
    setState(() {
      if (button == 'CAL') {
        // calculate if user is correct or incorrect
        checkResult();
      } else if (button == 'C') {
        // clear the input
        userAnswer = '';
      } else if (button == 'DEL') {
        // delete the last number
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else if (userAnswer.length < 3) {
        // maximum of 3 numbers can be inputted
        userAnswer += button;
      }
    });
  }

  int score = 0;
  int maxLevelScore = 4;
  // check if user is correct or not
  void checkResult() {
    if (score == maxLevelScore) {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: 'Congratulations! You have completed level 1!',
              onTap: goToNextLevel,
              icon: Icons.arrow_forward,
            );
          });
    }
    if ((numberA == 1 && numberB == 1) == (int.parse(userAnswer) == 0)) {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: 'Yaaay! You got it right!',
              onTap: goToNextQuestion,
              icon: Icons.arrow_forward,
            );
          });
    } else if (((numberA == 1 && numberB == 0) ||
            (numberA == 0 && numberB == 1)) ==
        (int.parse(userAnswer) == 1)) {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: 'Yaaay! You got it right!',
              onTap: goToNextQuestion,
              icon: Icons.arrow_forward,
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: 'Oops! Try again.',
              onTap: goBackToQuestion,
              icon: Icons.rotate_left,
            );
          });
    }
  }

  // create random numbers
  var randomNumber = Random();

  // GO TO NEXT QUESTION
  void goToNextQuestion() {
    // dismiss alert dialog
    Navigator.of(context).pop();

if(score != maxLevelScore){
  setState(() {
      score++;
    });
    // reset values
    setState(() {
      userAnswer = '';
    });

    // create a new question
    Random randomNumber = new Random();
    numberA = randomNumber.nextInt(2); // Generates 0 or 1
    numberB = randomNumber.nextInt(2); // Generates 0 or 1
}
    
    
  }

  void startTimer() {
    const duration = Duration(seconds: 10);

    Future.delayed(duration, () {
      goToNextLevel();
    });
  }

  PixelAdventure game = PixelAdventure();
  // GO TO NEXT Level
  void goToNextLevel() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameWidget(game: game)),
    );
  }

  // GO BACK TO QUESTION
  void goBackToQuestion() {
    // dismiss alert dialog
    Navigator.of(context).pop();
  }

  void showBanner() {
    showDialog(
        context: context,
        builder: (context) {
          return Column(
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
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Level 1: Binary Addition',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '0 plus 1 is 1',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '1 plus 1 is 0',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '0 plus 0 is 0',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF40B5E8),
        body: Column(
          children: [
            // level progress, player needs 5 correct answers in a row to proceed to next level
            Container(
              height: 160,
              color: Color(0xFF37319D),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Level 1: ',
                          style: whiteTextStyle,
                        ),
                        Text(
                          'Binary Addition',
                          style: whiteTextStyle,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      '${score}/${maxLevelScore}',
                      style: whiteTextStyle,
                    ),
                  ],
                ),
              ),
            ),

            // question
            Expanded(
              child: Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'What is: ',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // question

                          Text(
                            numberA.toString() +
                                ' + ' +
                                numberB.toString() +
                                ' = ',
                            style: TextStyle(
                              fontSize: 70,
                              color: Colors.white,
                            ),
                          ),

                          // answer box
                          Container(
                            height: 100,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Color(0xFF37319D),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                userAnswer,
                                style: whiteTextStyle,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // number pad
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: GridView.builder(
                  itemCount: numberPad.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (context, index) {
                    return MyButton(
                      child: numberPad[index],
                      onTap: () => buttonTapped(numberPad[index]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

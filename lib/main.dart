import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game_env/game.dart';

main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final myGame = MyGame();
    return MaterialApp(
      title: "Pothos",
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Pothos")),
          backgroundColor: Colors.green,
        ),
        body: GameWidget(
          game: myGame,
        ),
      ),
    );
  }
}

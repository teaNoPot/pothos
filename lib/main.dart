import 'dart:developer';

import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'game_env/game.dart';

main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pothos",
      home: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text("Pothos")),
            backgroundColor: Colors.green,
          ),
          body: const PothosBody()),
    );
  }
}


class PothosBody extends StatefulWidget {
  const PothosBody({super.key});

  @override
  _PothosBodyState createState() => _PothosBodyState();
}


class _PothosBodyState extends State<PothosBody> {
  late final MyGame game;

  @override
  void initState() {
    super.initState();

    game = MyGame();
  }

  @override
  Widget build(BuildContext buildContext) {
    return Stack(
      children: [
        Positioned.fill(
            child: GameWidget(
              game: game,
            )),
        Positioned(
          left: 120,
          top: 650,
          child: ComponentsNotifierBuilder<Floor>(
            notifier: game.componentsNotifier<Floor>(),
            builder: (context, notifier) {
              return GameHud(
                emptyFloors: notifier.components.length, // TODO: change this
                onCreate: game.create
              );
            },
          ),
        ),
      ],
    );
  }
}

class GameHud extends StatelessWidget {
  const GameHud({
    super.key,
    required this.emptyFloors,
    required this.onCreate,
  });

  final int emptyFloors;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: emptyFloors > 0
            ? ElevatedButton(
          onPressed: onCreate,
          child: const Text('Add a new plant'),
        )
            : Text('Remaining enemies: $emptyFloors'),
      ),
    );
  }
}


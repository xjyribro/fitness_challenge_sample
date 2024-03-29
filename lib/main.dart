import 'package:flutter/material.dart';
import 'package:sample_fitness/data/challenges.dart';
import 'package:sample_fitness/data/checkpoints.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Fitness App Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void createChallenges() {
    Checkpoint checkpoint1 = Checkpoint(
      checkpointName: '1 workout done',
      status: CheckpointStatus.other,
      target: 1,
      progress: 0,
    );
    Checkpoint checkpoint2 = Checkpoint(
      checkpointName: '3 workouts done',
      status: CheckpointStatus.other,
      target: 3,
      progress: 0,
    );
    Checkpoint checkpoint3 = Checkpoint(
      checkpointName: '5 workouts done',
      status: CheckpointStatus.other,
      target: 5,
      progress: 0,
    );
    Challenge challengeTemplate1 = Challenge(
      userId: '',
      challengeName: 'Do 5 workouts this week',
      status: ChallengeStatus.other,
      checkpoints: [checkpoint1, checkpoint2, checkpoint3], // checkpoints are done in order
      points: 3,
    );
  }

  @override
  void initState() {
    super.initState();
    createChallenges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Text('Fitness'),
    );
  }
}

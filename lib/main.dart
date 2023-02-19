import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dev Val',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  static final colorsList = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ].reversed.toList();

  final colors = colorsList + colorsList + colorsList;

  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    animationController!.duration = const Duration(seconds: 10);
    animationController!.addListener(() {
      setState(() {});
    });
    animationController!.forward();
    animationController!.repeat();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var count = 0;

    final children = (colors.map((e) {
      final offset = 1 - (count++ / colors.length);
      final fraction = (animationController!.value + offset) % 1;
      return MyAppHelper(
          Transform.scale(
              scale: 100 * Curves.decelerate.transform(fraction),
              child: Icon(Icons.favorite, color: e)),
          fraction);
    }).toList()
          ..sort((a, b) => -a.scale.compareTo(b.scale)))
        .map((helper) => helper.child)
        .toList();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: children,
      ),
    );
  }
}

class MyAppHelper {
  final Widget child;
  final double scale;

  MyAppHelper(this.child, this.scale);
}

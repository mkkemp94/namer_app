import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/myhomepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // This widget is the root of your application.

    return ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child: MaterialApp(
            title: "Michael's Namer App",
            theme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF00FF00))
            ),
            home: MyHomePage()
        )
    );
  }
}

class MyAppState extends ChangeNotifier {
  WordPair currentPair = WordPair.random();
  List<WordPair> favorites = <WordPair>[];
  List<WordPair> history = <WordPair>[];

  GlobalKey? historyListKey;

  void getNext() {
    history.insert(0, currentPair);
    var animatedList = historyListKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);
    currentPair = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite([WordPair? pair]) {
    pair = pair ?? currentPair;

    if (favorites.contains(pair)) {
      favorites.remove(pair);
    }
    else {
      favorites.add(pair);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
  }
}
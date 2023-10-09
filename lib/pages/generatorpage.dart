import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/myapp.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.currentPair;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          TitleText(),
          SizedBox(height: 20),
          BigCard(wordPair: pair),
          SizedBox(height: 30),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorite(); // Generate new random pair
                  },
                  icon: Icon(icon),
                  label: Text("Like")),

              SizedBox(width: 20),

              ElevatedButton(
                  onPressed: () {
                    appState.getNext(); // Generate new random pair
                  },
                  child: Text("Next Idea")),

            ],
          ),
        ],
      ),
    );
  }
}


class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      fontSize: 42,
      color: theme.colorScheme.onPrimary,
    );
    return Text(style: style, "Here's an AWESOME idea:");
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.wordPair,
  });

  final WordPair wordPair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      letterSpacing: 2,
      fontStyle: FontStyle.italic,
      color: theme.colorScheme.onPrimary,
      fontSize: 32
    );

    return Card(
      color: theme.colorScheme.primary,
      shadowColor: theme.colorScheme.secondary,
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          wordPair.asCamelCase,
          style: style,
          semanticsLabel: "${wordPair.first} ${wordPair.second}",
        ),
      ),
    );
  }
}
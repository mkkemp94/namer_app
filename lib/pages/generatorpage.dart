import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/myapp.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme.displaySmall!.copyWith(
      fontSize: 20
    );

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

          Expanded(flex: 2, child: HistoryListView()),
          SizedBox(height: 20),
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
                  label: Text("Like", style: style)),
              SizedBox(width: 20),
              ElevatedButton(
                  onPressed: () {
                    appState.getNext(); // Generate new random pair
                  },
                  child: Text("Next Idea", style: style,)),
            ],
          ),
          Spacer(flex: 2)
        ],
      ),
    );
  }
}

class HistoryListView extends StatefulWidget {
  const HistoryListView({Key? key}) : super(key: key);

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  // Needed so that [MyAppState] can tell [AnimatedList] to animate new items
  final _key = GlobalKey();

  // Used to "fade out" the history items at the top
  static const Gradient _maskingGradient = LinearGradient(
    // Go from fully transparent to fully opaque
    colors: [Colors.transparent, Colors.black],

    // ... from the top (transparent) to half to bottom (opaque)
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme.displaySmall!.copyWith(
        fontSize: 20
    );
    final appState = context.watch<MyAppState>();
    appState.historyListKey = _key;

    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),

      // This blend mode takes the opacity of our shader and applies it to the destination list
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        key: _key,
        reverse: true,
        padding: EdgeInsets.only(top: 100),
        initialItemCount: appState.history.length,
        itemBuilder: (context, index, animation) {

          final pair = appState.history[index];
          return SizeTransition(
            sizeFactor: animation,
            child: Center(
              child: TextButton.icon(
                onPressed: () {
                  appState.toggleFavorite(pair);
                },
                icon: appState.favorites.contains(pair)
                    ? Icon(Icons.favorite, size: 20)
                    : SizedBox(),
                label: Text(
                  pair.asLowerCase,
                  semanticsLabel: pair.asPascalCase,
                  style: style,
                ),
              ),
            ),
          );
        },
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
        fontSize: 32);

    return Card(
        color: theme.colorScheme.primary,
        shadowColor: theme.colorScheme.secondary,
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AnimatedSize(
            duration: Duration(milliseconds: 250),
            // Wrap compound word when window is too narrow
            child: MergeSemantics(
              child: Wrap(children: [
                Text(wordPair.first,
                    style: style.copyWith(fontWeight: FontWeight.w200)),
                Text(wordPair.second,
                    style: style.copyWith(fontWeight: FontWeight.bold))
              ]),
            ),
          ),
        ));
  }
}

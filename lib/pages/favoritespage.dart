import 'package:flutter/material.dart';
import 'package:namer_app/myapp.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final titleStyle = Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 32);
    final listStyle = Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 28);

    if (appState.favorites.isEmpty) {
      return Center(child: Text("No favorites yet"));
    }

    return ListView(
      children: [

        Padding(padding: const EdgeInsets.all(20),
          child: Text(style: titleStyle,"You have ${appState.favorites.length} favorite(s):"),
        ),

        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(style: listStyle, pair.asCamelCase)
          ),

      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:namer_app/myapp.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appState = context.watch<MyAppState>();
    final titleStyle = theme.textTheme.displaySmall!.copyWith(fontSize: 32);
    final listStyle = theme.textTheme.displaySmall!.copyWith(fontSize: 28);

    if (appState.favorites.isEmpty) {
      return Center(child: Text("No favorites yet"));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(padding: const EdgeInsets.all(20),
          child: Text(style: titleStyle,"You have ${appState.favorites.length} favorite(s):"),
        ),

        Expanded(
          // Make better use of wide windows with a grid
          child: GridView(

            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 400 / 80,
            ),

            children: [

              for (var pair in appState.favorites)
                ListTile(
                    leading: IconButton(
                        icon: Icon(Icons.delete_outline, semanticLabel: "Delete"),
                        color: theme.colorScheme.primary,
                        onPressed: () {
                          appState.removeFavorite(pair);
                        },
                    ),
                    title: Text(style: listStyle, pair.asCamelCase)
                ),

            ]

          ),
        ),
      ],
    );
  }
}
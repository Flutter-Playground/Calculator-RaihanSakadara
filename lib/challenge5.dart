import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:icon/icon.dart';
import './Home_screen.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(challenge5());
}

class challenge5 extends StatelessWidget {
  const challenge5({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: demo(),
    );
  }
}

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  _demo createState() => _demo();
}

class _demo extends State<demo> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  final wordPair = WordPair.random();
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 20, color: Colors.white);

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
            backgroundColor: Colors.blueGrey,
          );
        },
      ), // ...to here.
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        // The itemBuilder callback is called once per suggested
        // word pairing, and places each suggestion into a ListTile
        // row. For even rows, the function adds a ListTile row for
        // the word pairing. For odd rows, the function adds a
        // Divider widget to visually separate the entries. Note that
        // the divider may be difficult to see on smaller devices.
        itemBuilder: (BuildContext _context, int i) {
          // Add a one-pixel-high divider widget before each row
          // in the ListView.
          if (i.isOdd) {
            return Divider();
          }

          // The syntax "i ~/ 2" divides i by 2 and returns an
          // integer result.
          // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
          // This calculates the actual number of word pairings
          // in the ListView,minus the divider widgets.
          final int index = i ~/ 2;
          // If you've reached the end of the available word
          // pairings...
          if (index >= _suggestions.length) {
            // ...then generate 10 more and add them to the
            // suggestions list.
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red[50] : null,
        semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
      ),
      onTap: () {
        // NEW lines from here...
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      }, // ... to here.
    );
  }

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      // key: _innerDrawerKey,
      onTapClose: true, // default false
      swipe: true, // default true
      colorTransitionChild: Colors.blue, // default Color.black54
      colorTransitionScaffold: Colors.black54, // default Color.black54

      //When setting the vertical offset, be sure to use only top or bottom
      offset: IDOffset.only(bottom: 0.00, right: 0.00, left: 0.20),
      scale: IDOffset.horizontal(1), // set the offset in both directions

      proportionalChildArea: true, // default true // default 0
      leftAnimationType: InnerDrawerAnimation.static, // default static
      rightAnimationType: InnerDrawerAnimation.quadratic,
      backgroundDecoration: BoxDecoration(
          color: Colors.red[200]), // default  Theme.of(context).backgroundColor

      //when a pointer that is in contact with the screen and moves to the right or left
      onDragUpdate: (double val, InnerDrawerDirection? direction) {
        // return values between 1 and 0
        print(val);
        // check if the swipe is to the right or to the left
        print(direction == InnerDrawerDirection.start);
      },
      innerDrawerCallback: (a) =>
          print(a), // return  true (open) or false (close)

      leftChild: Material(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(
                        top: 30,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://ngonoo.com/engine/wp-content/uploads/2015/02/shutterstock_179216297.jpg'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Text(
                      'Raihan Sakadara',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    Text(
                      'sakadararaihan@gmail.com',
                      style: TextStyle(fontSize: 11, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.calculate_outlined),
              title: Text(
                'Kalkulator',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const homescreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.navigate_next),
              title: Text(
                'Challenge 5',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const challenge5()),
                );
              },
            ),
          ],
        ),
      ),

      rightChild: Container(),

      scaffold: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text("Challenge 5"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: _pushSaved,
              tooltip: 'Saved Suggestions',
            ),
          ],
        ),
        body: _buildSuggestions(),
      ),
    );
  }
}

//  Current State of InnerDrawerState
final GlobalKey<InnerDrawerState> _innerDrawerKey =
    GlobalKey<InnerDrawerState>();

void _toggle() {
  _innerDrawerKey.currentState?.toggle(
      // direction is optional
      // if not set, the last direction will be used
      //InnerDrawerDirection.start OR InnerDrawerDirection.end
      direction: InnerDrawerDirection.end);
}

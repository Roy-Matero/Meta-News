import 'package:darps_news/src/network/newsApiSearch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart' as words;


class Search extends StatefulWidget {
  Search({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final List<String> kWords;
  _SearchAppBarDelegate _searchDelegate;

  //Initializing with sorted list of english words
  _SearchState()
      : kWords = List.from(Set.from(words.all))
    ..sort(
          (w1, w2) => w1.toLowerCase().compareTo(w2.toLowerCase()),
    ),
        super();


  @override
  void initState() {
    super.initState();
    //Initializing search delegate with sorted list of English words
    _searchDelegate = _SearchAppBarDelegate(kWords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover,
            image: NetworkImage("https://images.pexels.com/photos/1055613/pexels-photo-1055613.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Center(child: Text("Search for customized news"),),
            SizedBox(height: 50),
            CupertinoTextField(
              placeholder: "Search",
              style: TextStyle(fontSize: 30.0),
              suffix: Icon(Icons.search, color: Colors.black),
              onTap: () {
              showSearchPage(context, _searchDelegate);
            },),
          ],
        ),
      ),
    );
  }

  //Shows Search result
  void showSearchPage(BuildContext context,
      _SearchAppBarDelegate searchDelegate) async {
    final String selected = await showSearch<String>(
      context: context,
      delegate: searchDelegate,
    );

    if (selected != null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('You searched for : $selected'),
        ),
      );
    }
  }
}

//Search delegate
class _SearchAppBarDelegate extends SearchDelegate<String> {
  final List<String> _words;
  final List<String> _history;

  _SearchAppBarDelegate(List<String> words)
      : _words = words,
  //pre-populated history of words
        _history = <String>[],
        super();

  // Setting leading icon for the search bar.
  //Clicking on back arrow will take control to main page
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        //Take control back to previous page
        this.close(context, null);
      },
    );
  }

  // Builds page to populate search results.
  @override
  Widget buildResults(BuildContext context) {
    return NewsApiSearch(this.query);
  }

  // Suggestions list while typing search query - this.query.
  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = this.query.isEmpty
        ? _history
        : _words.where((word) => word.startsWith(query));

    return _WordSuggestionList(
      query: this.query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        this.query = suggestion;
        this._history.insert(0, suggestion);
        showResults(context);
      },
    );
  }

  // Action buttons at the right of search bar.
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isNotEmpty ?
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ) : IconButton(
        icon: const Icon(Icons.backspace),
        tooltip: 'Exit',
        onPressed: () {},
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData.dark();
  }
}

// Suggestions list widget displayed in the search page.
class _WordSuggestionList extends StatelessWidget {
  const _WordSuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
          // Highlight the substring that matched the query.
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style: textTheme.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: textTheme,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}
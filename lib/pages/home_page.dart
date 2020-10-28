import 'dart:convert';

import 'package:flutter/material.dart';
import '../config.dart';
import '../models/joke.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Swipe to Refresh
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  static List<ModelJoke> _jokes = List<ModelJoke>();
  static List<ModelJoke> _jokesInApp = List<ModelJoke>();

  // Get the Joke from the API
  Future<List<ModelJoke>> comingJokes() async {
    var url = Config.apiUrl;
    var response = await http.get(url);
    var joke = List<ModelJoke>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      joke.add(ModelJoke.fromJson(notesJson));
    }
    return joke;
  }

  // Pull to refresh and get New Jokes
  Future<Null> _refresh() {
    // Clear the old data
    _jokes.clear();
    //Add the new data
    return comingJokes().then((value) {
      setState(() {
        _jokes.addAll(value);
        _jokesInApp = _jokes;
      });
    });
  }

  @override
  void initState() {
    // Get the Joke when the App initialize
    comingJokes().then((value) {
      setState(() {
        _jokes.addAll(value);
        _jokesInApp = _jokes;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Insta Joke',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                _jokesInApp[index].error
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Text('${_jokesInApp[index].message}')],
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 120, left: 25, right: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${_jokesInApp[index].category}',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                '${_jokesInApp[index].setup}',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.deepOrange,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                '${_jokesInApp[index].delivery}',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.lightBlue,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            );
          },
          itemCount: _jokesInApp.length,
        ),
      ),
    );
  }
}

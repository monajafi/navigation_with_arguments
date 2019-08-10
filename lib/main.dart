import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        final ScreenArguments args = settings.arguments;
        if (settings.name == PassArgumentsScreen.routeName) {
           return MaterialPageRoute(builder: (context) =>
              PassArgumentsScreen(title: args.title, message: args.message));
        }
      },
      title: 'Navigation With Arguments',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Navigate to screen that extracts arguments'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExtractedScreen(),
                      settings: RouteSettings(
                          arguments: ScreenArguments("Extract Arguments Screen",
                              "This message is extracted in the build method"))),
                );
              },
            ),
            RaisedButton(
              child: Text('Navigate to a named that accepts argumnets'),
              onPressed: () {
                Navigator.of(context).pushNamed(PassArgumentsScreen.routeName,
                    arguments: ScreenArguments("Accept Arguments Screen",
                        "This message is extracted in onGenerateRoute function"));
              },
            )
          ],
        ),
      ),
    );
  }
}

class ExtractedScreen extends StatelessWidget {
  static const routeName = '/extractedScreen';
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Center(
          child: Text(args.message),
        ),
      ),
    );
  }
}

class PassArgumentsScreen extends StatelessWidget {
  static const routeName = '/passScreen';
  final String title;
  final String message;

  const PassArgumentsScreen({Key key, this.title, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}

class ScreenArguments {
  final String title;
  final String message;
  ScreenArguments(this.title, this.message);
}

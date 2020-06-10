import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Covid(),
  theme: ThemeData(
    primarySwatch: Colors.grey,
  ),
  debugShowCheckedModeBanner: false,
));

class Covid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Coming Soon'),
        ),
      ),
    );
  }
}

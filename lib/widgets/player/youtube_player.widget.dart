import 'package:flutter/material.dart';

class DummyYoutubePlayer extends StatelessWidget {
  const DummyYoutubePlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.indigo,
      child: const Center(child: Text("Youtube is playing")),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:youtube_watching/widgets/modal/bottom_sheet/comments/comments_modal_bottom_sheet.widget.dart';
import 'package:youtube_watching/widgets/player/youtube_player.widget.dart';

class WatchVideoPage extends StatelessWidget {
  const WatchVideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const DummyYoutubePlayer(),
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              final height = constraints.maxHeight;
              return Center(
                child: TextButton(
                  onPressed: () {
                    showBottomSheet(
                      context: context,
                      builder: (context) {
                        return CommentsModalBottomSheet(minHeight: height);
                      },
                    );
                  },
                  child: const Text("show comments sheet"),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

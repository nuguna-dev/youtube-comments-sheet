import 'package:flutter/material.dart';

class CommentsModalBottomSheet extends StatefulWidget {
  const CommentsModalBottomSheet({
    Key? key,
    required this.minHeight,
  }) : super(key: key);
  final double minHeight;

  @override
  State<CommentsModalBottomSheet> createState() =>
      _CommentsModalBottomSheetState();
}

const disimissibleRatio = 0.7;
const expandableRatio = 0.4;
const toggleVelocity = 500.0;

class _CommentsModalBottomSheetState extends State<CommentsModalBottomSheet> {
  late double height;
  @override
  void initState() {
    super.initState();
    height = widget.minHeight;
  }

  void handleVerticalDragUpdate(DragUpdateDetails details) {
    // dy에 수직 드래그 변화량이 기록됩니다.
    // 아래로 드래그 하면 dy는 양수
    // 위로 드래그 하면 dy는 음수 입니다.
    final dy = details.delta.dy;
    final newHeight = height - dy;
    setState(() {
      height = newHeight;
    });
  }

  void handleVerticalDragEnd(BuildContext context, DragEndDetails details) {
    final minHeight = widget.minHeight;
    final velocity = details.primaryVelocity ?? 0;
    debugPrint("velocity: $velocity");

    // 아래로 드래그 하는 속도에 따라서
    if (velocity > toggleVelocity) {
      // 최소 사이즈보다 작은 크기일 때는 시트 제거
      if (height < minHeight) {
        Navigator.of(context).pop();
      } else if (height > minHeight) {
        // 최소 사이즈보다 큰 크기 일 때는 최소 사이즈로
        setHeightToMin();
      }
      return;
    }

    // 위로 드래그 하는 속도에 따라서
    if (velocity * -1 > toggleVelocity) {
      // 최소 사이즈보다 작은 상태에서
      if (height < minHeight) {
        setState(() {
          height = minHeight;
        });
      } else if (height > minHeight) {
        // 최소 사이즈보다 큰 상태 일 때
        setHeightToMax(context);
      }
    }

    final viewportHeight = MediaQuery.of(context).size.height;
    // 드래그 속도가 느린 경우, 최종 크기에 따라서
    if (height <= minHeight && height <= minHeight * disimissibleRatio) {
      // 정해진 크기보다 작거나,
      Navigator.of(context).pop();
    } else if ((height - minHeight) >=
        (viewportHeight - minHeight) * expandableRatio) {
      // 정해진 크기보다 커졌거나,
      setHeightToMax(context);
    } else {
      setHeightToMin();
    }
  }

  void setHeightToMax(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    setState(() {
      height = maxHeight;
    });
  }

  void setHeightToMin() {
    setState(() {
      height = widget.minHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(builder: (context) {
        return GestureDetector(
          onVerticalDragUpdate: handleVerticalDragUpdate,
          onVerticalDragEnd: (detail) => handleVerticalDragEnd(context, detail),
          child: Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: Column(
              children: [
                Container(
                  height: 50,
                  color: Colors.indigo[300],
                  child: const Center(child: Text("바텀 시트 드래그 영역")),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      for (var i = 0; i < 70; ++i)
                        ListTile(title: Text("Item $i"))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

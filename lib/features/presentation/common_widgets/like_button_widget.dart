import 'package:flutter/material.dart';

class LikeButtonWidget extends StatefulWidget {
  final Function likeButtonPressed;
  final bool isLiked;
  const LikeButtonWidget(
      {Key? key, required this.likeButtonPressed, this.isLiked = false})
      : super(key: key);

  @override
  State<LikeButtonWidget> createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.likeButtonPressed(),
      child: CircleAvatar(
        child: widget.isLiked
            ? const Icon(Icons.thumb_up_alt_rounded)
            : const Icon(Icons.thumb_up_alt_outlined),
      ),
    );
  }
}

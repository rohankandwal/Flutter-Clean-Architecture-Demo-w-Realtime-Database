import 'package:flutter/material.dart';

class FavoriteButtonWidget extends StatefulWidget {
  final Function favoriteButtonPressed;
  final bool isFavorite;
  const FavoriteButtonWidget(
      {Key? key, required this.favoriteButtonPressed, this.isFavorite = false})
      : super(key: key);

  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.favoriteButtonPressed(),
      child: CircleAvatar(
        child: widget.isFavorite
            ? const Icon(Icons.favorite_outlined)
            : const Icon(Icons.favorite_border_outlined),
      ),
    );
  }
}

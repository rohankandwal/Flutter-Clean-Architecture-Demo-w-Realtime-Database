import 'dart:io';
import 'package:flutter/material.dart';
import 'package:clean_demo/features/domain/entities/feed_entity.dart';
import 'package:clean_demo/features/presentation/common_widgets/favorite_button_widget.dart';
import 'package:clean_demo/features/presentation/common_widgets/like_button_widget.dart';

class FeedChildWidget extends StatefulWidget {
  final FeedEntity feedModel;
  final Function likeButtonPressed;
  final Function favoriteButtonPressed;

  const FeedChildWidget({
    Key? key,
    required this.feedModel,
    required this.likeButtonPressed,
    required this.favoriteButtonPressed,
  }) : super(key: key);

  @override
  State<FeedChildWidget> createState() => _FeedChildWidgetState();
}

class _FeedChildWidgetState extends State<FeedChildWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getTitle(),
            _getDescription(),
            const SizedBox(
              height: 8,
            ),
            _getImage(),
            const SizedBox(
              height: 8,
            ),
            _getLikeAndFavoriteRow(),
          ],
        ),
      ),
    );
  }

  Widget _getTitle() {
    return Text(
      widget.feedModel.title,
      style: TextStyle(color: Colors.black, fontSize: 18),
    );
  }

  Widget _getDescription() {
    return Text(
      widget.feedModel.description,
      style: TextStyle(color: Colors.black, fontSize: 14),
    );
  }

  Widget _getImage() {
    return Container(
      width: double.infinity,
      height: 100,
      child: Image.file(
        File(widget.feedModel.mediaPath),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _getLikeAndFavoriteRow() {
    return Row(
      children: [
        _getLikeButton(),
        const SizedBox(
          width: 10,
        ),
        _getFavoriteButton(),
      ],
    );
  }

  Widget _getLikeButton() {
    return LikeButtonWidget(
      isLiked: widget.feedModel.isLiked, // 0 means false, 1 means true
      likeButtonPressed: () => widget.likeButtonPressed(),
    );
  }

  Widget _getFavoriteButton() {
    return FavoriteButtonWidget(
      isFavorite:
          widget.feedModel.isFavorite, // 0 means false, 1 means true
      favoriteButtonPressed: () => widget.favoriteButtonPressed(),
    );
  }
}

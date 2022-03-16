class FeedEntity {
  final int id;
  final String title;
  final String description;
  final String mediaPath;
  final bool isLiked;
  final bool isFavorite;

  FeedEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.mediaPath,
    this.isLiked = false,
    this.isFavorite = false,
  });
}

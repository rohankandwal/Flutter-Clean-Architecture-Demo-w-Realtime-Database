import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_demo/core/config/navigation.dart';
import 'package:clean_demo/core/utils/constants.dart';
import 'package:clean_demo/core/utils/routes.dart';
import 'package:clean_demo/features/domain/entities/feed_entity.dart';
import 'package:clean_demo/features/presentation/common_widgets/feed_child_widget.dart';

import 'feed_bloc.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _searchString = "";

  final List<FeedEntity> _feeds = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      floatingActionButton: _getFloatingActionButton(),
      body: _getBody(),
    );
  }

  /// Gets the Appbar for the screen
  AppBar _getAppBar() {
    return AppBar(
      title: const Text(
        "Feed",
      ),
      centerTitle: true,
    );
  }

  /// Gets the floating action button which will redirect to create new screen
  Widget _getFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigation.intent(context, AppRoutes.add_new_post_screen);
      },
      child: const Icon(Icons.add),
    );
  }

  /// Gets the main body for the app which contains a searchbar and a listview
  Widget _getBody() {
    return BlocConsumer<FeedBloc, FeedState>(builder: (context, state) {
      if (state is FeedInitial) {
        BlocProvider.of<FeedBloc>(context).add(GetAllFeedsEvent());
        BlocProvider.of<FeedBloc>(context).add(GetFeedStreamEvent());
      }
      return Stack(
        children: [
          Positioned(
            child: _getSearchField(),
            left: 0,
            right: 0,
            top: 0,
          ),
          Positioned(
            child: _getFeedItems(),
            left: 0,
            right: 0,
            top: 120,
            //Todo check error for int conversion
            bottom: 0,
          )
        ],
      );
    }, listener: (context, state) {
      if (state is FeedLoadedState) {
        _feeds.clear();
        _feeds.addAll(state.feeds);
      } else if (state is FeedLoadingState) {
        print("In loading state");
      }
    },);
  }

  Widget _getSearchField() {
    return Container(
      padding: const EdgeInsets.all(16),
      height: Constants.FEED_SEARCH_BAR_HEIGHT,
      child: TextFormField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search",
          border: _getBorder(Colors.black),
          enabledBorder: _getBorder(Colors.black),
          errorBorder: _getBorder(Colors.red),
        ),
        onChanged: (value) {
          setState(() {
            _searchString = value;
          });
        },
      ),
    );
  }

  InputBorder _getBorder(final Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color),
    );
  }

  Widget _getFeedItems() {
    var results = _searchString.isEmpty
        ? _feeds // whole list
        : _feeds
        .where((c) =>
    c.title
        .toLowerCase()
        .contains(_searchString.toLowerCase()) ||
        c.description
            .toLowerCase()
            .contains(_searchString.toLowerCase()))
        .toList();
    if (results.isEmpty) {
      return const Center(
        child: Text("No data"),
      );
    }
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final _feedModel = results[index];
        return FeedChildWidget(
          key: UniqueKey(),
          feedModel: _feedModel,
          favoriteButtonPressed: () async {

            // results[index].save();
            // box.putAt(index, results[index]);
          },
          likeButtonPressed: () async {
            /*if (results[index].isLiked == 0) {
              results[index].isLiked = 1;
            } else {
              results[index].isLiked = 0;
            }*/
            // results[index].save();
            // box.putAt(index, results[index]);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

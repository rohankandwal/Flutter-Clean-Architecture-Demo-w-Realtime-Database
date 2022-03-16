# Flutter Clean Architecture w/ BLoC, Get_It & Hive

App to showcase demo for how to have Clean Architecture in Flutter with [Get_It](https://pub.dev/packages/get_it) for dependency injection, [BLoC](https://pub.dev/packages/flutter_bloc) for state maintainence and [Hive](https://pub.dev/packages/hive) for persisting data into database.

## Getting Started

This project is to showcase how we can use Clean Architure in Flutter App. The architecture of the app is as follows -

![Clean Architecture design](https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/Clean-Architecture-Flutter-Diagram.png?w=556&ssl=1)

The existing folder structure of the project is as belows -

<img width="248" alt="image" src="https://user-images.githubusercontent.com/7704510/158588239-ff4ceb3e-f163-44ff-9b53-f0a8d631a19e.png">

  ```
  Stream<List<FeedModel>> getFeedPostsDatabaseStream() {
    if (_feedBox == null) {
      _initializeHiveBox();
    }
    return _feedBox!.watch().map((event) => List<FeedModel>.generate(
        _feedBox!.values.length, (index) => _feedBox!.getAt(index)!));
  }
  ```
  
 Above function will create a Stream to listen for all the changes in the database. This then can be used to update the values automatically on `feed_screen.dart`.
 
## Run Project

```
flutter pub get

flutter pub run build_runner build --delete-conflicting-outputs 
```

Then you can run the project as usual

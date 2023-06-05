<p align="center">
  <a href="https://flutter.io/">
    <img src="https://logowik.com/content/uploads/images/flutter5786.jpg" alt="Logo" width=72 height=72>
  </a>

<h3 align="center">Inshorts Clone App</h3>

  <p align="center">
    Inshorts Clone using flutter
    <br>
    Inshorts clone created with  :heart: . Caching,Bookmark,Animation,Dark mode!
    <br>
    <br>
    <a href="https://github.com/bibek-ranjan-saha/inshorts_clone/issues/new">Report bug</a>
    ·
    <a href="https://github.com/bibek-ranjan-saha/inshorts_clone/issues/new">Request feature</a>
  </p>
</p>

Inshorts clone app using flutter

## Getting Started

This project is a starting point for a Flutter application.

## Steps to run

### Open terminal

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/bibek-ranjan-saha/inshorts_clone.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get 
```

**Step 3:**

This project uses `flavors` to differentiate app builds, execute the following command to run app:

```
flutter run apk -t lib/flavours/main_dev.dart --flavor development
```

**Step 3:**

Create a release apk to share a normal user:

```
flutter build apk --release -t lib/flavours/main_prod.dart --flavor production --no-tree-shake-icons
```

### Libraries & Tools Used


* [dio](https://pub.dev/packages/dio) (Networking client)
* [hive_flutter](https://pub.dev/packages/hive_flutter) (Local Database)
* [shared_preferences](https://pub.dev/packages/shared_preferences) (Storing smaller key-value pair)
* [go_router](https://pub.dev/packages/go_router) (routing/navigation)
* [provider](https://pub.dev/packages/provider) (State Management)
* [intl](https://pub.dev/packages/intl) (Formatting/Localization)
* [cached_network_image](https://pub.dev/packages/cached_network_image) (Image caching)
* [dio_http_cache](https://pub.dev/packages/dio_http_cache) (Http caching)
* [webview_flutter](https://pub.dev/packages/webview_flutter) (Web view)
* [another_transformer_page_view](https://pub.dev/packages/another_transformer_page_view) (Page transition animation)
* [path_provider](https://pub.dev/packages/path_provider) (Path provider)


Folder structureI am using in this project

```
lib/
|- constants/
|- flavours/
|- models/
|- providers/
|- screens/
|- services/
|- utils/
|- widgets/
|- main_common.dart
```
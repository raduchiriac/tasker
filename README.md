# tasker

<img alt="logo" src="assets/icons/icon.png" width="64"/>

Another Flutter "to-do list" App that uses [sqflite](https://pub.dev/packages/sqflite).

<div class="d-flex">
  <img alt="" src="assets/screenshot1.png" width="220" />
  <img alt="" src="assets/screenshot2.png" width="220" />
</div>

```bash
$ flutter pub run flutter_launcher_icons:main # generate the icons
$ flutter build apk --target-platform android-arm64 # build for Android
```

### TODO

- [x] Show an alarm icon for passed events
- [x] Play with the intensity of the priority colour
- [x] Put Monday as the first day in the `showDatePicker`
- [x] Create a SnackBar with an "Undo" action when delete
- [ ] Show/Hide completed tasks

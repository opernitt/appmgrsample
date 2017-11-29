# AppMgr Example

A UI App example

## Getting Started

Check out the source files and build the project using
```
qmake
make
```

This sample UI demonstrates various Qt features:
* Mouse/key event handling
* Signal/Slot signalling
* State changes
* Dynamic loading (qrc:/)
* Dynamic contents generation based on data (Json file with mock-up EPG data)
* Transitioning
* Animations
* UI Navigation (swipe, mouse, keyboard)
* C++/Qml integration

### Prerequisites

```
Qt 5.9.x
```

## Missing items and next steps in this project

This project was put together quickly to demonstrate some of Qt's capabilities. The following items will be implemented next:
1. Complete the App Store UI and Settings screen. Add signals and slots to handle changes
2. Organize the UI classes (subfolders for /EPG, /AppStore, etc)
3. Add/complete the AppMgr capabilities in order to:
  3a. Display a Splash screen
  3b. Load core and UI services (systemd)
  3c. Load other (external) UI components (i.e., Log-In screen or terms & conditions)
  3d. Add IPC messaging using D-Bus (Json mesages)
4. Dynamically load EPG Data and create EPG Grid Layout
5. Add proper comments and documentation so Doxygen can be used to generate a reference guide
6. Add Unit Tests to cover the Controller code (C++)
7. Add End-to-end (E2E) tests to cover the UI (using WebDriver)
8. Add (cross-compile) embedded Linux build and add a recipe to include this project (Yocto)

## Running the tests

Unit and E2E Tests are required

## Deployment

A cross-compile script will be added

## Built With

* [Yocto](https://www.yoctoproject.org/) - Yocto bitbake used to cross-compile
* [Qt/QtCreator](https://www.qt.io/qt-features-libraries-apis-tools-and-ide/) - QtCreator and tools

## Contributing

Contributions are not currently accepted.

## Versioning

We use [Git tagging](https://git-scm.com/book/en/v2/Git-Basics-Tagging) for versioning. 

## Authors

* **Olaf Pernitt** - *Initial work* - [email](mailto:olaf@pernitt.com)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* The Qt Company
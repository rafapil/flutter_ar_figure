import 'package:flutter/material.dart';
import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:avatar_view/avatar_view.dart';
import 'dart:io' as Platform;

class CameraWithMaskFiltersScreen extends StatefulWidget {
  @override
  _CameraWithMaskFiltersScreenState createState() =>
      _CameraWithMaskFiltersScreenState();
}

class _CameraWithMaskFiltersScreenState
    extends State<CameraWithMaskFiltersScreen> {
  // definition
  CameraDeepArController cameraDeepArController;
  String platformVersion = 'Unknown';
  int currentPage = 0;
  final vp = PageController(viewportFraction: .24);
  Effects currentEffect = Effects.none;
  Filters currentFilter = Filters.none;
  Masks currentMask = Masks.none;
  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          //
          children: [
            // Deep AR Camera
            CameraDeepAr(
              onCameraReady: (isReady) {
                platformVersion = 'Camera Status $isReady';
                print(platformVersion);
                setState(() {});
              },
              // camera
              onImageCaptured: (path) {
                platformVersion = 'Camera Status  $path';
                print(platformVersion);
                setState(() {});
              },
              iosLicenceKey:
                  "52295c9d9270364c60c12cea31e597fef8ffc39521bb8ba4505ea9af5c3e1bf4690d65c5fdca5721",
              androidLicenceKey:
                  "9b3efa93eaccd7c4659c1ccd24ac63dc790564b7b70a97a88663165ea61cb781eda3cc5d5eea7eb0 ",
              cameraDeepArCallback: (c) async {
                cameraDeepArController = c;
                setState(() {});
              },
            ),
            // Face Mask filter - Icons Buttons
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //
                      Padding(
                        padding: EdgeInsets.only(right: 28.0, left: 28.0),
                        child: Expanded(
                          // old flatbutton new flutter 2 TextButton
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: TextButton(
                              onLongPress: () {
                                if (null == cameraDeepArController) {
                                  return;
                                }
                                cameraDeepArController.snapPhoto();
                              },
                              child: Icon(
                                Icons.camera_enhance,
                                color: Colors.white54,
                                size: 45.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(8, (page) {
                            bool active = currentPage == page;
                            return Platform.Platform.isIOS
                                // ios
                                ? GestureDetector(
                                    onTap: () {
                                      currentPage = page;
                                      cameraDeepArController.changeMask(page);
                                      setState(() {});
                                    },
                                    child: AvatarView(
                                      radius: active ? 65 : 30,
                                      borderColor: Colors.yellow,
                                      borderWidth: 2.0,
                                      isOnlyText: false,
                                      avatarType: AvatarType.CIRCLE,
                                      backgroundColor: Colors.red,
                                      imagePath:
                                          'assets/ios/${page.toString()}.jpg',
                                      placeHolder: Icon(
                                        Icons.person,
                                        size: 50,
                                      ),
                                      errorWidget: Container(
                                        child: Icon(
                                          Icons.error,
                                          size: 50,
                                        ),
                                      ),
                                    ),
                                  )
                                // android
                                : GestureDetector(
                                    onTap: () {
                                      currentPage = page;
                                      cameraDeepArController.changeMask(page);
                                      setState(() {});
                                    },
                                    child: AvatarView(
                                      // this size is ok for android validate in ios
                                      radius: active ? 45 : 25,
                                      borderColor: Colors.yellow,
                                      borderWidth: 2.0,
                                      isOnlyText: false,
                                      avatarType: AvatarType.CIRCLE,
                                      backgroundColor: Colors.red,
                                      imagePath:
                                          'assets/android/${page.toString()}.jpg',
                                      placeHolder: Icon(
                                        Icons.person,
                                        size: 50,
                                      ),
                                      errorWidget: Container(
                                        child: Icon(
                                          Icons.error,
                                          size: 50,
                                        ),
                                      ),
                                    ),
                                  );
                          }),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<File> imageFile;
  late File _image;
  String result = '';
  late ImagePicker imagePicker;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    loadDataModelFiles();
  }

  loadDataModelFiles() async {
    String? output = await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    );
    print(output);
    ;
  }

  doImageClassification() async {
    var recognitions = await Tflite.runModelOnImage(
      path: _image.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2,
      threshold: 0.1,
      asynch: true,
    );
    print(recognitions?.length.toString());
    setState(() {
      result = "";
    });
    recognitions?.forEach((element) {
      setState(() {
        print(element.toString());
        result += element['label'];
      });
    });
  }

  selectPhoto() async {
    PickedFile? pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile!.path);
    setState(() {
      _image;
      doImageClassification();
    });
  }

  capturePhoto() async {
    PickedFile? pickedFile =
        await imagePicker.getImage(source: ImageSource.camera);
    _image = File(pickedFile!.path);
    setState(() {
      _image;
      doImageClassification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(width: 100),
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              child: Stack(
                children: [
                  Center(
                    child: TextButton(
                      onPressed: selectPhoto,
                      onLongPress: capturePhoto,
                      child: _image != null
                          ? Image.file(
                              _image,
                              height: 160,
                              width: 400,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 140,
                              height: 190,
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 160,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Text(
                result,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 35,
                  color: Colors.blueAccent,
                  backgroundColor: Colors.white24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

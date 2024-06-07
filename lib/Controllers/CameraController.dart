import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class CameraOpenController extends ChangeNotifier {
  var imageFile;
  var file;

  Future<void> selectImage(context,{required ImageSource source,required from}) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      if(from=="1"){
        imageFile = File(image.path);
      }
      else{
        file = File(image.path);
      }
      Navigator.pop(context);
    }
    notifyListeners();
  }

  Future<void> pickFile(context,{required allowedExtensions,required from}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );
    if (result != null && result.files.single.path != null) {
      if(from=="1"){
        imageFile = File(result.files.single.path!);
      }
      else{
        file = File(result.files.single.path!);
      }
      Navigator.pop(context);
    }
    notifyListeners();
  }


  Future<void> openDocument({required docUrl}) async {
    if (await canLaunch(docUrl.toString())) {
      await launch(docUrl.toString());
    } else {
      throw 'Could not open $docUrl';
    }
  }

  ClearFile(){
    imageFile=null;
    file = null;
    notifyListeners();
  }
}



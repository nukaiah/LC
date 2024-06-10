import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lc/Controllers/AuthenticationController.dart';
import 'package:lc/Utils/AppColors.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class CameraOpenController extends ChangeNotifier {
  var imageFile;
  var file;

  Future<void> selectImage(context,{required ImageSource source,required from}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if(image!=null){
      final File SimageFile = File(image.path);
      int maxSize = 5 * 1024 * 1024;
      final int imageSize = await SimageFile.length();
      if(imageSize<=maxSize){
        if(from=="1"){
          imageFile = File(image.path);
        }
        else{
          file = File(image.path);
        }
      }
      else{
        ShowMessage(context,message: "File size should 3 Mb or below",backgroundColor: onprimaryhrcolor);
      }
    }

    Navigator.pop(context);
    notifyListeners();
  }

  Future<void> pickFile(context,{required allowedExtensions,required from}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );
    if (result!=null && result.files.single.path != null) {
      int maxSize = 3 * 1024 * 1024;
      int selectedSize = result.files.single.size;
      if(selectedSize<=maxSize){
        if(from=="1"){
          imageFile = File(result.files.single.path!);
          Navigator.pop(context);
        }
        else{
          file = File(result.files.single.path!);
        }
      }
      else{
        if(from=="1"){
          Navigator.pop(context);
        }
        ShowMessage(context,message: "File size should 3 Mb or below",backgroundColor: onprimaryhrcolor);
      }
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



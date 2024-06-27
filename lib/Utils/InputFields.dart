import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lc/Utils/AppColors.dart';
import 'package:lc/Utils/TextStyles.dart';

Widget EmailField({controller,labelText,hintText}){
  return TextFormField(
    style: TxtStls.stl14,
    controller:controller,
    decoration: inputDecoration(labelText: labelText,hintText: hintText),
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.emailAddress,
    textCapitalization: TextCapitalization.sentences,
    validator: (email){
      final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$', caseSensitive: false, multiLine: false,);
      if(email!.isEmpty){
        return "$labelText can not be empty";
      }
      else if(!emailRegex.hasMatch(email)){
        return "$labelText is not formatted";
      }
      else{
        return null;
      }
    },
  );
}

Widget PasswordField({controller, isVisible = false, labelText, hintText,onPressed}) {
  return StatefulBuilder(builder: (context, setstate) {
    return TextFormField(
      style: TxtStls.stl14,
      obscureText: isVisible,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          contentPadding: const EdgeInsets.all(15),
          labelText:labelText,
          labelStyle: TxtStls.stl15,
          hintText: hintText,
          hintStyle: TxtStls.stl13,
          fillColor: secondarywhite,
          filled: true,
          counterText: "",
          suffixIcon: IconButton(icon:Icon(isVisible?Icons.visibility:Icons.visibility_off) ,onPressed: onPressed,)
      ),
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      textCapitalization: TextCapitalization.sentences,
      validator: (password) {
        if (password!.isEmpty) {
          return "Password cannot be empty";
        } else if (password.length < 5) {
          return "Password should be 5 chars";
        } else {
          return null;
        }
      },
    );
  });
}


InputDecoration inputDecoration({labelText,hintText}){
  return InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      contentPadding: const EdgeInsets.all(10),
      labelText:labelText,
      labelStyle: TxtStls.stl14,
      hintText: hintText,
      hintStyle: TxtStls.stl13,
      fillColor: secondarywhite,
      filled: true,
      counterText: ""
  );
}


Widget NameField({controller,labelText,hintText}){
  return TextFormField(
    style: TxtStls.stl14,
    controller:controller,
    decoration: inputDecoration(labelText: labelText,hintText: hintText),
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.name,
    textCapitalization: TextCapitalization.words,
    validator: (name){
      if(name!.isEmpty){
        return "$labelText can not be empty";
      }
      else{
        return null;
      }
    },
  );
}

Widget NameField1({controller,labelText,hintText}){
  return TextFormField(
    style: TxtStls.stl14,
    controller:controller,
    decoration: inputDecoration(labelText: labelText,hintText: hintText),
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.name,
    textCapitalization: TextCapitalization.words,
    maxLines: 2,
  );
}


Widget PhoneField({controller,labelText,hintText}){
  return TextFormField(
    style: TxtStls.stl14,
    controller:controller,
    decoration: inputDecoration(labelText: labelText,hintText: hintText),
    textInputAction: TextInputAction.next,
    keyboardType: const TextInputType.numberWithOptions(signed: true,decimal: false),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly
    ],
    maxLength: 10,
    validator: (phone){
      if(phone!.isEmpty){
        return "$labelText can not be empty";
      }
      else if(phone.length!=10){
        return "$labelText could be 10 digits only";
      }
      else{
        return null;
      }
    },

  );
}

Widget NumberField({controller,labelText,hintText,required maxLength}){
  return TextFormField(
    style: TxtStls.stl14,
    controller:controller,
    decoration: inputDecoration(labelText: labelText,hintText: hintText),
    textInputAction: TextInputAction.next,
    keyboardType: const TextInputType.numberWithOptions(signed: true,decimal: false),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly
    ],
    maxLength:maxLength,
    validator: (phone){
      if(phone!.isEmpty){
        return "$labelText can not be empty";
      }
      else{
        return null;
      }
    },

  );
}


Widget DobField(context,{controller,labelText,hintText,type="",onPressed}){
  return TextFormField(
    style: TxtStls.stl14,
    controller:controller,
    readOnly: true,
    decoration:InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        contentPadding: const EdgeInsets.all(10),
        labelText:labelText,
        labelStyle: TxtStls.stl14,
        hintText: hintText,
        hintStyle: TxtStls.stl13,
        fillColor: secondarywhite,
        filled: true,
        counterText: "",
      suffixIcon: IconButton(onPressed: onPressed, icon: Icon(Icons.clear))
    ),
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.name,
    textCapitalization: TextCapitalization.words,
    validator: (name){
      if(name!.isEmpty){
        return "$labelText can not be empty";
      }
      else{
        return null;
      }
    },
    onTap: (){
      type==""?selectDate(context,controller: controller):selectDateFuture(context,controller: controller);
    },
  );
}

Future<void> selectDate(BuildContext context,{required TextEditingController controller}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
  if (picked != null){
    controller.text = "${picked.year}-${picked.month<10?"0${picked.month}":picked.month}-${picked.day<10?"0${picked.day}":picked.day}";

  }
}

Future<void> selectDateFuture(BuildContext context,{required TextEditingController controller}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(3000),
  );
  if (picked != null){
    controller.text = "${picked.day<10?"0${picked.day}":picked.day}/${picked.month<10?"0${picked.month}":picked.month}/${picked.year}";
  }
}

Widget MyButton(context, {required bool load, required String title, required onTap}) {
  return InkWell(
    hoverColor: Colors.transparent,
    focusColor: primarycolor,
    splashColor: const Color.fromARGB(0, 6, 2, 84),
    highlightColor: Colors.transparent,
    onTap: load ? null : onTap,
    child: AnimatedContainer(
      alignment: Alignment.center,
      height: 50,
      width: load ? 50 : 400,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
          color: primarycolor, borderRadius: BorderRadius.circular(30)),
      child: load
          ? const CircularProgressIndicator(color: secondarywhite)
          : Text(title, style: TxtStls.wstl15),
    ),
  );
}

Widget SearchField(context,{controller,onChanged}){
  return TextFormField(
    style: TxtStls.stl14,
    controller: controller,
    decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        labelStyle: TxtStls.stl15,
        hintText: "Search in appointments",
        hintStyle: TxtStls.stl13,
        fillColor: secondarywhite,
        filled: true,
      suffixIcon: controller!.text.isNotEmpty
          ? IconButton(
        icon: const Icon(
          Icons.close,
          color: primarycolor,
        ),
        onPressed: () {
          controller.clear();
          onChanged("");
          FocusScope.of(context).requestFocus(FocusNode());
        },
      )
          : const Icon(
        Icons.search,
        color: primarycolor,
      ),
    ),
    onChanged: onChanged,
  );
}

Widget StatDropdown({value,required List<String> itemsList,labelText,hintText,onChanged}){
  return DropdownButtonFormField2(
    value: value,
    isExpanded: true,
    decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        contentPadding: const EdgeInsets.all(2),
        labelText:labelText,
        labelStyle: TxtStls.stl14,
        hintText: hintText,
        hintStyle: TxtStls.stl13,
        fillColor: secondarywhite,
        filled: true,
        counterText: ""
    ),
    hint: Text(
      hintText,
      style: TxtStls.stl14,
    ),
    items: itemsList.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value,style: TxtStls.stl13,),
      );
    }).toList(),
    validator: (value) {
      if (value == null) {
        return '$labelText is can not be null';
      }
      return null;
    },
    onChanged:onChanged,
    buttonStyleData: const ButtonStyleData(
      padding: EdgeInsets.only(right: 8),
    ),
    iconStyleData: const IconStyleData(
      icon: Icon(
        Icons.arrow_drop_down,
        color:primary,
      ),
      iconSize: 24,
    ),
    dropdownStyleData: DropdownStyleData(
      maxHeight: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    menuItemStyleData: const MenuItemStyleData(
      padding: EdgeInsets.symmetric(horizontal: 16),
    ),
  );
}

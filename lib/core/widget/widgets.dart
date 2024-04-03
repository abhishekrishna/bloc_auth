import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app_icons_icons.dart';
import '../const/colors.dart';

class CustomWidgets {
  // Custom Gradient Button Widget
  Widget customButton(BuildContext context, String btnLabel,
      VoidCallback? onTap, bool? isProfile) {
    ///This line add because when theme changed with getx that time rebuild widget
    ///and apply text style theme color
    /////So where is Widget build method that place add this line

    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      height: MediaQuery.of(context).size.height / 16,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [ColorTheme.accentColor, ColorTheme.softAccentColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: InkWell(
            onTap: () => onTap?.call(),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  btnLabel,
                  style: TextStyle(
                      fontFamily: 'PoppinsReg',
                      fontSize: 16,
                      color: ColorTheme.lightBaseColor),
                ),
                SizedBox(
                  width: 15,
                ),
                isProfile == false
                    ? Icon(
                        AppIcons.arrow_rgt,
                        color: ColorTheme.lightBaseColor,
                      )
                    : Container()
              ],
            ))),
      ),
    );
  }

  //Custom Text Field Widget
  // ignore: non_constant_identifier_names
  Widget customTextField(
      BuildContext context,
      List<TextInputFormatter>? _formatter,
      String? Function(String?)? _validator,
      FocusNode _focusNode,
      TextEditingController _inputController,
      String hintTxt,
      String prefixTxt,
      VoidCallback onTap,
      bool isObscureText,
      Function(String) onchange,
      {bool platformSelectScreen = false}) {
    return TextFormField(
      autofocus: true,
      inputFormatters: _formatter,
      validator: _validator,
      focusNode: _focusNode,
      controller: _inputController,
      obscureText: isObscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor:
            /*platformSelectScreen
            ? ColorTheme.lightSecondaryColor
            : */
            ColorTheme.darkThemeLanBgColor,

        hintText: hintTxt,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 0,
            // style: BorderStyle.none,
          ),
        ),
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        prefixText: prefixTxt,
        prefixStyle: TextStyle(
            color: /*platformSelectScreen
                ? ColorTheme.darkBaseColor
                : */

                ColorTheme.darkBaseColor),
        suffixIconConstraints: BoxConstraints(),
        suffixIcon: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.only(right: 10),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(
                AppIcons.close,
                size: 18,
                color: ColorTheme.darkSecondaryColor,
              ),
            ),
          ),
        ),
        contentPadding: EdgeInsets.only(left: 25, top: 15, bottom: 17),
        // labelText: "+91".tr,

        labelStyle: TextStyle(fontSize: 15, fontFamily: 'PoppinsReg'),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      onChanged: onchange,
    );
  }
}

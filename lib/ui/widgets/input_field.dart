import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../size_config.dart';
import '../theme.dart';


class InputField extends StatelessWidget {
  const InputField({Key? key, required this.title, required this.hint, this.controller, this.widget}) : super(key: key);

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: titleStyle),
          Container(
            padding:const EdgeInsets.only(left: 14),
            margin: const EdgeInsets.only(top: 12),
            width: SizeConfig.screenWidth,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              children: [
                Expanded(child: TextFormField(
                  style: subTitleStyle,
                  readOnly: widget!=null?true:false,
                  cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
                  controller: controller,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: subTitleStyle,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                        color: context.theme.colorScheme.background
                      ),
                    ),
                    focusedBorder:UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                          color: context.theme.colorScheme.background
                      ),
                    ),
                  ),
                ),),
                widget?? Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class OutlinedInputField extends TextField {
  OutlinedInputField({
    super.key,
    super.controller,
    super.focusNode,
    super.keyboardType,
    super.textInputAction,
    super.textCapitalization = TextCapitalization.none,
    super.style,
    super.strutStyle,
    super.textAlign = TextAlign.start,
    super.textAlignVertical,
    super.textDirection,
    super.readOnly = false,
    super.toolbarOptions,
    IconButton? suffixIcon,
  }) : super(
         decoration: InputDecoration(
           border: const OutlineInputBorder(
             borderRadius: BorderRadius.all(Radius.circular(10.0)),
           ),
           suffixIcon: suffixIcon,
         ),
       );
}

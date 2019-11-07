import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  InputTextField({
    this.hintText,
    this.onChanged,
    this.maxLines,
//    this.maxLengthEnforced,
  });

  final Function onChanged;
  final String hintText;
  final int maxLines;
//  final bool maxLengthEnforced;

  @override
  Widget build(BuildContext context) {
    return TextField(
      expands: false,
      minLines: 1,
      maxLines: maxLines ?? 1,

//      maxLengthEnforced: maxLengthEnforced ?? false,
      style: TextStyle(
        color: Colors.black,
      ),
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}

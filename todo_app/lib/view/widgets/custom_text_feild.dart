import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFeild extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool? isobscureText;
  final String? obscuringCharacter;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomTextFeild({
    super.key,
    required this.controller,
    required this.keyboardType,
    this.isobscureText,
    this.obscuringCharacter,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isobscureText!,
      obscuringCharacter: obscuringCharacter!,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.black,
      ),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 12.0),
          constraints: BoxConstraints(
            maxHeight: height * 0.065,
            maxWidth: width,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: 'Email',
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tafeel_task/core/theme/app_colors.dart';

class CustomTextFiled extends StatelessWidget {
  final String? hintText;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final int? maxLines;
  final String? helperText;
  final Color? fillColor;
  

  const CustomTextFiled({
    super.key,
    this.hintText,
    this.hintStyle,
    this.controller,
    this.maxLines,
    
    this.onChanged,
    this.fillColor,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      onChanged: onChanged,
      controller: controller,
      style: hintStyle ??
          TextStyle(
            color: AppColors.secondary,
            fontSize: 14,
          ),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ?? AppColors.primary,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
            vertical: MediaQuery.of(context).size.height * 0.02),
        hintText: hintText,
        hintStyle: hintStyle ??
            TextStyle(
              color: AppColors.secondary,
              fontSize: 14,
            ),
        helperText: helperText,
      ),
    );
  }
}

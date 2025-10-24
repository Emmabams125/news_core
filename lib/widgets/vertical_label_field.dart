import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/resources/app_colours.dart';

class VerticalLabelField extends StatelessWidget {
  const VerticalLabelField({
    super.key,
    required this.label,
    this.suffixIcon,
    this.prefix,
    this.prefixIcon,
    this.hintText,
    this.validator,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.defaultValidation = true,
    this.inputFormatters,
    this.profile,
    this.enabled = true,
    this.readOnly = false,
    this.contextPadding,
    this.focusNode,
    this.mainFieldFlex = 1,
    this.prefixFlex = 1,
    this.decoration,
    required TextStyle style,
  });

  final String label;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? prefixIcon;
  final String? hintText;
  final String? Function(String? value)? validator;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool defaultValidation;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? profile;
  final bool enabled;
  final bool readOnly;
  final EdgeInsetsGeometry? contextPadding;
  final FocusNode? focusNode;
  final int mainFieldFlex;
  final int prefixFlex;
  final InputDecoration? decoration; // ✅ store the decoration

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            color: AppColors.darkNavy,
            height: 1.2,
          ),
        ),
        const Gap(10),
        Row(
          children: [
            if (prefix != null) ...[
              Expanded(child: prefix!, flex: prefixFlex),
              const Gap(10),
            ],
            Expanded(
              flex: mainFieldFlex,
              child: TextField(
                controller: controller,
                style: TextStyle(
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkNavy,
                ),
                focusNode: focusNode,
                keyboardType: keyboardType,
                obscureText: obscureText,
                inputFormatters: inputFormatters,
                enabled: enabled,
                readOnly: readOnly,
                decoration: (decoration ?? const InputDecoration()).copyWith(
                  contentPadding:
                      contextPadding ??
                      const EdgeInsets.symmetric(
                        vertical:
                            12, // reduce this value to make the field shorter
                        horizontal: 12,
                      ),
                ), // apply decoration
              ),
            ),
          ],
        ),
      ],
    );
  }
}

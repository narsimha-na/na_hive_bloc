import 'package:flutter/material.dart';
import 'package:na_hive_bloc/constants/color_helper.dart';

class PrimaryButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final bool isLoading;
  const PrimaryButton(
      {required this.onPressed,
      this.isLoading = false,
      required this.label,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 52,
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Center(
          child: isLoading
              ? const Padding(
                  padding: EdgeInsets.all(10),
                  child: CircularProgressIndicator(
                    color: primaryTextColor,
                  ),
                )
              : Text(
                  label,
                  style: const TextStyle(
                    color: primaryTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  const SecondaryButton(
      {required this.onPressed, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 52,
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: secondaryTextColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

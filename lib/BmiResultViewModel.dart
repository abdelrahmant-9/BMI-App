import 'package:flutter/material.dart';

class BmiResultViewModel {
  final double bmi;
  final String status;
  final String message;
  final Color color;

  BmiResultViewModel({required this.bmi})
      : status = _getStatus(bmi),
        message = _getMessage(bmi),
        color = _getColor(bmi);

  static String _getStatus(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi < 25) {
      return 'Normal';
    } else if (bmi < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  static String _getMessage(double bmi) {
    if (bmi < 18.5) {
      return 'Your BMI is less than 18.5';
    } else if (bmi < 25) {
      return 'Your BMI is between 18.5 and 24.9';
    } else if (bmi < 30) {
      return 'Your BMI is between 25 and 29.9';
    } else {
      return 'Your BMI is 30 or higher';
    }
  }

  static Color _getColor(double bmi) {
    if (bmi < 18.5) {
      return Colors.blue;
    } else if (bmi < 25) {
      return Colors.green;
    } else if (bmi < 30) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}

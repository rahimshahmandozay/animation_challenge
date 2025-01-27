import 'package:flutter/material.dart';

class HeadphonesModel {
  final String image;
  final Color color;

  const HeadphonesModel({
    required this.image,
    required this.color,
  });
}

List<HeadphonesModel> product = [
  HeadphonesModel(
    image: "assets/images/image1.png",
    color: Color(0xFF000000),
  ),
  HeadphonesModel(
    image: "assets/images/image2.png",
    color: Color(0xFFB6D7E4),
  ),
  HeadphonesModel(
    image: "assets/images/image3.png",
    color: Color(0xFFFCECD0),
  ),
];

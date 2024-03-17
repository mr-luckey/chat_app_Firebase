import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundedImageNetwork extends StatelessWidget {
  final String imagePath;
  final double size;
  const RoundedImageNetwork(
      {required key, required this.imagePath, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          color: Colors.grey,
          // shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imagePath),
          ),
          borderRadius: BorderRadius.circular(size)),
    );
  }
}

class RoundedImagefile extends StatelessWidget {
  final File? image;
  final double size;
  const RoundedImagefile(
      {required Key key, required this.image, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          color: Colors.grey,
          // shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(image!.path!),
          ),
          borderRadius: BorderRadius.circular(size)),
    );
  }
}

// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:widget_mask/widget_mask.dart';

class CroppedImage extends StatefulWidget {
  final CroppedFile image;

  const CroppedImage({super.key, required this.image});

  @override
  State<CroppedImage> createState() => _CroppedImage();
}

class _CroppedImage extends State<CroppedImage> {
  bool _isMasked = false;

  void _toggleMask() {
    setState(() {
      _isMasked = !_isMasked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cropped Image'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 39, 39, 40),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Stack(
                  children: [
                    _buildNormalImage(),
                    if (_isMasked) _buildMask(),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _toggleMask,
              child: Text(_isMasked ? 'Show Original' : 'Apply Mask'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNormalImage() {
    return Image(
      image: FileImage(File(widget.image.path)),

    );
  }

  Widget _buildMask() {
    return Positioned.fill(
      child: WidgetMask(
        blendMode:
            BlendMode.dstIn, // Use srcIn to show the image inside the mask
        mask: Center(
          child: Image.asset(
            'assets/images/star.png',
              height: 800,
            width: 800,
          ),
        ),
        child: const SizedBox(),
      ),
    );
  }
}

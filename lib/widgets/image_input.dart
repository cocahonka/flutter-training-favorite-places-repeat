import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({required this.onSaved, super.key});

  final ValueSetter<File> onSaved;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _photo;

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final photo = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (photo == null) return;

    setState(() {
      _photo = File(photo.path);
      widget.onSaved(_photo!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: _photo == null
          ? TextButton.icon(
              label: const Text('Take Picture'),
              icon: const Icon(Icons.camera),
              onPressed: _takePhoto,
            )
          : GestureDetector(
              onTap: _takePhoto,
              child: Image.file(
                _photo!,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}

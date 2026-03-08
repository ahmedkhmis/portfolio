import 'package:app/utilities/extensions.dart';
import 'package:flutter/material.dart';
import 'package:app/utilities/app_constants.dart';

class AnimatedBackgroundImage extends StatefulWidget {
  final ScrollController scrollController;

  const AnimatedBackgroundImage(this.scrollController, {super.key});

  @override
  State<AnimatedBackgroundImage> createState() =>
      _AnimatedBackgroundImageState();
}

class _AnimatedBackgroundImageState extends State<AnimatedBackgroundImage> {
  late double _y;

  @override
  void initState() {
    super.initState();
    _y = 0.0;
    widget.scrollController.addListener(() {
      final offset = widget.scrollController.offset;
      if (offset < 500) {
        setState(() => _y = widget.scrollController.offset / 1000);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = context.isMobile ? 440.0 : 540.0;
    return SizedBox(
      height: height,
      width: double.maxFinite,
      child: Opacity(
        opacity: 0.08,
        child: Image.asset(
          AppConstants.logoAssetPath,
          fit: BoxFit.contain,
          alignment: Alignment(0.0, _y),
          errorBuilder: (_, __, ___) => Image.asset(
            'assets/images/transparent.png',
            fit: BoxFit.cover,
            alignment: Alignment(0.0, _y),
          ),
        ),
      ),
    );
  }
}

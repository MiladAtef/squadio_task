import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BottomInfoSheet extends StatelessWidget {
  final List<Widget> child;
  final String backdrops;
  final double? minSize;
  const BottomInfoSheet({
    Key? key,
    required this.child,
    required this.backdrops,
    this.minSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: DraggableScrollableSheet(
          initialChildSize: minSize ?? 0.65,
          minChildSize: minSize ?? 0.65,
          maxChildSize: 0.9,
          builder: (context, con) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(backdrops),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 100),
                  child: Container(
                    color: Colors.black87.withOpacity(.7),
                    child: ListView(
                      controller: con,
                      children: child,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
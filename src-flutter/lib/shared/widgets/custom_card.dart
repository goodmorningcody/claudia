import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius = 12.0,
    this.elevation = 2.0,
    this.border,
    this.onTap,
    this.width,
    this.height,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double borderRadius;
  final double elevation;
  final BorderSide? border;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: width,
      height: height,
      margin: margin,
      child: Material(
        color: backgroundColor ?? AppColors.surfaceContainer,
        elevation: elevation,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          decoration: border != null
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.fromBorderSide(border!),
                )
              : null,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Padding(
              padding: padding ?? const EdgeInsets.all(16.0),
              child: child,
            ),
          ),
        ),
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: card,
      );
    }

    return card;
  }
}

// Specialized card types
class CustomCardVariants {
  static Widget elevated({
    Key? key,
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    double? width,
    double? height,
  }) =>
      CustomCard(
        key: key,
        padding: padding,
        margin: margin,
        onTap: onTap,
        width: width,
        height: height,
        elevation: 4.0,
        child: child,
      );

  static Widget outline({
    Key? key,
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    double? width,
    double? height,
  }) =>
      CustomCard(
        key: key,
        padding: padding,
        margin: margin,
        onTap: onTap,
        width: width,
        height: height,
        elevation: 0,
        backgroundColor: Colors.transparent,
        border: BorderSide(color: AppColors.outline),
        child: child,
      );

  static Widget flat({
    Key? key,
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    double? width,
    double? height,
  }) =>
      CustomCard(
        key: key,
        padding: padding,
        margin: margin,
        onTap: onTap,
        width: width,
        height: height,
        elevation: 0,
        child: child,
      );
}
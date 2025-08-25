import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'custom_button.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.width,
    this.height,
    this.padding,
  });

  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: width,
        height: height,
        padding: padding ?? const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null) ...[
              DefaultTextStyle(
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                child: title!,
              ),
              const SizedBox(height: 16),
            ],
            if (content != null) ...[
              Flexible(
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                  child: content!,
                ),
              ),
              const SizedBox(height: 24),
            ],
            if (actions != null && actions!.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!
                    .map((action) => Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: action,
                        ))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    Widget? title,
    Widget? content,
    List<Widget>? actions,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => CustomDialog(
        title: title,
        content: content,
        actions: actions,
        width: width,
        height: height,
        padding: padding,
      ),
    );
  }
}

// Specialized dialog types
class CustomAlertDialog extends CustomDialog {
  CustomAlertDialog({
    super.key,
    required String title,
    required String message,
    String confirmText = 'OK',
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) : super(
          title: Text(title),
          content: Text(message),
          actions: [
            if (cancelText != null)
              CustomButtonConstructors.outline(
                onPressed: onCancel,
                child: Text(cancelText),
              ),
            CustomButtonConstructors.primary(
              onPressed: onConfirm,
              child: Text(confirmText),
            ),
          ],
        );

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'OK',
    String? cancelText,
    bool barrierDismissible = true,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => CustomAlertDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: cancelText != null ? () => Navigator.of(context).pop(false) : null,
      ),
    );
  }
}

class CustomConfirmDialog extends CustomDialog {
  CustomConfirmDialog({
    super.key,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool destructive = false,
  }) : super(
          title: Text(title),
          content: Text(message),
          actions: [
            CustomButtonConstructors.outline(
              onPressed: onCancel ?? () {},
              child: Text(cancelText),
            ),
            destructive
                ? CustomButtonConstructors.destructive(
                    onPressed: onConfirm,
                    child: Text(confirmText),
                  )
                : CustomButtonConstructors.primary(
                    onPressed: onConfirm,
                    child: Text(confirmText),
                  ),
          ],
        );

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool destructive = false,
    bool barrierDismissible = true,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => CustomConfirmDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        destructive: destructive,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
      ),
    );
  }
}
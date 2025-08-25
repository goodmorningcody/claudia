import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum CustomButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  destructive,
}

enum CustomButtonSize {
  small,
  medium,
  large,
  icon,
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = CustomButtonVariant.primary,
    this.size = CustomButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final CustomButtonVariant variant;
  final CustomButtonSize size;
  final bool disabled;
  final bool loading;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: _getButtonHeight(),
      child: ElevatedButton(
        onPressed: (disabled || loading) ? null : onPressed,
        style: _getButtonStyle(theme),
        child: loading
            ? SizedBox(
                width: _getIconSize(),
                height: _getIconSize(),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getLoadingColor(),
                  ),
                ),
              )
            : child,
      ),
    );
  }

  ButtonStyle _getButtonStyle(ThemeData theme) {
    return ElevatedButton.styleFrom(
      backgroundColor: _getBackgroundColor(),
      foregroundColor: _getForegroundColor(),
      elevation: _getElevation(),
      padding: _getPadding(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: _getBorderSide(),
      ),
    ).copyWith(
      overlayColor: WidgetStateProperty.all(
        _getForegroundColor().withValues(alpha: 0.1),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case CustomButtonVariant.primary:
        return AppColors.primary;
      case CustomButtonVariant.secondary:
        return AppColors.secondary;
      case CustomButtonVariant.outline:
        return Colors.transparent;
      case CustomButtonVariant.ghost:
        return Colors.transparent;
      case CustomButtonVariant.destructive:
        return AppColors.error;
    }
  }

  Color _getForegroundColor() {
    switch (variant) {
      case CustomButtonVariant.primary:
        return AppColors.onPrimary;
      case CustomButtonVariant.secondary:
        return AppColors.onSecondary;
      case CustomButtonVariant.outline:
        return AppColors.primary;
      case CustomButtonVariant.ghost:
        return AppColors.onSurface;
      case CustomButtonVariant.destructive:
        return AppColors.onError;
    }
  }

  double _getElevation() {
    switch (variant) {
      case CustomButtonVariant.primary:
      case CustomButtonVariant.secondary:
      case CustomButtonVariant.destructive:
        return 2;
      case CustomButtonVariant.outline:
      case CustomButtonVariant.ghost:
        return 0;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case CustomButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case CustomButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal:16, vertical: 8);
      case CustomButtonSize.large:
        return const EdgeInsets.symmetric(horizontal:24, vertical: 12);
      case CustomButtonSize.icon:
        return const EdgeInsets.all(8);
    }
  }

  double _getButtonHeight() {
    switch (size) {
      case CustomButtonSize.small:
        return 32;
      case CustomButtonSize.medium:
        return 40;
      case CustomButtonSize.large:
        return 48;
      case CustomButtonSize.icon:
        return 40;
    }
  }

  double _getIconSize() {
    switch (size) {
      case CustomButtonSize.small:
        return 14;
      case CustomButtonSize.medium:
        return 16;
      case CustomButtonSize.large:
        return 18;
      case CustomButtonSize.icon:
        return 16;
    }
  }

  BorderSide _getBorderSide() {
    if (variant == CustomButtonVariant.outline) {
      return BorderSide(color: AppColors.outline, width: 1);
    }
    return BorderSide.none;
  }

  Color _getLoadingColor() {
    switch (variant) {
      case CustomButtonVariant.outline:
      case CustomButtonVariant.ghost:
        return AppColors.primary;
      default:
        return _getForegroundColor();
    }
  }
}

// Convenience constructors
extension CustomButtonConstructors on CustomButton {
  static CustomButton primary({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    CustomButtonSize size = CustomButtonSize.medium,
    bool disabled = false,
    bool loading = false,
    bool fullWidth = false,
  }) =>
      CustomButton(
        key: key,
        onPressed: onPressed,
        variant: CustomButtonVariant.primary,
        size: size,
        disabled: disabled,
        loading: loading,
        fullWidth: fullWidth,
        child: child,
      );

  static CustomButton secondary({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    CustomButtonSize size = CustomButtonSize.medium,
    bool disabled = false,
    bool loading = false,
    bool fullWidth = false,
  }) =>
      CustomButton(
        key: key,
        onPressed: onPressed,
        variant: CustomButtonVariant.secondary,
        size: size,
        disabled: disabled,
        loading: loading,
        fullWidth: fullWidth,
        child: child,
      );

  static CustomButton outline({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    CustomButtonSize size = CustomButtonSize.medium,
    bool disabled = false,
    bool loading = false,
    bool fullWidth = false,
  }) =>
      CustomButton(
        key: key,
        onPressed: onPressed,
        variant: CustomButtonVariant.outline,
        size: size,
        disabled: disabled,
        loading: loading,
        fullWidth: fullWidth,
        child: child,
      );

  static CustomButton ghost({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    CustomButtonSize size = CustomButtonSize.medium,
    bool disabled = false,
    bool loading = false,
    bool fullWidth = false,
  }) =>
      CustomButton(
        key: key,
        onPressed: onPressed,
        variant: CustomButtonVariant.ghost,
        size: size,
        disabled: disabled,
        loading: loading,
        fullWidth: fullWidth,
        child: child,
      );

  static CustomButton destructive({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    CustomButtonSize size = CustomButtonSize.medium,
    bool disabled = false,
    bool loading = false,
    bool fullWidth = false,
  }) =>
      CustomButton(
        key: key,
        onPressed: onPressed,
        variant: CustomButtonVariant.destructive,
        size: size,
        disabled: disabled,
        loading: loading,
        fullWidth: fullWidth,
        child: child,
      );
}
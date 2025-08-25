import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../constants/app_colors.dart';

enum IconSize {
  small,
  medium,
  large,
  extraLarge,
}

class CustomIcon extends StatelessWidget {
  const CustomIcon(
    this.icon, {
    super.key,
    this.size = IconSize.medium,
    this.color,
    this.semanticLabel,
  });

  final IconData icon;
  final IconSize size;
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: _getIconSize(),
      color: color ?? AppColors.onSurface,
      semanticLabel: semanticLabel,
    );
  }

  double _getIconSize() {
    switch (size) {
      case IconSize.small:
        return 16.0;
      case IconSize.medium:
        return 24.0;
      case IconSize.large:
        return 32.0;
      case IconSize.extraLarge:
        return 48.0;
    }
  }
}

// Common icons used throughout the app
class AppIcons {
  // Window controls
  static const close = LucideIcons.x;
  static const minimize = LucideIcons.minus;
  static const maximize = LucideIcons.square;
  static const restore = LucideIcons.copy;
  
  // Navigation
  static const home = LucideIcons.home;
  static const back = LucideIcons.arrowLeft;
  static const forward = LucideIcons.arrowRight;
  static const up = LucideIcons.arrowUp;
  static const down = LucideIcons.arrowDown;
  
  // Actions
  static const add = LucideIcons.plus;
  static const edit = LucideIcons.edit;
  static const delete = LucideIcons.trash2;
  static const save = LucideIcons.save;
  static const copy = LucideIcons.copy;
  static const paste = LucideIcons.clipboard;
  static const search = LucideIcons.search;
  static const filter = LucideIcons.filter;
  static const sort = LucideIcons.arrowUpDown;
  static const refresh = LucideIcons.rotateCw;
  
  // Files and folders
  static const file = LucideIcons.file;
  static const folder = LucideIcons.folder;
  static const folderOpen = LucideIcons.folderOpen;
  static const download = LucideIcons.download;
  static const upload = LucideIcons.upload;
  static const attach = LucideIcons.paperclip;
  
  // Communication
  static const message = LucideIcons.messageSquare;
  static const send = LucideIcons.send;
  static const phone = LucideIcons.phone;
  static const video = LucideIcons.video;
  static const mail = LucideIcons.mail;
  
  // Status
  static const success = LucideIcons.check;
  static const error = LucideIcons.x;
  static const warning = LucideIcons.alertTriangle;
  static const info = LucideIcons.info;
  static const loading = LucideIcons.loader2;
  
  // User interface
  static const user = LucideIcons.user;
  static const users = LucideIcons.users;
  static const settings = LucideIcons.settings;
  static const menu = LucideIcons.menu;
  static const moreHorizontal = LucideIcons.moreHorizontal;
  static const moreVertical = LucideIcons.moreVertical;
  
  // Media
  static const play = LucideIcons.play;
  static const pause = LucideIcons.pause;
  static const stop = LucideIcons.square;
  static const volume = LucideIcons.volume2;
  static const volumeOff = LucideIcons.volumeX;
  static const image = LucideIcons.image;
  
  // Development
  static const code = LucideIcons.code;
  static const terminal = LucideIcons.terminal;
  static const git = LucideIcons.gitBranch;
  static const database = LucideIcons.database;
  static const server = LucideIcons.server;
  static const bug = LucideIcons.bug;
  
  // Claudia specific
  static const agent = LucideIcons.bot;
  static const session = LucideIcons.messageCircle;
  static const project = LucideIcons.folderClosed;
  static const timeline = LucideIcons.clock;
  static const checkpoint = LucideIcons.bookmark;
  static const usage = LucideIcons.barChart3;
  static const mcp = LucideIcons.plug;
}

// Icon button component
class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = IconSize.medium,
    this.color,
    this.backgroundColor,
    this.tooltip,
    this.padding,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final IconSize size;
  final Color? color;
  final Color? backgroundColor;
  final String? tooltip;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: backgroundColor ?? Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(8.0),
          child: CustomIcon(
            icon,
            size: size,
            color: color,
          ),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}

// Window control buttons
class WindowControlButton extends StatelessWidget {
  const WindowControlButton({
    super.key,
    required this.type,
    required this.onPressed,
  });

  final WindowControlType type;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: _getColor(),
        shape: BoxShape.circle,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(6),
          child: _getIcon(),
        ),
      ),
    );
  }

  Color _getColor() {
    switch (type) {
      case WindowControlType.close:
        return AppColors.windowClose;
      case WindowControlType.minimize:
        return AppColors.windowMinimize;
      case WindowControlType.maximize:
        return AppColors.windowMaximize;
    }
  }

  Widget? _getIcon() {
    // Icons appear on hover in real macOS, but for simplicity we'll show them always
    switch (type) {
      case WindowControlType.close:
        return const Icon(
          Icons.close,
          size: 8,
          color: Colors.black54,
        );
      case WindowControlType.minimize:
        return const Icon(
          Icons.remove,
          size: 8,
          color: Colors.black54,
        );
      case WindowControlType.maximize:
        return const Icon(
          Icons.fullscreen,
          size: 8,
          color: Colors.black54,
        );
    }
  }
}

enum WindowControlType {
  close,
  minimize,
  maximize,
}
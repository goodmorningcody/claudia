import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomTabController extends ChangeNotifier {
  CustomTabController({int initialIndex = 0}) : _index = initialIndex;

  int _index;
  int get index => _index;

  set index(int newIndex) {
    if (_index != newIndex) {
      _index = newIndex;
      notifyListeners();
    }
  }

  void animateTo(int index) {
    this.index = index;
  }
}

class CustomTab {
  const CustomTab({
    required this.text,
    this.icon,
    this.closeable = false,
  });

  final String text;
  final IconData? icon;
  final bool closeable;
}

class CustomTabs extends StatefulWidget {
  const CustomTabs({
    super.key,
    required this.tabs,
    required this.children,
    this.controller,
    this.onTabClose,
    this.onTabChange,
    this.isScrollable = false,
    this.padding,
  });

  final List<CustomTab> tabs;
  final List<Widget> children;
  final CustomTabController? controller;
  final Function(int index)? onTabClose;
  final Function(int index)? onTabChange;
  final bool isScrollable;
  final EdgeInsetsGeometry? padding;

  @override
  State<CustomTabs> createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabs> {
  late CustomTabController _controller;
  late bool _controllerCreated;

  @override
  void initState() {
    super.initState();
    _controllerCreated = widget.controller == null;
    _controller = widget.controller ?? CustomTabController();
    _controller.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTabChange);
    if (_controllerCreated) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _handleTabChange() {
    if (widget.onTabChange != null) {
      widget.onTabChange!(_controller.index);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: widget.padding ?? const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.outlineWithOpacity),
          ),
          child: widget.isScrollable
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _buildTabRow(),
                )
              : _buildTabRow(),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: IndexedStack(
            index: _controller.index,
            children: widget.children,
          ),
        ),
      ],
    );
  }

  Widget _buildTabRow() {
    return Row(
      mainAxisSize: widget.isScrollable ? MainAxisSize.min : MainAxisSize.max,
      children: widget.tabs.asMap().entries.map((entry) {
        final index = entry.key;
        final tab = entry.value;
        final isSelected = index == _controller.index;

        return Flexible(
          flex: widget.isScrollable ? 0 : 1,
          child: _CustomTabButton(
            tab: tab,
            isSelected: isSelected,
            onTap: () => _controller.animateTo(index),
            onClose: tab.closeable && widget.onTabClose != null
                ? () => widget.onTabClose!(index)
                : null,
          ),
        );
      }).toList(),
    );
  }
}

class _CustomTabButton extends StatelessWidget {
  const _CustomTabButton({
    required this.tab,
    required this.isSelected,
    required this.onTap,
    this.onClose,
  });

  final CustomTab tab;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Material(
        color: isSelected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (tab.icon != null) ...[
                  Icon(
                    tab.icon,
                    size: 16,
                    color: isSelected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                ],
                Flexible(
                  child: Text(
                    tab.text,
                    style: TextStyle(
                      color: isSelected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
                      fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (onClose != null) ...[
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: onClose,
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      child: Icon(
                        Icons.close,
                        size: 14,
                        color: isSelected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Convenience widgets for common tab patterns
class CustomTabView extends StatelessWidget {
  const CustomTabView({
    super.key,
    required this.tabs,
    required this.children,
    this.controller,
    this.onTabChange,
  });

  final List<CustomTab> tabs;
  final List<Widget> children;
  final CustomTabController? controller;
  final Function(int index)? onTabChange;

  @override
  Widget build(BuildContext context) {
    return CustomTabs(
      tabs: tabs,
      controller: controller,
      onTabChange: onTabChange,
      children: children,
    );
  }
}

class ScrollableCustomTabView extends StatelessWidget {
  const ScrollableCustomTabView({
    super.key,
    required this.tabs,
    required this.children,
    this.controller,
    this.onTabChange,
    this.onTabClose,
  });

  final List<CustomTab> tabs;
  final List<Widget> children;
  final CustomTabController? controller;
  final Function(int index)? onTabChange;
  final Function(int index)? onTabClose;

  @override
  Widget build(BuildContext context) {
    return CustomTabs(
      tabs: tabs,
      controller: controller,
      onTabChange: onTabChange,
      onTabClose: onTabClose,
      isScrollable: true,
      children: children,
    );
  }
}
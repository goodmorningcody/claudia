import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'shared/theme/app_theme.dart';
import 'shared/constants/app_colors.dart';
import 'shared/widgets/custom_button.dart';
import 'shared/widgets/custom_card.dart';
import 'shared/widgets/custom_icon.dart';
import 'shared/widgets/custom_dialog.dart';
import 'shared/widgets/animated_widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize window manager for desktop
  await windowManager.ensureInitialized();
  
  // Configure window properties
  WindowOptions windowOptions = const WindowOptions(
    size: Size(1200, 800),
    minimumSize: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  
  runApp(const ProviderScope(child: ClaudiaFlutterApp()));
}

class ClaudiaFlutterApp extends StatelessWidget {
  const ClaudiaFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Claudia Flutter',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryWithOpacity,
              AppColors.secondary.withValues(alpha: 0.8),
            ],
          ),
        ),
        child: Column(
          children: [
            // Custom title bar
            _buildTitleBar(context),
            // Main content with animations
            Expanded(
              child: Center(
                child: FadeInAnimation(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 300),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo with scale animation
                      ScaleInAnimation(
                        delay: const Duration(milliseconds: 500),
                        child: CustomCardVariants.elevated(
                          padding: const EdgeInsets.all(24),
                          child: CustomIcon(
                            AppIcons.agent,
                            size: IconSize.extraLarge,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      SlideInAnimation(
                        direction: SlideDirection.up,
                        delay: const Duration(milliseconds: 700),
                        child: Text(
                          'Claudia Flutter',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SlideInAnimation(
                        direction: SlideDirection.up,
                        delay: const Duration(milliseconds: 900),
                        child: Text(
                          'Phase 2: Core UI System Migration Complete!\nDesign System • Animations • Icons',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      SlideInAnimation(
                        direction: SlideDirection.up,
                        delay: const Duration(milliseconds: 1100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButtonConstructors.outline(
                              onPressed: () {
                                CustomDialog.show(
                                  context: context,
                                  title: const Text('Phase 2 Complete'),
                                  content: const Text('Core UI System Migration has been implemented successfully!'),
                                );
                              },
                              child: const Text('Show Dialog'),
                            ),
                            const SizedBox(width: 16),
                            CustomButtonConstructors.primary(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Phase 2 Complete: Core UI System Migration!'),
                                    backgroundColor: AppColors.success,
                                  ),
                                );
                              },
                              child: const Text('Get Started'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      SlideInAnimation(
                        direction: SlideDirection.up,
                        delay: const Duration(milliseconds: 1300),
                        child: _buildFeatureCards(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleBar(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.surfaceWithOpacity,
        border: Border(
          bottom: BorderSide(
            color: AppColors.outlineWithOpacity,
          ),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          CustomIcon(
            AppIcons.agent,
            size: IconSize.small,
            color: AppColors.primary,
          ),
          const SizedBox(width: 12),
          Text(
            'Claudia Flutter',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          // Window controls with proper styling
          Row(
            children: [
              WindowControlButton(
                type: WindowControlType.minimize,
                onPressed: () async {
                  await windowManager.minimize();
                },
              ),
              const SizedBox(width: 8),
              WindowControlButton(
                type: WindowControlType.maximize,
                onPressed: () async {
                  bool isMaximized = await windowManager.isMaximized();
                  if (isMaximized) {
                    await windowManager.unmaximize();
                  } else {
                    await windowManager.maximize();
                  }
                },
              ),
              const SizedBox(width: 8),
              WindowControlButton(
                type: WindowControlType.close,
                onPressed: () async {
                  await windowManager.close();
                },
              ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildFeatureCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFeatureCard(
          icon: AppIcons.settings,
          title: 'Design System',
          description: 'Custom components\nwith variants',
        ),
        const SizedBox(width: 16),
        _buildFeatureCard(
          icon: AppIcons.image,
          title: 'Animations',
          description: 'Smooth transitions\nand effects',
        ),
        const SizedBox(width: 16),
        _buildFeatureCard(
          icon: AppIcons.agent,
          title: 'Icons',
          description: 'Lucide icon system\nintegrated',
        ),
      ],
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return AnimatedCard(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: 120,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIcon(
              icon,
              size: IconSize.large,
              color: AppColors.primary,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

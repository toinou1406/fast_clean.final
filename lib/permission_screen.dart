import 'dart:async';
import 'package:fastclean/action_button.dart';
import 'package:fastclean/constants.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fastclean/l10n/app_localizations.dart';
import 'aurora_widgets.dart'; // For AuroraPainter

class PermissionScreen extends StatefulWidget {
  final VoidCallback onPermissionGranted;
  final void Function(Locale) onLocaleChanged;

  const PermissionScreen({super.key, required this.onPermissionGranted, required this.onLocaleChanged});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen>
    with TickerProviderStateMixin {
  bool _isLoading = false;
  late AnimationController _animationController;
  late AnimationController _auroraController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  String _currentLanguageCode = 'en'; // Default language

  @override
  void initState() {
    super.initState();
    _loadCurrentLanguage();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _auroraController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _fadeAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _slideAnimation = Tween<Offset>(
            begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutCubic));

    _animationController.forward();
  }

  Future<void> _loadCurrentLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentLanguageCode = prefs.getString('language_code') ?? 'en';
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _auroraController.dispose();
    super.dispose();
  }

  Future<void> _requestPermission() async {
    setState(() => _isLoading = true);

    final result = await PhotoManager.requestPermissionExtend();

    if (result.hasAccess) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('permission_granted', true);
      widget.onPermissionGranted();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.photoAccessRequired),
            backgroundColor: Colors.red.shade700,
            action: SnackBarAction(
              label: AppLocalizations.of(context)!.settings,
              textColor: Colors.white,
              onPressed: () {
                PhotoManager.openSetting();
              },
            ),
          ),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipOval(
                      child: CustomPaint(
                        painter: AuroraPainter(
                          animation: _auroraController,
                          colors: const [etherealGreen, deepCyan, etherealGreen],
                          stops: const [0.2, 0.6, 1.0],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.photo_library_outlined,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    l10n.privacyFirst,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displayLarge?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.permissionScreenBody,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white.withAlpha(179),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 48),
                  _buildActionButton(),
                  const SizedBox(height: 48),
                  _buildLanguageSelector(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFlag('en', '🇬🇧', _currentLanguageCode == 'en'),
        const SizedBox(width: 24),
        _buildFlag('es', '🇪🇸', _currentLanguageCode == 'es'),
        const SizedBox(width: 24),
        _buildFlag('fr', '🇫🇷', _currentLanguageCode == 'fr'),
        const SizedBox(width: 24),
        _buildFlag('zh', '🇨🇳', _currentLanguageCode == 'zh'),
      ],
    );
  }

  Widget _buildFlag(String languageCode, String flag, bool isSelected) {
    return GestureDetector(
      onTap: () async {
        final newLocale = Locale(languageCode);
        widget.onLocaleChanged(newLocale);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('language_code', languageCode);
        setState(() {
          _currentLanguageCode = languageCode;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: isSelected
            ? BoxDecoration(
                border: Border.all(color: etherealGreen, width: 2),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        child: Text(
          flag,
          style: const TextStyle(fontSize: 32),
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    final l10n = AppLocalizations.of(context)!;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: _isLoading
          ? const CircularProgressIndicator(
              key: ValueKey('loader'),
              valueColor: AlwaysStoppedAnimation<Color>(etherealGreen),
            )
          : ActionButton(
              key: const ValueKey('button'),
              label: l10n.grantAccessContinue,
              onPressed: _requestPermission,
            ),
    );
  }
}

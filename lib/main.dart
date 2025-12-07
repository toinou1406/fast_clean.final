import 'dart:async';
import 'dart:developer' as developer;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'constants.dart';
import 'action_button.dart';

// Aurora & Custom Widgets
import 'aurora_widgets.dart';
import 'aurora_circular_indicator.dart';
import 'full_screen_image_view.dart';
import 'permission_screen.dart';
import 'language_settings_screen.dart';
import 'photo_analyzer.dart';
import 'photo_cleaner_service.dart';
import 'saved_space_indicator.dart';
import 'sorting_indicator_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool permissionGranted = prefs.getBool('permission_granted') ?? false;
  final String? languageCode = prefs.getString('language_code');

  runApp(MyApp(
    initialRoute: permissionGranted ? AppRoutes.home : AppRoutes.permission,
    locale: languageCode != null ? Locale(languageCode) : null,
  ));
}

class AppRoutes {
  static const String home = '/';
  static const String permission = '/permission';
  static const String settings = '/settings';
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.initialRoute, this.locale});
  final String initialRoute;
  final Locale? locale;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = widget.locale ?? AppLocalizations.supportedLocales.first;
  }

  void changeLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme appTextTheme = GoogleFonts.interTextTheme(
      ThemeData.dark().textTheme,
    ).copyWith(
      displayLarge: GoogleFonts.inter(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
      titleLarge: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w600, color: offWhite),
      titleMedium: GoogleFonts.inter(fontSize: 18, color: offWhite.withAlpha(230)),
      bodyMedium: GoogleFonts.inter(fontSize: 14, color: offWhite.withAlpha(179)),
      labelLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: darkCharcoal),
    );

    final ThemeData theme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: darkCharcoal,
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        onPrimary: darkCharcoal,
        secondary: offWhite,
        surface: Color(0xFF2C2C2C),
        onSurface: offWhite,
        error: Colors.redAccent,
      ),
      textTheme: appTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, color: offWhite),
      ),
    );

    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: theme,
      locale: _locale,
      debugShowCheckedModeBanner: false,
      initialRoute: widget.initialRoute,
      routes: {
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.permission: (context) => PermissionScreen(
          onPermissionGranted: () {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          },
          onLocaleChanged: changeLocale,
        ),
        AppRoutes.settings: (context) => LanguageSettingsScreen(onLocaleChanged: changeLocale),
      },
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final PhotoCleanerService _service = PhotoCleanerService();

  StorageInfo? _storageInfo;
  double _spaceSaved = 0.0;
  List<PhotoResult> _selectedPhotos = [];
  final Set<String> _ignoredPhotos = {};
  bool _isLoading = false;
  bool _isDeleting = false;
  bool _hasScanned = false;
  String _sortingMessage = ""; // Default will be set from l10n
  Timer? _messageTimer;
  bool _isInitialized = false;

  List<String> _getSortingMessages() {
    final l10n = AppLocalizations.of(context)!;
    return [
      l10n.sortingMessageAnalyzing,
      l10n.sortingMessageBlurry,
      l10n.sortingMessageScreenshots,
      l10n.sortingMessageDuplicates,
      l10n.sortingMessageScores,
      l10n.sortingMessageCompiling,
      l10n.sortingMessageRanking,
      l10n.sortingMessageFinalizing,
    ];
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _loadStorageInfo();
    await _resetMonthlySavedSpace();
    await _loadSavedSpace();
    await _restoreState();
    if (mounted) {
      setState(() => _isInitialized = true);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _messageTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _saveState();
    }
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selected_photo_ids', _selectedPhotos.map((p) => p.asset.id).toList());
    await prefs.setStringList('ignored_photo_ids', _ignoredPhotos.toList());
    await prefs.setBool('has_scanned', _hasScanned);
  }

  Future<void> _restoreState() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('selected_photo_ids')) return;

    final photoIds = prefs.getStringList('selected_photo_ids') ?? [];
    final ignoredIds = prefs.getStringList('ignored_photo_ids') ?? [];
    final hasScanned = prefs.getBool('has_scanned') ?? false;

    if (photoIds.isNotEmpty) {
      List<PhotoResult> restoredPhotos = [];
      for (final id in photoIds) {
        try {
          final asset = await AssetEntity.fromId(id);
          if (asset != null) {
            restoredPhotos.add(PhotoResult(asset, PhotoAnalysisResult.dummy()));
          }
        } catch (e) { /* Asset might have been deleted. */ }
      }

      if (mounted) {
        setState(() {
          _selectedPhotos = restoredPhotos;
          _ignoredPhotos.addAll(ignoredIds);
          _hasScanned = hasScanned;
        });
      }
    }
  }

  Future<void> _resetMonthlySavedSpace() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('lastSavedMonth') != DateTime.now().month) {
      setState(() => _spaceSaved = 0.0);
      await prefs.setDouble('spaceSaved', 0.0);
      await prefs.setInt('lastSavedMonth', DateTime.now().month);
    }
  }

  Future<void> _loadSavedSpace() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _spaceSaved = prefs.getDouble('spaceSaved') ?? 0.0);
  }

  Future<void> _saveSavedSpace() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('spaceSaved', _spaceSaved);
    await prefs.setInt('lastSavedMonth', DateTime.now().month);
  }

  String _formatBytes(double bytes, [int decimals = 2]) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  Future<void> _loadStorageInfo() async {
    final info = await _service.getStorageInfo();
    if (mounted) setState(() => _storageInfo = info);
  }

  Future<void> _sortPhotos({bool rescan = false}) async {
    final l10n = AppLocalizations.of(context)!;
    final sortingMessages = _getSortingMessages();

    setState(() {
      _isLoading = true;
      _sortingMessage = sortingMessages.first;
    });

    _messageTimer?.cancel();
    int msgIndex = 0;
    _messageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!_isLoading) { timer.cancel(); return; }
      setState(() => _sortingMessage = sortingMessages[++msgIndex % sortingMessages.length]);
    });

    try {
      if (rescan) _service.reset();
      await _service.scanPhotos(permissionErrorMessage: l10n.photoAccessRequired);
      if (mounted) setState(() => _hasScanned = true);

      final photos = await _service.selectPhotosToDelete(excludedIds: _ignoredPhotos.toList());

      if (mounted) {
        if (photos.isEmpty && _hasScanned) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.noMorePhotos)),
          );
        }
        setState(() => _selectedPhotos = photos);
        _preCachePhotoFiles(photos);
      }
    } catch (e, s) {
      developer.log('Error during photo sorting', name: 'photo_cleaner.error', error: e, stackTrace: s);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorOccurred(e.toString()))),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
      _messageTimer?.cancel();
    }
  }

  void _preCachePhotoFiles(List<PhotoResult> photos) {
    for (final photo in photos) {
      photo.asset.file; // no need to await
    }
  }

  Future<void> _deletePhotos() async {
    HapticFeedback.heavyImpact();
    setState(() => _isDeleting = true);

    try {
      final photosToDelete = _selectedPhotos.where((p) => !_ignoredPhotos.contains(p.asset.id)).toList();
      final Map<String, int> sizeMap = {};
      await Future.forEach(photosToDelete, (photo) async {
        final file = await photo.asset.file;
        sizeMap[photo.asset.id] = await file?.length() ?? 0;
      });

      final deletedIds = await _service.deletePhotos(photosToDelete);
      if (deletedIds.isEmpty && photosToDelete.isNotEmpty && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.couldNotDelete)));
        setState(() => _isDeleting = false);
        return;
      }

      int totalBytesDeleted = deletedIds.fold(0, (sum, id) => sum + (sizeMap[id] ?? 0));

      if (mounted) {
        setState(() {
          _selectedPhotos = [];
          _ignoredPhotos.clear();
          _spaceSaved += totalBytesDeleted;
        });
        _saveSavedSpace();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.photosDeleted(deletedIds.length, _formatBytes(totalBytesDeleted.toDouble())))),
        );
      }
      await _loadStorageInfo();
    } catch (e,s) {
      developer.log('Error deleting photos', name: 'photo_cleaner.error', error: e, stackTrace: s);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.errorDeleting(e.toString()))),
        );
      }
    } finally {
      if (mounted) setState(() => _isDeleting = false);
    }
  }

  void _toggleIgnoredPhoto(String id) {
    HapticFeedback.lightImpact();
    setState(() {
      if (_ignoredPhotos.contains(id)) {
        _ignoredPhotos.remove(id);
      } else {
        _ignoredPhotos.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator(color: etherealGreen)));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homeScreenTitle, key: const Key('homeScreenTitle'), style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: offWhite),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.settings);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                child: _buildMainContent(),
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    if (_selectedPhotos.isNotEmpty) {
      return GridView.builder(
        key: const ValueKey('grid'),
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 4, mainAxisSpacing: 4),
        itemCount: _selectedPhotos.length,
        itemBuilder: (context, index) {
          final photo = _selectedPhotos[index];
          return PhotoCard(
            key: ValueKey(photo.asset.id),
            photo: photo,
            isIgnored: _ignoredPhotos.contains(photo.asset.id),
            onToggleKeep: () => _toggleIgnoredPhoto(photo.asset.id),
            onOpenFullScreen: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullScreenImageView(
                  photos: _selectedPhotos,
                  initialIndex: index,
                  ignoredPhotos: _ignoredPhotos,
                  onToggleKeep: _toggleIgnoredPhoto,
                ),
              ),
            ),
          );
        },
      );
    }

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(etherealGreen)));
    }

    return EmptyState(
      key: const ValueKey('empty'),
      storageInfo: _storageInfo,
      spaceSaved: _spaceSaved,
      formattedSpaceSaved: _formatBytes(_spaceSaved),
    );
  }

  Widget _buildBottomBar() {
    if (_isDeleting) return const SizedBox.shrink();

    int photosToDeleteCount = _selectedPhotos.length - _ignoredPhotos.length;
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _isLoading
          ? SortingIndicatorBar(message: _sortingMessage)
          : _selectedPhotos.isNotEmpty
            ? Row(
                children: [
                  Expanded(
                    child: ActionButton(
                      label: l10n.reSort,
                      onPressed: () => _sortPhotos(),
                      isPrimary: false,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: photosToDeleteCount > 0
                      ? ActionButton(
                          label: l10n.delete(photosToDeleteCount),
                          onPressed: _deletePhotos,
                        )
                      : ActionButton(
                          label: l10n.pass,
                          onPressed: () => setState(() {
                            _selectedPhotos = [];
                            _ignoredPhotos.clear();
                          }),
                          isPrimary: false,
                        ),
                  ),
                ],
              )
            : ActionButton(
                label: l10n.analyzePhotos,
                onPressed: () => _sortPhotos(rescan: true),
                key: const Key('analyzePhotosButton'),
              ),
      ),
    );
  }
}

class PhotoCard extends StatefulWidget {
  final PhotoResult photo;
  final bool isIgnored;
  final VoidCallback onToggleKeep;
  final VoidCallback onOpenFullScreen;

  const PhotoCard({super.key, required this.photo, required this.isIgnored, required this.onToggleKeep, required this.onOpenFullScreen});

  @override
  State<PhotoCard> createState() => _PhotoCardState();
}

class _PhotoCardState extends State<PhotoCard> {
  Uint8List? _thumbnailData;

  @override
  void initState() {
    super.initState();
    _loadThumbnail();
  }

  Future<void> _loadThumbnail() async {
    final data = await widget.photo.asset.thumbnailDataWithSize(const ThumbnailSize(200, 200));
    if (mounted) setState(() => _thumbnailData = data);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onOpenFullScreen,
      onDoubleTap: widget.onToggleKeep,
      child: Hero(
        tag: widget.photo.asset.id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (_thumbnailData != null)
                Image.memory(_thumbnailData!, fit: BoxFit.cover)
              else
                Container(color: Colors.grey[850]),
              AnimatedOpacity(
                opacity: widget.isIgnored ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 250),
                child: AuroraBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderWidth: 3.0,
                  child: Container(), // Empty container, the border is the decoration
                ),
              ),
              AnimatedOpacity(
                opacity: widget.isIgnored ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 250),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.keep,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      shadows: [Shadow(blurRadius: 5.0, color: Colors.black87, offset: Offset(1,1))],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyState extends StatefulWidget {
  final StorageInfo? storageInfo;
  final double spaceSaved;
  final String formattedSpaceSaved;

  const EmptyState({super.key, required this.storageInfo, required this.spaceSaved, required this.formattedSpaceSaved});

  @override
  State<EmptyState> createState() => _EmptyStateState();
}

class _EmptyStateState extends State<EmptyState> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SavedSpaceIndicator(
              spaceSaved: widget.spaceSaved,
              formattedSpaceSaved: widget.formattedSpaceSaved,
            ),
            const SizedBox(height: 40),
            if (widget.storageInfo != null)
              AuroraCircularIndicator(storageInfo: widget.storageInfo!)
            else
              const CircularProgressIndicator(color: etherealGreen),
          ],
        ),
      ),
    );
  }
}

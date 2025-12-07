// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get privacyFirst => 'La confidentialité d\'abord';

  @override
  String get permissionScreenBody =>
      'FastClean analyse vos photos directement sur votre appareil. Rien n\'est jamais téléchargé sur un serveur.';

  @override
  String get grantAccessContinue => 'Autoriser l\'accès et continuer';

  @override
  String get homeScreenTitle => 'FastClean';

  @override
  String get sortingMessageAnalyzing => 'Analyse des métadonnées des photos...';

  @override
  String get sortingMessageBlurry => 'Détection des images floues...';

  @override
  String get sortingMessageScreenshots =>
      'Recherche de mauvaises captures d\'écran...';

  @override
  String get sortingMessageDuplicates => 'Vérification des doublons...';

  @override
  String get sortingMessageScores => 'Calcul des scores des photos...';

  @override
  String get sortingMessageCompiling => 'Compilation des résultats...';

  @override
  String get sortingMessageRanking =>
      'Classement des photos par \'mauvaise qualité\'...';

  @override
  String get sortingMessageFinalizing =>
      'Finalisation de la sélection de photos...';

  @override
  String get noMorePhotos => 'Plus de photos supprimables trouvées !';

  @override
  String errorOccurred(String error) {
    return 'Une erreur est survenue : $error';
  }

  @override
  String photosDeleted(int count, String space) {
    return '$count photos supprimées et $space économisés';
  }

  @override
  String errorDeleting(String error) {
    return 'Erreur lors de la suppression des photos : $error';
  }

  @override
  String get reSort => 'Retrier';

  @override
  String delete(int count) {
    return 'Supprimer ($count)';
  }

  @override
  String get pass => 'Passer';

  @override
  String get analyzePhotos => 'Analyser les photos';

  @override
  String fullScreenTitle(int count, int total) {
    return '$count sur $total';
  }

  @override
  String get kept => 'Gardée';

  @override
  String get keep => 'Garder';

  @override
  String get failedToLoadImage => 'Échec du chargement de l\'image';

  @override
  String get couldNotDelete =>
      'Impossible de supprimer les photos. Veuillez réessayer.';

  @override
  String get photoAccessRequired =>
      'Une autorisation d\'accès complète aux photos est requise.';

  @override
  String get settings => 'Paramètres';

  @override
  String get storageUsed => 'Stockage utilisé';

  @override
  String get spaceSavedThisMonth => 'Espace économisé (ce mois-ci)';

  @override
  String get appTitle => 'FastClean';

  @override
  String get chooseYourLanguage => 'Choisissez votre langue';
}

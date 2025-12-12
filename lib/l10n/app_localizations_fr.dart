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

  @override
  String get permissionTitle => 'Accès aux photos requis';

  @override
  String get permissionDescription =>
      'FastClean a besoin d\'accéder à vos photos pour vous aider à les nettoyer.';

  @override
  String get grantPermission => 'Autoriser l\'accès';

  @override
  String get totalSpaceSaved => 'Espace total économisé';

  @override
  String get readyToClean => 'Prêt à nettoyer ?';

  @override
  String get letsFindPhotos =>
      'Trouvons des photos que vous pouvez supprimer en toute sécurité.';

  @override
  String get storageSpaceSaved => 'Espace de stockage économisé';

  @override
  String get premiumWelcomeTitle => 'Bienvenue en Premium !';

  @override
  String get premiumWelcomeMessage =>
      'Vous bénéficiez de 7 jours d\'essai gratuit avec des tris illimités.';

  @override
  String get premiumTrialExpiredTitle => 'Essai Premium terminé';

  @override
  String get premiumTrialExpiredMessage =>
      'Vous êtes maintenant en mode normal. Vous pouvez trier 3 fois par jour. Passez à Premium pour des tris illimités.';

  @override
  String get dailySortLimitReachedTitle => 'Limite quotidienne atteinte';

  @override
  String get dailySortLimitReachedMessage =>
      'Vous avez utilisé vos 3 tris gratuits pour aujourd\'hui. Revenez demain ou passez à Premium.';

  @override
  String sortsLeft(Object count) {
    return '$count tris restants';
  }

  @override
  String get upgradeToPremium => 'Passer à Premium';

  @override
  String get premiumScreenTitle => 'FastClean Premium';

  @override
  String get premiumFeatureUnlimited => 'Tris illimités';

  @override
  String get premiumFeatureAdFree => 'Expérience sans publicité';

  @override
  String get premiumFeatureFuture => 'Accès aux futures fonctionnalités';

  @override
  String get monthlySubscription => 'Abonnement mensuel';

  @override
  String get yearlySubscription => 'Abonnement annuel';

  @override
  String get monthlyPrice => '2,99 \$/mois';

  @override
  String get yearlyPrice => '1,99 \$/mois';

  @override
  String get yearlyPriceSub => 'Facturé 23,88 \$ par an';

  @override
  String get mostPopular => 'Le plus populaire';

  @override
  String get continueButton => 'Continuer';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get spaceFreedForPremium => 'Espace libéré pour du Premium';

  @override
  String get oneDayPremiumEarned =>
      'Félicitations ! Vous avez gagné 1 jour de Premium !';
}

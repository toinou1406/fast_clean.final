// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get privacyFirst => 'Privacy First';

  @override
  String get permissionScreenBody =>
      'FastClean analyzes your photos directly on your device. Nothing is ever uploaded to a server.';

  @override
  String get grantAccessContinue => 'Grant Access & Continue';

  @override
  String get homeScreenTitle => 'FastClean';

  @override
  String get sortingMessageAnalyzing => 'Analyzing photo metadata...';

  @override
  String get sortingMessageBlurry => 'Detecting blurry images...';

  @override
  String get sortingMessageScreenshots => 'Searching for bad screenshots...';

  @override
  String get sortingMessageDuplicates => 'Checking for duplicates...';

  @override
  String get sortingMessageScores => 'Calculating photo scores...';

  @override
  String get sortingMessageCompiling => 'Compiling results...';

  @override
  String get sortingMessageRanking => 'Ranking photos by \'badness\'...';

  @override
  String get sortingMessageFinalizing => 'Finalizing the photo selection...';

  @override
  String get noMorePhotos => 'No more deletable photos found!';

  @override
  String errorOccurred(String error) {
    return 'An error occurred: $error';
  }

  @override
  String photosDeleted(int count, String space) {
    return 'Deleted $count photos and saved $space';
  }

  @override
  String errorDeleting(String error) {
    return 'Error deleting photos: $error';
  }

  @override
  String get reSort => 'Re-sort';

  @override
  String delete(int count) {
    return 'Delete ($count)';
  }

  @override
  String get pass => 'Pass';

  @override
  String get analyzePhotos => 'Analyze Photos';

  @override
  String fullScreenTitle(int count, int total) {
    return '$count of $total';
  }

  @override
  String get kept => 'Kept';

  @override
  String get keep => 'Keep';

  @override
  String get failedToLoadImage => 'Failed to load image';

  @override
  String get couldNotDelete => 'Could not delete photos. Please try again.';

  @override
  String get photoAccessRequired => 'Full photo access permission is required.';

  @override
  String get settings => 'Settings';

  @override
  String get storageUsed => 'Storage Used';

  @override
  String get spaceSavedThisMonth => 'Space Saved (This Month)';

  @override
  String get appTitle => 'FastClean';

  @override
  String get chooseYourLanguage => 'Choose your language';

  @override
  String get permissionTitle => 'Photo Access Required';

  @override
  String get permissionDescription =>
      'FastClean needs access to your photos to help you clean them up.';

  @override
  String get grantPermission => 'Grant Permission';

  @override
  String get totalSpaceSaved => 'Total Space Saved';

  @override
  String get readyToClean => 'Ready to Clean?';

  @override
  String get letsFindPhotos => 'Let\'s find some photos you can safely delete.';

  @override
  String get storageSpaceSaved => 'Storage Space Saved';

  @override
  String get premiumWelcomeTitle => 'Welcome to Premium!';

  @override
  String get premiumWelcomeMessage =>
      'You have a 7-day free trial with unlimited sorting.';

  @override
  String get premiumTrialExpiredTitle => 'Premium Trial Ended';

  @override
  String get premiumTrialExpiredMessage =>
      'You are now in normal mode. You can sort 3 times a day. Upgrade to Premium for unlimited sorting.';

  @override
  String get dailySortLimitReachedTitle => 'Daily Limit Reached';

  @override
  String get dailySortLimitReachedMessage =>
      'You have used your 3 free sorts for today. Come back tomorrow or upgrade to Premium.';

  @override
  String sortsLeft(Object count) {
    return '$count sorts left';
  }

  @override
  String get upgradeToPremium => 'Upgrade to Premium';

  @override
  String get premiumScreenTitle => 'FastClean Premium';

  @override
  String get premiumFeatureUnlimited => 'Unlimited Sorts';

  @override
  String get premiumFeatureAdFree => 'Ad-free Experience';

  @override
  String get premiumFeatureFuture => 'Access to Future Features';

  @override
  String get monthlySubscription => 'Monthly Subscription';

  @override
  String get yearlySubscription => 'Yearly Subscription';

  @override
  String get monthlyPrice => '\$2.99/month';

  @override
  String get yearlyPrice => '\$1.99/month';

  @override
  String get yearlyPriceSub => 'Billed \$23.88 per year';

  @override
  String get mostPopular => 'Most Popular';

  @override
  String get continueButton => 'Continue';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get spaceFreedForPremium => 'Space Freed for Premium';

  @override
  String get oneDayPremiumEarned =>
      'Congratulations! You\'ve earned 1 day of Premium!';
}

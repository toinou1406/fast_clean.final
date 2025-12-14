// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get privacyFirst => 'Конфіденційність перш за все';

  @override
  String get permissionScreenBody =>
      'FastClean аналізує ваші фотографії безпосередньо на вашому пристрої. Нічого ніколи не завантажується на сервер.';

  @override
  String get grantAccessContinue => 'Надати доступ і продовжити';

  @override
  String get homeScreenTitle => 'FastClean';

  @override
  String get sortingMessageAnalyzing => 'Аналіз метаданих фото...';

  @override
  String get sortingMessageBlurry => 'Виявлення розмитих зображень...';

  @override
  String get sortingMessageScreenshots => 'Пошук поганих знімків екрана...';

  @override
  String get sortingMessageDuplicates => 'Перевірка наявності дублікатів...';

  @override
  String get sortingMessageScores => 'Обчислення оцінок фотографій...';

  @override
  String get sortingMessageCompiling => 'Збір результатів...';

  @override
  String get sortingMessageRanking => 'Ранжування фотографій за «поганістю»...';

  @override
  String get sortingMessageFinalizing => 'Завершення вибору фотографій...';

  @override
  String get noMorePhotos => 'Більше не знайдено фотографій для видалення!';

  @override
  String errorOccurred(String error) {
    return 'Сталася помилка: $error';
  }

  @override
  String photosDeleted(int count, String space) {
    return 'Видалено $count фотографій і збережено $space';
  }

  @override
  String errorDeleting(String error) {
    return 'Помилка під час видалення фотографій: $error';
  }

  @override
  String get reSort => 'Повторне сортування';

  @override
  String delete(int count) {
    return 'Видалити ($count)';
  }

  @override
  String get pass => 'Пропустити';

  @override
  String get analyzePhotos => 'Аналізувати фотографії';

  @override
  String fullScreenTitle(int count, int total) {
    return '$count з $total';
  }

  @override
  String get kept => 'Збережено';

  @override
  String get keep => 'Зберегти';

  @override
  String get failedToLoadImage => 'Не вдалося завантажити зображення';

  @override
  String get couldNotDelete =>
      'Не вдалося видалити фотографії. Будь ласка спробуйте ще раз.';

  @override
  String get photoAccessRequired =>
      'Потрібен повний дозвіл на доступ до фотографій.';

  @override
  String get settings => 'Налаштування';

  @override
  String get storageUsed => 'Використано сховище';

  @override
  String get spaceSavedThisMonth => 'Збережено місця (цього місяця)';

  @override
  String get appTitle => 'FastClean';

  @override
  String get chooseYourLanguage => 'Виберіть свою мову';

  @override
  String get permissionTitle => 'Потрібен доступ до фотографій';

  @override
  String get permissionDescription =>
      'FastClean потребує доступу до ваших фотографій, щоб допомогти вам їх очистити.';

  @override
  String get grantPermission => 'Надати дозвіл';

  @override
  String get totalSpaceSaved => 'Загалом заощаджено місця';

  @override
  String get readyToClean => 'Готові до очищення?';

  @override
  String get letsFindPhotos =>
      'Давайте знайдемо фотографії, які можна безпечно видалити.';

  @override
  String get storageSpaceSaved => 'Збережено місце в сховищі';

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

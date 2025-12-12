
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fastclean/l10n/app_localizations.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.premiumScreenTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFeatureList(l10n, theme),
            const SizedBox(height: 32),
            _buildSubscriptionOption(
              context: context,
              title: l10n.yearlySubscription,
              price: l10n.yearlyPrice,
              subtitle: l10n.yearlyPriceSub,
              isPopular: true,
            ),
            const SizedBox(height: 16),
            _buildSubscriptionOption(
              context: context,
              title: l10n.monthlySubscription,
              price: l10n.monthlyPrice,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // TODO: Handle subscription logic
              },
              child: Text(l10n.continueButton),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // TODO: Handle restore purchases
              },
              child: Text(l10n.restorePurchases),
            ),
            const SizedBox(height: 24),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureList(AppLocalizations l10n, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFeatureItem(l10n.premiumFeatureUnlimited, Icons.all_inclusive_rounded, theme),
        const SizedBox(height: 12),
        _buildFeatureItem(l10n.premiumFeatureAdFree, Icons.tv_off_rounded, theme),
        const SizedBox(height: 12),
        _buildFeatureItem(l10n.premiumFeatureFuture, Icons.star_rounded, theme),
      ],
    );
  }

  Widget _buildFeatureItem(String text, IconData icon, ThemeData theme) {
    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 28),
        const SizedBox(width: 16),
        Expanded(
          child: Text(text, style: theme.textTheme.titleMedium),
        ),
      ],
    );
  }

  Widget _buildSubscriptionOption({
    required BuildContext context,
    required String title,
    required String price,
    String? subtitle,
    bool isPopular = false,
  }) {
    final theme = Theme.of(context);
    return Card(
      elevation: isPopular ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isPopular ? theme.colorScheme.primary : theme.dividerColor,
          width: isPopular ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            if (isPopular)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    AppLocalizations.of(context).mostPopular.toUpperCase(),
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            if (isPopular) const SizedBox(height: 8),
            Text(title, style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(price, style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold)),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(subtitle, style: theme.textTheme.bodyMedium),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {
            // TODO: Link to Terms of Service
          },
          child: Text(AppLocalizations.of(context).termsOfService),
        ),
        TextButton(
          onPressed: () {
            // TODO: Link to Privacy Policy
          },
          child: Text(AppLocalizations.of(context).privacyPolicy),
        ),
      ],
    );
  }
}

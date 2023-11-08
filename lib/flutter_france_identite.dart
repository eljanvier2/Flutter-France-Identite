library flutter_france_identite;

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// A custom button that opens the France Identité app.
///
/// This button can be customized with various parameters, including the button's dimensions, text, and behavior.
class FranceIdentiteButton extends StatelessWidget {
  /// The width of the button. Defaults to 340.
  final double width;

  /// The height of the button. Defaults to 130.
  final double height;

  /// The width of the logo. Defaults to 75.
  final double logoWidth;

  /// The height of the logo. Defaults to 75.
  final double logoHeight;

  /// The text inside the button. Defaults to 'Ouvrir France Identité'.
  final String buttonText;

  /// Whether to show the logo. Defaults to true.
  /// This parameter is ignored if showText is true.
  final bool showLogo;

  /// Whether to show the logo or the text. Defaults to false. If false the Marianne logo (without text) will be shown.
  final bool showLogoText;

  /// Whether to show the text. Defaults to true. If false the Marianne logo (without text) will be shown.
  /// This parameter is ignored if showLogo is false.
  final bool showText;

  /// The button's border radius. Defaults to 10.
  final double borderRadius;

  /// The background color of the button. Defaults to black (opacity can be changed through opacity parameter).
  final Color backgroundColor;

  /// The color of the text. Defaults to the France Identité blue.
  final Color? textColor;

  /// The font family of the text. Defaults to the default font family you set in your app's theme.
  final String? fontFamily;

  /// The opacity of the button's background color. Defaults to 0.05.
  final double opacity;

  /// The font size of the text. Defaults to 20.
  final double fontSize;

  /// The spacing between the logo and the text. Defaults to 15.
  final double spacing;

  /// The horizontal padding of inside the button. Defaults to 15.
  final double paddingHoriz;

  /// The vertical padding of inside the button. Defaults to 10.
  final double paddingVert;

  /// The package name of the app on Android. Defaults to fr.gouv.franceidentite.
  final String androidPackageName;

  /// The URL scheme to open the app. Defaults to an empty string.
  final String? iosUrlScheme;

  /// The link to the app store. Defaults to the France Identité app on the French store.
  final String appStoreLink;

  /// Whether to open the store if the app is not installed. Defaults to true.
  final bool openStore;

  /// Whether the logo should be trailing the text. Defaults to false.
  final bool logoTrailing;

  /// The scale of the button. Defaults to 1.
  final double scale;

  const FranceIdentiteButton({
    super.key,
    this.width = 340,
    this.height = 100,
    this.logoWidth = 75,
    this.logoHeight = 75,
    this.buttonText = 'Ouvrir France Identité',
    this.fontFamily,
    this.showLogo = true,
    this.showLogoText = false,
    this.showText = true,
    this.borderRadius = 10,
    this.backgroundColor = Colors.black,
    this.textColor,
    this.opacity = 0.05,
    this.fontSize = 20,
    this.spacing = 15,
    this.paddingHoriz = 15,
    this.paddingVert = 10,
    this.androidPackageName = 'fr.gouv.franceidentite',
    this.iosUrlScheme,
    this.appStoreLink =
        "https://apps.apple.com/fr/app/france-identit%C3%A9/id1590142959",
    this.openStore = true,
    this.logoTrailing = false,
    this.scale = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: SizedBox(
        width: width,
        height: height,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor.withOpacity(opacity),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          onPressed: () async {
            await LaunchApp.openApp(
              androidPackageName: androidPackageName,
              iosUrlScheme: iosUrlScheme ?? "",
              appStoreLink: appStoreLink,
              openStore: openStore,
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: paddingVert,
              horizontal: paddingHoriz,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection:
                  logoTrailing ? TextDirection.rtl : TextDirection.ltr,
              children: [
                showLogo || !showText
                    ? SizedBox(
                        height: logoHeight,
                        width: logoWidth,
                        child: SvgPicture.asset(
                          fit: BoxFit.contain,
                          AssetImage(
                            showLogoText
                                ? 'assets/logo_france_identite.svg'
                                : 'assets/logo_marianne.svg',
                          ).assetName,
                          package: 'flutter_france_identite',
                        ),
                      )
                    : const SizedBox.shrink(),
                showText || !showLogo
                    ? SizedBox(width: spacing)
                    : const SizedBox.shrink(),
                showText || !showLogo
                    ? Text(
                        buttonText,
                        style: TextStyle(
                          color: textColor ?? franceIdentiteBlue,
                          fontSize: fontSize,
                          fontFamily: fontFamily,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Checks if the France Identité app is installed.
///
/// [androidPackageName] is the package name of the app on Android.
/// [iosUrlScheme] is the URL scheme of the app on iOS.
Future<bool> isFranceIdentiteInstalled(
    {String? androidPackageName, String? iosUrlScheme}) async {
  return await LaunchApp.isAppInstalled(
    androidPackageName: androidPackageName ?? 'fr.gouv.franceidentite',
    iosUrlScheme: iosUrlScheme ?? '',
  );
}

/// Opens the France Identité app.
///
/// [androidPackageName] is the package name of the app on Android.
/// [iosUrlScheme] is the URL scheme of the app on iOS.
/// [appStoreLink] is the link to the app in the App Store.
/// [openStore] determines whether to open the store if the app is not installed.
Future<int> openFranceIdentite(
    {String? androidPackageName,
    String? iosUrlScheme,
    String? appStoreLink,
    bool? openStore}) async {
  return await LaunchApp.openApp(
    androidPackageName: androidPackageName ?? 'fr.gouv.franceidentite',
    iosUrlScheme: iosUrlScheme ?? "",
    appStoreLink: appStoreLink ??
        "https://apps.apple.com/fr/app/france-identit%C3%A9/id1590142959",
    openStore: openStore ?? true,
  );
}

/// Returns a widget displaying the Marianne logo.
///
/// [width] is the width of the logo. If not provided, the logo will take up as much space as it can.
/// [height] is the height of the logo. If not provided, the logo will take up as much space as it can.
Widget marianneLogo({double? width, double? height}) {
  return SvgPicture.asset(
    const AssetImage('assets/logo_marianne.svg').assetName,
    package: 'flutter_france_identite',
    height: height,
    width: width,
  );
}

/// Returns a widget displaying the France Identité logo.
///
/// [width] is the width of the logo. If not provided, the logo will take up as much space as it can.
/// [height] is the height of the logo. If not provided, the logo will take up as much space as it can.
Widget franceIdentiteLogo({double? width, double? height}) {
  return SvgPicture.asset(
    const AssetImage('assets/logo_france_identite.svg').assetName,
    package: 'flutter_france_identite',
    height: height,
    width: width,
  );
}

Color franceIdentiteBlue = const Color.fromRGBO(0, 0, 145, 1);

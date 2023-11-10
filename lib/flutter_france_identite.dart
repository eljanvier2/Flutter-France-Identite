library flutter_france_identite;

import 'dart:convert';
import 'dart:io';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

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

/// Sends a POST request to the French Identity Provider's document validation API.
///
/// The function picks a PDF file from the file system and sends it to the API for validation.
/// The API checks the validity of the document and returns a response containing the status of the document and its attributes.
///
/// The function returns a list containing two elements:
/// - A boolean indicating whether the document is valid (true if valid, false otherwise)
/// - A map containing the response from the API if the document is valid, or null if the document is not valid or if no file was picked
///
/// [url] is the URL of the API endpoint.
/// [request] is the HTTP request that will be sent to the API.
/// [result] is the result of picking a file from the file system.
/// [file] is the file that will be sent to the API.
/// [length] is the length of the file.
/// [streamedresponse] is the response from the API as a stream.
/// [response] is the response from the API as a string.
///
/// The function handles errors by returning [false, null] if the API returns a non-200 status code or if no file is picked.
///
/// Example usage:
/// ```dart
/// var result = await checkDocumentValidity();
/// if (result[0]) {
///   print('Document is valid');
///   print('Response from API: ${result[1]}');
/// } else {
///   print('Document is not valid');
/// }
/// ```
///
/// Note: This function requires the 'file_picker' package for picking files, and the 'http' package for sending the HTTP request.
Future<List> checkDocumentValidity(SharedFile? sharedFile) async {
  Uri url = Uri(
    scheme: 'https',
    host: "idp.france-identite.gouv.fr",
    path: "/attestation-validator-api/api/validation/v1/check-doc-valid",
    queryParameters: {
      'all-attributes': 'true',
    },
  );

  var request = http.MultipartRequest('POST', url);

  request.headers.addAll({
    "Accept": "application/json, text/plain, */*",
    "Content-Type": "multipart/form-data",
    "Origin": "https://idp.france-identite.gouv.fr",
    "Referer": "https://idp.france-identite.gouv.fr/usager/valider-attest",
  });

  if (sharedFile == null) {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      sharedFile = SharedFile(value: result.files.single.path!);
    }
  }
  if (sharedFile != null) {
    var file = File(sharedFile.value!);
    var length = await file.length();

    request.files.add(http.MultipartFile(
      'file',
      file.openRead(),
      length,
      filename: basename(file.path),
      contentType: MediaType('application', 'pdf'),
    ));
    var streamedresponse = await request.send();
    var response = await http.Response.fromStream(streamedresponse);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return [body["status"] == "VALID", body];
    } else {
      return [false, null];
    }
  } else {
    return [false, null];
  }
}

/// Verifies the identity of a user by checking the validity of a document and comparing the information in the document with the provided information.
///
/// The function takes a set of information (name, familyName, gender, nationality, birthdate, birthplace),
/// and checks if the information in a document matches the provided information.
///
/// The function returns a boolean indicating whether the identity is verified (true if it is verified, false otherwise).
///
/// [name] is the given name to be checked.
/// [familyName] is the family name to be checked.
/// [gender] is the gender to be checked.
/// [nationality] is the nationality to be checked.
/// [birthdate] is the birthdate to be checked.
/// [birthplace] is the birthplace to be checked.
///
/// The function handles errors by returning false if the document is not valid or if the information does not match.
///
/// Example usage:
/// ```dart
/// var isVerified = await verifyIdentity('John', 'Doe', 'male', 'French', '2000-01-01', 'Paris');
/// if (isVerified) {
///   print('Identity is verified');
/// } else {
///   print('Identity is not verified');
/// }
/// ```
///
/// Note: This function requires the 'checkDocumentValidity' and 'checkCorrespondingInfos' functions.
Future<bool> verifyIdentity(
  SharedFile? sharedFile,
  String? name,
  String? familyName,
  String? gender,
  String? nationality,
  String? birthdate,
  String? birthplace,
) async {
  var res = await checkDocumentValidity(sharedFile);
  if (res[0]) {
    return checkCorrespondingInfos(
      res[1]['attributes'],
      name,
      familyName,
      gender,
      nationality,
      birthdate,
      birthplace,
    );
  }
  return false;
}

/// Checks if the information in the response body matches the provided information.
///
/// The function takes a response body and a set of information (name, familyName, gender, nationality, birthdate, birthplace),
/// and checks if the information in the response body matches the provided information.
///
/// The function returns a boolean indicating whether the information matches (true if it matches, false otherwise).
///
/// [responseBody] is the response body from the API.
/// [name] is the given name to be checked.
/// [familyName] is the family name to be checked.
/// [gender] is the gender to be checked.
/// [nationality] is the nationality to be checked.
/// [birthdate] is the birthdate to be checked.
/// [birthplace] is the birthplace to be checked.
///
/// The function handles encoding issues by decoding the strings from the response body from Windows-1252 to UTF-8.
///
/// Example usage:
/// ```dart
/// var responseBody = // get response body from API
/// var isValid = checkCorrespondingInfos(responseBody, 'John', 'Doe', 'male', 'French', '2000-01-01', 'Paris');
/// if (isValid) {
///   print('Information matches');
/// } else {
///   print('Information does not match');
/// }
/// ```
///
/// Note: This function requires the 'dart:convert' package for encoding and decoding strings.
bool checkCorrespondingInfos(
  dynamic responseBody,
  String? name,
  String? familyName,
  String? gender,
  String? nationality,
  String? birthdate,
  String? birthplace,
) {
  String decodeWindows1252String(String input) {
    var bytes = latin1.encode(input);
    return utf8.decode(bytes, allowMalformed: true);
  }

  bool valid = true;

  if (name != null && name.isNotEmpty) {
    valid = valid &&
        decodeWindows1252String(responseBody["givenName"]).toLowerCase() ==
            name.toLowerCase();
  }
  if (familyName != null && familyName.isNotEmpty) {
    valid = valid &&
        decodeWindows1252String(responseBody["familyName"]).toLowerCase() ==
            familyName.toLowerCase();
  }
  if (gender != null && gender.isNotEmpty) {
    valid = valid &&
        decodeWindows1252String(responseBody["gender"]).toLowerCase() ==
            gender.toLowerCase();
  }
  if (nationality != null && nationality.isNotEmpty) {
    valid = valid &&
        decodeWindows1252String(responseBody["nationality"]).toLowerCase() ==
            nationality.toLowerCase();
  }
  if (birthdate != null && birthdate.isNotEmpty) {
    valid = valid &&
        decodeWindows1252String(responseBody["birthDate"]) == birthdate;
  }
  if (birthplace != null && birthplace.isNotEmpty) {
    valid = valid &&
        decodeWindows1252String(responseBody["birthPlace"])
            .toLowerCase()
            .contains(birthplace.toLowerCase());
  }
  return valid;
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

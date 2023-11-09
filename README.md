# Flutter France Identité
A Flutter package for opening the France Identité app.

This package offers utils to help implement France Identité for identity verification in flutter apps.

## Features

This package contains:

- A  **FranceIdentiteButton()** Widget: *a customizable button that opens the France Identité app.*

-  A **isFranceIdentiteInstalled()**  Function: *a function returning whether the France Identité app is installed on the device.*

-  A **openFranceIdentite()** Function: *a function opening the France Identité app or it's page on the device's store.*

- A **verifyIdentity()** Function: *a function implementing the checkDocumentValidity() and checkCorrespondingInfos() functions to verify a user's identity.*

- A **checkDocumentValidity()** Function: *a function returning whether a .pdf file picked inside the device's files is a valid identity certificate.*

- A **checkCorrespondingInfos()** Function: *a function returning whether the infos given by the user correspond to the infos inside the response's body returned by the checkDocumentValidity() function.*

-  A **marianneLogo()**  Function: *a function returning a marianne logo widget with modifiable dimensions.*

-  A **franceIdentiteLogo()**  Function: *a function returning a france identite logo widget with modifiable dimensions.*

-  A **franceIdentiteBlue**  Color: *a Color corresponding to the blue used in the France Identité app.*

**Working default values**

| | Android | iOS |
|--- | ------- | --- |
| opening store | Yes | Yes |
| opening app | Yes | Not yet |
| checking if<br>app installed | Yes | Not yet |
| verifying doc<br>validity | Yes | Yes |
| checking <br>corresponding infos | Yes | Yes |

## Getting started

This plugin is a work in progress. It is by no means linked to the French government or any official authority in charge of the France Identité app.

This plugin uses the external_app_launcher package to streamline operations with France Identité.

## Code Illustration

```
import 'package:flutter/material.dart';
import 'package:flutter_france_identite/flutter_france_identite.dart';

void main() {
  runApp(const FranceIdentiteTestApp());
}

class FranceIdentiteTestApp extends StatelessWidget {
  const FranceIdentiteTestApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter France Identite Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const FranceIdentiteButton(
              logoTrailing: true,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                List res = await checkDocumentValidity();
                if (res[0] == true) {
                  print(checkCorrespondingInfos(
                    res[1]['attributes'],
                    "name",
                    'surname',
                    'x',
                    'fra',
                    'dd/mm/yyyy',
                    'city',
                  ));
                }
              },
              child: const Text('Check document validity'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Additional information

[France Identité website](https://france-identite.gouv.fr/)<br>
[Flutter External app launcher](https://pub.dev/packages/external_app_launcher)

You are more than welcome to contribute to this package. You can also directly contact me if you want to discuss the package, the france identite app's potential use in your application, missing or current features or flutter in general.

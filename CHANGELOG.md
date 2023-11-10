## 1.0.0

* Initial release: Works fully on android, still needs some research for default values used in iOS devices

## 2.0.0

* Added identity verification feature: Includes document validity check and information comparison. Handles encoding issues and error responses from API.

## 2.1.0

* Now handling shared files coming from other app. The intended use case is to allow the use of the 'Partager' button after generating an identity certificate inside the France Identité app to share it directly to your app and be able t verify it without needing to use the file picker.

## 2.1.1

* Fixed potential conflicts caused by the version of the http package used

## 2.1.2

* Now handling optionnal parameters in information comparaison to allow not checking every information

## 2.1.3

* Fixed verifyIdentity function to handle changes made in previous versions to information checking and shared file handling
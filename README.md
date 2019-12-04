# README
This is the supporting repo for **Bringing Tesseract to Mobile (with React Native)** blog.

## Setup
- Setup your environment for [React Native(iOS)](https://facebook.github.io/react-native/docs/0.60/getting-started) development. Please see **React Native CLI Quickstart** portion.

- Clone this repo
```
$ git clone git@github.com:wetoolaguer/mobile-ocr.git
```

- Install React Native dependencies
```
$ cd mobile-ocr
$ yarn install
```

- Install iOS Dependencies
*You may need to setup [cocoapods](https://cocoapods.org/)*

```
$ cd ios
$ pod install
```

- Build the app
```
cd ..
react-native run-ios
```

You should see **"Sample Text"** on the screen. It's scanning the image ./sample_image.jpg.

/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {useState} from 'react';
import {
  SafeAreaView,
  StyleSheet,
  StatusBar,
  NativeModules,
  Image,
  Text,
  View,
} from 'react-native';

import SampleImage from './sample_image.jpg';

const App = () => {
  const [result, setResult] = useState(null);

  async function performScan() {
    const OCR = NativeModules.OCR;
    const source = Image.resolveAssetSource(SampleImage);
    const coordinates = {
      x: 0,
      y: 0,
      width: 300,
      height: 300,
    };

    const scanResult = await OCR.scanForText(source.uri, coordinates);
    setResult(scanResult);
  }

  performScan();

  return (
    <>
      <StatusBar barStyle="dark-content" />
      <SafeAreaView>
        <View style={styles.display}>
          <Text>{result}</Text>
        </View>
      </SafeAreaView>
    </>
  );
};

const styles = StyleSheet.create({
  display: {
    width: '100%',
    height: '100%',
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export default App;

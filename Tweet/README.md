
# react-native-tweet

## Getting started

`$ npm install react-native-tweet --save`

### Mostly automatic installation

`$ react-native link react-native-tweet`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-tweet` and add `RNTweet.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNTweet.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNTweetPackage;` to the imports at the top of the file
  - Add `new RNTweetPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-tweet'
  	project(':react-native-tweet').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-tweet/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-tweet')
  	```

#### Windows
[Read it! :D](https://github.com/ReactWindows/react-native)

1. In Visual Studio add the `RNTweet.sln` in `node_modules/react-native-tweet/windows/RNTweet.sln` folder to their solution, reference from their app.
2. Open up your `MainPage.cs` app
  - Add `using Com.Reactlibrary.RNTweet;` to the usings at the top of the file
  - Add `new RNTweetPackage()` to the `List<IReactPackage>` returned by the `Packages` method


## Usage
```javascript
import RNTweet from 'react-native-tweet';

// TODO: What to do with the module?
RNTweet;
```
  
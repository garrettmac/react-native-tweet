<p align="center"><img alt="react-native-tweet" src="snapshots/react-native-tweet/react-native-tweet.jpg" width="308"></p><p align="center">Meet react-native-tweet</p><p align="center"><a href="http://standardjs.com/"><img  src="https://img.shields.io/badge/code style-standard-brightgreen.svg?style=flat-square"></a><a href="http://standardjs.com/"><img  src="https://img.shields.io/github/downloads/atom/atom/latest/total.svg"></a><a href="https://npmjs.org/package/react-native-tweet"><img alt="npm version" src="http://img.shields.io/npm/v/react-native-tweet.svg?style=flat-square"></a><a href="https://npmjs.org/package/react-native-tweet"><img alt="npm version" src="http://img.shields.io/npm/dm/react-native-tweet.svg?style=flat-square"></a><a href="https://github.com/garrettmac/react-native-tweet/pulls?q=is:pr is:closed"><img alt="PR Stats" src="https://img.shields.io/issuestats/i/github/garrettmac/react-native-tweet.svg?style=flat-square"></a><a href="https://github.com/garrettmac/react-native-tweet/issues?q=is:issue is:closed"><img alt="Issue Stats" src="https://img.shields.io/issuestats/p/github/garrettmac/react-native-tweet.svg" style="flat-square"></a>   <a><img  src="https://img.shields.io/github/forks/garrettmac/react-native-tweet.svg"/></a><a><img  src="https://img.shields.io/github/stars/garrettmac/react-native-tweet.svg"/></a><a><img  src="https://img.shields.io/badge/license-MIT-blue.svg"/><a><img  src="https://img.shields.io/twitter/url/https/github.com/garrettmac/react-native-tweet.svg?style=social"></a><a href="https://gitter.im/garrettmac/react-native-tweet?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge"><img alt="Join the chat" src="https://badges.gitter.im/garrettmac/react-native-tweet.svg"></a></p>

# React Native Tweet


React Native Tweet is the most up to date Twitter Module using **Twitter Kit 3** (without Fabric)

Currently only ios, android coming soon

## Getting Started

## Installation

- Install `react-native` first

```bash
npm i react-native -g
yarn add react-native-tweet
mkdir Example
cd Example
yarn install #(or with npm)
npm start
```


### Example

or clone the repo and play with the example project

```bash
$ git clone https://github.com/garrettmac/react-native-tweet
# $ cd react-native-tweet/Example //not available yet
$ yarn install
$ react-native link react-native-tweet
$ npm start
```
### Setup

#### ios

> in your ios/EXAMPLE.plist

```
<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>twitterkit-XXXXXXXXX</string>
			</array>
		</dict>
	</array>
```
> in your ios/AppDelegate.m

```
#import <TwitterKit/TwitterKit.h>

...
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
...
   [[Twitter sharedInstance] startWithConsumerKey:@"XXXXXXXXX" consumerSecret:@"XXXXXXXXX"];
...
```

### Basic Usage

- In your `index.js`, use:

```jsx
import RNTweet from "react-native-tweet"
//or by method
import {RNTweetLogin,RNTweetLogout,RNTweetCompose,RNTweetUser,RNTweetRetweet,RNTweetApi,} from "react-native-tweet"
........
```








| Methods  | Params   | Description |
|------------------|------------------|------------------|
| `RNTweet.login` / `RNTweetLogin` | N/A | Login User |
| `RNTweet.logout` / `RNTweetLogout` | N/A | Logout User |
| `RNTweet.compose` / `RNTweetCompose` | {setText,setURL,setVideo,setImage} | Compose Tweet  |
| `RNTweet.user` / `RNTweetUser` | N/A | Get User  |
| `RNTweet.retweet` / `RNTweetRetweet` | tweet `id` | Retweet  |
| `RNTweet.api` / `RNTweetApi` | {endpoint,q}| Api User |









## RNTwitter.compose()
```jsx
RNTwitter.compose({
setText:"YOUR TEXT"
setURL:"YOUR URL"
setVideo:"YOUR VIDEO"
setImage:"YOUR IMAGE"
})
.then(console.log).catch(console.warn)//optional

```
## RNTwitter.logout()
```jsx
RNTwitter.logout()
.then(console.log).catch(console.warn)//optional

```
## RNTwitter.user()
```jsx
RNTwitter.user()
.then(console.log).catch(console.warn)//optional

```
## RNTwitter.retweet(tweetId)
```jsx
RNTwitter.retweet(tweetId)
.then(console.log).catch(console.warn)//optional
```



## RNTwitter.api(options)


```jsx
RNTwitter.api({
    endpoint: 'search/tweets.json',
    q: encodeURI(`${q}`),
    count
  })
.then(console.log).catch(console.warn)//optional
  ```

  > see https://dev.twitter.com/rest/public

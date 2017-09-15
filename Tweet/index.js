
import { NativeModules } from 'react-native';

const { RNTweet } = NativeModules;

export default RNTweet;

export {
  RNTweet.login as RNTweetLogin,
  RNTweet.logout as RNTweetLogout,
  RNTweet.compose as RNTweetCompose,
  RNTweet.user as RNTweetUser,
  RNTweet.retweet as RNTweetRetweet,
  RNTweet.api as RNTweetApi,

}

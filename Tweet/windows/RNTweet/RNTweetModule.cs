using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Tweet.RNTweet
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNTweetModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNTweetModule"/>.
        /// </summary>
        internal RNTweetModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNTweet";
            }
        }
    }
}

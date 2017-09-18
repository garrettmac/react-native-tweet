//
//  RNTweet.m
//  PoliticcMobile
//
//  Created by vyga on 8/12/17.
//  Copyright © 2017 Facebook. All rights reserved.


#import "RNTweet.h"
#import <TwitterKit/TwitterKit.h>
#import <React/RCTUtils.h>
#import <React/RCTConvert.h>

@implementation RNTweet




- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}
//
//- (void)selectPhotos
//{
//  UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//  picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//  UIViewController *rnView = [UIApplication sharedApplication].keyWindow.rootViewController;
//
//  //picker.delegate = rnView;
//  [rnView presentModalViewController:picker animated:YES];
//}


RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(init: (NSString *)consumerKey consumerSecret:(NSString *)consumerSecret resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{

    [[Twitter sharedInstance] startWithConsumerKey:consumerKey consumerSecret:consumerSecret];
}

RCT_EXPORT_METHOD(login: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{


  [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
    if (session) {
      NSLog(@"signed in as %@", session.userName);

      /*
       http://cocoadocs.org/docsets/TwitterCore/2.0.2/Classes/TWTRSession.html
       */
      NSDictionary *user = @{@"authToken": session.authToken,
                             @"authTokenSecret": session.authTokenSecret,
                             @"userID":session.userID,
                             @"userName":session.userName};

//      NSString *loginTitle=@"You Successfully Logged into Twitter as";

       NSString * title = [NSString stringWithFormat: @"Welcome %@", session.userName];
      UIViewController *rnView = [UIApplication sharedApplication].keyWindow.rootViewController;
      UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:@"You Successfully Logged into Twitter!" preferredStyle:UIAlertControllerStyleActionSheet];
       [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
      }]];
      [rnView presentViewController:alert animated:YES completion:nil];


       resolve(user);
    } else {
      NSLog(@"error: %@", [error localizedDescription]);
       reject(@"Error", @"Twitter signin error", error);
    }
  }];

}

RCT_EXPORT_METHOD(logout:
                   (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  UIViewController *rnView = [UIApplication sharedApplication].keyWindow.rootViewController;
//  NSUserDefaults *twitterSession = [NSUserDefaults standardUserDefaults];
//  [twitterSession setObject:0 forKey:@"TwitterSession"];
//  [twitterSession synchronize];

//  NSLog(@"Twitter session = %@", twitterSession);

//  [[Twitter sharedInstance] logOut];
//  [self.view insertSubview:_logoutTwitter atIndex:16];
  TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
  NSString *userID = store.session.userID;
  [store logOutUserID:userID];
//
//  NSHTTPCookie *cookie;
//  NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//  for (cookie in [storage cookies])
//  {
//    NSString* domainName = [cookie domain];
//    NSRange domainRange = [domainName rangeOfString:@"Twitter"];
//    if(domainRange.length > 0)
//    {
//      [storage deleteCookie:cookie];
//    }
//  }
//
//  NSURL *url = [NSURL URLWithString:@"https://api.twitter.com"];
//  NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
//  for (NSHTTPCookie *cookie in cookies)
//  {
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
//  }
//

  if(userID){
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Good Bye!" message:@"You Successfully Logged Out of Twitter" preferredStyle:UIAlertControllerStyleActionSheet];

    [rnView presentViewController:alert animated:YES completion:nil];
    [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
      // Called when user taps outside
    }]];

    resolve(@"User successfully logged out.");
  }else{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No user to log out." message:@"You are aready logged out." preferredStyle:UIAlertControllerStyleActionSheet];
    [rnView presentViewController:alert animated:YES completion:nil];
    [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
      // Called when user taps outside
    }]];

//    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//      // Called when user taps outside
//    }]];

    resolve(@"User successfully logged out.");
  }


}




RCT_EXPORT_METHOD(compose:(NSDictionary *)options
                resolve:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject
                  )
{
  TWTRComposer *composer = [[TWTRComposer alloc] init];


  if (options[@"setText"]) {
  [composer setText:options[@"setText"]];
  }
  if (options[@"setImage"]) {
    [composer setImage:[UIImage imageNamed:options[@"setImage"]]];
  }
  if (options[@"setVideo"]) {
//    [composer setImage:[videoURL imageNamed:options[@"setImage"]]];
  }

  if (options[@"setURL"]) {
    [composer setURL:options[@"setURL"]];
  }
UIViewController *rnView = [UIApplication sharedApplication].keyWindow.rootViewController;

//  [composer showFromViewController:self completion:^(TWTRComposerResult result) {
    [composer showFromViewController:rnView completion:^(TWTRComposerResult result) {
    if (result == TWTRComposerResultCancelled) {
      NSLog(@"Tweet composition cancelled");
       resolve(@"user cancelled");
    }
    else {
      NSLog(@"Sending Tweet!");
      UIViewController *rnView = [UIApplication sharedApplication].keyWindow.rootViewController;
      UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tweet Sent!" message:@"Tweet Successfuly added to your Twitter Feed" preferredStyle:UIAlertControllerStyleActionSheet];
      [rnView presentViewController:alert animated:YES completion:nil];
      [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // Called when user taps outside
      }]];
      resolve(@"success");
    }
  }];
}




RCT_EXPORT_METHOD(user: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  TWTRAPIClient *client = [[TWTRAPIClient alloc] init];
  TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];

  TWTRSession *lastSession = store.session;
  NSError *clientError;
  if(lastSession) {
    NSString *showEndpoint = @"https://api.twitter.com/1.1/users/show.json";
    NSDictionary *params = @{@"user_id": lastSession.userID};
    NSURLRequest *request = [client
                             URLRequestWithMethod:@"GET"
                             URL:showEndpoint
                             parameters:params
                             error:&clientError];

    if (request) {
      [client
       sendTwitterRequest:request
       completion:^(NSURLResponse *response,
                    NSData *data,
                    NSError *connectionError) {
         if (data) {
           NSError *jsonError;
           NSDictionary *json = [NSJSONSerialization
                                 JSONObjectWithData:data
                                 options:0
                                 error:&jsonError];
           NSLog(@"%@",[json description]);
           resolve(json);
         }
         else {
           NSLog(@"Error code: %ld | Error description: %@", (long)[connectionError code], [connectionError localizedDescription]);
           reject(@"CONNECTION ERR", @"Connection Error:",connectionError);

         }
       }];
    }else {
      NSLog(@"Error: %@", clientError);
      reject(@"Error", @"User is not Logged In.",clientError);
    }
  }else{
    NSError *err  = [NSError errorWithDomain:@"not_logged_in"
                                        code:403
                                    userInfo:@{NSLocalizedDescriptionKey:@"User not logged in."}];
    reject(@"Error",@"User is not logged in.",err);
  }
}






//RCT_EXPORT_METHOD(retweet: (NSString * )tweetId
//                  resolve:(RCTPromiseResolveBlock) resolve
//                  rejecter: (RCTPromiseRejectBlock) reject) {
//  UIViewController * rnView = [UIApplication sharedApplication].keyWindow.rootViewController;
//  TWTRAPIClient * client = [[TWTRAPIClient alloc] init];
//  TWTRSessionStore * store = [[Twitter sharedInstance] sessionStore];
//
//  TWTRSession * lastSession = store.session;
//  if (lastSession) {
//    NSString * endpoint = [NSString stringWithFormat: @ "https://api.twitter.com/1.1/statuses/retweet/%@.json", tweetId];
//
//     NSLog(@"endpoint: %@", endpoint);
//     NSLog(@"client: %@", client);
//
//    NSDictionary * params = @ {
//      @"user_id": lastSession.userID
//    };
//     NSLog(@"params: %@", params);
//    NSError * clientError;
//    NSURLRequest * request = [client
//                              URLRequestWithMethod: @ "POST"
//                              URL: endpoint
//                              parameters: params
//                              error: & clientError
//                              ];
//
//
//    if (request) {
//      [client sendTwitterRequest: request
//                      completion: ^ (NSURLResponse * response,
//                                     NSData * data,
//                                     NSError * connectionError) {
//                        if (data) {
//                          NSError * err;
//                          NSDictionary * json = [NSJSONSerialization
//                                                 JSONObjectWithData: data
//                                                 options: 0
//                                                 error: & err
//                                                 ];
//                          NSLog(@ "%@", [json description]);
//                        } else {
//                          NSLog(@ "Error code: %ld | Error description: %@", (long)[connectionError code], [connectionError localizedDescription]);
//
//                          UIAlertController * alert = [UIAlertController
//                                                       alertControllerWithTitle: @ "Could not Retweet"
//                                                       message: @ "Please check your connection and try again!"
//                                                       preferredStyle: UIAlertControllerStyleActionSheet
//                                                       ];
//                          [rnView presentViewController: alert animated: YES completion: nil];
//                          [alert addAction: [UIAlertAction
//                                             actionWithTitle: @ "Dismiss" style: UIAlertActionStyleCancel handler: ^ (UIAlertAction * action) {}]];
//
////                          reject(@"CONNECTION ERR", @"Error description: %@", connectionError);
//                         // reject(@"CONNECTION ERR",@"There as an error",@"coonection");
//                        }
//                      }
//       ];
//    } else {
//      NSLog(@ "Error: %@", clientError);
//      reject(@ "Error", @ "There as an error", clientError);
//      UIAlertController * alert = [UIAlertController
//                                   alertControllerWithTitle: @ "An Error Occured. Please Try Again."
//                                   message: @ "It Looks like the error occured while creating your request!"
//                                   preferredStyle: UIAlertControllerStyleActionSheet
//                                   ];
//      [rnView presentViewController: alert animated: YES completion: nil];
//      [alert addAction: [UIAlertAction
//                         actionWithTitle: @ "Dismiss" style: UIAlertActionStyleCancel handler: ^ (UIAlertAction * action) {}]];
//
//
//    }
//
//
//  } else {
//    UIAlertController * alert = [UIAlertController alertControllerWithTitle: @ "Please Login"
//                                                                    message: @ "You must be logged in to do that!"
//                                                             preferredStyle: UIAlertControllerStyleActionSheet
//                                 ];
//    [rnView presentViewController: alert animated: YES completion: nil];
//    [alert addAction: [UIAlertAction
//                       actionWithTitle: @ "Dismiss" style: UIAlertActionStyleCancel handler: ^ (UIAlertAction * action) {}]];
//
//  }
//}







RCT_EXPORT_METHOD(retweet:(NSString * )tweetId
                  resolve:(RCTPromiseResolveBlock) resolve
                  rejecter: (RCTPromiseRejectBlock) reject) {
  {
    UIViewController * rnView = [UIApplication sharedApplication].keyWindow.rootViewController;

    //  NSString *q = options[@"q"];
    TWTRAPIClient *client = [[TWTRAPIClient alloc] init];
    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
//    TWTROAuthSigning *headerSigner = [[TWTROAuthSigning alloc] initWithAuthConfig:[Twitter sharedInstance].authConfig authSession:[Twitter sharedInstance].sessionStore.session];

     //NSLog(@"headerSigner: %@",headerSigner);
//    TWTRSession *lastSession = store.session;
    NSError *clientError;

//    NSString * endpoint = [NSString stringWithFormat: @ "https://api.twitter.com/1.1/statuses/retweet/%@.json", tweetId];
    //

    NSString * endpoint= [NSString stringWithFormat: @"https://api.twitter.com/1.1/statuses/retweet/%@.json", tweetId];
//    NSDictionary *params = @{@"user_id": lastSession.userID};

    NSDictionary *params = @{@"id":tweetId};

//    NSURLRequest *request = [client
//                             URLRequestWithMethod:@"GET"
//                             URL:showEndpoint
//                             parameters:params
//                             error:&clientError];
    NSLog(@"endpoint: %@", endpoint);
    NSLog(@"params: %@",params);

    NSURLRequest *request = [client URLRequestWithMethod:@"POST" URL:endpoint parameters:params error:&clientError];

    if (request) {
      [client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
          // handle the response data e.g.
          NSError *jsonError;
          NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
         NSLog(@"json: %@", json);
          UIAlertController * alert = [UIAlertController alertControllerWithTitle: @ "Successfully Retweeted!"
                                                                          message: @ "This retweet is now visible on your wall!"
                                                                   preferredStyle: UIAlertControllerStyleActionSheet
                                       ];
          [rnView presentViewController: alert animated: YES completion: nil];
          [alert addAction: [UIAlertAction
                             actionWithTitle: @ "Dismiss" style: UIAlertActionStyleCancel handler: ^ (UIAlertAction * action) {}]];
          resolve(json);

          NSLog(@"json: %@", json);

        }else {
          NSLog(@"Error: %@", connectionError);
          NSError *err  = [NSError errorWithDomain:@"connection_err"
                                              code:403
                                          userInfo:@{NSLocalizedDescriptionKey:@"no data"}];
           reject(@"Error", @"no data.",err);
        }
      }];
    }
    else {
      NSLog(@"Error: %@", clientError);
      reject(@"Error", @"clientError.",clientError);
    }




  }
}








RCT_EXPORT_METHOD(api:(NSDictionary *)options
                  resolve:(RCTPromiseResolveBlock) resolve
                  rejecter: (RCTPromiseRejectBlock) reject) {
{
  NSString *method=@"GET";
  if (options[@"method"]) {
    method=options[@"method"];
  }

//  NSString *q = options[@"q"];
  TWTRAPIClient *client = [[TWTRAPIClient alloc] init];

  if (!options[@"endpoint"]) {
    NSError *err  = [NSError errorWithDomain:@"no_endpoint"
                                        code:403
                                    userInfo:@{NSLocalizedDescriptionKey:@"Please provide the 'endpoint' parameter."}];
    reject(@"Error", @"Error making request.",err);
  }


  NSString * endpoint= [NSString stringWithFormat: @"https://api.twitter.com/1.1/%@", options[@"endpoint"]];
  NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
  for (NSString *aSubKey in [options allKeys]) {
    NSString *aSubValue = [options objectForKey:aSubKey];
    //NSLog(@"SubKey : %@, SubValue = %@", aSubKey, aSubValue);
    [params setObject:aSubValue forKey:aSubKey];
  }
  NSLog(@"%@",params);
  NSError *clientError;

  NSURLRequest *request = [client URLRequestWithMethod:method URL:endpoint parameters:params error:&clientError];

  if (request) {
    [client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
      if (data) {
        // handle the response data e.g.
        NSError *jsonError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
      resolve(json);
           //NSLog(@"json: %@", json);

      }
      else {
        NSLog(@"Error: %@", connectionError);
        NSError *err  = [NSError errorWithDomain:@"connection_err"
                                            code:403
                                        userInfo:@{NSLocalizedDescriptionKey:@"Connection Error."}];
        reject(@"Error", @"Connection error.",err);
      }
    }];
  }
  else {
    NSLog(@"Error: %@", clientError);
    reject(@"Error", @"clientError.",clientError);
  }




}
}



@end

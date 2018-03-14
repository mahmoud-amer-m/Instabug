# InstaNetworking

[![CI Status](http://img.shields.io/travis/mahmoud.amer.m@gmail.com/InstaNetworking.svg?style=flat)](https://travis-ci.org/mahmoud.amer.m@gmail.com/InstaNetworking)
[![Version](https://img.shields.io/cocoapods/v/InstaNetworking.svg?style=flat)](http://cocoapods.org/pods/InstaNetworking)
[![License](https://img.shields.io/cocoapods/l/InstaNetworking.svg?style=flat)](http://cocoapods.org/pods/InstaNetworking)
[![Platform](https://img.shields.io/cocoapods/p/InstaNetworking.svg?style=flat)](http://cocoapods.org/pods/InstaNetworking)

# Usage
You'll only deal with URLSession class that has two main methods (request / Download)
## You can use InstaChallenge project inside the repo as your guide
## 1- Get/Post/Put Requests
- (void)request:(NSString *)URL method:(NSString *)method parameters:(NSDictionary *)parameters  completion:( void (^)(NSDictionary *response, NSError *error))completionHandler

### Parameters:
  URL - NSString: request URL
  
  method - NSString: Request Method (Get/Post/Put)
  
  parameters - NSDictionary: request parameters
  
  Completion - Block: fires when request completed to return data to the enqueuer
  
### Example
    URLSession *urlSession = [URLSession sharedNetworkSession];
    [urlSession request:@"< Your URL >" method:POST_METHOD_TYPE parameters:@{@"key1" : @"value1",@"key2" : @"value2"} completion:^(NSDictionary *response, NSError *error){
      // Your Data Dictionary
    }];
    
## 2- Download File
- (void)Download:(NSString *)URL method:(NSString *)method parameters:(NSDictionary *)parameters;

### Parameters:
  URL - NSString: request URL
  
  method - NSString: Request Method (Download)
  
  parameters - NSDictionary: request parameters
  
To implement this method and get current download progress and be notified when download completed, You should implement the protocol URLSessionDownloadDelegate

### Example
    URLSession *urlSession = [URLSession sharedNetworkSession];
    urlSession.delegate = self;
    [urlSession Download:@"http://upload.wikimedia.org/wikipedia/commons/7/7f/Williams_River-27527.jpg" method:DOWNLOAD_METHOD_TYPE parameters:nil];
    
    
## 3- InstaImageView (Bonus :) )
To use InstaImageView, you can use it directly in your story board by dragging UIImageView and change class to InstaImageView.
In your view controller, whenever you've the image URL then call download method
-(void)setImageWithURL:(NSString *)url defaultImage:(UIImage *)defaultImage;

### Parameters:
  URL - NSString: request URL
  defaultImage - UIImage: default image to be displayed until downloading the image
  
### Example
    [_instaImgView setImageWithURL:@"http://upload.wikimedia.org/wikipedia/commons/7/7f/Williams_River-27527.jpg" defaultImage:[UIImage imageNamed:@"<YOUR_DEFAULT_IMAGE>"]];

## Installation

InstaNetworking is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'InstaNetworking'
```

## Author

mahmoud.amer.m@gmail.com, mahmoud.amer.m@gmail.com

## License

InstaNetworking is available under the MIT license. See the LICENSE file for more info.

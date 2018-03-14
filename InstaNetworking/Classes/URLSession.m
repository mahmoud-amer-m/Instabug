//
//  URLSession.m
//  InstaNetworking
//
//  Created by Mahmoud Amer on 3/11/18.
//  Copyright © 2018 Mahmoud Amer. All rights reserved.
//

#import "URLSession.h"



@implementation URLSession

/* Singleton */
+ (URLSession *)sharedNetworkSession
{
    static dispatch_once_t predicate = 0;
    __strong static id sharedObject = nil;
    
    dispatch_once(&predicate, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

/* Post/Get/Put Requests
 Parameters:
 URL - NSString: request URL
 method - NSString: Request Method (Get/Post/Put)
 parameters - NSDictionary: request parameters
 Completion - Block: fires when request completed to return data to the enqueuer
 */
- (void)request:(NSString *)URL method:(NSString *)method parameters:(NSDictionary *)parameters  completion:( void (^)(NSDictionary *response, NSError *error))completionHandler
{
    if ([self checkNetworkCapability]) {
        NSLog(@"url : %@", URL);
        BOOL validRequest = [HelperClass validateText:URL] && [HelperClass validateText:method];
        if (validRequest) {
            if(!self.requestsQueue)
                self.requestsQueue = [[NSMutableArray alloc] init];
            
            NSURL *url = [NSURL URLWithString:URL];
            
            Request *request = [[Request alloc] initWithUrl:url andMethod:method andParameters:parameters];
            [self.requestsQueue addObject:request];
            if ([method isEqualToString:GET_METHOD_TYPE] || [method isEqualToString:POST_METHOD_TYPE] || [method isEqualToString:PUT_METHOD_TYPE])
            {
                [request DataWithMethodType:method :^(NSDictionary *getResponse, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completionHandler(getResponse, error);
                    });
                }];
            }
        }
    }else
        completionHandler(nil, nil);
//        [NSException raise:@"InstaNetwork can only process 6 requests using WIFI and 2 using cellular" format:@""];

}

/* DOWNLOAD
 Parameters:
 URL - NSString: request URL
 method - NSString: Request Method (Download)
 parameters - NSDictionary: request parameters
 */
- (void)Download:(NSString *)URL method:(NSString *)method parameters:(NSDictionary *)parameters
{
    if ([self checkNetworkCapability]) {
        NSLog(@"url there : %@", URL);
        BOOL validRequest = [HelperClass validateText:URL] && [HelperClass validateText:method];
        if (validRequest) {
            if(!self.requestsQueue)
                self.requestsQueue = [[NSMutableArray alloc] init];
            
            NSURL *url = [NSURL URLWithString:URL];
            
            Request *request = [[Request alloc] initWithUrl:url andMethod:method andParameters:parameters];
            [self.requestsQueue addObject:request];
            if ([method isEqualToString:DOWNLOAD_METHOD_TYPE])
            {
                request.delegate = self;
                [request DOWNLOAD];
            }
        }
    }
}

#pragma Request Download Delegate
/* TOTO */
-(void)updateProgress:(float)progress
{
    [self.delegate updateProgress:progress];
}

/* TOTO */
-(void)finishedDownloadTask:(NSData *)data
{
    [self.delegate finishedDownloadTask:data];
}

#pragma Check network reachability and requests number
/* TOTO */
-(BOOL)checkNetworkCapability {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    if(status == NotReachable)
    {
        return NO;
    }
    else if (status == ReachableViaWiFi)
    {
        if (self.requestsQueue.count < WifiMaxNum)
        {
            return YES;
        }else
            [NSException raise:@"InstaNetwork can only process 6 requests using WIFI and 2 using cellular" format:@""];
    }
    else if (status == ReachableViaWWAN)
    {
        if (self.requestsQueue.count < WWanMaxNum)
        {
            return YES;
        }else
            [NSException raise:@"InstaNetwork can only process 6 requests using WIFI and 2 using cellular" format:@""];
    }
    return NO;
}



@end

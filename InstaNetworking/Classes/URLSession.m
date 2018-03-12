//
//  URLSession.m
//  InstaNetworking
//
//  Created by Mahmoud Amer on 3/11/18.
//  Copyright © 2018 Mahmoud Amer. All rights reserved.
//

#import "URLSession.h"



@implementation URLSession

+ (URLSession *)sharedNetworkSession
{
    static dispatch_once_t predicate = 0;
    __strong static id sharedObject = nil;
    
    dispatch_once(&predicate, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

- (void)increaseCount
{
    int countInt =[self.count intValue];
    
    countInt ++;
    self.count = [NSNumber numberWithInt:countInt];
    NSLog(@"new count : %i", countInt);
}

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
//        [NSException raise:@"Instabug Challenge -- Cannot load more requests" format:@"This exception is for debugging only"];
}

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
        return (self.requestsQueue.count < WifiMaxNum) ? YES : NO;
    }
    else if (status == ReachableViaWWAN)
    {
        return (self.requestsQueue.count < WWanMaxNum) ? YES : NO;
    }
    return NO;
}



@end

//
//  URLSession.h
//  InstaNetworking
//
//  Created by Mahmoud Amer on 3/11/18.
//  Copyright © 2018 Mahmoud Amer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "HelperClass.h"
#import "Reachability.h"


@interface URLSession : NSObject

@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSMutableArray *requestsQueue;

+ (URLSession *)sharedNetworkSession;
- (void)increaseCount;

- (void)request:(NSString *)URL method:(NSString *)method parameters:(NSDictionary *)parameters  completion:( void (^)(NSDictionary *response, NSError *error))completionHandler;

//- (void)GET:(Request *)request :( void (^)(NSData *response, NSError *error))completionHandler;


@end

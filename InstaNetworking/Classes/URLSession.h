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

/* Protocol to notify ypur view controller with download progress and when the download completed */
@protocol URLSessionDownloadDelegate <NSObject>
@required
-(void)updateProgress:(float)progress;
-(void)finishedDownloadTask:(NSData *)data;
@end

@interface URLSession : NSObject <RequestDownloadDelegate>

@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSMutableArray *requestsQueue;
@property (nonatomic, weak) id <URLSessionDownloadDelegate> delegate;
    

+ (URLSession *)sharedNetworkSession;

- (void)request:(NSString *)URL method:(NSString *)method parameters:(NSDictionary *)parameters  completion:( void (^)(NSDictionary *response, NSError *error))completionHandler;

- (void)Download:(NSString *)URL method:(NSString *)method parameters:(NSDictionary *)parameters;


@end

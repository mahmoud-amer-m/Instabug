//
//  Request.h
//  InstaNetworking
//
//  Created by Mahmoud Amer on 3/11/18.
//  Copyright © 2018 Mahmoud Amer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HelperClass.h"

#define GET_METHOD_TYPE @"GET"
#define POST_METHOD_TYPE @"POST"
#define PUT_METHOD_TYPE @"PUT"
#define UPLOAD_METHOD_TYPE @"UPLOAD"
#define DOWNLOAD_METHOD_TYPE @"DOWNLOAD"

@protocol RequestDownloadDelegate <NSObject>
@required
-(void)updateProgress:(float)progress;
-(void)finishedDownloadTask:(NSData *)data;
@end

@interface Request : NSObject <NSURLSessionDownloadDelegate>

@property (nonatomic) NSURL *requestUrl;
@property (nonatomic) NSString *requestMethod;
@property (nonatomic) NSDictionary *requestParameters;

- (id)initWithUrl:(NSURL *)url andMethod:(NSString *)method andParameters:(NSDictionary *)parameters;

- (void)DataWithMethodType:(NSString *)methodType :( void (^)(NSDictionary *response, NSError *error))completionHandler;

- (void)UPLOAD :( void (^)(NSDictionary *response, NSError *error))completionHandler;
    
- (void)DOWNLOAD;
@property (nonatomic, retain) NSMutableData *dataToDownload;
@property (nonatomic) float downloadSize;
@property (nonatomic, weak) id <RequestDownloadDelegate> delegate;


@end

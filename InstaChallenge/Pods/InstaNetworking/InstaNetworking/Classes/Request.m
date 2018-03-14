//
//  Request.m
//  InstaNetworking
//
//  Created by Mahmoud Amer on 3/11/18.
//  Copyright © 2018 Mahmoud Amer. All rights reserved.
//

#import "Request.h"

@implementation Request

/* Class Initialization */
- (id)initWithUrl:(NSURL *)url andMethod:(NSString *)method andParameters:(NSDictionary *)parameters {
    self = [super init];
    if (self)
    {
        self.requestUrl = url;
        self.requestMethod = method;
        if (parameters) {
            self.requestParameters = parameters;
        }
    }
    return self;
}

/* Method returns NSURLSession with default session configuration */
- (NSURLSession *)dataSession
{
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return session;
}

/* Put/Get/Post Requests */
- (void)DataWithMethodType:(NSString *)methodType :( void (^)(NSDictionary *response, NSError *error))completionHandler
{
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:self.requestUrl];
    [urlRequest setHTTPMethod:methodType];
    if (self.requestParameters){
        if ([methodType isEqualToString:GET_METHOD_TYPE])
            urlRequest = [self addParametersToGetRequest:urlRequest andParameters:self.requestParameters];
        else if ([methodType isEqualToString:POST_METHOD_TYPE])
            urlRequest = [self addParametersToPostRequest:urlRequest andParameters:self.requestParameters];
        else
            [NSException raise:@"Unknown method type (POST-PUT-GET)" format:@""];
        NSLog(@"urlRequest :: %@", urlRequest.HTTPBody);
    }
    
    NSURLSession *session = [self dataSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                          if(httpResponse.statusCode == 200)
                                          {
                                              if (completionHandler == nil)
                                              {
                                                  completionHandler(nil, nil);
                                              }
                                              NSError *jsonParsingError = nil;
                                              NSDictionary *responseDictionary = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonParsingError];
                                              NSLog(@"responseDictionary: %@", responseDictionary);
                                              if (jsonParsingError == nil) {
                                                  completionHandler(responseDictionary, nil);
                                              }
                                              else NSLog(@"JSON parsing Error: %@", jsonParsingError);
                                          }
                                          else
                                          {
                                              if (error)
                                              {
                                                  NSLog(@"Error code %li", (long)error.code);
                                                  if (error.code == -1022) {
                                                      [NSException raise:@"No time for learn in this challenge -_-, please google it (objective-c -1022 error code)" format:@"objective-c -1022 error code"];
                                                  }
                                                  completionHandler(nil, error);
                                                  return;
                                              }
                                              
                                              NSLog(@"Error code %li", (long)error.code);
                                          }
                                      }];
    [dataTask resume];
}

/* TOTO */
- (void)UPLOAD :( void (^)(NSDictionary *response, NSError *error))downloadCompletionHandler
{
    
}

/* Download Method */
- (void)DOWNLOAD
{
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:self.requestUrl];
    if (self.requestParameters) {
        urlRequest = [self addParametersToPostRequest:urlRequest andParameters:self.requestParameters];
    }
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL: self.requestUrl];
    
    [dataTask resume];
}

#pragma mark - NSURLSession Delegate Methods
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    completionHandler(NSURLSessionResponseAllow);
    
    self.downloadSize = [response expectedContentLength];
    self.dataToDownload = [[NSMutableData alloc] init];
}
    
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [self.dataToDownload appendData:data];
    [self.delegate updateProgress:[self.dataToDownload length]/self.downloadSize];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    if (error) {
        NSLog(@"Insta download error : %@", error.localizedDescription);
    }
    else {
        [self.delegate finishedDownloadTask:self.dataToDownload];
    }

}

/* Preparing Get Requests Parameters */
- (NSMutableURLRequest *)addParametersToGetRequest:(NSMutableURLRequest *)request andParameters:(NSDictionary *)parameters {
    if (parameters) {
        if(parameters.count > 0) {
            NSMutableString *parametersString = [[NSString stringWithFormat:@"%@?", request.URL] mutableCopy];
            for (id key in parameters)
            {
                NSString *value = [NSString stringWithFormat:@"%@", parameters[key]];
                [parametersString appendString:[NSString stringWithFormat:@"%@=%@", key, value]];
            }
            request.URL = [NSURL URLWithString:parametersString];
        }
    }
    
    return request;
}

/* Preparing Post Requests Parameters */
- (NSMutableURLRequest *)addParametersToPostRequest:(NSMutableURLRequest *)request andParameters:(NSDictionary *)parameters {
    if (parameters) {
        if(parameters.count > 0) {
            [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
            NSError *error;
            NSLog(@"Params : %@", parameters);
            NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:kNilOptions error:&error];
            if (!error)
                [request setHTTPBody:postData];
        }
    }
    
    return request;
}
@end

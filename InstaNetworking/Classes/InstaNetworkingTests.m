//
//  InstaNetworkingTests.m
//  InstaNetworking
//
//  Created by Mahmoud Amer on 3/13/18.
//

#import <XCTest/XCTest.h>

@interface InstaNetworkingTests : XCTestCase

@end

@implementation InstaNetworkingTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testGetRequest
{
    NSString *url = @"http://ryaheenapp.com/nursery_backend/public/api/user_info";
    [self.urlSession request:url method:GET_METHOD_TYPE parameters:@{@"id" : @"2"} completion:^(NSDictionary *response, NSError *error){
        BOOL flag = (error != nil) && (response != nil);
        XCTAssert(flag, @"Get Method %@ return :\t%@", url, error);
    }];
}

-(void)testPostRequest
{
    NSString *url = @"http://ryaheenapp.com/nursery_backend/public/api/user_login";
    [self.urlSession request:url method:POST_METHOD_TYPE parameters:@{ @"username" : @"sanaa", @"password" : @"123456" } completion:^(NSDictionary *response, NSError *error){
        BOOL flag = (error != nil) || (response != nil);
        XCTAssert(flag, @"Post Method %@ return :\t%@", url, error);
    }];
}

-(void)testWifiSevenRequests
{
    for (int i = 0; i < 8; i++) {
        NSString *url = @"http://ryaheenapp.com/nursery_backend/public/api/user_login";
        [self.urlSession request:url method:POST_METHOD_TYPE parameters:@{ @"username" : @"sanaa", @"password" : @"123456" } completion:^(NSDictionary *response, NSError *error){
            BOOL flag = (error == nil) || (response == nil);
            XCTAssert(flag, @"Post Method %@ return :\t%@", url, error);
        }];
    }
}

-(void)testCellularSevenRequests
{
    for (int i = 0; i < 3; i++) {
        NSString *url = @"http://ryaheenapp.com/nursery_backend/public/api/user_login";
        [self.urlSession request:url method:POST_METHOD_TYPE parameters:@{ @"username" : @"sanaa", @"password" : @"123456" } completion:^(NSDictionary *response, NSError *error){
            BOOL flag = (error == nil) || (response == nil);
            XCTAssert(flag, @"Post Method %@ return :\t%@", url, error);
        }];
    }
}

@end

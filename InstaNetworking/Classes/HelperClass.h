//
//  HelperClass.h
//  InstaNetworking
//
//  Created by Mahmoud Amer on 3/11/18.
//  Copyright © 2018 Mahmoud Amer. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    WifiMaxNum = 6,
    WWanMaxNum = 2
} MaxRequests;

@interface HelperClass : NSObject

+ (BOOL)validateText:(NSString *)text; 


@end

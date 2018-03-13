//
//  HelperClass.m
//  InstaNetworking
//
//  Created by Mahmoud Amer on 3/11/18.
//  Copyright © 2018 Mahmoud Amer. All rights reserved.
//

#import "HelperClass.h"

@implementation HelperClass

/*
 Validate string
 Returns true if string is valid
 */
+ (BOOL)validateText:(NSString *)text{
    if(text && !([text isEqualToString:@""]) && !(text.length == 0))
        return YES;
    else
        return NO;
}


@end

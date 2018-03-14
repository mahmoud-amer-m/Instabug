//
//  ViewController.h
//  testPod
//
//  Created by Mahmoud Amer on 3/12/18.
//  Copyright © 2018 Mahmoud Amer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <InstaNetworking/URLSession.h>
#import <InstaNetworking/InstaImageView.h>

@interface ViewController : UIViewController <URLSessionDownloadDelegate>
@property (weak, nonatomic) IBOutlet InstaImageView *instaImgView;

- (IBAction)downloadAction:(UIButton *)sender;
    
- (IBAction)uploadAction:(UIButton *)sender;
    
@end


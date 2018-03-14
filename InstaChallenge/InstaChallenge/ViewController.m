//
//  ViewController.m
//  testPod
//
//  Created by Mahmoud Amer on 3/12/18.
//  Copyright © 2018 Mahmoud Amer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    URLSession *urlSession = [URLSession sharedNetworkSession];
    [urlSession request:@"http://ryaheenapp.com/nursery_backend/public/api/user_login" method:POST_METHOD_TYPE parameters:@{@"username" : @"sanaa",@"password" : @"123456"} completion:^(NSDictionary *response, NSError *error){}];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_instaImgView setImageWithURL:@"http://upload.wikimedia.org/wikipedia/commons/7/7f/Williams_River-27527.jpg" defaultImage:[UIImage imageNamed:@"Screen Shot 2018-03-13 at 10.18.01 PM.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)downloadAction:(UIButton *)sender
{
    
    URLSession *urlSession = [URLSession sharedNetworkSession];
    urlSession.delegate = self;
    [urlSession Download:@"http://upload.wikimedia.org/wikipedia/commons/7/7f/Williams_River-27527.jpg" method:DOWNLOAD_METHOD_TYPE parameters:nil];
    
}
    
-(void)updateProgress:(float)progress{
    NSLog(@"get upload progress : %f", progress);
}
-(void)finishedDownloadTask:(NSData *)data{
    NSLog(@"finished download taks");
}
    
- (IBAction)uploadAction:(UIButton *)sender
{
    
}
@end

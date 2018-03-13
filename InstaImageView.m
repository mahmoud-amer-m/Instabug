//
//  InstaImageView.m
//  InstaNetworking
//
//  Created by Mahmoud Amer on 3/13/18.
//

#import "InstaImageView.h"

@implementation InstaImageView

-(void)setImageWithURL:(NSString *)url defaultImage:(UIImage *)defaultImage
{
    URLSession *test = [URLSession sharedNetworkSession];
    test.delegate = self;
    [test Download:url method:DOWNLOAD_METHOD_TYPE parameters:nil];
    if (defaultImage)
        [self setImage:defaultImage];
    
    self.loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.loadingIndicator.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    [self.loadingIndicator setHidden:NO];
    [self.loadingIndicator startAnimating];
    [self addSubview:self.loadingIndicator];
}


-(void)updateProgress:(float)progress{
    [self addSubview:self.loadingIndicator];
}
-(void)finishedDownloadTask:(NSData *)data{
    [self.loadingIndicator stopAnimating];
    [self.loadingIndicator setHidden:YES];
    
    UIImage *im = [UIImage imageWithData:data];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.image = im;
    });
}

@end

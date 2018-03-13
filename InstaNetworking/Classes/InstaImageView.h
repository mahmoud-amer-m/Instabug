//
//  InstaImageView.h
//  InstaNetworking
//
//  Created by Mahmoud Amer on 3/13/18.
//

#import <UIKit/UIKit.h>
#import "URLSession.h"

@interface InstaImageView : UIImageView <URLSessionDownloadDelegate>

@property (nonatomic, strong) UIActivityIndicatorView *loadingIndicator;


-(void)setImageWithURL:(NSString *)url defaultImage:(UIImage *)defaultImage;

@end

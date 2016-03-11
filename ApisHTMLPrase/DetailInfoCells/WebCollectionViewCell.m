//
//  WebCollectionViewCell.m
//  ApisHTMLPrase
//
//  Created by 陈峰 on 16/3/10.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#import "WebCollectionViewCell.h"

@interface WebCollectionViewCell () {

    __weak IBOutlet UIWebView *webView;
}

@end

@implementation WebCollectionViewCell
+ (CGSize)calcuateCellHeight {
    return (CGSize){[UIScreen mainScreen].bounds.size.width-30.f ,190.f};
}

- (void)awakeFromNib {
    webView.scrollView.bounces = NO;
}

- (void)setWebUrl:(NSString *)webUrl {
    _webUrl = webUrl;
    [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:webUrl]]];
}


@end

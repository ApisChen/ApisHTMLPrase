//
//  DetailInfoViewController.m
//  ApisHTMLPrase
//
//  Created by 陈峰 on 16/3/10.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#import "DetailInfoViewController.h"
#import "HTMLParser.h"

@interface DetailInfoViewController ()

@end

@implementation DetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *praseArray = [HTMLParser priseHTML:_htmlStr];
    
}



@end

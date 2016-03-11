//
//  ViewController.m
//  ApisHTMLPrase
//
//  Created by 陈峰 on 16/3/10.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#import "ViewController.h"
#import "DetailInfoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonMethod:(id)sender {
    NSString *readmePath = [[NSBundle mainBundle] pathForResource:@"demo2" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:readmePath encoding:NSUTF8StringEncoding error:NULL];
    
    DetailInfoViewController *detailVC = [DetailInfoViewController new];
    detailVC.htmlStr = html;
    [self presentViewController:detailVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

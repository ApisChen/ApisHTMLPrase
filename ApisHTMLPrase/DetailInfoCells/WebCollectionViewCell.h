//
//  WebCollectionViewCell.h
//  ApisHTMLPrase
//
//  Created by 陈峰 on 16/3/10.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSString *webUrl;

+ (CGSize)calcuateCellHeight;

@end

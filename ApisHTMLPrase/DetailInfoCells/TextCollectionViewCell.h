//
//  TextCollectionViewCell.h
//  ApisHTMLPrase
//
//  Created by 陈峰 on 16/3/10.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TextCollectionViewCellTextType) {
    TextCollectionViewCellTextType_Title = 0,
    TextCollectionViewCellTextType_Content,
};

@interface TextCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (assign, nonatomic) TextCollectionViewCellTextType textType;

+ (CGSize)calcuateTextHeightWithText:(NSString *)text textType:(TextCollectionViewCellTextType)textType;
+ (UIFont *)fontByTextType:(TextCollectionViewCellTextType)textType;

@end

//
//  TextCollectionViewCell.m
//  ApisHTMLPrase
//
//  Created by 陈峰 on 16/3/10.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#import "TextCollectionViewCell.h"

@interface TextCollectionViewCell () {
    UIFont *textFont;
}

@end

@implementation TextCollectionViewCell

+ (UIFont *)fontByTextType:(TextCollectionViewCellTextType)textType {
    switch (textType) {
        case TextCollectionViewCellTextType_Content:
            return [UIFont systemFontOfSize:14.f];
            
        case TextCollectionViewCellTextType_Title:
            return [UIFont systemFontOfSize:14.f];
            
        default:
            return [UIFont systemFontOfSize:14.f];
    }
}

+ (CGSize)calcuateTextHeightWithText:(NSString *)text textType:(TextCollectionViewCellTextType)textType {
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width-30.f;
    CGRect aframe = [text boundingRectWithSize:CGSizeMake(maxWidth, 0)
                                        options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                    attributes:@{NSFontAttributeName:[TextCollectionViewCell fontByTextType:textType]}
                                        context:nil];
    return (CGSize){maxWidth, aframe.size.height};
}

- (void)awakeFromNib {
    self.textType = TextCollectionViewCellTextType_Content;

}

- (void)setTextType:(TextCollectionViewCellTextType)textType {
    _textType = textType;
    _textLabel.font = [TextCollectionViewCell fontByTextType:textType];
}

@end

//
//  PictureCollectionViewCell.m
//  ApisHTMLPrase
//
//  Created by 陈峰 on 16/3/10.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#import "PictureCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface PictureCollectionViewCell () {

    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet NSLayoutConstraint *imageRatioConstraint;
    
}

@end

@implementation PictureCollectionViewCell

- (void)awakeFromNib {

}

+ (CGSize)calcuateCellHeightByImage:(UIImage *)image {
    if (image) {
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width-30.f;
        if (image.size.width<=maxWidth) {
            return image.size;
        } else {
            return (CGSize){maxWidth, image.size.height/image.size.width*maxWidth};
        }
        
    } else {
        return CGSizeZero;
    }
}

- (void)setPicUrl:(NSString *)picUrl {
    _picUrl = picUrl;
    [imageView sd_setImageWithURL:[NSURL URLWithString:picUrl]
                 placeholderImage:nil
                          options:0
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            if (!error && _needDownloadImage) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    imageRatioConstraint.constant = image.size.width/image.size.height;
                                    if (_delegate && [_delegate respondsToSelector:@selector(pictureCollectionViewCell:completePictureDownloadP:)]) {
                                        [_delegate pictureCollectionViewCell:self completePictureDownloadP:image];
                                    }
                                });
                            }
    }];
}

@end

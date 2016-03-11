//
//  PictureCollectionViewCell.h
//  ApisHTMLPrase
//
//  Created by 陈峰 on 16/3/10.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PictureCollectionViewCell;

@protocol PictureCollectionViewCellDelegate <NSObject>

@required
- (void)pictureCollectionViewCell:(PictureCollectionViewCell *)cell completePictureDownloadP:(UIImage *)image;

@end

@interface PictureCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<PictureCollectionViewCellDelegate> delegate;

@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, assign) BOOL needDownloadImage;

+ (CGSize)calcuateCellHeightByImage:(UIImage *)image;


@end

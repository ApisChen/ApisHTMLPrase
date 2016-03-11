//
//  DetailInfoViewController.m
//  ApisHTMLPrase
//
//  Created by 陈峰 on 16/3/10.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#import "DetailInfoViewController.h"
#import "HTMLParser.h"
#import "TextCollectionViewCell.h"
#import "PictureCollectionViewCell.h"
#import "WebCollectionViewCell.h"

@interface DetailInfoViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, PictureCollectionViewCellDelegate> {

    __weak IBOutlet UICollectionView *collection;
    NSMutableDictionary *picInfoDict;
    NSArray *dataArray;
}

@end

@implementation DetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    picInfoDict = [NSMutableDictionary dictionary];
    [collection registerNib:[UINib nibWithNibName:@"TextCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TextCollectionViewCell"];
    [collection registerNib:[UINib nibWithNibName:@"PictureCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PictureCollectionViewCell"];
    [collection registerNib:[UINib nibWithNibName:@"WebCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"WebCollectionViewCell"];

    
    dataArray = [HTMLParser priseHTML:_htmlStr];
    [collection reloadData];
}

- (void)setHtmlStr:(NSString *)htmlStr {
    _htmlStr = htmlStr;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *nodeInfo = dataArray[indexPath.item];
    NSString *nodeType = nodeInfo.allKeys.firstObject;
    NSString *nodeDetail = nodeInfo[nodeType];
    
    if ([nodeType isEqualToString:HTMLPraseTitle]) {
        
        TextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TextCollectionViewCell" forIndexPath:indexPath];
        cell.textLabel.text = nodeDetail;
        cell.textType = TextCollectionViewCellTextType_Content;
//        cell.backgroundColor = [UIColor redColor];
        return cell;
        
    } else if ([nodeType isEqualToString:HTMLPraseContent]) {
        
        TextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TextCollectionViewCell" forIndexPath:indexPath];
        cell.textLabel.text = nodeDetail;
        cell.textType = TextCollectionViewCellTextType_Title;
//        cell.backgroundColor = [UIColor redColor];
        return cell;
        
    } else if ([nodeType isEqualToString:HTMLPraseSubText]) {
        
        TextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TextCollectionViewCell" forIndexPath:indexPath];
        cell.textLabel.text = nodeDetail;
        cell.textType = TextCollectionViewCellTextType_Content;
//        cell.backgroundColor = [UIColor redColor];
        return cell;
        
    } else if ([nodeType isEqualToString:HTMLPraseVideo]) {
        
        WebCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WebCollectionViewCell" forIndexPath:indexPath];
        cell.webUrl = nodeDetail;
//        cell.backgroundColor = [UIColor redColor];
        return cell;
        
    } else if ([nodeType isEqualToString:HTMLPrasePicture]) {
        PictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PictureCollectionViewCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.picUrl = nodeDetail;
        cell.needDownloadImage = picInfoDict[indexPath]==nil;
//        cell.backgroundColor = [UIColor redColor];
        return cell;
    }
    
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *nodeInfo = dataArray[indexPath.item];
    NSString *nodeType = nodeInfo.allKeys.firstObject;
    if ([nodeType isEqualToString:HTMLPraseTitle]) {
        
        return [TextCollectionViewCell calcuateTextHeightWithText:nodeInfo[nodeType] textType:TextCollectionViewCellTextType_Title];
        
    } else if ([nodeType isEqualToString:HTMLPraseContent]) {
        
        return [TextCollectionViewCell calcuateTextHeightWithText:nodeInfo[nodeType] textType:TextCollectionViewCellTextType_Content];
        
    } else if ([nodeType isEqualToString:HTMLPraseSubText]) {
        
        return [TextCollectionViewCell calcuateTextHeightWithText:nodeInfo[nodeType] textType:TextCollectionViewCellTextType_Content];
        
    } else if ([nodeType isEqualToString:HTMLPraseVideo]) {
        
        return [WebCollectionViewCell calcuateCellHeight];
        
    } else if ([nodeType isEqualToString:HTMLPrasePicture]) {
        
        return [PictureCollectionViewCell calcuateCellHeightByImage:picInfoDict[indexPath]];
        
    }
    return CGSizeZero;
}

- (void)pictureCollectionViewCell:(PictureCollectionViewCell *)cell completePictureDownloadP:(UIImage *)image {
    NSIndexPath *indexpath = [collection indexPathForCell:cell];
    if (indexpath && image) {
        picInfoDict[indexpath] = image;
        [collection reloadItemsAtIndexPaths:@[indexpath]];
    }
}


@end

//
//  DropMenuCell.h
//  SelectTageDemo
//
//  Created by 中国孔 on 2019/2/28.
//  Copyright © 2019 孔令辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TageModel,DropMenuCell;

@protocol DropMenuItemDelegate <NSObject>

- (void)dropMenuCell:(DropMenuCell *)cell withCellItems:(TageModel *)modls;


@end
@interface DropMenuCell : UICollectionViewCell

@property (strong , nonatomic) UILabel *title;
@property (strong , nonatomic) UIView *line;
@property (strong , nonatomic) TageModel *models;

@property (assign , nonatomic) id<DropMenuItemDelegate>delegate;


@end

NS_ASSUME_NONNULL_END

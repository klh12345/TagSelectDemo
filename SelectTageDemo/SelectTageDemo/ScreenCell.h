//
//  ScreenCell.h
//  SelectTageDemo
//
//  Created by 中国孔 on 2019/3/1.
//  Copyright © 2019 孔令辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ScreenModel;

@protocol tagSelectDelagate <NSObject>



@end
@interface ScreenCell : UICollectionViewCell

@property (strong , nonatomic) UIButton *tageBtn;

@property (strong , nonatomic) ScreenModel *model;


@end

NS_ASSUME_NONNULL_END

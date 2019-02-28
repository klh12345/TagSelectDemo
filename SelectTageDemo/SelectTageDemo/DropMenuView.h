//
//  DropMenuView.h
//  SelectTageDemo
//
//  Created by 中国孔 on 2019/2/28.
//  Copyright © 2019 孔令辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class  DropMenuView,TageModel;
@protocol DropMenuDelegate <NSObject>

- (void)dropppmenuView:(DropMenuView *)view withResutStr:(NSString *)str;

@end
@interface DropMenuView : UIView

// 初始化方法
+ (instancetype)createDropMenuViewwithItems:(TageModel *)models;

@property (strong , nonatomic) TageModel *models;

@property (assign , nonatomic) id<DropMenuDelegate>delegate;

// 数据重置
- (void)resetExpress;



@end

NS_ASSUME_NONNULL_END

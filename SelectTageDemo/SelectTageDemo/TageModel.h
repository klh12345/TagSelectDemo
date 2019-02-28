//
//  TageModel.h
//  SelectTageDemo
//
//  Created by 中国孔 on 2019/2/28.
//  Copyright © 2019 孔令辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface TageModel : NSObject


@property (strong , nonatomic) NSString *title;
@property (assign , nonatomic) NSInteger identifer;

@property (strong , nonatomic) NSString *titles;
@property (nonatomic , assign) CGFloat menuHeight;

@property (assign , nonatomic) CGRect frame;
@property (assign , nonatomic) BOOL titleSelected;

@property (strong , nonatomic) NSMutableArray *dataArray;

@property (strong , nonatomic) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END

//
//  ScreeningView.m
//  SelectTageDemo
//
//  Created by 中国孔 on 2019/2/28.
//  Copyright © 2019 孔令辉. All rights reserved.
//

#import "ScreeningView.h"
#import "ScreenCell.h"
#import "ScreenModel.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

@interface ScreeningView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong , nonatomic) UICollectionView *collectionView;
@property (strong , nonatomic) NSMutableArray *dataSource;

@property (strong , nonatomic) UIButton *button;


@end
static NSString *const ScreenCellid = @"ScreenCell";
@implementation ScreeningView

- (instancetype)initWithFrame:(CGRect)frame{
   
    self = [super initWithFrame:frame];
    if (self) {
     
        UITapGestureRecognizer *taper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taper:)];
        [self addGestureRecognizer:taper];
        
        self.backgroundColor = [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:1.0f];
        
        [self initSubView];
        
    }
    return self;
}





- (void)initSubView{
    
   
    NSArray *titles = @[@"取消",@"确定"];
//    CGFloat space = ScreenW *2/3 / (titles.count + 1);
    CGFloat space = 0;
    for (int i = 0; i < titles.count; i ++) {
        
       UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [button setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        [button sizeToFit];
        button.layer.cornerRadius = 8.0f;
        button.clipsToBounds = YES;
        button.layer.borderWidth = 1.0f;
        button.layer.borderColor = [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f].CGColor;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        CGFloat btnX = i ? space+15 : 25;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.frame = CGRectMake(btnX, ScreenH - StatusBarHeight - 50, 100, 34);
        
        space = CGRectGetMaxX(button.frame);
        [self addSubview:button];
    }
    
}






// 避免父视图的点击事件在这里响应
- (void)taper:(UITapGestureRecognizer *)taper{
    
    return;
    
}


- (void)buttonAction:(UIButton *)sender{
    
    
    if ([sender.currentTitle isEqualToString:@"取消"]) {
        
    }else if ([sender.currentTitle isEqualToString:@"确定"]){
        
        
    }
    
}


- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, StatusBarHeight + 44, ScreenW * 2/3, ScreenH - StatusBarHeight - 44) collectionViewLayout:flowlayout];
        
        [_collectionView registerClass:[ScreenCell class] forCellWithReuseIdentifier:ScreenCellid];
        [self addSubview:_collectionView];
    }
    
    return _collectionView;
}


- (NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        
    }
    return _dataSource;
}


@end

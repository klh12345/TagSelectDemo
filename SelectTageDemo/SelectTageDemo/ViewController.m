//
//  ViewController.m
//  SelectTageDemo
//
//  Created by 中国孔 on 2019/2/27.
//  Copyright © 2019 孔令辉. All rights reserved.
//

#import "ViewController.h"
#import "DropMenuView.h"

#import "DropMenuCell.h"
#import "TageModel.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
@interface ViewController ()<DropMenuDelegate>
@property (strong , nonatomic) TageModel *model;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"标签选择器demo";
    
    // 把不通类型的数据封装成字段 存放
    NSArray *titles = @[@"推荐",@"价格",@"销量",@"筛选"];
    
    // 推荐
    NSArray *remomentarray = @[@"从低到高",@"从高到低"];
    NSMutableArray *dataArray1 = [NSMutableArray array];
    for (int i = 0;i < remomentarray.count ;i ++) {
        TageModel *model = [[TageModel alloc] init];
        model.title = remomentarray[i];
        
        [dataArray1 addObject:model];
    }
    
    //价格
    NSArray *saler = @[@"0~100",@"100~500",@"500~1000",@"1000~2000",@"2000~3000"];
    NSMutableArray *priceArray = [NSMutableArray array];
    for (int i = 0; i < saler.count; i ++) {
        TageModel *model = [[TageModel alloc] init];
        model.title = saler[i];
        [priceArray addObject:model];
    }
    
    //销量
    NSArray *price = @[@"100",@"1000",@"2000",@"3000",@"40000"];
    NSMutableArray *salerArray = [NSMutableArray array];
    for (int i = 0; i< price.count; i ++) {
        TageModel *model = [[TageModel alloc] init];
        model.title = price[i];
        [salerArray addObject:model];
    }
    
    // 筛选
    NSArray *choose = @[@"条件",@"条件1",@"条件2",@"条件3"];
    NSMutableArray *chooseArray = [NSMutableArray array];
    for (int i = 0; i < choose.count; i ++) {
        TageModel *model = [[TageModel alloc] init];
        model.title = choose[i];
        [chooseArray addObject:model];
    }
    
    
    NSMutableArray *resultArray = [NSMutableArray array];
    for (int i = 0; i < titles.count; i ++) {
        TageModel *model = [[TageModel alloc] init];
        model.title = titles[i];
       
        if (i == 0) {
            model.dataArray = dataArray1;
        }else if (i == 1){
            model.dataArray = priceArray;
        }else if (i == 2){
            model.dataArray = salerArray;
        }else if (i == 3){
            model.dataArray = chooseArray;
        }
        
        model.identifer = i;
        [resultArray addObject:model];
        
        self.model = model;
    }
    
    
    TageModel *models = [[TageModel alloc] init];
    models.frame = CGRectMake(0, StatusBarHeight, ScreenW, 60);
    models.titles = resultArray.mutableCopy;
    models.menuHeight = 60;
    models.dataArray = resultArray;
    
    
    DropMenuView *view = [DropMenuView createDropMenuViewwithItems:models];
    view.delegate = self;
    [self.view addSubview:view];
    
    
    
    
    
}


- (void)dropppmenuView:(DropMenuView *)view withResutStr:(NSString *)str{
    
    NSLog(@"===========%@",str);
    
}


@end

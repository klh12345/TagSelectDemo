//
//  DropMenuView.m
//  SelectTageDemo
//
//  Created by 中国孔 on 2019/2/28.
//  Copyright © 2019 孔令辉. All rights reserved.
//

#import "DropMenuView.h"

#import "DropMenuCell.h"
#import "TageModel.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define NavigationBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

@interface DropMenuView ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DropMenuItemDelegate>
@property (strong , nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (strong , nonatomic) UICollectionView *collectioView;
@property (strong , nonatomic) UIView *bottomLine;
@property (strong , nonatomic) UIView *headerLine;
// 菜单栏的高度
@property (assign , nonatomic) CGFloat menuHeight;
// 当前选中头部那个按钮
@property (assign , nonatomic) NSInteger currentIndex;
// 当前页面上正在显示titles
@property (strong , nonatomic) NSMutableArray *titles;

@property (strong , nonatomic) UITableView *tableView;
// tableView 使用时数据源
@property (strong , nonatomic) NSMutableArray *dataSource;



@end

static NSString *const dropMenuCellid = @"DropMenuCell";
@implementation DropMenuView

+ (instancetype)createDropMenuViewwithItems:(TageModel *)models{
   
    DropMenuView *view = [[DropMenuView alloc] initWithFrame:CGRectMake(0, models.frame.origin.y, models.frame.size.width, ScreenH - 34 - models.frame.size.height)];
    view.models = models;
    
    return view;
    
}

- (instancetype)init{
    
    if (self = [super init]) {
        [self setupUI];
        [self defaultSetting];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self defaultSetting];
    }
    return self;
}


- (void)setModels:(TageModel *)models{
    _models = models;
    
    self.titles = models.titles.copy;
        
    if (models.menuHeight) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.collectioView.frame = CGRectMake(0, NavigationBarHeight, ScreenW, models.menuHeight);
            
        } completion:^(BOOL finished) {
        }];
        
        self.menuHeight = models.menuHeight;
        
    }
        
    [self resetExpress];
    
}



- (void)defaultSetting{
    self.backgroundColor = [UIColor clearColor];
    self.menuHeight = 44;
    self.currentIndex = 0;
    
}

- (void)setupUI{
    
    [self addSubview:self.collectioView];
    [self.collectioView addSubview:self.headerLine];
    [self.collectioView addSubview:self.bottomLine];
    
    
    [self addSubview:self.tableView];
}

- (void)layoutSubviews{
    
    self.collectioView.frame = CGRectMake(0, NavigationBarHeight, ScreenW,self.menuHeight);
    self.headerLine.frame = CGRectMake(0, 0, ScreenW, 1);
    self.bottomLine.frame = CGRectMake(0, self.menuHeight - 1, ScreenW, 1);
    
}

- (void)show{
    
    [self.tableView reloadData];
    
    // 先reset 避免 tableView 未收回时点击了其他标题 造成原状态无法回复的BUg
    [self resetExpress];
    
    TageModel *headerModel = self.titles[self.currentIndex];
    headerModel.titleSelected = YES;
    
    [self.collectioView reloadData];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.tableView.frame = CGRectMake(0, self.menuHeight+NavigationBarHeight, ScreenW, headerModel.dataArray.count * 44);
        self.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0F alpha:1.0F];
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)dismiss{
    
    [self resetExpress];
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = CGRectMake(0,NavigationBarHeight +self.menuHeight, ScreenW, 0);
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        
        [self.tableView reloadData];
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
    
    [self dismiss];
    
}






// 重置头部显示 每次用户跟新筛选条件后需要重新加载头部显示
- (void)resetExpress{
    
    for (TageModel *model in self.titles) {
        model.titleSelected = NO;
    }
    
    [self.collectioView reloadData];
    
}


- (void)dropMenuCell:(DropMenuCell *)cell withCellItems:(TageModel *)modls{
   
    modls.titleSelected = !modls.titleSelected;
    self.currentIndex = modls.indexPath.row;
    
    if (modls.titleSelected) {
        self.dataSource = modls.dataArray.mutableCopy;
        for (TageModel *model in self.titles) {

            if (model.identifer != model.identifer) {
                model.titleSelected = NO;
            }

        }
        [self show];
    }else{

        [self dismiss];
    }

    [self.collectioView reloadData];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
  return  self.dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
    
    // 先定位当前头部标签类型
    TageModel *model = self.titles[self.currentIndex];
    // 根据类型取出对应类型下的值
    TageModel *cotentModel = model.dataArray[indexPath.row];
    
    cell.textLabel.text = cotentModel.title;
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
    cell.textLabel.textColor = [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TageModel *model = self.titles[self.currentIndex];
    TageModel *contentModel = model.dataArray[indexPath.row];
    
    NSString *str = contentModel.title;
    if ([self.delegate respondsToSelector:@selector(dropppmenuView:withResutStr:)]) {
        [self.delegate dropppmenuView:self withResutStr:str];
    }
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
     return CGSizeMake(ScreenW/self.titles.count, self.menuHeight);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.titles.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DropMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dropMenuCellid forIndexPath:indexPath];
    TageModel *model = self.titles[indexPath.row];
    model.indexPath = indexPath;
    
    cell.delegate = self;
    cell.models = model;
    
    return cell;
}












#pragma mark --  Lazyload

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight+60, ScreenW, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];
        [self addSubview:self.tableView];
        
    }
    return _tableView;
}


- (UICollectionViewFlowLayout *)flowLayout{
    
    if (!_flowLayout) {
        
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 0.01f;
        _flowLayout.minimumInteritemSpacing = 0.02f;
    }
    return _flowLayout;
}

- (UICollectionView *)collectioView{
    
    if (!_collectioView) {
        
        _collectioView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, ScreenW, 0) collectionViewLayout:self.flowLayout];
        _collectioView.delegate = self;
        _collectioView.dataSource = self;
        
        _collectioView.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
        [_collectioView registerClass:[DropMenuCell class] forCellWithReuseIdentifier:dropMenuCellid];
        [self addSubview:self.collectioView];
    }
    return _collectioView;
}

- (NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (UIView *)headerLine{
    
    if (!_headerLine) {
        _headerLine = [[UIView alloc] init];
        _headerLine.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
    }
    return _headerLine;
}


- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
        
    }
    
    return _bottomLine;
    
}

- (NSMutableArray *)titles{
    
    if (!_titles) {
        
        _titles = [NSMutableArray array];
        
    }
    return _titles;
}

@end

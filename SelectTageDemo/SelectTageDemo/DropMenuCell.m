//
//  DropMenuCell.m
//  SelectTageDemo
//
//  Created by 中国孔 on 2019/2/28.
//  Copyright © 2019 孔令辉. All rights reserved.
//

#import "DropMenuCell.h"
#import "TageModel.h"


@implementation DropMenuCell


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {

        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.line];
    }
    return self;
}



- (void)setModels:(TageModel *)models{
    _models = models;
    
    _title.text = models.title;
    _title.textColor = models.titleSelected ? [UIColor colorWithRed:100.0f/255.0f green:51.0f/255.0f blue:200.0f/255.0f alpha:1.0f]:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f];

}


- (void)layoutSubviews{
    
    
    // 这个位置不能用 bounds 必须使用frame
    //  frame: 该view在父view坐标系统中的位置和大小。（参照点是，父亲的坐标系统）
    //  bounds: 该view在本地坐标系统中的位置和大小。（参照点是，本地坐标系统
    // 另外:
    // center：该view的中心点在父view坐标系统中的位置和大小。（参照电是，父亲的坐标系统）
    self.title.frame = self.bounds;
    
    self.line.frame = CGRectMake(self.frame.size.width -1, (self.frame.size.height - self.frame.size.height * 0.2) * 0.5, 1, self.frame.size.width * 0.2);
    
}


- (void)taper:(UITapGestureRecognizer *)tapers{
    
    
    if ([self.delegate respondsToSelector:@selector(dropMenuCell:withCellItems:)]) {
        
        [self.delegate dropMenuCell:self withCellItems:self.models];
    }
    
}


- (UIView *)line{
    
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor lightGrayColor];
    }
    return _line;
}


- (UILabel *)title{
    
    if (!_title) {
     
        _title = [[UILabel alloc] init];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.userInteractionEnabled = YES;
        _title.font = [UIFont systemFontOfSize:13.0f];
        _title.textColor = [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f];
        UITapGestureRecognizer *taper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taper:)];
        taper.numberOfTapsRequired = 1;
        taper.numberOfTouchesRequired = 1;
        
        [_title addGestureRecognizer:taper];
    }
    return _title;
}


@end

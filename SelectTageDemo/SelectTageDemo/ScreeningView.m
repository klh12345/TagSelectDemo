//
//  ScreeningView.m
//  SelectTageDemo
//
//  Created by 中国孔 on 2019/2/28.
//  Copyright © 2019 孔令辉. All rights reserved.
//

#import "ScreeningView.h"

@implementation ScreeningView

- (instancetype)initWithFrame:(CGRect)frame{
   
    self = [super initWithFrame:frame];
    if (self) {
     
        UITapGestureRecognizer *taper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taper:)];
        [self addGestureRecognizer:taper];
        
        
    }
    return self;
}









// 避免父视图的点击事件在这里响应
- (void)taper:(UITapGestureRecognizer *)taper{
    
    return;
    
}



@end

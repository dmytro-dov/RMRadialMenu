//
//  RadialMenuImageItemView.m
//  RadialMenu
//
//  Created by Admin on 19.02.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "RadialMenuImageItemView.h"
#import "RMRadialMenuView.h"
@interface RadialMenuImageItemView()

@end


@implementation RadialMenuImageItemView

-(id) init
{
    if(self = [super init])
    {
        _imgView = [[UIImageView alloc] init];
        [self addSubview:_imgView];
        
    }
    return self;
}
-(void) didMoveToSuperview
{
    [super didMoveToSuperview];


    [_imgView setFrame:CGRectMake(self.segmentCenter.x-20, self.segmentCenter.y-20 , 40, 40)];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

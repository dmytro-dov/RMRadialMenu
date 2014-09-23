//
//  RMRadialMenuItem.m
//  RadialMenu
//
//  Created by Admin on 22/09/2014.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "RMRadialMenuItem.h"

@interface RMRadialMenuItem()

@property (nonatomic, retain) UIBezierPath *path;

@end

@implementation RMRadialMenuItem

-(id) init
{
    if(self = [super init])
    {
        _fillColor = [UIColor orangeColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

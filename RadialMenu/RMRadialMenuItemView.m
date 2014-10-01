//
//  RMRadialMenuItem.m
//  RadialMenu
//
//  Created by Admin on 22/09/2014.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "RMRadialMenuItemView.h"

@interface RMRadialMenuItemView()

//@property (nonatomic, retain) CAShapeLayer *segmentLayer;

@end

@implementation RMRadialMenuItemView

-(id) init
{
    if(self = [super init])
    {
        _fillColor = [UIColor clearColor];
        _strokeColor = [UIColor magentaColor];
        _segmentLayer = [CAShapeLayer layer];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _fillColor = [UIColor clearColor];
        _strokeColor = [UIColor magentaColor];
        _segmentLayer = [CAShapeLayer layer];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:_segmentLayer.path];
    [_fillColor setFill];
    [_strokeColor setStroke];
    if(path)
        [path fill];
}


@end

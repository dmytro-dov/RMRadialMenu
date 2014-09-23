//
//  RMRadialMenuView.m
//  RadialMenu
//
//  Created by Admin on 22/09/2014.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "RMRadialMenuView.h"

@interface RMRadialMenuView ()

@property float centerRadius;

@end

@implementation RMRadialMenuView

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _centerRadius = 52;
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *middleCircle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.frame.size.width/2-_centerRadius, self.frame.size.height/2-_centerRadius, 2*_centerRadius, 2*_centerRadius) ];
    [super drawRect:rect];
    [[UIColor whiteColor] setFill];
    CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
    
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), NULL);
    [[UIColor redColor] setStroke];
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1);
    [middleCircle stroke];
    UIFont* font = [UIFont fontWithName:@"Arial" size:12];
    UIColor* textColor = [UIColor redColor];
    NSDictionary* stringAttrs = @{ NSFontAttributeName : font, NSForegroundColorAttributeName : textColor };
    
    NSAttributedString* attrStr = [[NSAttributedString alloc] initWithString:@"Hello" attributes:stringAttrs];
    for(int i = 0; i < [_dataSource numberOfItemsInRadialMenuView:self]; i++)
    {
        [attrStr drawAtPoint:CGPointMake(10.f, 10.f)];
    }
    [attrStr drawAtPoint:CGPointMake(10.f, 10.f)];
    
}


@end

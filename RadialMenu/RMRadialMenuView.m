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
@property CGPoint centre;

@end

@implementation RMRadialMenuView

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _centerRadius = 30;
        _centre = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
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
    
    
    
    NSAttributedString* attrStr = [[NSAttributedString alloc] initWithString:@"." attributes:stringAttrs];
    NSInteger n = [_dataSource numberOfItemsInRadialMenuView:self];
    float sizeArc = (2*M_PI)/n - (6*M_PI/180);
    float alpha = 0;
    for(int i = 1; i <= n; i++)
    {
        
        alpha = i* sizeArc + i *(6*M_PI/180);
        UIBezierPath *segment= [UIBezierPath bezierPathWithArcCenter:_centre radius:33 startAngle:alpha endAngle: alpha + sizeArc clockwise:true];
        [segment moveToPoint:_centre.x + sin(alpha)*33];
        segment appendPath:[UIBezierPath bezierPathWithArcCenter:_centre radius:120 startAngle:alpha endAngle: alpha + sizeArc clockwise:true];
        [segment stroke];
        UIBezierPath *circleOuter= [UIBezierPath bezierPathWithArcCenter:_centre radius:120 startAngle:alpha endAngle: alpha + sizeArc clockwise:true];
        [circleOuter stroke];
        //[attrStr drawAtPoint:CGPointMake( _centre.x + sin(alpha) * 60, _centre.y + cos(alpha) * 60)];
    }
    //[attrStr drawAtPoint:CGPointMake(10.f, 10.f)];
    
}


@end

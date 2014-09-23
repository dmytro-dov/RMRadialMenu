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
    double sizeArc = (2*M_PI)/n - (6*M_PI/180);
    double alpha = 0;
    double alphaLine = 0;
    double angleGap = 0;
    for(int i = 0; i < n; i++)
    {
        double c = sqrt(2*pow(33, 2)*(1-cos((6*M_PI/180))));
        angleGap = 2*asin(c/(2*120));
        angleGap = (6*M_PI/180) - angleGap;
        alpha = i* sizeArc + i *(6*M_PI/180) + (6*M_PI/180)/2 - M_PI/2 - sizeArc/2 - angleGap/2;
        alphaLine = alpha + M_PI/2;
        UIBezierPath *segment = [UIBezierPath bezierPath];
        [segment moveToPoint:CGPointMake(_centre.x + sin(alphaLine)*33, _centre.y - cos(alphaLine)*33)];
        [segment addLineToPoint:CGPointMake(_centre.x + sin(alphaLine - angleGap/2)*120, _centre.y - cos(alphaLine - angleGap/2)*120)];
        [segment addArcWithCenter:_centre radius:120 startAngle:alpha - angleGap/2 endAngle:alpha + sizeArc + angleGap/2 clockwise:true];
        [segment addLineToPoint:CGPointMake(_centre.x + sin(alphaLine+sizeArc)*33, _centre.y - cos(alphaLine+sizeArc)*33)];
        [segment addArcWithCenter:_centre radius:33 startAngle:alpha + sizeArc endAngle:alpha   clockwise:false];
        [segment closePath];
        [segment stroke];
        [[UIColor colorWithRed: 30/255.0f green:30/255.0f blue:230/255.0f alpha:0.5f] setFill];
        [segment fill];
        [[UIBezierPath bezierPathWithArcCenter:_centre radius:1 startAngle:0 endAngle:2*M_PI clockwise:true] stroke];
    }
    //[attrStr drawAtPoint:CGPointMake(10.f, 10.f)];
    
}


@end

//
//  RMRadialMenuItem.m
//  RadialMenu
//
//  Created by Admin on 22/09/2014.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "RMRadialMenuItemView.h"
#import "RMRadialMenuView.h"
#define DarkenAmount 45.0f
@interface RMRadialMenuItemView()
@property (nonatomic) UIColor *originalColor;
//@property (nonatomic, retain) CAShapeLayer *segmentLayer;
@property CGPoint segmentCenter;
@end
@interface RMRadialMenuView ()

@property float centerRadius;
@property float segmentGap;
@property CGPoint centre;
@property NSInteger selectedIndex;
@property int y;
@property (nonatomic) UIColor *prevColor;

@end

@implementation RMRadialMenuItemView
@synthesize fillColor = _fillColor;

-(id) init
{
    if(self = [super init])
    {
        _fillColor = [UIColor clearColor];
        _strokeColor = [UIColor magentaColor];
        _segmentLayer = [CAShapeLayer layer];
        _darkened = false;
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
        _darkened = false;
    }
    return self;
}

-(UIColor *) fillColor
{
    return _fillColor;
}

-(void) setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    _originalColor = fillColor;
    [self setNeedsDisplay];
}
-(void) darkenSegment
{
    if(!_darkened)
    {
        
        NSLog(@"DARKENING");
        CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
        if ([_fillColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
            [_fillColor getRed:&red green:&green blue:&blue alpha:&alpha];
            NSLog(@"R:%fG:%fB:%f", red*255.0, green*255.0, blue*255.0);
            if(red >= (DarkenAmount)/255.0 )
                red = red - (DarkenAmount)/255.0;
            else
                red = red;
            if(green >= (DarkenAmount)/255.0)
                green = green - (DarkenAmount)/255.0;
            else
                green = green;
            if(blue >=(DarkenAmount)/255.0 )
                blue = blue - (DarkenAmount)/255.0;
            else
                blue = blue;
        }
        
        NSLog(@"R:%fG:%fB:%f", red*255.0, green*255.0, blue*255.0);
        _fillColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        _darkened = true;
    }
    
}
-(void) lightenSegment
{
    if(_darkened)
    {
        NSLog(@"LIGHTENING");
        
        _fillColor = _originalColor;
        _darkened = false;
    }
}

-(void) didMoveToSuperview
{
    
    RMRadialMenuView *radialMenuView = (RMRadialMenuView *) [self superview];
    NSInteger i =[radialMenuView.items indexOfObject:self];
    NSInteger n = [radialMenuView.items count];
    double sizeArc = (2*M_PI)/n - (radialMenuView.segmentGap*M_PI/180);
    double c = sqrt(2*pow(33, 2)*(1-cos((radialMenuView.segmentGap*M_PI/180))));
    double angleGap = 2*asin(c/(2*OUTER_RADIUS));
    double alphaLine = 0;
    
    
    angleGap = (radialMenuView.segmentGap*M_PI/180) - angleGap;
    float alpha = i* sizeArc + i *(radialMenuView.segmentGap*M_PI/180) + (radialMenuView.segmentGap*M_PI/180)/2 - M_PI/2 - sizeArc/2 - angleGap/2;
    alphaLine = alpha + M_PI/2;
//    double x1 = radialMenuView.centre.x + sin(alphaLine)*33;
//    double x2 = radialMenuView.centre.x + sin(alphaLine - angleGap/2)*OUTER_RADIUS;
//    double y2 = radialMenuView.centre.y - cos(alphaLine - angleGap/2)*OUTER_RADIUS;
//    double x3 = radialMenuView.centre.x + cos(-(sizeArc + angleGap))*(x2-self.center.x) + sin(-(sizeArc + angleGap))*(y2-self.center.y);
//    double x4 = radialMenuView.centre.x + sin(alphaLine+sizeArc)*INNER_RADIUS;
//    
//    double y1 = radialMenuView.centre.y - cos(alphaLine)*33;
//    double y3 = radialMenuView.centre.y - sin(-(sizeArc + angleGap))*(x2-self.center.x) + cos(-(sizeArc + angleGap))*(y2-self.center.y);
//    double y4 = radialMenuView.centre.y - cos(alphaLine+sizeArc)*33;
    double D = (2*OUTER_RADIUS*sin((sizeArc + angleGap))/2)/3*(sizeArc + angleGap);
    D = (OUTER_RADIUS + INNER_RADIUS)/2;
    double x =radialMenuView.centre.x + cos(-(sizeArc + angleGap)/2)*(radialMenuView.centre.x + sin(alphaLine - angleGap/2)*D-self.center.x) + sin(-(sizeArc + angleGap)/2)*(radialMenuView.centre.y - cos(alphaLine - angleGap/2)*D-self.center.y);
    double y = radialMenuView.centre.y - sin(-(sizeArc + angleGap)/2)*(radialMenuView.centre.x + sin(alphaLine - angleGap/2)*D-self.center.x) + cos(-(sizeArc + angleGap)/2)*(radialMenuView.centre.y - cos(alphaLine - angleGap/2)*D-self.center.y);
    self.segmentCenter = CGPointMake(x, y);

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

//
//  RMRadialMenuItem.m
//  RadialMenu
//
//  Created by Admin on 22/09/2014.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "RMRadialMenuItemView.h"

#define DarkenAmount 45.0f
@interface RMRadialMenuItemView()
@property (nonatomic) UIColor *originalColor;
//@property (nonatomic, retain) CAShapeLayer *segmentLayer;
@property CGPoint segmentCenter;
@end
@interface RMRadialMenuView ()

@property CGFloat centerRadius;
@property CGFloat ringGap;
@property CGFloat segmentRadius;
@property float segmentGap;
@property CGPoint centre;
@property RMIndexPath selectedIndex;

@property int y;
@property (nonatomic) UIColor *prevColor;
@property CGPoint anchor;

@end

@implementation RMRadialMenuItemView
@synthesize fillColor = _fillColor;

-(id) init
{
    if(self = [super init])
    {
        _fillColor = [UIColor clearColor];
        _strokeColor = [UIColor whiteColor];
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
        [self setNeedsDisplay];
    }
    
}
-(void) lightenSegment
{
    if(_darkened)
    {
        NSLog(@"LIGHTENING");
        
        _fillColor = _originalColor;
        _darkened = false;
        [self setNeedsDisplay];
    }
}

-(void) didMoveToSuperview
{
    if(!self.segmentCenter.x && !self.segmentCenter.y)
        [self determineCenter];
    
    

}

-(void) determineCenter
{
    RMRadialMenuView *radialMenuView = (RMRadialMenuView *) [self superview];
    int sectionIndex = _indexPath.section;
    NSInteger i =[radialMenuView.items[sectionIndex] indexOfObject:self];
    NSInteger n = [radialMenuView.items[sectionIndex] count];
    
    double sizeArc = (2*M_PI)/n - (radialMenuView.segmentGap*M_PI/180);
    double alpha = 0;
    double angleGap = 0;
    CGFloat startingRadius = radialMenuView.centerRadius + radialMenuView.ringGap*(sectionIndex + 1) + radialMenuView.segmentRadius * sectionIndex;
    CGFloat innerRadius =radialMenuView.centerRadius + radialMenuView.ringGap;

    
    double c = sqrt(2*pow(innerRadius, 2)*(1-cos((radialMenuView.segmentGap*M_PI/180))));
    angleGap = 2*asin(c/(2*(startingRadius +radialMenuView.segmentRadius)));
    angleGap = (radialMenuView.segmentGap*M_PI/180) - angleGap;
    double ci = sqrt(2*pow(innerRadius, 2)*(1-cos((radialMenuView.segmentGap*M_PI/180))));
    double angleGapi = 2*asin(ci/(2*(startingRadius)));
    angleGapi = (radialMenuView.segmentGap*M_PI/180) - angleGapi;
    alpha = i * sizeArc + i *(radialMenuView.segmentGap*M_PI/180) - sizeArc/2;
    
    
    CGFloat D = (innerRadius + startingRadius + radialMenuView.segmentRadius*(sectionIndex +1))/2;
    double x =radialMenuView.centre.x + cos(-(sizeArc + angleGap)/2)*(radialMenuView.centre.x + sin(alpha - angleGap/2)*D-self.center.x) + sin(-(sizeArc + angleGap)/2)*(radialMenuView.centre.y - cos(alpha - angleGap/2)*D-self.center.y);
    double y = radialMenuView.centre.y - sin(-(sizeArc + angleGap)/2)*(radialMenuView.centre.x + sin(alpha - angleGap/2)*D-self.center.x) + cos(-(sizeArc + angleGap)/2)*(radialMenuView.centre.y - cos(alpha - angleGap/2)*D-self.center.y);
    self.segmentCenter = CGPointMake(x, y);
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:_segmentLayer.path];
    [_fillColor setFill];
    [_strokeColor setStroke];
    [path stroke];
    [path fill];
}


@end

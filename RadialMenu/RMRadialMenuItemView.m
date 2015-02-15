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
        CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
        if ([_fillColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
            [_fillColor getRed:&red green:&green blue:&blue alpha:&alpha];
            NSLog(@"R:%fG:%fB:%f", red*255.0, green*255.0, blue*255.0);
            if(red + DarkenAmount/255.0 <= 1)
            {
                if(red >DarkenAmount/255.0)
                    red = red + DarkenAmount/255.0;
            }
            else
                red = 1.0;
            if(green + DarkenAmount/255.0 <= 1)
            {
                if(green >DarkenAmount/255.0)
                    green = green + DarkenAmount/255.0;
            }
            else
                green = 1.0;
            if(blue + DarkenAmount/255.0 <= 1)
            {
                if(blue >DarkenAmount/255.0)
                    blue = blue + DarkenAmount/255.0;
            }
            else
                blue = 1.0;
        }
        NSLog(@"R:%fG:%fB:%f", red*255.0, green*255.0, blue*255.0);
        _fillColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        _darkened = false;
    }
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

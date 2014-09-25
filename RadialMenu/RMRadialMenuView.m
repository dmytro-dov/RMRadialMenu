//
//  RMRadialMenuView.m
//  RadialMenu
//
//  Created by Admin on 22/09/2014.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "RMRadialMenuView.h"
#import "RMRadialMenuItem+Path.h"


@interface RMRadialMenuView ()

@property float centerRadius;
@property float segmentGap;
@property CGPoint centre;

@property int y;
@property (nonatomic) UIColor *prevColor;

@end

@implementation RMRadialMenuView

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _centerRadius = 30;
        _centre = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        _segmentGap = 9;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.0f;
    }
    return self;
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    //NSLog(@"%f %f", [touch locationInView:self.view].x, [touch locationInView:self.view].y);
    for(RMRadialMenuItem *item in _items)
    {
        bool found = false;
        
        for(UITouch *t in touches)
        {
            UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:item.segmentLayer.path];
            if([path containsPoint:[t locationInView:item]])
            {
                //item.fillColor = [UIColor redColor];
                NSLog(@"little end %d", item.index);
                found = true;
            }
            else
            {
                
            }
        }
        if(found)
        {
            item.fillColor = [UIColor greenColor];
            [item setNeedsDisplay];
        }
        else
        {
            item.fillColor = [UIColor orangeColor];
            [item setNeedsDisplay];
        }
        //item.fillColor = [UIColor orangeColor];
    }
    //[self setNeedsDisplay];
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for(RMRadialMenuItem *item in _items)
    {
        item.fillColor = [UIColor orangeColor];
        [item setNeedsDisplay];
        //item.fillColor = [UIColor orangeColor];
    }
    [UIView animateWithDuration:0.2 animations:^(void){
        self.alpha = 0.0f;
    }completion:^(bool fin){
        [self removeFromSuperview];
    }];
    
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    for(UIView *sub in self.subviews)
        [sub removeFromSuperview];
    UIBezierPath *middleCircle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.frame.size.width/2-_centerRadius, self.frame.size.height/2-_centerRadius, 2*_centerRadius, 2*_centerRadius) ];
    [[UIColor clearColor] setFill];
    [middleCircle stroke];
    if(!_items || [_items count] != [_dataSource numberOfItemsInRadialMenuView:self])
    {
        NSMutableArray *tempItems = [NSMutableArray array];
        
        for(int i = 0; i < [_dataSource numberOfItemsInRadialMenuView:self]; i++)
        {
           [tempItems addObject: [_dataSource radialMenuView:self itemAtIndex:i]];
        }
        _items = [NSArray arrayWithArray:tempItems];
        NSLog(@"%li", [_items count]);
        
        
        NSInteger n = [_items count];
        double sizeArc = (2*M_PI)/n - (_segmentGap*M_PI/180);
        double alpha = 0;
        double alphaLine = 0;
        double angleGap = 0;
        NSMutableArray * segments = [NSMutableArray array];
        for(int i = 0; i < n; i++)
        {
            double c = sqrt(2*pow(33, 2)*(1-cos((_segmentGap*M_PI/180))));
            angleGap = 2*asin(c/(2*120));
            angleGap = (_segmentGap*M_PI/180) - angleGap;
            alpha = i* sizeArc + i *(_segmentGap*M_PI/180) + (_segmentGap*M_PI/180)/2 - M_PI/2 - sizeArc/2 - angleGap/2;
            alphaLine = alpha + M_PI/2;
            UIBezierPath *segment = [UIBezierPath bezierPath];
            [segment moveToPoint:CGPointMake(_centre.x + sin(alphaLine)*33, _centre.y - cos(alphaLine)*33)];
            [segment addLineToPoint:CGPointMake(_centre.x + sin(alphaLine - angleGap/2)*120, _centre.y - cos(alphaLine - angleGap/2)*120)];
            [segment addArcWithCenter:_centre radius:120 startAngle:alpha - angleGap/2 endAngle:alpha + sizeArc + angleGap/2 clockwise:true];
            [segment addLineToPoint:CGPointMake(_centre.x + sin(alphaLine+sizeArc)*33, _centre.y - cos(alphaLine+sizeArc)*33)];
            [segment addArcWithCenter:_centre radius:33 startAngle:alpha + sizeArc endAngle:alpha   clockwise:false];
            [segment closePath];
            RMRadialMenuItem *item = (RMRadialMenuItem*) _items[i];
            [item setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            item.segmentLayer.path = [segment CGPath];
            [[UIColor colorWithRed: 30/255.0f green:30/255.0f blue:230/255.0f alpha:0.5f] setFill];
            
            [segments addObject:segment];
            //[[UIBezierPath bezierPathWithArcCenter:_centre radius:1 startAngle:0 endAngle:2*M_PI clockwise:true] stroke];
        }
    }
    
    for(int i = 0; i < [_items count]; i++)
    {
        RMRadialMenuItem *item = (RMRadialMenuItem*) _items[i];
        
        item.segmentLayer.fillColor = item.fillColor.CGColor;
        item.segmentLayer.strokeColor = item.strokeColor.CGColor;
        UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:item.segmentLayer.path];
        //[path fill];
        item.index = i;
           [self addSubview:item];
            item.backgroundColor = [UIColor clearColor];
            [item setNeedsDisplay];
        
        
    }
    //[attrStr drawAtPoint:CGPointMake(10.f, 10.f)];
    
}


@end

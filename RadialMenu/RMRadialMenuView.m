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
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(tapItem:)];
        [self addGestureRecognizer:swipe];
        self.backgroundColor = [UIColor clearColor];
        s
    }
    return self;
}

-(void) tapItem: (UISwipeGestureRecognizer *) sender
{
    NSLog(@"%li", [sender direction]);
    for(RMRadialMenuItem *item in _items)
    {
        for(int i = 0; i < sender.numberOfTouches; i ++)
        {
            if([item.path containsPoint:[sender locationOfTouch:i inView:self]])
            {
                    
                item.fillColor = [UIColor redColor];
            }
        }
    }
    [self setNeedsDisplay];
   
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    UIBezierPath *middleCircle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.frame.size.width/2-_centerRadius, self.frame.size.height/2-_centerRadius, 2*_centerRadius, 2*_centerRadius) ];
    [[UIColor clearColor] setFill];
    [middleCircle stroke];
    if(!_items)
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
            item.path = segment;
            [[UIColor colorWithRed: 30/255.0f green:30/255.0f blue:230/255.0f alpha:0.5f] setFill];
            //[segment fill];
            [segments addObject:segment];

            //[[UIBezierPath bezierPathWithArcCenter:_centre radius:1 startAngle:0 endAngle:2*M_PI clockwise:true] stroke];
        }
    }
    
    for(int i = 0; i < [_items count]; i++)
    {
        RMRadialMenuItem *item = (RMRadialMenuItem*) _items[i];
        
        [item.fillColor setFill];
        [item.strokeColor setStroke];
        [item.path fill];
        [item.path stroke];
        
    }
    //[attrStr drawAtPoint:CGPointMake(10.f, 10.f)];
    
}


@end

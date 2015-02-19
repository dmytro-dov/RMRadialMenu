//
//  RMRadialMenuView.m
//  RadialMenu
//
//  Created by Admin on 22/09/2014.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "RMRadialMenuView.h"
#import "RMRadialMenuItem+Path.h"
#import "RMTouchPanGestureRecognizer.h"



@interface RMRadialMenuView ()

@property float centerRadius;
@property float segmentGap;
@property CGPoint centre;
@property NSInteger selectedIndex;

@property int y;
@property (nonatomic) UIColor *prevColor;
@property CGPoint anchor;

@end

@implementation RMRadialMenuView
@synthesize triggerView = _triggerView;
-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _selectedIndex = -1;
        _centerRadius = 30;
        _centre = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        _segmentGap = 9;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.0f;
        _isStatic = true;
        _anchor = CGPointMake(frame.origin.x + frame.size.width/2, frame.origin.y + frame.size.height/2);
            }
    return self;
}
-(void)didMoveToSuperview
{
   RMTouchPanGestureRecognizer *panRecognizer = [[RMTouchPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragged:)];
    [self.superview addGestureRecognizer:panRecognizer];
    
}

-(UIView *) triggerView
{
    return _triggerView;
}

-(void) setTriggerView:(UIView *)triggerView
{
    _triggerView = triggerView;
    _anchor = CGPointMake(_triggerView.frame.origin.x + _triggerView.frame.size.width/2, _triggerView.frame.origin.y + _triggerView.frame.size.height/2);
}

-(void) dragged: (RMTouchPanGestureRecognizer *) gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        UITouch *touch = gesture.touch;
        
        
        if ([touch view] == _triggerView)
        {
            if(_isStatic)
            {
                [self setFrame:CGRectMake(_anchor.x - self.frame.size.width/2, _anchor.y - self.frame.size.height/2, self.frame.size.width, self.frame.size.height)];
            }
            else
            {
                [self setFrame:CGRectMake([gesture locationInView:self.superview].x -self.frame.size.width/2, [gesture locationInView:self.superview].y -self.frame.size.height/2, self.frame.size.width, self.frame.size.height)];
            }
            
            
            [UIView animateWithDuration:0.2 animations:^(void){
                self.alpha = 1.0f;
            }];
        }
        
        
    }
    if(gesture.state == UIGestureRecognizerStateChanged)
    {
        bool selected = false;
        for(RMRadialMenuItemView *item in _items)
        {
            bool found = false;
            
            
            UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:item.segmentLayer.path];
            if([path containsPoint:[gesture.touch locationInView:self]])
            {
                //item.fillColor = [UIColor redColor];
                //NSLog(@"little end %d", item.index);
                
                
                found = true;
            }
            else
            {
                
            }
            
            if(found)
            {
                [item darkenSegment];
                [item setNeedsDisplay];
                _selectedIndex = item.index;
                selected = true;
            }
            else
            {
                [item lightenSegment];
                [item setNeedsDisplay];
            }
            //item.fillColor = [UIColor orangeColor];
        }
        if(!selected)
        {
            _selectedIndex = -1;
        }
    }
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        for(RMRadialMenuItemView *item in _items)
        {
            if(item.index != _selectedIndex)
            {
                [item lightenSegment];
                [item setNeedsDisplay];
            }
            //item.fillColor = [UIColor orangeColor];
        }
        if(_selectedIndex >= 0)
        {
            [_delegate radialMenuView:self selectedItemAtIndex:_selectedIndex];
        }
        _selectedIndex = -1;
        [UIView animateWithDuration:0.15 animations:^(void){
            self.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self setFrame:CGRectMake(-300, -300, self.frame.size.width, self.frame.size.height)];
            for(RMRadialMenuItemView *item in _items)
            {
                [item lightenSegment];
                [item setNeedsDisplay];
                //item.fillColor = [UIColor orangeColor];
            }
        }];
    }

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
    [[UIColor colorWithWhite:0.2 alpha:0.5] setStroke];
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
            angleGap = 2*asin(c/(2*OUTER_RADIUS));
            angleGap = (_segmentGap*M_PI/180) - angleGap;
            alpha = i* sizeArc + i *(_segmentGap*M_PI/180) + (_segmentGap*M_PI/180)/2 - M_PI/2 - sizeArc/2 - angleGap/2;
            alphaLine = alpha + M_PI/2;
            UIBezierPath *segment = [UIBezierPath bezierPath];
            [segment moveToPoint:CGPointMake(_centre.x + sin(alphaLine)*33, _centre.y - cos(alphaLine)*33)];
            [segment addLineToPoint:CGPointMake(_centre.x + sin(alphaLine - angleGap/2)*OUTER_RADIUS, _centre.y - cos(alphaLine - angleGap/2)*OUTER_RADIUS)];
            [segment addArcWithCenter:_centre radius:OUTER_RADIUS startAngle:alpha - angleGap/2 endAngle:alpha + sizeArc + angleGap/2 clockwise:true];
            [segment addLineToPoint:CGPointMake(_centre.x + sin(alphaLine+sizeArc)*INNER_RADIUS, _centre.y - cos(alphaLine+sizeArc)*33)];
            [segment addArcWithCenter:_centre radius:33 startAngle:alpha + sizeArc endAngle:alpha   clockwise:false];
            [segment closePath];
            RMRadialMenuItemView *item = (RMRadialMenuItemView*) _items[i];
            [item setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            item.segmentLayer.path = [segment CGPath];
            [[UIColor colorWithRed: 30/255.0f green:30/255.0f blue:230/255.0f alpha:0.5f] setFill];
            
            [segments addObject:segment];
            //[[UIBezierPath bezierPathWithArcCenter:_centre radius:1 startAngle:0 endAngle:2*M_PI clockwise:true] stroke];
        }
    }
    
    for(int i = 0; i < [_items count]; i++)
    {
        RMRadialMenuItemView *item = (RMRadialMenuItemView*) _items[i];
        
        item.segmentLayer.fillColor = item.fillColor.CGColor;
        item.segmentLayer.strokeColor = item.strokeColor.CGColor;
        UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:item.segmentLayer.path];
        [path fill];
        item.index = i;
           [self addSubview:item];
            item.backgroundColor = [UIColor clearColor];
            [item setNeedsDisplay];
        
        
    }
    //[attrStr drawAtPoint:CGPointMake(10.f, 10.f)];
    
}


@end

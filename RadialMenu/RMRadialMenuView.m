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
RMIndexPath RMIndexPathMake(int section, int segment)
{
    RMIndexPath ip = {section, segment};
    return ip;
}

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
@property int lastShownSection;

@end

@implementation RMRadialMenuView
@synthesize triggerView = _triggerView;
-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _selectedIndex = RMIndexPathMake(-1, -1);
        _centerRadius = 30;
        _centre = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        _segmentGap = 0;
        _ringGap = -1;
        _segmentRadius = 65;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.0f;
        _isStatic = true;
        _lastShownSection = -1;
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
        for(int i = 0; i < [_items count]; i++)
        {
            for(RMRadialMenuItemView *item in _items[i])
            {
                
                if([path containsPoint:[gesture.touch locationInView:self]])
                {
                    _selectedIndex = RMIndexPathMake(i,item.indexPath.segment);
                    
                    selected = true;
                    [item darkenSegment];
//                    if(_lastShownSection != i || _lastShownSection == -1)
//                    {
//                        _lastShownSection = i;
//                        [self showNextSection];
//                    }
                    
                }
                else
                {
                    [item lightenSegment];
//                    if(_lastShownSection>i)
//                    {
//                        [self hideNextSection];
//                        _lastShownSection = i;
//                    }


                }
                //item.fillColor = [UIColor orangeColor];
            }
            if(!selected)
            {
                _selectedIndex = RMIndexPathMake(-1,-1);
            }

            
        }
    }
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        for(int i = 0; i <[_items count]; i++)
        {
            for(RMRadialMenuItemView *item in _items[i])
            {
                if(item.indexPath.segment != _selectedIndex.segment && item.indexPath.section != _selectedIndex.section)
                {
                    [item lightenSegment];
//                   [self hideNextSection];;
                }
                //item.fillColor = [UIColor orangeColor];
            }
            if(_selectedIndex.segment >= 0)
            {
                [_delegate radialMenuView:self selectedItemAtIndexPath:RMIndexPathMake(_selectedIndex.section, _selectedIndex.segment)];
            }
            _selectedIndex = RMIndexPathMake(-1,-1);
            [UIView animateWithDuration:0.15 animations:^(void){
                self.alpha = 0.0f;
            } completion:^(BOOL finished) {
                for(int i = 0; i < [_items count]; i++)
                {
                    for(RMRadialMenuItemView *item in _items[i])
                    {
                        [item lightenSegment];
//                        [self hideNextSection];
                        //item.fillColor = [UIColor orangeColor];
                    }
                }
            }];
        }
        
        
    }

}

-(void) showNextSection
{
    for(int y = 0; y < [_items count]; y++)
    {
        if(y <= _selectedIndex.section + 1)
        for (int i = 0; i < [_items[y] count]; i++)
        {
            [self addSubview:_items[y][i]];
            NSLog(@"Added");
        }
    }
    
}
-(void) hideNextSection
{
    for(int y = 0; y < [_items count]; y++)
    {
        if(y > _selectedIndex.section + 1)
            for (int i = 0; i < [_items[y] count]; i++)
            {
                [_items[y][i] removeFromSuperview];
            }
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
    
    if(!_items || [_items count] != [_dataSource numberOfSectionsInRadialMenuView:self])
    {
        _items = [NSArray array];
        NSMutableArray *tempItems = [NSMutableArray array];
        for( int sectionIndex = 0; sectionIndex < [_dataSource numberOfSectionsInRadialMenuView:self]; sectionIndex++)
        {
            NSMutableArray *tempSegments = [NSMutableArray array];

            
            for(int i = 0; i < [_dataSource numberOfItemsInRadialMenuViewSection:sectionIndex]; i++)
            {
                [tempSegments addObject: [_dataSource radialMenuView:self itemAtIndexPath:RMIndexPathMake(sectionIndex, i)]];
            }
           [tempItems addObject: [NSArray arrayWithArray:tempSegments]];
            NSLog(@"%li", [tempSegments count]);
            
            
            NSInteger n = [tempSegments count];
            double sizeArc = (2*M_PI)/n - (_segmentGap*M_PI/180);
            double alpha = 0;
            double angleGap = 0;
            NSMutableArray * segments = [NSMutableArray array];
            CGFloat startingRadius = _centerRadius + _ringGap*(sectionIndex + 1) + _segmentRadius * sectionIndex;
            CGFloat innerRadius =_centerRadius + _ringGap;
            for(int i = 0; i < n; i++)
            {
                
                double c = sqrt(2*pow(innerRadius, 2)*(1-cos((_segmentGap*M_PI/180))));
                angleGap = 2*asin(c/(2*(startingRadius +_segmentRadius)));
                angleGap = (_segmentGap*M_PI/180) - angleGap;
                double ci = sqrt(2*pow(innerRadius, 2)*(1-cos((_segmentGap*M_PI/180))));
                double angleGapi = 2*asin(ci/(2*(startingRadius)));
                angleGapi = (_segmentGap*M_PI/180) - angleGapi;
                alpha = i * sizeArc + i *(_segmentGap*M_PI/180) - M_PI/2 - sizeArc/2;
                UIBezierPath *segment = [UIBezierPath bezierPath];
                [segment addArcWithCenter:_centre radius:startingRadius startAngle:alpha + sizeArc +angleGapi/2 endAngle:alpha - angleGapi/2 clockwise:false];
                [segment addArcWithCenter:_centre radius:startingRadius + _segmentRadius startAngle:alpha - angleGap/2 endAngle:alpha + sizeArc +angleGap/2  clockwise:true];
                
                [segment closePath];
                RMRadialMenuItemView *item = (RMRadialMenuItemView*) tempSegments[i];
                [item setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
                item.segmentLayer.path = [segment CGPath];
                [[UIColor colorWithRed: 30/255.0f green:30/255.0f blue:230/255.0f alpha:0.5f] setFill];
                
                [segments addObject:segment];
                //[[UIBezierPath bezierPathWithArcCenter:_centre radius:1 startAngle:0 endAngle:2*M_PI clockwise:true] stroke];
            }
        }
        
        _items = [NSArray arrayWithArray:tempItems];
    }

            //Apply color
    for(int y = 0; y < [_items count]; y++)
    {
        
        for (int i = 0; i < [_items[y] count]; i++)
        {
            RMRadialMenuItemView *item = (RMRadialMenuItemView*) _items[y][i];
            
            item.segmentLayer.fillColor = item.fillColor.CGColor;
            item.segmentLayer.strokeColor = item.strokeColor.CGColor;
            
            item.indexPath = RMIndexPathMake(y, i);

//            if(y==0 || y == _selectedIndex.section || y == _selectedIndex.section + 1)
//            {
//                                [self addSubview:item];
//            }
            [self addSubview:item];//to remove
            item.backgroundColor = [UIColor clearColor];
            [item setNeedsDisplay];
        }
        
        
    }
    //[attrStr drawAtPoint:CGPointMake(10.f, 10.f)];
    
}


@end

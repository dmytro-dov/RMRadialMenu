//
//  RMTouchDownGestureRecognizer.m
//  RadialMenu
//
//  Created by Dmitry on 01/10/2014.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "RMTouchPanGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation RMTouchPanGestureRecognizer
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.state == UIGestureRecognizerStatePossible) {
        self.state = UIGestureRecognizerStateBegan;
        _touch = [touches anyObject];
        
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.state == UIGestureRecognizerStatePossible) {
        self.state = UIGestureRecognizerStateChanged;
        _touch = [touches anyObject];
        
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.state = UIGestureRecognizerStateEnded;
}
@end
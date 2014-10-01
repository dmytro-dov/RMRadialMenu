//
//  RMRadialMenuItem.h
//  RadialMenu
//
//  Created by Admin on 22/09/2014.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMRadialMenuItemView : UIView
@property (nonatomic) UIColor *fillColor;
@property (nonatomic) UIColor *strokeColor;
@property int index;
@property (nonatomic, retain) CAShapeLayer *segmentLayer;
-(id) init;
@end

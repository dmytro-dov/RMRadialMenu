//
//  RMRadialMenuView.h
//  RadialMenu
//
//  Created by Admin on 22/09/2014.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RMRadialMenuItem;
@class RMRadialMenuView;

@protocol RMRadialMenuDataSource <NSObject>

@required
-(NSInteger) numberOfItemsInRadialMenuView: (RMRadialMenuView *) radialMenuView;
-(RMRadialMenuItem *) radialMenuView: (RMRadialMenuView *) radialMenuVIew itemAtIndex: (NSInteger) index;

@end

@protocol RMRadialMenuDelegate <NSObject>

@optional
-(void) radialMenuView: (RMRadialMenuView *) radialMenuView selectedItemAtIndex: (NSInteger) index;

@end

@interface RMRadialMenuView : UIView
@property (nonatomic) NSArray *items;
@property (nonatomic, assign) id<RMRadialMenuDataSource> dataSource;
@property (nonatomic, assign) id<RMRadialMenuDelegate> delegate;
@end

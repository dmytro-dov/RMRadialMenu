//
//  RMRadialMenuView.h
//  RadialMenu
//
//  Created by Admin on 22/09/2014.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define INNER_RADIUS 33.0
#define SECTION_RADIUS 107.0

#ifndef RMINDEXPATH
#define RMINDEXPATH
typedef struct
{
    int section, segment;
}RMIndexPath;

RMIndexPath RMIndexPathMake(int section, int segment);

#endif
@class RMRadialMenuView;
@class RMRadialMenuItemView;


@protocol RMRadialMenuDataSource <NSObject>

@required
-(NSInteger) numberOfItemsInRadialMenuViewSection: (NSInteger) sectionIndex;
-(NSInteger) numberOfSectionsInRadialMenuView: (RMRadialMenuView *) radialMenuView;
-(RMRadialMenuItemView *) radialMenuView: (RMRadialMenuView *) radialMenuView itemAtIndexPath: (RMIndexPath) indexPath;

@end

@protocol RMRadialMenuDelegate <NSObject>

@optional
-(void) radialMenuView: (RMRadialMenuView *) radialMenuView selectedItemAtIndexPath: (RMIndexPath) indexPath;

@end

@interface RMRadialMenuView : UIView <UIGestureRecognizerDelegate>
@property (nonatomic) NSArray *items;
@property (nonatomic, assign) id<RMRadialMenuDataSource> dataSource;
@property (nonatomic, assign) id<RMRadialMenuDelegate> delegate;
@property bool isStatic;
@property (nonatomic) UIView *triggerView;
@end

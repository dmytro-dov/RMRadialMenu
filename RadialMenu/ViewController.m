//
//  ViewController.m
//  RadialMenu
//
//  Created by Admin on 22/09/2014.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "ViewController.h"
#import "RadialMenuImageItemView.h"

@interface ViewController ()
@property (nonatomic) RMRadialMenuView *radialMenuView;
@property (nonatomic) UISlider *slider;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _radialMenuView = [[RMRadialMenuView alloc] initWithFrame:CGRectMake(0, 0, 1000, 1000)];
    _radialMenuView.dataSource = self;
    _radialMenuView.delegate = self;
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 300, 300, 50)];
    [self.view addSubview:_slider];
    [_slider addTarget:self
               action:@selector(valueChanged:)
     forControlEvents:UIControlEventValueChanged];
    UIView * v = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-30, 2*self.view.bounds.size.height/3-30, 60, 60)];
    v.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    v.layer.cornerRadius = 30;
    [self.view addSubview:v];
    _radialMenuView.triggerView = v;
    [self.view addSubview:_radialMenuView];
    
}

-(void) valueChanged: (UISlider *)slider
{
    NSLog(@"Ch");
}
-(NSInteger) numberOfSectionsInRadialMenuView:(RMRadialMenuItemView *)radialMenuView
{
    return 2;
}
-(NSInteger) numberOfItemsInRadialMenuViewSection:(NSInteger) sectionIndex
{
    switch (sectionIndex)
    {
        case 0:
        {
            return 4;
        }
        case 2:
            return 5;
        case 3:
            return 7;
        case 4:
            return 3;
        default:
        {
            return 8;
        }
    }
    
}
-(void) radialMenuView:(RMRadialMenuView *)radialMenuView selectedItemAtIndexPath:(RMIndexPath)indexPath
{
    NSLog(@"Index Path %li - %li", indexPath.section, indexPath.segment);
}

-(RMRadialMenuItemView *) radialMenuView:(RMRadialMenuView *)radialMenuView itemAtIndexPath:(RMIndexPath)indexPath
{
    RMRadialMenuItemView *item = [[RMRadialMenuItemView alloc] init];
    
    switch (indexPath.segment)
    {
        case 0:
        {
            item = [[RadialMenuImageItemView alloc] init];
            //[((RadialMenuImageItemView*)item).imgView setImage:[UIImage imageNamed:@"fb_logo"]];
            //item.fillColor = [UIColor colorWithRed:(60/255.0) green:(90/255.0) blue:((153/255.0)) alpha:1] ;
            break;
        }
        case 1:
        {
            item = [[RadialMenuImageItemView alloc] init];
            //[((RadialMenuImageItemView*)item).imgView setImage:[UIImage imageNamed:@"gplus_logo"]];
            //item.fillColor = [UIColor colorWithRed:(220/255.0) green:(74/255.0) blue:((56/255.0)) alpha:1] ;
            break;
        }
        case 2:
        {
            item = [[RadialMenuImageItemView alloc] init];
           // [((RadialMenuImageItemView*)item).imgView setImage:[UIImage imageNamed:@"vk_logo"]];
           // item.fillColor = [UIColor colorWithRed:(76/255.0) green:(117/255.0) blue:((163/255.0)) alpha:1] ;
            break;
        }
        case 3:
        {
            item = [[RadialMenuImageItemView alloc] init];
//[((RadialMenuImageItemView*)item).imgView setImage:[UIImage imageNamed:@"twitter_logo"]];
           // item.fillColor = [UIColor colorWithRed:(42/255.0) green:(169/255.0) blue:((224/255.0)) alpha:1] ;
            break;
        }
        default:
        {
            item = [[RadialMenuImageItemView alloc] init];
//[((RadialMenuImageItemView*)item).imgView setImage:[UIImage imageNamed:@"example_image"]];
          //  item.fillColor = [UIColor colorWithRed:(143/255.0) green:(14/255.0) blue:((200/255.0)) alpha:1] ;
            break;
        }
    }
    switch(indexPath.segment % 4)
    {
        case 0:
        {
            item.fillColor = [UIColor colorWithRed:(143/255.0) green:(14/255.0) blue:((200/255.0)) alpha:1] ;
            return item;
        }
            
        case 1:
        {
            item.fillColor = [UIColor colorWithRed:(17/255.0) green:(234/255.0) blue:((200/255.0)) alpha:1] ;
            return item;
        }
        case 2:
        {
            item.fillColor = [UIColor colorWithRed:(78/255.0) green:(55/255.0) blue:((200/255.0)) alpha:1] ;
            return item;
        }
        case 3:
        {
            item.fillColor = [UIColor colorWithRed:(205/255.0) green:(23/255.0) blue:((14/255.0)) alpha:1] ;
            return item;
        }
            default:
        {
            item.fillColor = [UIColor colorWithRed:(34/255.0) green:(124/255.0) blue:((24/255.0)) alpha:1] ;
            return item;
        }
    }
    return item;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

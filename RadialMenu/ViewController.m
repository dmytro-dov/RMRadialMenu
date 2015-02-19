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
    _radialMenuView = [[RMRadialMenuView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-150, self.view.bounds.size.height/2-150, 300, 300)];
    _radialMenuView.dataSource = self;
    _radialMenuView.delegate = self;
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 300, 300, 50)];
    [self.view addSubview:_slider];
    [_slider addTarget:self
               action:@selector(valueChanged:)
     forControlEvents:UIControlEventValueChanged];
    UIView * v = [[UIView alloc] initWithFrame:CGRectMake(180, 440, 60, 60)];
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
-(NSInteger) numberOfItemsInRadialMenuView:(RMRadialMenuView *)radialMenuView
{
    return 4;
}
-(void) radialMenuView:(RMRadialMenuView *)radialMenuView selectedItemAtIndex:(NSInteger)index
{
    NSLog(@"Index %li", index);
}

-(RMRadialMenuItemView *) radialMenuView:(RMRadialMenuView *)radialMenuView itemAtIndex:(NSInteger)index
{
    RMRadialMenuItemView *item;
    switch (index)
    {
        case 0:
        {
            item = [[RadialMenuImageItemView alloc] init];
            [((RadialMenuImageItemView*)item).imgView setImage:[UIImage imageNamed:@"fb_logo"]];
            item.fillColor = [UIColor colorWithRed:(60/255.0) green:(90/255.0) blue:((153/255.0)) alpha:1] ;
            break;
        }
        case 1:
        {
            item = [[RadialMenuImageItemView alloc] init];
            [((RadialMenuImageItemView*)item).imgView setImage:[UIImage imageNamed:@"gplus_logo"]];
            item.fillColor = [UIColor colorWithRed:(220/255.0) green:(74/255.0) blue:((56/255.0)) alpha:1] ;
            break;
        }
        case 2:
        {
            item = [[RadialMenuImageItemView alloc] init];
            [((RadialMenuImageItemView*)item).imgView setImage:[UIImage imageNamed:@"vk_logo"]];
            item.fillColor = [UIColor colorWithRed:(76/255.0) green:(117/255.0) blue:((163/255.0)) alpha:1] ;
            break;
        }
        case 3:
        {
            item = [[RadialMenuImageItemView alloc] init];
            [((RadialMenuImageItemView*)item).imgView setImage:[UIImage imageNamed:@"twitter_logo"]];
            item.fillColor = [UIColor colorWithRed:(42/255.0) green:(169/255.0) blue:((224/255.0)) alpha:1] ;
            break;
        }
        default:
        {
            item = [[RMRadialMenuItemView alloc] init];
            item.fillColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:((255/255.0)) alpha:1] ;
            break;
        }
    }
    return item;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  RadialMenu
//
//  Created by Admin on 22/09/2014.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (nonatomic) RMRadialMenuView *radialMenuView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RMRadialMenuView *view = [[RMRadialMenuView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
     view.dataSource = self;
    [self.view addSubview:view];
    
   
    // Do any additional setup after loading the view, typically from a nib.
}
-(NSInteger) numberOfItemsInRadialMenuView:(RMRadialMenuView *)radialMenuView
{
    return 4;
}

-(RMRadialMenuItem *) radialMenuView:(RMRadialMenuView *)radialMenuView itemAtIndex:(NSInteger)index
{
    RMRadialMenuItem *item = [[RMRadialMenuItem alloc] init];
    item.fillColor = [[UIColor redColor] colorWithAlphaComponent:(float)index/15];
    return item;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

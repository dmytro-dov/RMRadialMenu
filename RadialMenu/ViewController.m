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
    
  [self.view addSubview:_radialMenuView];
    // Do any additional setup after loading the view, typically from a nib.
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
    RMRadialMenuItemView *item = [[RMRadialMenuItemView alloc] init];
    item.fillColor = [UIColor colorWithRed:(246.0/255.0) green:(100.0/255.0) blue:((216.0/255.0)) alpha:0.5] ;
    return item;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

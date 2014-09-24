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
    _radialMenuView = [[RMRadialMenuView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    _radialMenuView.dataSource = self;
    [self.view addSubview:_radialMenuView];
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 300, 300, 50)];
    [self.view addSubview:_slider];
    [_slider addTarget:self
               action:@selector(valueChanged:)
     forControlEvents:UIControlEventValueChanged];
    
   
    // Do any additional setup after loading the view, typically from a nib.
}
-(void) valueChanged: (UISlider *)slider
{
    NSLog(@"Ch");
    [_radialMenuView setNeedsDisplay];
}
-(NSInteger) numberOfItemsInRadialMenuView:(RMRadialMenuView *)radialMenuView
{
    NSLog(@"%f", _slider.value);
    return (NSInteger)(_slider.value * 100);
}

-(RMRadialMenuItem *) radialMenuView:(RMRadialMenuView *)radialMenuView itemAtIndex:(NSInteger)index
{
    RMRadialMenuItem *item = [[RMRadialMenuItem alloc] init];
    item.fillColor = [[UIColor redColor] colorWithAlphaComponent:(float)index/(NSInteger)(_slider.value * 100)];
    return item;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

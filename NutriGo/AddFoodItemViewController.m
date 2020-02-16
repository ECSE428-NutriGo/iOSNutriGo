//
//  AddFoodItemViewController.m
//  NutriGo
//
//  Created by Sam Cattani on 2020-02-12.
//  Copyright © 2020 oweek.communications.mcgilleus.ca. All rights reserved.
//

#import "AddFoodItemViewController.h"
#import "NewFoodItemViewController.h"

@interface AddFoodItemViewController ()

@property (nonatomic, retain) UITextField *search;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UILabel *addItem;

@end

@implementation AddFoodItemViewController

@synthesize search, scrollView, addItem;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:243.0/255.0 green:129.0/255.0 blue:147.0/255.0 alpha:1]];
    [self layout];
}

- (void) layout
{
    CGFloat yStart = self.view.frame.size.height / 10;
    CGFloat height = self.view.frame.size.height / 8;
    CGFloat width = 4 * self.view.frame.size.width / 5;
    
    search = [[UITextField alloc] init];
    [search setFrame:CGRectMake(self.view.frame.size.width / 2 - width / 2, yStart, width, height)];
    [self setTextFieldBorder:search];
    [self.view addSubview:search];
    
    yStart += height;
    CGFloat scrollHeight = 4.5 * height;
    CGFloat xStart = self.view.frame.size.width / 10;
    CGFloat offset = self.view.frame.size.height / 30;
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(xStart, yStart, width, scrollHeight)];
    [self.view addSubview:scrollView];
    
    // placeholder for now
    
    yStart = 7;
    
    for (int i = 0; i < 10; i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, yStart, width, height)];
        yStart += offset + height;
        [view setBackgroundColor:[UIColor colorWithRed:178.0/255.0 green:88.0/255.0 blue:103.0/255.0 alpha:1]];
        [scrollView addSubview:view];
    }
    
    
    [scrollView setContentSize:CGSizeMake(width, yStart)];
    
    addItem = [[UILabel alloc] init];
    [addItem setFrame:CGRectMake(self.view.frame.size.width / 4, 3 * self.view.frame.size.height / 4, self.view.frame.size.width / 2, self.view.frame.size.height / 12)];
    [addItem setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
    [addItem setText:@"NEW ITEM"];
    [addItem setTextAlignment:NSTextAlignmentCenter];
    [addItem setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:161.0/255.0 blue:172.0/255.0 alpha:1]];
    [addItem setTextColor:[UIColor whiteColor]];
    [addItem setUserInteractionEnabled:YES];
    [addItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewItem)]];
    [self.view addSubview:addItem];
}

- (void) setTextFieldBorder :(UITextField *)textField{

    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 4;
    border.borderColor = [UIColor whiteColor].CGColor;
    border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height);
    border.borderWidth = borderWidth;
    [textField.layer addSublayer:border];
    textField.layer.masksToBounds = YES;
}

- (void) addNewItem
{
    NewFoodItemViewController *vc = [[NewFoodItemViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end

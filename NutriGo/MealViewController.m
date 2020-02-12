//
//  MealViewController.m
//  NutriGo
//
//  Created by Sam Cattani on 2020-02-12.
//  Copyright © 2020 oweek.communications.mcgilleus.ca. All rights reserved.
//

#import "MealViewController.h"
#import "HomeViewController.h"
#import "NewMealViewController.h"
#import "ProfileViewController.h"

@interface MealViewController ()

@property (nonatomic, retain) UIImage *graph;
@property (nonatomic, retain) UIImageView *graphImage;
@property (nonatomic, retain) UIImage *meal;
@property (nonatomic, retain) UIImageView *mealView;
@property (nonatomic, retain) UIImage *profile;
@property (nonatomic, retain) UIImageView *profileView;
@property (nonatomic, retain) UIImage *settings;
@property (nonatomic, retain) UIImageView *settingsView;
@property (nonatomic, retain) UITextField *search;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UILabel *addMeal;

@end

@implementation MealViewController

@synthesize graph, graphImage, meal, mealView, profile, profileView, settings, settingsView, search, scrollView, addMeal;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:243.0/255.0 green:129.0/255.0 blue:147.0/255.0 alpha:1]];
    [self layout];
}

- (void) layout
{
    if (graph == nil)
    {
        
        CGFloat size = self.view.frame.size.width / 8;
        CGFloat offset = self.view.frame.size.width / 2 / 5;
        CGFloat yStart = 17 * self.view.frame.size.height / 20;
        
        graph = [UIImage imageNamed:@"graph"];
        graphImage = [[UIImageView alloc] initWithImage:graph];
        [graphImage setFrame:CGRectMake(offset, yStart, size, size)];
        [graphImage setUserInteractionEnabled:YES];
        [graphImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectGraph)]];
        [self.view addSubview:graphImage];
        
        meal = [UIImage imageNamed:@"meal"];
        mealView = [[UIImageView alloc] initWithImage:[self inverseColor:meal]];
        [mealView setFrame:CGRectMake(offset * 2 + size, yStart, size, size)];
        [mealView setUserInteractionEnabled:YES];
        [self.view addSubview:mealView];
        
        profile = [UIImage imageNamed:@"profile"];
        profileView = [[UIImageView alloc] initWithImage:profile];
        [profileView setFrame:CGRectMake(offset * 3 + 2 * size, yStart, size, size)];
        [profileView setUserInteractionEnabled:YES];
        [profileView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectProfile)]];
        [self.view addSubview:profileView];
        
        settings = [UIImage imageNamed:@"settings"];
        settingsView = [[UIImageView alloc] initWithImage:settings];
        [settingsView setFrame:CGRectMake(offset * 4 + 3 * size, yStart, size, size)];
        [settingsView setUserInteractionEnabled:YES];
        [settingsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectSettings)]];
        [self.view addSubview:settingsView];
        
        yStart = self.view.frame.size.height / 10;
        CGFloat height = self.view.frame.size.height / 8;
        CGFloat width = 4 * self.view.frame.size.width / 5;
        
        search = [[UITextField alloc] init];
        [search setFrame:CGRectMake(self.view.frame.size.width / 2 - width / 2, yStart, width, height)];
        [self setTextFieldBorder:search];
        [self.view addSubview:search];
        
        yStart += height;
        CGFloat scrollHeight = 4.5 * height;
        CGFloat xStart = self.view.frame.size.width / 10;
        offset = self.view.frame.size.height / 30;
        
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
        
        addMeal = [[UILabel alloc] init];
        [addMeal setFrame:CGRectMake(self.view.frame.size.width / 4, 3 * self.view.frame.size.height / 4, self.view.frame.size.width / 2, self.view.frame.size.height / 12)];
        [addMeal setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
        [addMeal setText:@"NEW MEAL"];
        [addMeal setTextAlignment:NSTextAlignmentCenter];
        [addMeal setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:161.0/255.0 blue:172.0/255.0 alpha:1]];
        [addMeal setTextColor:[UIColor whiteColor]];
        [addMeal setUserInteractionEnabled:YES];
        [addMeal addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewMeal)]];
        [self.view addSubview:addMeal];
    }
}

- (UIImage *)inverseColor:(UIImage *)image {
    CIImage *coreImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert"];
    [filter setValue:coreImage forKey:kCIInputImageKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    return [UIImage imageWithCIImage:result];
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

- (void) addNewMeal
{
    NewMealViewController *vc = [[NewMealViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) selectGraph
{
    [mealView setImage:[UIImage imageNamed:@"meal"]];
    [graphImage setImage:[self inverseColor:graphImage.image]];
    HomeViewController *vc = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) selectProfile
{
    [profileView setImage:[self inverseColor:profileView.image]];
    [mealView setImage:[UIImage imageNamed:@"meal"]];
    ProfileViewController *vc = [[ProfileViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) selectSettings
{
    [settingsView setImage:[self inverseColor:settingsView.image]];
    [mealView setImage:[UIImage imageNamed:@"meal"]];
}

@end

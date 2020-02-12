//
//  HomeViewController.m
//  NutriGo
//
//  Created by Sam Cattani on 2020-02-03.
//  Copyright © 2020 oweek.communications.mcgilleus.ca. All rights reserved.
//

#import "HomeViewController.h"
#import "MealViewController.h"
#import "ProfileViewController.h"

@interface HomeViewController ()

@property (nonatomic, retain) UIImage *graph;
@property (nonatomic, retain) UIImageView *graphImage;
@property (nonatomic, retain) UIImage *meal;
@property (nonatomic, retain) UIImageView *mealView;
@property (nonatomic, retain) UIImage *profile;
@property (nonatomic, retain) UIImageView *profileView;
@property (nonatomic, retain) UIImage *settings;
@property (nonatomic, retain) UIImageView *settingsView;

@end

@implementation HomeViewController

@synthesize graph, graphImage, meal, mealView, profile, profileView, settings, settingsView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layout];
    [self.view setBackgroundColor:[UIColor colorWithRed:121.0/255.0 green:193.0/255.0 blue:200.0/255.0 alpha:1]];
}

- (void) layout
{
    if (graph == nil)
    {
        
        CGFloat size = self.view.frame.size.width / 8;
        CGFloat offset = self.view.frame.size.width / 2 / 5;
        CGFloat yStart = 17 * self.view.frame.size.height / 20;
        
        graph = [UIImage imageNamed:@"graph"];
        graphImage = [[UIImageView alloc] initWithImage:[self inverseColor:graph]];
        [graphImage setFrame:CGRectMake(offset, yStart, size, size)];
        [graphImage setUserInteractionEnabled:YES];
        //[graphImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeColour)]];
        [self.view addSubview:graphImage];
        
        meal = [UIImage imageNamed:@"meal"];
        mealView = [[UIImageView alloc] initWithImage:meal];
        [mealView setFrame:CGRectMake(offset * 2 + size, yStart, size, size)];
        [mealView setUserInteractionEnabled:YES];
        [mealView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMeal)]];
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
    }
}

- (void) selectMeal
{
    [mealView setImage:[self inverseColor:mealView.image]];
    [graphImage setImage:[UIImage imageNamed:@"graph"]];
    MealViewController *vc = [[MealViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) selectProfile
{
    [profileView setImage:[self inverseColor:profileView.image]];
    [graphImage setImage:[UIImage imageNamed:@"graph"]];
    ProfileViewController *vc = [[ProfileViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) selectSettings
{
    [settingsView setImage:[self inverseColor:settingsView.image]];
    [graphImage setImage:[UIImage imageNamed:@"graph"]];
}

- (UIImage *)inverseColor:(UIImage *)image {
    CIImage *coreImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert"];
    [filter setValue:coreImage forKey:kCIInputImageKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    return [UIImage imageWithCIImage:result];
}

@end

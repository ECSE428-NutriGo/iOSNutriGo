//
//  ProfileViewController.m
//  NutriGo
//
//  Created by Sam Cattani on 2020-02-12.
//  Copyright © 2020 oweek.communications.mcgilleus.ca. All rights reserved.
//

#import "ProfileViewController.h"
#import "HomeViewController.h"
#import "MealViewController.h"
#import "EditProfileViewController.h"

@interface ProfileViewController ()

@property (nonatomic, retain) UIImage *graph;
@property (nonatomic, retain) UIImageView *graphImage;
@property (nonatomic, retain) UIImage *meal;
@property (nonatomic, retain) UIImageView *mealView;
@property (nonatomic, retain) UIImage *profile;
@property (nonatomic, retain) UIImageView *profileView;
@property (nonatomic, retain) UIImage *settings;
@property (nonatomic, retain) UIImageView *settingsView;
@property (nonatomic, retain) UILabel *goalsLabel;
@property (nonatomic, retain) UILabel *calories;
@property (nonatomic, retain) UILabel *fat;
@property (nonatomic, retain) UILabel *carbs;
@property (nonatomic, retain) UILabel *protein;
@property (nonatomic, retain) UILabel *caloriesNum;
@property (nonatomic, retain) UILabel *fatNum;
@property (nonatomic, retain) UILabel *carbsNum;
@property (nonatomic, retain) UILabel *proteinNum;
@property (nonatomic, retain) UILabel *editGoals;

@end

@implementation ProfileViewController

@synthesize graph, graphImage, meal, mealView, profile, profileView, settings, settingsView, goalsLabel, calories, fat, carbs, protein, editGoals, caloriesNum, fatNum, proteinNum, carbsNum, caloriesNumVal, fatNumVal, carbsNumVal, proteinNumVal;

- (void) viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:156.0/255.0 blue:99.0/255.0 alpha:1]];
    [self layout];
}

- (void) layout
{
    if (graph == nil)
    {
        
        CGFloat size = self.view.frame.size.width / 8;
        CGFloat offset = self.view.frame.size.width / 2 / 5;
        CGFloat yStart = 17 * self.view.frame.size.height / 20;
        
        // Title Variables
        CGFloat titleW = self.view.frame.size.width / 2;
        CGFloat titleH = self.view.frame.size.height / 12;
        CGFloat titleX = self.view.frame.size.width / 2 - titleW / 2;
        CGFloat titleY = self.view.frame.size.height / 8;
        
        // Nutrition Variables
        CGFloat nutritionW = self.view.frame.size.width / 2;
        CGFloat nutritionH = self.view.frame.size.height / 12;
        CGFloat nutritionX = self.view.frame.size.width / 12;
        CGFloat numX = 11 * self.view.frame.size.width / 12 - nutritionW;
        CGFloat nutritionY = 2 * self.view.frame.size.height / 7;
        CGFloat spacing = self.view.frame.size.height / 14;
        CGFloat nutritionSize = 32;
        
        // Button Variables
        CGFloat bX = self.view.frame.size.width / 4;
        CGFloat bY = 3 * self.view.frame.size.height / 4;
        CGFloat bWidth = self.view.frame.size.width / 2;
        CGFloat bHeight = self.view.frame.size.height / 12;
        
        graph = [UIImage imageNamed:@"graph"];
        graphImage = [[UIImageView alloc] initWithImage:graph];
        [graphImage setFrame:CGRectMake(offset, yStart, size, size)];
        [graphImage setUserInteractionEnabled:YES];
        [graphImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectGraph)]];
        [self.view addSubview:graphImage];
        
        meal = [UIImage imageNamed:@"meal"];
        mealView = [[UIImageView alloc] initWithImage:meal];
        [mealView setFrame:CGRectMake(offset * 2 + size, yStart, size, size)];
        [mealView setUserInteractionEnabled:YES];
        [mealView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMeal)]];
        [self.view addSubview:mealView];
        
        profile = [UIImage imageNamed:@"profile"];
        profileView = [[UIImageView alloc] initWithImage:[self inverseColor:profile]];
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
        
        // Title label
        goalsLabel = [[UILabel alloc] init];
        [goalsLabel setFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        [goalsLabel setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:60]];
        [goalsLabel setText:@"GOALS"];
        [goalsLabel setTextAlignment:NSTextAlignmentCenter];
        [goalsLabel setTextColor:[UIColor whiteColor]];
        [self.view addSubview:goalsLabel];
        
        // Macro labels
        calories = [[UILabel alloc] init];
        [calories setFrame:CGRectMake(nutritionX, nutritionY, nutritionW, nutritionH)];
        [calories setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:nutritionSize]];
        [calories setText:@"CALORIES"];
        [calories setTextAlignment:NSTextAlignmentLeft];
        [calories setTextColor:[UIColor whiteColor]];
        [self.view addSubview:calories];
        
        caloriesNum = [[UILabel alloc] init];
        [caloriesNum setFrame:CGRectMake(numX, nutritionY, nutritionW, nutritionH)];
        [caloriesNum setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:nutritionSize]];
        [caloriesNum setText:[caloriesNumVal stringByAppendingString:@"cal"]];
        [caloriesNum setTextAlignment:NSTextAlignmentRight];
        [caloriesNum setTextColor:[UIColor whiteColor]];
        [self.view addSubview:caloriesNum];
        
        nutritionY += spacing;
        
        fat = [[UILabel alloc] init];
        [fat setFrame:CGRectMake(nutritionX, nutritionY, nutritionW, nutritionH)];
        [fat setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:nutritionSize]];
        [fat setText:@"FAT"];
        [fat setTextAlignment:NSTextAlignmentLeft];
        [fat setTextColor:[UIColor whiteColor]];
        [self.view addSubview:fat];
        
        fatNum = [[UILabel alloc] init];
        [fatNum setFrame:CGRectMake(numX, nutritionY, nutritionW, nutritionH)];
        [fatNum setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:nutritionSize]];
        [fatNum setText:[fatNumVal stringByAppendingString:@"g"]];
        [fatNum setTextAlignment:NSTextAlignmentRight];
        [fatNum setTextColor:[UIColor whiteColor]];
        [self.view addSubview:fatNum];
        
        nutritionY += spacing;
        
        carbs = [[UILabel alloc] init];
        [carbs setFrame:CGRectMake(nutritionX, nutritionY, nutritionW, nutritionH)];
        [carbs setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:nutritionSize]];
        [carbs setText:@"CARBS"];
        [carbs setTextAlignment:NSTextAlignmentLeft];
        [carbs setTextColor:[UIColor whiteColor]];
        [self.view addSubview:carbs];
        
        carbsNum = [[UILabel alloc] init];
        [carbsNum setFrame:CGRectMake(numX, nutritionY, nutritionW, nutritionH)];
        [carbsNum setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:nutritionSize]];
        [carbsNum setText:[carbsNumVal stringByAppendingString:@"g"]];
        [carbsNum setTextAlignment:NSTextAlignmentRight];
        [carbsNum setTextColor:[UIColor whiteColor]];
        [self.view addSubview:carbsNum];
        
        nutritionY += spacing;
        
        protein = [[UILabel alloc] init];
        [protein setFrame:CGRectMake(nutritionX, nutritionY, nutritionW, nutritionH)];
        [protein setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:nutritionSize]];
        [protein setText:@"PROTEIN"];
        [protein setTextAlignment:NSTextAlignmentLeft];
        [protein setTextColor:[UIColor whiteColor]];
        [self.view addSubview:protein];
        
        proteinNum = [[UILabel alloc] init];
        [proteinNum setFrame:CGRectMake(numX, nutritionY, nutritionW, nutritionH)];
        [proteinNum setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:nutritionSize]];
        [proteinNum setText:[proteinNumVal stringByAppendingString:@"g"]];
        [proteinNum setTextAlignment:NSTextAlignmentRight];
        [proteinNum setTextColor:[UIColor whiteColor]];
        [self.view addSubview:proteinNum];
        
        // Edit goals button
        editGoals = [[UILabel alloc] init];
        [editGoals setFrame:CGRectMake(bX, bY, bWidth, bHeight)];
        [editGoals setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
        [editGoals setText:@"EDIT GOALS"];
        [editGoals setTextAlignment:NSTextAlignmentCenter];
        [editGoals setBackgroundColor:[UIColor colorWithRed:160.0/255.0 green:82.0/255.0 blue:45.0/255.0 alpha:1]];
        [editGoals setTextColor:[UIColor whiteColor]];
        [editGoals setUserInteractionEnabled:YES];
        [editGoals addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editGoals)]];
        [self.view addSubview:editGoals];
        
    }
}

- (void) editGoals
{
    EditProfileViewController *vc = [[EditProfileViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) selectGraph
{
    [profileView setImage:[UIImage imageNamed:@"profile"]];
    [graphImage setImage:[self inverseColor:graphImage.image]];
    HomeViewController *vc = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) selectMeal
{
    [mealView setImage:[self inverseColor:mealView.image]];
    [profileView setImage:[UIImage imageNamed:@"profile"]];
    MealViewController *vc = [[MealViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) selectSettings
{
    [settingsView setImage:[self inverseColor:settingsView.image]];
    [profileView setImage:[UIImage imageNamed:@"profile"]];
}

- (UIImage *)inverseColor:(UIImage *)image {
    CIImage *coreImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert"];
    [filter setValue:coreImage forKey:kCIInputImageKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    return [UIImage imageWithCIImage:result];
}

- (void) receiveData:(NSString *) calories fat:(NSString *) fat carbs:(NSString *) carbs protein:(NSString *) protein
{
    caloriesNumVal = calories;
    fatNumVal = fat;
    carbsNumVal = carbs;
    proteinNumVal = protein;
    [caloriesNum setText:[caloriesNumVal stringByAppendingString:@"cal"]];
    [fatNum setText:[fatNumVal stringByAppendingString:@"g"]];
    [carbsNum setText:[carbsNumVal stringByAppendingString:@"g"]];
    [proteinNum setText:[proteinNumVal stringByAppendingString:@"g"]];
}

@end

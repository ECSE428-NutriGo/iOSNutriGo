//
//  EditProfileViewController.m
//  NutriGo
//
//  Created by Isaac on 2/13/20.
//  Copyright © 2020 oweek.communications.mcgilleus.ca. All rights reserved.
//

#import "EditProfileViewController.h"
#import "ProfileViewController.h"
@import SVProgressHUD;

@interface EditProfileViewController ()

@property (nonatomic, retain) UILabel *cancel;
@property (nonatomic, retain) UILabel *save;
@property (nonatomic, retain) UILabel *goalsLabel;
@property (nonatomic, retain) UILabel *calories;
@property (nonatomic, retain) UILabel *fat;
@property (nonatomic, retain) UILabel *carbs;
@property (nonatomic, retain) UILabel *protein;
@property (nonatomic, retain) UITextField *caloriesNum;
@property (nonatomic, retain) UITextField *fatNum;
@property (nonatomic, retain) UITextField *carbsNum;
@property (nonatomic, retain) UITextField *proteinNum;

@end


@implementation EditProfileViewController

@synthesize cancel, save, goalsLabel, calories, fat, carbs, protein, caloriesNum, fatNum, carbsNum, proteinNum;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:156.0/255.0 blue:99.0/255.0 alpha:1]];
    [SVProgressHUD show];
    [self layout];
}

- (void) viewDidAppear:(BOOL)animated
{

    [self loadValues];
    [super viewDidAppear:animated];
}


- (void) layout
{
    if (cancel == nil)
    {
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
        NSString *caloriesNumStr = @"0";
        NSString *fatNumStr = @"0";
        NSString *carbsNumStr = @"0";
        NSString *proteinNumStr = @"0";
        
        // Button Variables
        CGFloat bY = 3 * self.view.frame.size.height / 4;
        CGFloat bWidth = self.view.frame.size.width / 3;
        CGFloat bHeight = self.view.frame.size.height / 12;
        CGFloat cancelX = self.view.frame.size.width / 8;
        CGFloat saveX = 2 * self.view.frame.size.width / 3 - self.view.frame.size.width / 8;
        
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
        
        caloriesNum = [[UITextField alloc] init];
        [caloriesNum setFrame:CGRectMake(numX, nutritionY, nutritionW, nutritionH)];
        [caloriesNum setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:nutritionSize]];
        [caloriesNum setText:caloriesNumStr];
        [caloriesNum setTextAlignment:NSTextAlignmentRight];
        [caloriesNum setTextColor:[UIColor whiteColor]];
        [self setTextFieldBorder:caloriesNum];
        [self.view addSubview:caloriesNum];
        
        nutritionY += spacing;
        
        fat = [[UILabel alloc] init];
        [fat setFrame:CGRectMake(nutritionX, nutritionY, nutritionW, nutritionH)];
        [fat setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:nutritionSize]];
        [fat setText:@"FAT"];
        [fat setTextAlignment:NSTextAlignmentLeft];
        [fat setTextColor:[UIColor whiteColor]];
        [self.view addSubview:fat];
        
        fatNum = [[UITextField alloc] init];
        [fatNum setFrame:CGRectMake(numX, nutritionY, nutritionW, nutritionH)];
        [fatNum setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:nutritionSize]];
        [fatNum setText:fatNumStr];
        [fatNum setTextAlignment:NSTextAlignmentRight];
        [fatNum setTextColor:[UIColor whiteColor]];
        [self setTextFieldBorder:fatNum];
        [self.view addSubview:fatNum];
        
        nutritionY += spacing;
        
        carbs = [[UILabel alloc] init];
        [carbs setFrame:CGRectMake(nutritionX, nutritionY, nutritionW, nutritionH)];
        [carbs setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:nutritionSize]];
        [carbs setText:@"CARBS"];
        [carbs setTextAlignment:NSTextAlignmentLeft];
        [carbs setTextColor:[UIColor whiteColor]];
        [self.view addSubview:carbs];
        
        carbsNum = [[UITextField alloc] init];
        [carbsNum setFrame:CGRectMake(numX, nutritionY, nutritionW, nutritionH)];
        [carbsNum setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:nutritionSize]];
        [carbsNum setText:carbsNumStr];
        [carbsNum setTextAlignment:NSTextAlignmentRight];
        [carbsNum setTextColor:[UIColor whiteColor]];
        [self setTextFieldBorder:carbsNum];
        [self.view addSubview:carbsNum];
        
        nutritionY += spacing;
        
        protein = [[UILabel alloc] init];
        [protein setFrame:CGRectMake(nutritionX, nutritionY, nutritionW, nutritionH)];
        [protein setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:nutritionSize]];
        [protein setText:@"PROTEIN"];
        [protein setTextAlignment:NSTextAlignmentLeft];
        [protein setTextColor:[UIColor whiteColor]];
        [self.view addSubview:protein];
        
        proteinNum = [[UITextField alloc] init];
        [proteinNum setFrame:CGRectMake(numX, nutritionY, nutritionW, nutritionH)];
        [proteinNum setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:nutritionSize]];
        [proteinNum setText:proteinNumStr];
        [proteinNum setTextAlignment:NSTextAlignmentRight];
        [proteinNum setTextColor:[UIColor whiteColor]];
        [self setTextFieldBorder:proteinNum];
        [self.view addSubview:proteinNum];
        
        // Edit goals button
        save = [[UILabel alloc] init];
        [save setFrame:CGRectMake(saveX, bY, bWidth, bHeight)];
        [save setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
        [save setText:@"SAVE"];
        [save setTextAlignment:NSTextAlignmentCenter];
        [save setBackgroundColor:[UIColor colorWithRed:160.0/255.0 green:82.0/255.0 blue:45.0/255.0 alpha:1]];
        [save setTextColor:[UIColor whiteColor]];
        [save setUserInteractionEnabled:YES];
        [save addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveChanges)]];
        [self.view addSubview:save];
        
        cancel = [[UILabel alloc] init];
        [cancel setFrame:CGRectMake(cancelX, bY, bWidth, bHeight)];
        [cancel setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
        [cancel setText:@"CANCEL"];
        [cancel setTextAlignment:NSTextAlignmentCenter];
        [cancel setBackgroundColor:[UIColor colorWithRed:160.0/255.0 green:82.0/255.0 blue:45.0/255.0 alpha:1]];
        [cancel setTextColor:[UIColor whiteColor]];
        [cancel setUserInteractionEnabled:YES];
        [cancel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popVC)]];
        [self.view addSubview:cancel];
    }
}

- (void) popVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) saveChanges
{
    NSString *post = [NSString stringWithFormat:@"username=%@&protein_target=%@&carb_target=%@&fat_target=%@", @"samantha.cattani@mail.mcgill.ca", [proteinNum text], [carbsNum text], [fatNum text]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://nutrigo-staging.herokuapp.com/rest-auth/user/"]];
    [request setHTTPMethod:@"PUT"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSString *string = [NSString stringWithFormat:@"Token %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
    [request addValue:string forHTTPHeaderField:@"Authorization"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
         
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSError *jsonError = nil;
        NSData *dataUTF8 = [responseString dataUsingEncoding:NSUTF8StringEncoding];

        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:dataUTF8 options:0 error:&jsonError];

        if (jsonError) {
            NSLog(@"Error parsing JSON: %@", jsonError);
        }
        NSLog(@"%@", dict);
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            if ([[NSThread currentThread] isMainThread]){
                [SVProgressHUD dismiss];
                ProfileViewController *vc = [[ProfileViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                NSLog(@"Not in main thread--completion handler");
            }
        });
    }];
    [task resume];

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

- (void) loadValues
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:@"https://nutrigo-staging.herokuapp.com/rest-auth/user/"]];
    [request setHTTPMethod:@"GET"];
    
    NSString *string = [NSString stringWithFormat:@"Token %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
    [request addValue:string forHTTPHeaderField:@"Authorization"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSError *jsonError = nil;
        NSArray* jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[NSThread currentThread] isMainThread]){
                NSInteger calories = [[jsonResult valueForKey:@"protein_target"] integerValue] * 4 + [[jsonResult valueForKey:@"carb_target"] integerValue] * 4 + [[jsonResult valueForKey:@"fat_target"] integerValue] * 9;
                NSString * caloriesNumVal = [NSString stringWithFormat: @"%ld", (long) calories];
                [caloriesNum setText:caloriesNumVal];
                [fatNum setText:[jsonResult valueForKey:@"fat_target"]];
                [carbsNum setText:[jsonResult valueForKey:@"carb_target"]];
                [proteinNum setText:[jsonResult valueForKey:@"protein_target"]];
                [SVProgressHUD dismiss];
            }
            else{
                NSLog(@"Not in main thread--completion handler");
            }
        });
    }];
    [task resume];
}

@end

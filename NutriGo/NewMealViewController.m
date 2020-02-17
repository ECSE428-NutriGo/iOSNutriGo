//
//  NewMealViewController.m
//  NutriGo
//
//  Created by Sam Cattani on 2020-02-12.
//  Copyright © 2020 oweek.communications.mcgilleus.ca. All rights reserved.
//

#import "NewMealViewController.h"
#import "AddFoodItemViewController.h"
#import "ManualEntryViewController.h"
#import "MealViewController.h"
@import SVProgressHUD;

@interface NewMealViewController ()

@property (nonatomic, retain) UILabel *cancel;
@property (nonatomic, retain) UILabel *manualEntry;
@property (nonatomic, retain) UILabel *mealItemsList;
@property (nonatomic, retain) UILabel *addFoodItem;
@property (nonatomic, retain) UILabel *nutritionInformation;
@property (nonatomic, retain) UILabel *confirm;
@property (nonatomic, retain) UITextField *search;

@end

@implementation NewMealViewController

@synthesize cancel, manualEntry, mealItemsList, addFoodItem, nutritionInformation, confirm, search, ids, foodItemTitles;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:243.0/255.0 green:129.0/255.0 blue:147.0/255.0 alpha:1]];
    if (self.ids == nil)
    {
        self.ids = [NSMutableArray array];
    }
    
    if (self.foodItemTitles == nil)
    {
        self.foodItemTitles = [NSMutableArray array];
    }
    [self layout];
}

- (void) viewDidAppear:(BOOL)animated
{
    
    
    [super viewDidAppear:animated];
}

- (void) layout
{
    if (cancel == nil)
    {
        CGFloat size = self.view.frame.size.width / 8;
        CGFloat offset = self.view.frame.size.width / 2 / 5;
        CGFloat yStart = 17 * self.view.frame.size.height / 20;
        
        yStart = self.view.frame.size.height / 5;
        CGFloat height = self.view.frame.size.height / 8;
        CGFloat width = 4 * self.view.frame.size.width / 5;
        
        search = [[UITextField alloc] init];
        [search setFrame:CGRectMake(self.view.frame.size.width / 2 - width / 2, yStart, width, height / 2)];
        [self setTextFieldBorder:search];
        [self.view addSubview:search];
        
        cancel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 10, self.view.frame.size.height / 15, self.view.frame.size.width / 4, self.view.frame.size.height / 20)];
        [cancel setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:18]];
        [cancel setText:@"CANCEL"];
        [cancel setTextAlignment:NSTextAlignmentCenter];
        [cancel setBackgroundColor:[UIColor colorWithRed:178.0/255.0 green:88.0/255.0 blue:103.0/255.0 alpha:1]];
        [cancel setTextColor:[UIColor whiteColor]];
        [cancel setUserInteractionEnabled:YES];
        [cancel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popVC)]];
        [self.view addSubview:cancel];
        
        confirm = [[UILabel alloc] initWithFrame:CGRectMake(3 * self.view.frame.size.width / 4 - self.view.frame.size.width / 10, self.view.frame.size.height / 15, self.view.frame.size.width / 4, self.view.frame.size.height / 20)];
        [confirm setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:18]];
        [confirm setText:@"CONFIRM"];
        [confirm setTextAlignment:NSTextAlignmentCenter];
        [confirm setBackgroundColor:[UIColor colorWithRed:178.0/255.0 green:88.0/255.0 blue:103.0/255.0 alpha:1]];
        [confirm setTextColor:[UIColor whiteColor]];
        [confirm setUserInteractionEnabled:YES];
        [confirm addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popVC)]];
        [self.view addSubview:confirm];
        
        yStart = self.view.frame.size.height / 4;
        CGFloat xLabelStart = self.view.frame.size.width / 10;
        CGFloat labelWidth = 4 * self.view.frame.size.width / 5;
        CGFloat labelHeight = self.view.frame.size.height / 6;
        CGFloat buttonHeight = self.view.frame.size.height / 12;
        CGFloat buttonWidth = self.view.frame.size.width / 2;
        CGFloat xButtonStart = self.view.frame.size.width / 4;
        offset = self.view.frame.size.height / 30;
        
        mealItemsList = [[UILabel alloc] initWithFrame:CGRectMake(xLabelStart, yStart, labelWidth, labelHeight)];
        [mealItemsList setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:18]];
        // [mealItemsList setText:@"MEAL ITEM 1, MEAL ITEM 2, MEAL ITEM 3, MEAL ITEM 4, MEAL ITEM 5, MEAL ITEM 6, MEAL ITEM 7, MEAL ITEM 8, MEAL ITEM 9"];
        if (foodItemTitles != nil)
        {
            NSMutableString *string = [NSMutableString string];
            for (int i = 0; i < [foodItemTitles count]; i++)
            {
                [string appendString:[foodItemTitles objectAtIndex:i]];
                if (i != [foodItemTitles count] - 1)
                {
                    [string appendString:@", "];
                }
            }
            [mealItemsList setText:string];
        }
        
        [mealItemsList setNumberOfLines:0];
        [mealItemsList setTextColor:[UIColor whiteColor]];
        [self.view addSubview:mealItemsList];
        
        yStart += offset + labelHeight;
        
        nutritionInformation = [[UILabel alloc] initWithFrame:CGRectMake(xLabelStart, yStart, labelWidth, labelHeight)];
        [nutritionInformation setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:18]];
        [nutritionInformation setText:@"CALORIES:\nCARBS:\nPROTEIN:\nFAT:"];
        [nutritionInformation setNumberOfLines:4];
        [nutritionInformation setTextColor:[UIColor whiteColor]];
        //   [self.view addSubview:nutritionInformation];
        
        yStart += 2 * offset + labelHeight;
        
        addFoodItem = [[UILabel alloc] initWithFrame:CGRectMake(xButtonStart, yStart, buttonWidth, buttonHeight)];
        [addFoodItem setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:22]];
        [addFoodItem setText:@"ADD FOOD ITEM"];
        [addFoodItem setTextAlignment:NSTextAlignmentCenter];
        [addFoodItem setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:161.0/255.0 blue:172.0/255.0 alpha:1]];
        [addFoodItem setTextColor:[UIColor whiteColor]];
        [addFoodItem setUserInteractionEnabled:YES];
        [addFoodItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addItem)]];
        [self.view addSubview:addFoodItem];
        
        yStart += offset + buttonHeight;
        
        manualEntry = [[UILabel alloc] initWithFrame:CGRectMake(xButtonStart, yStart, buttonWidth, buttonHeight)];
        [manualEntry setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:22]];
        [manualEntry setText:@"MANUALLY ENTER"];
        [manualEntry setTextAlignment:NSTextAlignmentCenter];
        [manualEntry setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:161.0/255.0 blue:172.0/255.0 alpha:1]];
        [manualEntry setTextColor:[UIColor whiteColor]];
        [manualEntry setUserInteractionEnabled:YES];
        [manualEntry addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(manualEntryNew)]];
        [self.view addSubview:manualEntry];
    }
}

- (void) popVC
{
    [SVProgressHUD show];
    
    NSMutableString *post = [NSMutableString stringWithString:@"fooditems="];
    [post appendString:[ids componentsJoinedByString:@", "]];
    [post appendFormat:@"&name=%@", [search text]];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];

    NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                         ids, @"fooditems",
                         search.text, @"name",
                         nil];
    NSError *error;
    postData = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://nutrigo-staging.herokuapp.com/nutri/meal/"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
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
                [self.navigationController pushViewController:[[MealViewController alloc] init] animated:YES];
            }
            else{
                NSLog(@"Not in main thread--completion handler");
            }
        });
    }];
    [task resume];
}

- (void) addItem
{
    AddFoodItemViewController *vc = [[AddFoodItemViewController alloc] init];
    vc.ids = self.ids;
    vc.foodItemTitles = self.foodItemTitles;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) manualEntryNew
{
    ManualEntryViewController *vc = [[ManualEntryViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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

@end

//
//  ManualEntryViewController.m
//  NutriGo
//
//  Created by Sam Cattani on 2020-02-12.
//  Copyright © 2020 oweek.communications.mcgilleus.ca. All rights reserved.
//

#import "ManualEntryViewController.h"
@import SVProgressHUD;
#import "MealViewController.h"

@interface ManualEntryViewController ()

@property (nonatomic, retain) UILabel *cancel;
@property (nonatomic, retain) UITextField *MealName;
@property (nonatomic, retain) UITextField *Fat;
@property (nonatomic, retain) UITextField *Carbs;
@property (nonatomic, retain) UITextField *Protein;
@property (nonatomic, retain) UILabel *addItem;
@property (nonatomic, retain) UILabel *Title;
@property (nonatomic, retain) UILabel *Food;
@property (nonatomic, retain) UILabel *gramLabel;
@property (nonatomic, retain) UILabel *fatLabel;
@property (nonatomic, retain) UILabel *carbLabel;
@property (nonatomic, retain) UILabel *proteinLabel;

@end

@implementation ManualEntryViewController

@synthesize MealName, addItem, Title, Fat, Carbs, Protein, cancel, Food, gramLabel, fatLabel, carbLabel, proteinLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:243.0/255.0 green:129.0/255.0 blue:147.0/255.0 alpha:1]];
    [self layout];
}

- (void) layout
{
    CGFloat yStart = self.view.frame.size.height / 8;
    CGFloat height = self.view.frame.size.height / 8;
    CGFloat width = 4 * self.view.frame.size.width / 5;
    
    cancel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 10, self.view.frame.size.height / 15, self.view.frame.size.width / 4, self.view.frame.size.height / 20)];
    [cancel setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:18]];
    [cancel setText:@"CANCEL"];
    [cancel setTextAlignment:NSTextAlignmentCenter];
    [cancel setBackgroundColor:[UIColor colorWithRed:178.0/255.0 green:88.0/255.0 blue:103.0/255.0 alpha:1]];
    [cancel setTextColor:[UIColor whiteColor]];
    [cancel setUserInteractionEnabled:YES];
    [cancel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popVC)]];
    [self.view addSubview:cancel];
    
    
    Title = [[UILabel alloc] init];
    [Title setText:@"MANUAL ENTRY"];
    [Title setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:38]];
    [Title setFrame:CGRectMake(self.view.frame.size.width / 2 - width / 2, yStart, width, height)];
    [Title setTextAlignment:NSTextAlignmentCenter];
    [Title setTextColor:[UIColor whiteColor]];
    [self.view addSubview:Title];
    
    
    Food = [[UILabel alloc] init];
    [Food setText:@"MEAL : "];
    [Food setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
    [Food setFrame:CGRectMake(self.view.frame.size.width / 2 - width / 2, yStart+80, width, height)];
    [Food setTextColor:[UIColor whiteColor]];
    [self.view addSubview:Food];
    
    MealName = [[UITextField alloc] init];
    [MealName setFrame:CGRectMake(self.view.frame.size.width / 2 - width / 2, yStart+160, width, self.view.frame.size.height / 22)];
    [MealName setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    [self setTextFieldFont:MealName];
    [self.view addSubview:MealName];
    
    
    gramLabel = [[UILabel alloc] init];
    [gramLabel setText:@"grams"];
    [gramLabel setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:18]];
    [gramLabel setFrame:CGRectMake(self.view.frame.size.width / 2+ width / 3.5, yStart+180, width/4, height)];
    [gramLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:gramLabel];
    
    fatLabel = [[UILabel alloc] init];
    [fatLabel setText:@"FAT : "];
    [fatLabel setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
    [fatLabel setFrame:CGRectMake(self.view.frame.size.width / 2 - width / 2, yStart+240, width, height)];
    [fatLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:fatLabel];
    
    Fat = [[UITextField alloc] init];
    [Fat setFrame:CGRectMake(self.view.frame.size.width / 2+ width / 3.5, yStart+280, width/5, self.view.frame.size.height / 24)];
    [Fat setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    [Fat setTextAlignment:NSTextAlignmentCenter];
    [self setTextFieldFont:Fat];
    [self.view addSubview:Fat];
    
    
    carbLabel = [[UILabel alloc] init];
    [carbLabel setText:@"CARBOHYDRATES : "];
    [carbLabel setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
    [carbLabel setFrame:CGRectMake(self.view.frame.size.width / 2 - width / 2, yStart+320, width, height)];
    [carbLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:carbLabel];
    
    Carbs = [[UITextField alloc] init];
    [Carbs setFrame:CGRectMake(self.view.frame.size.width / 2+ width / 3.5, yStart+360, width/5, self.view.frame.size.height / 24)];
    [Carbs setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    [Carbs setTextAlignment:NSTextAlignmentCenter];
    [self setTextFieldFont:Carbs];
    [self.view addSubview:Carbs];
    
    
    
    proteinLabel = [[UILabel alloc] init];
    [proteinLabel setText:@"PROTEIN : "];
    [proteinLabel setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
    [proteinLabel setFrame:CGRectMake(self.view.frame.size.width / 2 - width / 2, yStart+400, width, height)];
    [proteinLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:proteinLabel];
    
    Protein = [[UITextField alloc] init];
    [Protein setFrame:CGRectMake(self.view.frame.size.width / 2+ width / 3.5, yStart+440, width/5, self.view.frame.size.height / 24)];
    [Protein setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    [Protein setTextAlignment:NSTextAlignmentCenter];
    [self setTextFieldFont:Protein];
    [self.view addSubview:Protein];
    
    
    addItem = [[UILabel alloc] init];
    [addItem setFrame:CGRectMake(self.view.frame.size.width / 4, 3 * self.view.frame.size.height / 4, self.view.frame.size.width / 2, self.view.frame.size.height / 12)];
    [addItem setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
    [addItem setText:@"CREATE"];
    [addItem setTextAlignment:NSTextAlignmentCenter];
    [addItem setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:161.0/255.0 blue:172.0/255.0 alpha:1]];
    [addItem setTextColor:[UIColor whiteColor]];
    [addItem setUserInteractionEnabled:YES];
    [addItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)]];
    [self.view addSubview:addItem];
}
- (void) setTextFieldFont :(UITextField *)textField{
    textField.font = [UIFont fontWithName:@"SourceCodePro-Black" size:20];
}
- (void) popVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) goBack
{
    [SVProgressHUD show];
    
    NSString *post = [NSString stringWithFormat:@"name=%@&protein=%@&fat=%@&carb=%@", [MealName text], [Protein text], [Fat text], [Carbs text]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://nutrigo-staging.herokuapp.com/nutri/meal/"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    [request addValue:@"Token 3d505b29e14e580add1226ee474022210d9a9dd9" forHTTPHeaderField:@"Authorization"];
    
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
                MealViewController *vc = [[MealViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                NSLog(@"Not in main thread--completion handler");
            }
        });
    }];
    [task resume];
}

@end

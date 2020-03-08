//
//  EditProfileAttriutesViewController.m
//  NutriGo
//
//  Created by Sam Cattani on 2020-03-07.
//  Copyright © 2020 oweek.communications.mcgilleus.ca. All rights reserved.
//

#import "EditProfileAttriutesViewController.h"
@import SVProgressHUD;

@interface EditProfileAttriutesViewController ()

@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UITextField *proteinField;
@property (nonatomic, retain) UITextField *carbField;
@property (nonatomic, retain) UITextField *fatField;
@property (nonatomic, retain) UITextField *tweightField;
@property (nonatomic, retain) UITextField *cweightField;
@property (nonatomic, retain) UILabel *backButton;
@property (nonatomic, retain) UILabel *putButton;

@end

@implementation EditProfileAttriutesViewController

@synthesize title, proteinField, carbField, fatField, tweightField, cweightField, backButton, putButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:199.0/255.0 blue:255.0/255.0 alpha:1]];
    [self layout];
}

- (void) layout {
    
    CGFloat yStart = self.view.frame.size.height / 12;
    CGFloat xStart = self.view.frame.size.width/4;
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(doneClicked:)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects: flexibleSpace, doneButton, nil]];
    
    title = [[UILabel alloc] init];
    [title setFrame:CGRectMake(0, yStart, self.view.frame.size.width, self.view.frame.size.height / 7)];
    [title setText:@"EDIT GOALS"];
    [title setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:self.view.frame.size.height / 16]];
    [title setTextColor:[UIColor whiteColor]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:title];
    
    proteinField = [[UITextField alloc] initWithFrame:CGRectMake(xStart, yStart*3, self.view.frame.size.width/2, self.view.frame.size.height / 20)];
    proteinField.placeholder = @"  New Protein Target";
    proteinField.keyboardType = UIKeyboardTypeNumberPad;
    [proteinField.layer setCornerRadius:14.0f];
    [proteinField setBackgroundColor:[UIColor whiteColor]];
    [proteinField.layer setBorderColor:[UIColor grayColor].CGColor];
    [proteinField.layer setBorderWidth:1.0];
    proteinField.inputAccessoryView = keyboardDoneButtonView;
    [self.view addSubview:proteinField];
    
    fatField = [[UITextField alloc] initWithFrame:CGRectMake(xStart, yStart*4, self.view.frame.size.width/2, self.view.frame.size.height / 20)];
    fatField.placeholder = @"  New Fat Target";
    fatField.keyboardType = UIKeyboardTypeNumberPad;
    [fatField.layer setCornerRadius:14.0f];
    [fatField setBackgroundColor:[UIColor whiteColor]];
    [fatField.layer setBorderColor:[UIColor grayColor].CGColor];
    [fatField.layer setBorderWidth:1.0];
    fatField.inputAccessoryView = keyboardDoneButtonView;
    [self.view addSubview:fatField];
    
    carbField = [[UITextField alloc] initWithFrame:CGRectMake(xStart, yStart*5, self.view.frame.size.width/2, self.view.frame.size.height / 20)];
    carbField.placeholder = @"  New Carb Target";
    carbField.keyboardType = UIKeyboardTypeNumberPad;
    [carbField.layer setCornerRadius:14.0f];
    [carbField setBackgroundColor:[UIColor whiteColor]];
    [carbField.layer setBorderColor:[UIColor grayColor].CGColor];
    [carbField.layer setBorderWidth:1.0];
    carbField.inputAccessoryView = keyboardDoneButtonView;
    [self.view addSubview:carbField];
    
    tweightField = [[UITextField alloc] initWithFrame:CGRectMake(xStart, yStart*6, self.view.frame.size.width/2, self.view.frame.size.height / 20)];
    tweightField.placeholder = @"  New Weight Target";
    tweightField.keyboardType = UIKeyboardTypeNumberPad;
    [tweightField.layer setCornerRadius:14.0f];
    [tweightField setBackgroundColor:[UIColor whiteColor]];
    [tweightField.layer setBorderColor:[UIColor grayColor].CGColor];
    [tweightField.layer setBorderWidth:1.0];
    tweightField.inputAccessoryView = keyboardDoneButtonView;
    [self.view addSubview:tweightField];
    
    cweightField = [[UITextField alloc] initWithFrame:CGRectMake(xStart, yStart*7, self.view.frame.size.width/2, self.view.frame.size.height / 20)];
    cweightField.placeholder = @"  New Current Weight";
    cweightField.keyboardType = UIKeyboardTypeNumberPad;
    [cweightField.layer setCornerRadius:14.0f];
    [cweightField setBackgroundColor:[UIColor whiteColor]];
    [cweightField.layer setBorderColor:[UIColor grayColor].CGColor];
    [cweightField.layer setBorderWidth:1.0];
    cweightField.inputAccessoryView = keyboardDoneButtonView;
    [self.view addSubview:cweightField];
    
    backButton = [[UILabel alloc] init];
    [backButton setFrame:CGRectMake(self.view.frame.size.width/8, yStart*9, self.view.frame.size.width/4, self.view.frame.size.height/10)];
    [backButton setBackgroundColor:[UIColor colorWithRed:132.0/255.0 green:106.0/255.0 blue:173.0/255.0 alpha:1]];
    [backButton setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:20]];
    [backButton setText:@"CANCEL"];
    [backButton setTextColor:[UIColor whiteColor]];
    [backButton setTextAlignment:NSTextAlignmentCenter];
    [backButton setUserInteractionEnabled:YES];
    backButton.layer.masksToBounds = YES;
    [backButton.layer setCornerRadius:14.0f];
    [backButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)]];
    [self.view addSubview:backButton];
    
    putButton = [[UILabel alloc] init];
    [putButton setFrame:CGRectMake(5*self.view.frame.size.width/8, yStart*9, self.view.frame.size.width/4, self.view.frame.size.height/10)];
    [putButton setBackgroundColor:[UIColor colorWithRed:132.0/255.0 green:106.0/255.0 blue:173.0/255.0 alpha:1]];
    [putButton setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:20]];
    [putButton setText:@"DONE"];
    [putButton setTextColor:[UIColor whiteColor]];
    [putButton setTextAlignment:NSTextAlignmentCenter];
    [putButton setUserInteractionEnabled:YES];
    putButton.layer.masksToBounds = YES;
    [putButton.layer setCornerRadius:14.0f];
    [putButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateUser)]];
    [self.view addSubview:putButton];
}

- (IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
}

- (void) goBack {
    [self.navigationController popViewControllerAnimated:true];
}

- (void) updateUser {
    [SVProgressHUD show];
    
    NSString *post = [NSString stringWithFormat:@"protein_target=%@&carb_target=%@&fat_target=%@&target_weight=%@&current_weight=%@", proteinField.text, carbField.text, fatField.text, tweightField.text, cweightField.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *auth = [NSString stringWithFormat:@"Token %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://nutrigo-staging.herokuapp.com/rest-auth/user/"]];
    [request setHTTPMethod:@"PUT"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:auth forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
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
                [self goBack];
            }
            else{
                NSLog(@"Not in main thread--completion handler");
            }
        });
    }];
    [task resume];
}

@end

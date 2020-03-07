//
//  ChangePasswordViewController.m
//  NutriGo
//
//  Created by Sam Cattani on 2020-03-07.
//  Copyright © 2020 oweek.communications.mcgilleus.ca. All rights reserved.
//

#import "SettingsViewController.h"
#import "ChangePasswordViewController.h"
@import SVProgressHUD;

@interface ChangePasswordViewController ()

@property (nonatomic, retain) UILabel *cancel;
@property (nonatomic, retain) UILabel *oldPasswordLabel;
@property (nonatomic, retain) UILabel *neWPasswordLabel;
@property (nonatomic, retain) UILabel *retypeNewPasswordLabel;
@property (nonatomic, retain) UITextField *oldPassword;
@property (nonatomic, retain) UITextField *neWPassword;
@property (nonatomic, retain) UITextField *retypeNewPassword;
@property (nonatomic, retain) UILabel *confirm;


@end

@implementation ChangePasswordViewController

@synthesize oldPasswordLabel, oldPassword, neWPasswordLabel, neWPassword, retypeNewPasswordLabel, retypeNewPassword, cancel, confirm ;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:199.0/255.0 blue:255.0/255.0 alpha:1]];
    [self layout];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) layout
{
    
        CGFloat yStart = self.view.frame.size.height / 8;
        CGFloat height = self.view.frame.size.height / 8;
        CGFloat width = 4 * self.view.frame.size.width / 5;
    
    
        cancel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 10, 1.5*self.view.frame.size.height / 15, self.view.frame.size.width / 4, self.view.frame.size.height / 20)];
        [cancel setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:18]];
        [cancel setText:@"CANCEL"];
        [cancel setTextAlignment:NSTextAlignmentCenter];
        [cancel setBackgroundColor:[UIColor colorWithRed:70/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1]];
        [cancel setTextColor:[UIColor whiteColor]];
        [cancel setUserInteractionEnabled:YES];
        [cancel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popVC)]];
        [self.view addSubview:cancel];

        oldPasswordLabel = [[UILabel alloc] init];
        [oldPasswordLabel setText:@"Old Password"];
        [oldPasswordLabel setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
        [oldPasswordLabel setFrame:CGRectMake(self.view.frame.size.width / 2 - width / 2, yStart+80, width, height)];
        [oldPasswordLabel setTextColor:[UIColor whiteColor]];
        [self.view addSubview:oldPasswordLabel];
    
        oldPassword = [[UITextField alloc] init];
        [oldPassword setFrame:CGRectMake(self.view.frame.size.width / 2 - width / 2, yStart+160, width, self.view.frame.size.height / 22)];
        [oldPassword setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
        [oldPassword setTextAlignment:NSTextAlignmentCenter];
        [oldPassword setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
        [oldPassword setPlaceholder:(@"old password")];
        [oldPassword setSecureTextEntry:TRUE];
        [self setTextFieldFont:oldPassword];
        [self.view addSubview:oldPassword];
        
        neWPasswordLabel = [[UILabel alloc] init];
        [neWPasswordLabel setText:@"New Password "];
        [neWPasswordLabel setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
        [neWPasswordLabel setFrame:CGRectMake(self.view.frame.size.width / 2 - width / 2, yStart+180, width, height)];
        [self.view addSubview:neWPasswordLabel];
        
        neWPassword = [[UITextField alloc] init];
        [neWPassword setFrame:CGRectMake(self.view.frame.size.width / 2 - width / 2, yStart+260, width, self.view.frame.size.height / 22)];
        [neWPassword setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
        [neWPassword setTextAlignment:NSTextAlignmentCenter];
        [neWPassword setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
        [neWPassword setPlaceholder:(@"new password")];
        [neWPassword setSecureTextEntry:TRUE];
        [neWPassword setTextColor:[UIColor whiteColor]];
        [self setTextFieldFont:neWPassword];
        [self.view addSubview:neWPassword];
        
        retypeNewPassword = [[UITextField alloc] init];
        [retypeNewPassword setFrame:CGRectMake(self.view.frame.size.width / 2 - width / 2, yStart+320, width, self.view.frame.size.height / 22)];
        [retypeNewPassword setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
        [retypeNewPassword setTextAlignment:NSTextAlignmentCenter];
        [retypeNewPassword setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
        [retypeNewPassword setPlaceholder:(@"retype new password")];
        [retypeNewPassword setSecureTextEntry:TRUE];
        [neWPasswordLabel setTextColor:[UIColor whiteColor]];
        [self setTextFieldFont:retypeNewPassword];
        [self.view addSubview:retypeNewPassword];
    
    confirm = [[UILabel alloc] init];
      [confirm setFrame:CGRectMake(self.view.frame.size.width / 4, 2.5 * self.view.frame.size.height / 4, self.view.frame.size.width / 2, self.view.frame.size.height / 12)];
      [confirm setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:20]];
      [confirm setText:@"Confirm"];
      [confirm setTextAlignment:NSTextAlignmentCenter];
      [confirm setBackgroundColor:[UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1]];
      [confirm setTextColor:[UIColor whiteColor]];
      [confirm setUserInteractionEnabled:YES];
      [confirm addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePassword)]];
      [self.view addSubview:confirm];
        
}

- (void) changePassword {
    
    if (neWPassword.text.length == 0 || oldPassword.text.length == 0 || retypeNewPassword.text.length == 0 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty Field"
                                                            message:@"Please fill all required feilds"
                                                            delegate:self
                                                            cancelButtonTitle:@"Dismiss"
                                                            otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [SVProgressHUD show];
    
    NSString *post = [NSString stringWithFormat:@"password=%@&password1=%@&password2=%@", neWPassword.text, oldPassword.text, retypeNewPassword.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://nutrigo-staging.herokuapp.com/rest-auth/changepassword/"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
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
                if (dict[@"password"] != nil) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wrong Password"
                        message:dict[@"password"][0]
                        delegate:self
                        cancelButtonTitle:@"Dismiss"
                        otherButtonTitles:nil];
                    [alert show];
                    return;
                }
                else if (dict[@"password1"] != nil) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Weak Password"
                        message:dict[@"password1"][0]
                        delegate:self
                        cancelButtonTitle:@"Dismiss"
                        otherButtonTitles:nil];
                    [alert show];
                    return;
                }
                else if (dict[@"key"] != nil) {
                    [[NSUserDefaults standardUserDefaults]setObject:[self.neWPassword text] forKey:@"password"];
                    [[NSUserDefaults standardUserDefaults]setObject:[dict objectForKey:@"key"] forKey:@"token"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [self popVC];
                }
            }
            else{
                NSLog(@"Not in main thread--completion handler");
            }
        });
    }];
    [task resume];
}

- (void) setTextFieldFont :(UITextField *)textField{
    textField.font = [UIFont fontWithName:@"SourceCodePro-Black" size:20];
}
- (void) popVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

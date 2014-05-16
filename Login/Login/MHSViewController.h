//
//  MHSViewController.h
//  Login
//
//  Created by Maher Suboh on 5/10/14.
//  Copyright (c) 2014 Maher Suboh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHSViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *userID;
@property (strong, nonatomic) IBOutlet UITextField *userPassword;
@property (strong, nonatomic) IBOutlet UILabel *welcomeMessage;

@property (strong, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) IBOutlet UIButton *logoutButton;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)loginAction:(UIButton *)sender;


@property (strong, nonatomic) IBOutlet UIButton *updateRecord;
@property (strong, nonatomic) IBOutlet UIButton *deleteRecord;

- (IBAction)updateRecordAction:(UIButton *)sender;
- (IBAction)deleteRecordAction:(id)sender;


@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) IBOutlet UIView *updateView;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextView *address;

@end

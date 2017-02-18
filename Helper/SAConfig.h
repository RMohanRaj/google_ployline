//
//  LHConfig.h
//  LindeHealthcare
//
//  Created by OCSDEV2 on 10/02/15.
//  Copyright (c) 2015 Appsolute. All rights reserved.
//

#define APP_NAME                               [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]


//Screen Sizes
#define IS_IPHONE5                      (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IS_IPHONE6_Plus                 (([[UIScreen mainScreen] bounds].size.height-736)?NO:YES)
#define IS_IPHONE6                      (([[UIScreen mainScreen] bounds].size.height-667)?NO:YES)
#define IS_IPHONE4                      (([[UIScreen mainScreen] bounds].size.height-480)?NO:YES)

#define SCREEN_WIDTH     [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT    [[UIScreen mainScreen] bounds].size.height

//Ios Versons
#define IS_GREATER_IOS7  (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)?YES:NO)
#define IS_GREATER_IOS8  (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)?YES:NO)

#define NearestCount 10

//Placholder Color
#define PlaceHolder_COLOR               [UIColor colorWithRed:178.0/255.0 green:178.0/255.0 blue:178.0/255.0  alpha:1.0]

//Font Name
#define ARIAL_BOLD(Value)        [UIFont fontWithName:@"Arial-BoldMT"        size:Value]

#define ARIAL_NORMAL(Value)      [UIFont fontWithName:@"ArialMT"             size:Value]

#define LINDE_DAX_OFFICE(Value)  [UIFont fontWithName:@"LindeDaxOffice-Bold" size:Value]

#define IDIOMPAD    @"IdiomPad"
#define IDIOMPHONE  @"IdiomPhone"

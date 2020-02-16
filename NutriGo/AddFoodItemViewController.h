//
//  AddFoodItemViewController.h
//  NutriGo
//
//  Created by Sam Cattani on 2020-02-12.
//  Copyright © 2020 oweek.communications.mcgilleus.ca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewMealViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddFoodItemViewController : UIViewController

@property (nonatomic, retain) NSMutableArray *ids;
@property (nonatomic, retain) NSMutableArray *foodItemTitles;

@end

NS_ASSUME_NONNULL_END

//
//  NewViewController.h
//  EasyEdit
//
//  Created by Nikolai on 1/31/16.
//  Copyright © 2016 MR. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Constants.h"

@interface NewViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnSavedFiles;
@property (weak, nonatomic) IBOutlet UIView *viewPortrait;
@property (weak, nonatomic) IBOutlet UIView *viewSquare;
@property (weak, nonatomic) IBOutlet UIView *viewLandscape;
@property (weak, nonatomic) IBOutlet UIView *viewWhite;
@property (weak, nonatomic) IBOutlet UIView *viewBlack;
@property (weak, nonatomic) IBOutlet UIButton *btnCreateNew;
@property (weak, nonatomic) IBOutlet UIView *viewTransparent;

@end

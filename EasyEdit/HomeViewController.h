//
//  HomeViewController.h
//  EasyEdit
//
//  Created by Nikolai on 2/1/16.
//  Copyright © 2016 MR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (nonatomic) int bgColor;
@property (nonatomic) int bgType;
@property (weak, nonatomic) UIImage* bgImage;

@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;
@property (weak, nonatomic) IBOutlet UIButton *btnType;
@property (weak, nonatomic) IBOutlet UIButton *btnLogo;
@property (weak, nonatomic) IBOutlet UIButton *btnImage;

//ToolTab
@property (weak, nonatomic) IBOutlet UIView *viewToolTab;
@property (weak, nonatomic) IBOutlet UIButton *btnUndo;
@property (weak, nonatomic) IBOutlet UIButton *btnRedo;
@property (weak, nonatomic) IBOutlet UIButton *btnFonts;
@property (weak, nonatomic) IBOutlet UIButton *btnSymbols;

//LayerTab
@property (weak, nonatomic) IBOutlet UIView *viewLayerTab;
@property (weak, nonatomic) IBOutlet UIButton *btnLayer1;
@property (weak, nonatomic) IBOutlet UIButton *btnLayer2;
@property (weak, nonatomic) IBOutlet UIButton *btnLayer3;
@property (weak, nonatomic) IBOutlet UIButton *btnLayer4;
@property (weak, nonatomic) IBOutlet UIButton *btnLayer5;
@property (weak, nonatomic) IBOutlet UIButton *btnFullVersion;

@property (weak, nonatomic) IBOutlet UIView *viewSelectSymbol;
@property (weak, nonatomic) IBOutlet UICollectionView *cvSymbols;

@property (weak, nonatomic) IBOutlet UIView *viewSelectFont;
@property (weak, nonatomic) IBOutlet UITableView *tblFonts;

@property (weak, nonatomic) IBOutlet UIView *viewOpacity;
@property (weak, nonatomic) IBOutlet UIButton *btnOk;
@property (weak, nonatomic) IBOutlet UISlider *sliderOpacity;

//Edit views
@property (weak, nonatomic) IBOutlet UIView *viewEdit;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@property (weak, nonatomic) IBOutlet UIView *viewLayer1;
@property (weak, nonatomic) IBOutlet UIView *viewLayer2;
@property (weak, nonatomic) IBOutlet UIView *viewLayer3;
@property (weak, nonatomic) IBOutlet UIView *viewLayer4;
@property (weak, nonatomic) IBOutlet UIView *viewLayer5;

@end

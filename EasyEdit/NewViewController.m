//
//  NewViewController.m
//  EasyEdit
//
//  Created by Nikolai on 1/31/16.
//  Copyright © 2016 MR. All rights reserved.
//

#import "NewViewController.h"
#import "HomeViewController.h"

@interface NewViewController (){
    int backgroundColor;
    int backgroundType;
    UIImage *backgroundImage;
}

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Tap gesture on sizes
    self.viewPortrait.tag=PORTRAIT;
    self.viewSquare.tag=SQUARE;
    self.viewLandscape.tag=LANDSCAPE;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.viewPortrait addGestureRecognizer:singleTap1];
    [self.viewSquare addGestureRecognizer:singleTap2];
    [self.viewLandscape addGestureRecognizer:singleTap3];
    
    //Tap gesture on background types
    self.viewWhite.tag = WHITE;
    self.viewBlack.tag = BLACK;
    self.viewTransparent.tag = TRANSPARENT;
    UITapGestureRecognizer *singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *singleTap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *singleTap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.viewWhite addGestureRecognizer:singleTap4];
    [self.viewBlack addGestureRecognizer:singleTap5];
    [self.viewTransparent addGestureRecognizer:singleTap6];
    
    backgroundColor = WHITE;
    [self setSelection:_viewWhite];
    backgroundType = PORTRAIT;
    [self setSelection:_viewPortrait];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickSavedFiles:(id)sender {
    [self loadSavedFiles];
}

- (IBAction)onClickCreateNew:(id)sender {
    [self performSegueWithIdentifier:@"segueToHome" sender:self];
    
}
-(void)resetSizeSelection
{
    self.viewPortrait.layer.borderWidth = 0.0f;
    self.viewPortrait.layer.borderColor = nil;
    self.viewSquare.layer.borderWidth = 0.0f;
    self.viewSquare.layer.borderColor = nil;
    self.viewLandscape.layer.borderWidth = 0.0f;
    self.viewLandscape.layer.borderColor = nil;
}
-(void)resetBackgroundColorSelection
{
    self.viewWhite.layer.borderWidth = 0.0f;
    self.viewWhite.layer.borderColor = nil;
    self.viewBlack.layer.borderWidth = 0.0f;
    self.viewBlack.layer.borderColor = nil;
    self.viewTransparent.layer.borderWidth = 0.0f;
    self.viewTransparent.layer.borderColor = nil;
}
-(void)setSelection:(UIView*)view
{
    view.layer.borderWidth = 1.0f;
    view.layer.borderColor = [UIColor redColor].CGColor;
}
-(void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    UIView* view = recognizer.view;
    switch(view.tag) {
        case PORTRAIT: //Portrait
        case SQUARE: //Square
        case LANDSCAPE: //Portrait
            [self resetSizeSelection];
            [self setSelection:view];
            backgroundType = (int)view.tag;
            
            break;
        
        case WHITE: //White
        case BLACK: //Black
        case TRANSPARENT: //Transparent
            [self resetBackgroundColorSelection];
            [self setSelection:view];
            backgroundColor = (int)view.tag;
            break;
        default:
            break;
    }
}
-(void)loadSavedFiles
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    backgroundImage = info[UIImagePickerControllerEditedImage];
   
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self performSegueWithIdentifier:@"segueToHome" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"segueToHome"]){
        HomeViewController *homeVC = [segue destinationViewController];
        if(backgroundImage==nil){
            homeVC.bgColor = backgroundColor;
            homeVC.bgType = backgroundType;
        } else {
            homeVC.bgImage = backgroundImage;
        }
        
        
    }
}


@end

//
//  HomeViewController.m
//  EasyEdit
//
//  Created by Nikolai on 2/1/16.
//  Copyright © 2016 MR. All rights reserved.
//

#import "HomeViewController.h"
#import "Constants.h"

#define DEFAULT_FONTSIZE 18
@interface HomeViewController (){
    BOOL toolTabIsVisible;
    BOOL layerTabIsVisible;
    NSArray* arrFonts;
    NSArray* arrSymbols;
    NSString *fontName;
    UIView *currentLayer;
    
    UIImage * symbol;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initViews];
    [self initFonts];
    [self.tblFonts setSeparatorColor:[UIColor clearColor]];
    self.tblFonts.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [self initSymbols];
   
    self.viewSelectFont.hidden = YES;
    self.viewSelectSymbol.hidden = YES;
    self.viewOpacity.hidden = YES;
    self.viewToolTab.transform = CGAffineTransformMakeTranslation(-120, 0);
    self.viewLayerTab.transform = CGAffineTransformMakeTranslation(120, 0);
    toolTabIsVisible = NO;
    layerTabIsVisible = NO;
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    // Setting the swipe direction.
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.view addGestureRecognizer:swipeLeft];
    [self.view addGestureRecognizer:swipeRight];
    
    //Init layer.
    [self.btnLayer1 setBackgroundColor:[UIColor darkGrayColor]];
    [self.btnLayer1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    currentLayer = self.viewLayer1;
    [self.viewEdit bringSubviewToFront:currentLayer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) initViews {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    self.viewEdit.layer.borderWidth=1.0;
    self.viewEdit.layer.borderColor = [UIColor whiteColor].CGColor;
    
    currentLayer = self.viewLayer1;
    [self.viewEdit bringSubviewToFront:currentLayer];
    
    if(self.bgImage!=nil)
    {
        self.heightConstraint.constant = screenSize.height - 140.0;
        //self.viewLayer1.backgroundColor = [UIColor redColor];
        //self.viewLayer2.backgroundColor = [UIColor blueColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.viewEdit.bounds.size.width, self.viewEdit.bounds.size.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        imageView.autoresizingMask =
        ( UIViewAutoresizingFlexibleBottomMargin
         | UIViewAutoresizingFlexibleHeight
         | UIViewAutoresizingFlexibleLeftMargin
         | UIViewAutoresizingFlexibleRightMargin
         | UIViewAutoresizingFlexibleTopMargin
         | UIViewAutoresizingFlexibleWidth );
        
        [imageView setImage:self.bgImage];
        
        [self.viewEdit addSubview:imageView];
        [self.viewEdit sendSubviewToBack:imageView];
        return;
    }
    
    
    switch (self.bgColor) {
        case WHITE:
            [self.viewEdit setBackgroundColor:[UIColor whiteColor]];
            break;
        case BLACK:
            [self.viewEdit setBackgroundColor:[UIColor blackColor]];
            break;
        case TRANSPARENT:
            [self.viewEdit setBackgroundColor:[UIColor clearColor]];
            break;
        default:
            break;
    }
    switch (self.bgType) {
            
        case PORTRAIT:
            self.heightConstraint.constant = screenSize.height-140.0;
            break;
        case SQUARE:
            self.heightConstraint.constant = screenSize.width;
            break;
        case LANDSCAPE:
            self.heightConstraint.constant = 250.0;
        default:
            break;
    }
}
- (void) initFonts {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    NSArray *fontFamilies = [UIFont familyNames];
    for (int i = 0; i < [fontFamilies count]; i++)
    {
        NSString *fontFamily = [fontFamilies objectAtIndex:i];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:fontFamily];
        [tempArray addObjectsFromArray:fontNames];
        //NSLog (@"%@: %@", fontFamily, fontNames);
    }
    arrFonts = [tempArray sortedArrayUsingComparator:^(id string1, id string2) {
        return [((NSString *)string1) compare:((NSString *)string2)
                                      options:NSNumericSearch];
    }];
}
- (void) initSymbols {
    arrSymbols = [NSArray arrayWithObjects:@"apple55", @"birthday10", @"check33", @"cook4", @"covered16", @"cutlery6", @"dollar103", @"drink110", @"fish52", @"gesture40", @"glass15", @"healthy-food", @"hot51", @"medal77", @"plate7", @"play43", @"premium1", @"protection3", @"question58", @"recycle2", @"steak", @"tea24", @"triangle38", @"triangular42", @"winner77", nil];
    
}
- (IBAction)onClickType:(id)sender {
    UITextField* txtField =
    [[UITextField alloc]initWithFrame:CGRectMake(100.0,100.0,200.0,40.0)];
    txtField.layer.borderWidth = 1.0;
    txtField.layer.borderColor = [UIColor blueColor].CGColor;
    
    [txtField setFont:[UIFont fontWithName:fontName size:(DEFAULT_FONTSIZE)]];
    [txtField setDelegate:self];
    [txtField setReturnKeyType:UIReturnKeyDone];
    [txtField setTag:100];
    [currentLayer addSubview:txtField];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [txtField addGestureRecognizer:panRecognizer];
}
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
}
- (IBAction)onClickLogo:(id)sender {
    [self loadImage];
}
- (IBAction)onClickImage:(id)sender {
    [self loadImage];
}
- (IBAction)onClickOkSymbol:(id)sender {
    self.viewSelectSymbol.hidden = YES;
    
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(200.0, 50.0, 25.0, 25.0)];
    
    imgView.autoresizingMask =
    ( UIViewAutoresizingFlexibleBottomMargin
     | UIViewAutoresizingFlexibleHeight
     | UIViewAutoresizingFlexibleLeftMargin
     | UIViewAutoresizingFlexibleRightMargin
     | UIViewAutoresizingFlexibleTopMargin
     | UIViewAutoresizingFlexibleWidth );
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.userInteractionEnabled = YES;
    [imgView setImage:symbol];
    
    [currentLayer addSubview:imgView];
    [currentLayer bringSubviewToFront:imgView];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [imgView addGestureRecognizer:panRecognizer];
    
}
- (IBAction)onClickOkFont:(id)sender {
    self.viewSelectFont.hidden = YES;
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.layer.borderWidth = 1.0f;
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    textField.layer.borderWidth = 0.0f;
    return YES;
}

#pragma mark - ToolTab menu item clicked.
- (IBAction)onClickUndo:(id)sender {
    self.viewSelectSymbol.hidden = YES;
    self.viewSelectFont.hidden = YES;
}
- (IBAction)onClickRedo:(id)sender {
    self.viewSelectSymbol.hidden = YES;
    self.viewSelectFont.hidden = YES;
}
- (IBAction)onClickFont:(id)sender {
    self.viewSelectSymbol.hidden = YES;
    self.viewSelectFont.hidden = NO;
}
- (IBAction)onClickSymbol:(id)sender {
    self.viewSelectFont.hidden = YES;
    self.viewSelectSymbol.hidden = NO;
}

- (IBAction)onClickLayerButton:(id)sender {
    [self resetLayerButtons];
    UIButton* btnLayer = (UIButton*)sender;
    [btnLayer setBackgroundColor:[UIColor darkGrayColor]];
    [btnLayer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    switch ([sender tag]) {
        case 1:
            currentLayer = self.viewLayer1;
            [self.viewEdit bringSubviewToFront:currentLayer];
            break;
        case 2:
            currentLayer = self.viewLayer2;
            [self.viewEdit bringSubviewToFront:currentLayer];
            break;
        case 3:
            currentLayer = self.viewLayer3;
            [self.viewEdit bringSubviewToFront:currentLayer];
            break;
        case 4:
            currentLayer = self.viewLayer4;
            [self.viewEdit bringSubviewToFront:currentLayer];
            break;
        case 5:
            currentLayer = self.viewLayer5;
            [self.viewEdit bringSubviewToFront:currentLayer];
            break;
            
            
        default:
            break;
    }
}
- (void)resetLayerButtons
{
    [self.btnLayer1 setBackgroundColor:[UIColor whiteColor]];
    [self.btnLayer2 setBackgroundColor:[UIColor whiteColor]];
    [self.btnLayer3 setBackgroundColor:[UIColor whiteColor]];
    [self.btnLayer4 setBackgroundColor:[UIColor whiteColor]];
    [self.btnLayer5 setBackgroundColor:[UIColor whiteColor]];
    
    [self.btnLayer1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.btnLayer2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.btnLayer3 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.btnLayer4 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.btnLayer5 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        //NSLog(@"Left Swipe");
        if(toolTabIsVisible){
            toolTabIsVisible = NO;
            [UIView animateWithDuration:0.4 animations:^{
                self.viewToolTab.transform = CGAffineTransformMakeTranslation(-120,0);
            }];
        }else if(!layerTabIsVisible){
            layerTabIsVisible = YES;
            [UIView animateWithDuration:0.4 animations:^{
                self.viewLayerTab.transform = CGAffineTransformMakeTranslation(0,0);
            }];
        }
            
    }
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        //NSLog(@"Right Swipe");
        if(layerTabIsVisible){
            layerTabIsVisible = NO;
            [UIView animateWithDuration:0.4 animations:^{
                self.viewLayerTab.transform = CGAffineTransformMakeTranslation(120,0);
            }];
        }else if(!toolTabIsVisible){
            toolTabIsVisible = YES;
            [UIView animateWithDuration:0.4 animations:^{
                self.viewToolTab.transform = CGAffineTransformMakeTranslation(0,0);
            }];
        }
    }
    
}
#pragma mark - UICollectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return arrSymbols.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"symbolCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:[arrSymbols objectAtIndex:indexPath.row]];
    
    cell.layer.borderWidth = 0.0f;
    cell.layer.borderColor = [UIColor greenColor].CGColor;
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UIImageView *imgView = (UIImageView *)[cell viewWithTag:100];
    symbol = imgView.image;
    
    cell.layer.borderWidth = 1.0f;
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView  cellForItemAtIndexPath:indexPath];
    cell.layer.borderWidth = 0.0f;
}

#pragma mark- UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrFonts.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor blackColor];
    [cell setSelectedBackgroundView:bgColorView];
    
    cell.textLabel.text = [arrFonts objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor redColor];
    cell.textLabel.font = [UIFont fontWithName:[arrFonts objectAtIndex:indexPath.row] size:12.0f];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    fontName = cell.textLabel.text;
    
    NSArray* subViews = [currentLayer subviews];
    for (UIView *subview in subViews) {
        if([subview isKindOfClass:[UITextField class]])
        {
            UITextField* t = (UITextField*)subview;
            [t setFont:[UIFont fontWithName:fontName size:DEFAULT_FONTSIZE]];
            
        }
    }
}

-(void)loadImage
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage* img = info[UIImagePickerControllerEditedImage];
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100.0, 100.0, 200.0, 200.0)];

    imgView.autoresizingMask =
    ( UIViewAutoresizingFlexibleBottomMargin
     | UIViewAutoresizingFlexibleHeight
     | UIViewAutoresizingFlexibleLeftMargin
     | UIViewAutoresizingFlexibleRightMargin
     | UIViewAutoresizingFlexibleTopMargin
     | UIViewAutoresizingFlexibleWidth );
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.userInteractionEnabled = YES;
    [imgView setImage:img];

    [currentLayer addSubview:imgView];
    [currentLayer bringSubviewToFront:imgView];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [imgView addGestureRecognizer:panRecognizer];
    
    [picker dismissViewControllerAnimated:YES completion:nil];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

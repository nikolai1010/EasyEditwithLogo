//
//  SaveViewController.m
//  EasyEdit
//
//  Created by Nikolai on 1/31/16.
//  Copyright © 2016 MR. All rights reserved.
//

#import "SaveViewController.h"

@interface SaveViewController ()

@end

@implementation SaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onClickDone:(id)sender {
}
- (IBAction)onClickSaveAs:(id)sender {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Enter a file name."
                                  message:nil
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   //Do Some action here
                                                   
                                               }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Filename";
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (IBAction)onClickResolution:(id)sender {
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Select a resolution"
                                 message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* resolution1 = [UIAlertAction
                         actionWithTitle:@"1024 * 1024"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here
                             [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [view addAction:resolution1];
    UIAlertAction* resolution2 = [UIAlertAction
                                  actionWithTitle:@"320 * 640"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  { 
                                      //Do some thing here
                                      [view dismissViewControllerAnimated:YES completion:nil];
                                      
                                  }];
    [view addAction:resolution2];
    UIAlertAction* resolution3 = [UIAlertAction
                                  actionWithTitle:@"640 * 960"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      //Do some thing here
                                      [view dismissViewControllerAnimated:YES completion:nil];
                                      
                                  }];
    [view addAction:resolution3];
    [self presentViewController:view animated:YES completion:nil];
}
- (IBAction)onClickFormat:(id)sender {
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle: @"Select a file format"
                                 message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* png = [UIAlertAction
                         actionWithTitle:@"PNG"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here
                             [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* jpg = [UIAlertAction
                          actionWithTitle:@"JPG"
                          style:UIAlertActionStyleDefault
                          handler:^(UIAlertAction * action)
                          {
                              //Do some thing here
                              [view dismissViewControllerAnimated:YES completion:nil];
                              
                          }];
    UIAlertAction* pdf = [UIAlertAction
                          actionWithTitle:@"PDF"
                          style:UIAlertActionStyleDefault
                          handler:^(UIAlertAction * action)
                          {
                              //Do some thing here
                              [view dismissViewControllerAnimated:YES completion:nil];
                              
                          }];
    [view addAction:png];
    [view addAction:jpg];
    [view addAction:pdf];
    [self presentViewController:view animated:YES completion:nil];
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

//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Max on 2019/7/10.
//  Copyright © 2019 Max. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"
#import "BNRDatePickerViewController.h"

@interface BNRDetailViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIButton *deletePictureBtn;

@end

@implementation BNRDetailViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setItem:(BNRItem *)item {
    _item = item;
    self.navigationItem.title = _item.itemName;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BNRItem *item = self.item;
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    NSString *itemKey = self.item.itemKey;
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:itemKey];
    self.imageView.image = imageToDisplay;
    if (imageToDisplay) {
        self.deletePictureBtn.hidden = NO;
    } else {
        self.deletePictureBtn.hidden = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
////    NSLog(@"touches:%@ event:%@", touches, event);
//    [self.view endEditing:YES];
//}

- (IBAction)chooseDateAction:(UIButton *)sender {
    BNRDatePickerViewController *datePickViewController = [[BNRDatePickerViewController alloc] init];
    datePickViewController.item = self.item;
    [self.navigationController pushViewController:datePickViewController animated:YES];
}

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        NSArray *availableTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        imagePicker.mediaTypes = availableTypes;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    
    UIView * cameraOverlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    cameraOverlayView.backgroundColor = [UIColor clearColor];
    
    // cameraOverlayView只支持Camera
    if (imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UILabel *crossLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        crossLabel.text = @"+";
        crossLabel.backgroundColor = [UIColor clearColor];
        crossLabel.textAlignment = NSTextAlignmentCenter;
        [cameraOverlayView addSubview:crossLabel];
        cameraOverlayView.center = self.view.center;
        imagePicker.cameraOverlayView = cameraOverlayView;
    }
    
    
    
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    NSURL *mediaURL = info[UIImagePickerControllerMediaURL];
    if (mediaURL) {
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum([mediaURL path])) {
            UISaveVideoAtPathToSavedPhotosAlbum([mediaURL path], nil, nil, nil);
            [[NSFileManager defaultManager] removeItemAtPath:[mediaURL path] error:nil];
        }
    } else {
        UIImage *image = info[UIImagePickerControllerEditedImage];
        [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];
        self.imageView.image = image;
    }
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)deletePicture:(id)sender {
    self.imageView.image = nil;
    NSString *itemKey = self.item.itemKey;
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:itemKey];
    if (imageToDisplay) {
        [[BNRImageStore sharedStore] deleteImageForKey:itemKey];
        self.deletePictureBtn.hidden = YES;
    } else {
        self.deletePictureBtn.hidden = NO;
    }
}


@end

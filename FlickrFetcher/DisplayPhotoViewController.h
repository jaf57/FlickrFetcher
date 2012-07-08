//
//  DisplayPhotoViewController.h
//  FlickrFetcher
//
//  Created by Joseph Fischetti on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DisplayPhotoViewControllerDelegate <NSObject>



@end
@interface DisplayPhotoViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIImageView* imageView;
@property (nonatomic, strong) UIImage *photo;
@property (nonatomic, strong) NSDictionary *photoInfo;

-(BOOL) doesPhotoArray:(NSArray *) list containPhoto: (NSDictionary *) photo;
@end

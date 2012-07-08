//
//  TopPlacePhotoListViewController.h
//  FlickrFetcher
//
//  Created by Joseph Fischetti on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopPlacePhotoListViewController;
@protocol TopPlacePhotoListViewControllerDelagate <NSObject>

-(NSArray *)getPhotoList: (TopPlacePhotoListViewController *) sender;

@end
@interface TopPlacePhotoListViewController : UITableViewController
@property (nonatomic, strong) NSArray * photoList;
@property (nonatomic, strong) NSString *placeTitle;
@property (nonatomic, weak) id <TopPlacePhotoListViewControllerDelagate> delegate;
@end

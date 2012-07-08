//
//  ViewController.h
//  FlickrFetcher
//
//  Created by Joseph Fischetti on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopPlacesViewController : UITableViewController
@property (nonatomic, strong) NSArray *topPlaces;
@property (nonatomic,strong) NSArray *photoList;
@end

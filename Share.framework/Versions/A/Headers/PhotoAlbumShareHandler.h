//
//  PhotoAlbumShareHandler.h
//  Share
//
//  Created by Xiangjian Meng on 13-8-1.
//  Copyright (c) 2013年 Xiangjian Meng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareDataModelPhotoAlbum.h"

@protocol PhotoAlbumShareHandlerDelegate <NSObject>

- (void)photoAlbumShareSuccess;

- (void)photoAlbumShareFailure;

@end

@interface PhotoAlbumShareHandler : NSObject

@property (nonatomic,weak) id <PhotoAlbumShareHandlerDelegate> delegate;

+(PhotoAlbumShareHandler *)defaultHandler;


- (void)shareImageViaPhotoAlbumModel:(ShareDataModelPhotoAlbum *)photo;

@end

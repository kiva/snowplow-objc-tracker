//
//  SPServiceProvider.h
//  Snowplow
//
//  Copyright (c) 2013-2021 Snowplow Analytics Ltd. All rights reserved.
//
//  This program is licensed to you under the Apache License Version 2.0,
//  and you may not use this file except in compliance with the Apache License
//  Version 2.0. You may obtain a copy of the Apache License Version 2.0 at
//  http://www.apache.org/licenses/LICENSE-2.0.
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the Apache License Version 2.0 is distributed on
//  an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
//  express or implied. See the Apache License Version 2.0 for the specific
//  language governing permissions and limitations there under.
//
//  Authors: Alex Benini
//  Copyright: Copyright (c) 2013-2021 Snowplow Analytics Ltd
//  License: Apache License Version 2.0
//

#import <Foundation/Foundation.h>
#import "SPSubject.h"
#import "SPEmitter.h"
#import "SPTracker.h"
#import "SPTrackerControllerImpl.h"

NS_ASSUME_NONNULL_BEGIN

@interface SPServiceProvider : NSObject

@property (nonatomic, nonnull, readonly) NSString *namespace;

@property (nonatomic, nullable) SPEmitter *emitter;
@property (nonatomic, nullable) SPSubject *subject;
@property (nonatomic, nullable) SPTracker *tracker;

@property (nonatomic, nullable) SPTrackerControllerImpl *trackerController;

- (instancetype)initWithNamespace:(NSString *)namespace network:(SPNetworkConfiguration *)networkConfiguration configurations:(NSArray<SPConfiguration *> *)configurations;

- (void)resetWithConfigurations:(NSArray<SPConfiguration *> *)configurations;

- (void)shutdown;

@end

NS_ASSUME_NONNULL_END

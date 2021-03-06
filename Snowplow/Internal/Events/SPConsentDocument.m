//
//  SPConsentDocument.m
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
//  Copyright: Copyright © 2020 Snowplow Analytics.
//  License: Apache License Version 2.0
//

#import "SPConsentDocument.h"

#import "SPTrackerConstants.h"
#import "SPUtilities.h"
#import "SPPayload.h"
#import "SPSelfDescribingJson.h"

@implementation SPConsentDocument {
    NSString * _documentId;
    NSString * _version;
    NSString * _name;
    NSString * _documentDescription;
}

+ (instancetype)build:(void(^)(id<SPConsentDocumentBuilder> builder))buildBlock {
    SPConsentDocument* document = [SPConsentDocument new];
    if (buildBlock) { buildBlock(document); }
    [document preconditions];
    return document;
}

- (instancetype)init {
    self = [super init];
    return self;
}

- (instancetype)initWithDocumentId:(NSString *)documentId version:(NSString *)version {
    if (self = [super init]) {
        _documentId = documentId;
        _version = version;
    }
    return self;
}

- (void) preconditions {
    [SPUtilities checkArgument:(_documentId != nil) withMessage:@"Document ID cannot be nil."];
    [SPUtilities checkArgument:(_version != nil) withMessage:@"Version cannot be nil."];
}

// --- Builder Methods

SP_BUILDER_METHOD(NSString *, name)
SP_BUILDER_METHOD(NSString *, documentDescription)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

- (void) setDocumentId:(NSString *)dId {
    _documentId = dId;
}

- (void) setVersion:(NSString *)version {
    _version = version;
}

- (void) setName:(NSString *)name {
    _name = name;
}

- (void) setDescription:(NSString *)description {
    _documentDescription = description;
}

#pragma clang diagnostic pop

// --- Public Methods

- (SPSelfDescribingJson *) getPayload {

    NSMutableDictionary * event = [[NSMutableDictionary alloc] init];
    [event setObject:_documentId forKey:kSPCdId];
    [event setObject:_version forKey:kSPCdVersion];
    if ([_name length] != 0) {
        [event setObject:_name forKey:kSPCdName];
    }
    if ([_documentDescription length] != 0) {
        [event setObject:_documentDescription forKey:KSPCdDescription];
    }

    return [[SPSelfDescribingJson alloc] initWithSchema:kSPConsentDocumentSchema
                                                andData:event];
}

@end


//
//  APAcornRaindrop.m
//  AcornRaindrop
//
//  Created by Adam Preble on 1/17/12.
//  Copyright (c) 2012 Adam Preble. All rights reserved.
//
//  This is a Cloud App Raindrop that uploads the active
//  document in the Acorn image editor.
//
//  More about Raindrops: http://developer.getcloudapp.com/raindrops
//  More about Acorn: http://flyingmeat.com/acorn/
//  More about the author: http://adampreble.net

#import "APAcornRaindrop.h"

@interface AcornDoc : NSDocument
- (void)webExportWithOptions:(NSDictionary*)opts; // public JSTalk interface.
@end

@interface AcornApp : NSApplication
- (AcornDoc*)currentDocument; // returns an NSDocument
@end

@implementation APAcornRaindrop

- (NSString *)pasteboardNameForTriggeredRaindrop
{
	NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"AcornImage.png"];
	NSURL *fileURL = [NSURL fileURLWithPath:path];
	
	// Delete the file, if it already exists, so that we can test for its existence later:
	[[NSFileManager defaultManager] removeItemAtURL:fileURL error:nil];
    
    AcornApp *acorn = (id)[[NSConnection connectionWithRegisteredName:@"com.flyingmeat.Acorn.JSTalk" host:0x00] rootProxy];
    
    if (!acorn) { // Acorn isn't running?
        return nil;
    }
    
    [[acorn currentDocument] webExportWithOptions:[NSDictionary dictionaryWithObjectsAndKeys:(id)kUTTypePNG, @"uti", path, @"file", nil]];
    
	// Did Acorn export the file? If not, return nil (Raindrop Error).
	if (![[NSFileManager defaultManager] fileExistsAtPath:[fileURL path]]) {
        return nil;
    }
		
    // Create pasteboard with unique name
	NSPasteboard *pasteboard = [NSPasteboard pasteboardWithUniqueName];
    
	// Add an item
	NSPasteboardItem *item = [[NSPasteboardItem alloc] init];
	[item setString:[fileURL absoluteString] forType:(NSString *)kUTTypeFileURL];
	[pasteboard writeObjects:[NSArray arrayWithObject:item]];

	// Return the pasteboard name
	return [pasteboard name];
}

@end

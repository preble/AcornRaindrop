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
	// Connect to Acorn using JSTalk:
    AcornApp *acorn = (id)[[NSConnection connectionWithRegisteredName:@"com.flyingmeat.Acorn.JSTalk" host:0x00] rootProxy];
    
    if (!acorn) { // Acorn isn't running?
        return nil;
    }
    
	AcornDoc *document = [acorn currentDocument];
	if (!document)
		return nil; // no document open
	
	// We want to find a good name for this file, since CloudApp will show the name to the link visitor.
	// If the file has been saved, we'll use the base of the filename, otherwise we'll default to AcornImge.
	NSString *name;
	NSURL *documentURL = [document fileURL];
	if (documentURL)
		name = [[documentURL lastPathComponent] stringByDeletingPathExtension];
	else
		name = @"AcornImage"; // Presumably it is an Untitled document.
	
	NSString *path = [[NSTemporaryDirectory() stringByAppendingPathComponent:name] stringByAppendingPathExtension:@"png"];
	NSURL *fileURL = [NSURL fileURLWithPath:path];
	
	// Delete the file, if it already exists, so that we can test for its existence later and make sure this is a fresh export:
	[[NSFileManager defaultManager] removeItemAtURL:fileURL error:nil];
	
	// Ask Acorn to export the document:
    [document webExportWithOptions:[NSDictionary dictionaryWithObjectsAndKeys:(id)kUTTypePNG, @"uti", path, @"file", nil]];
    
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

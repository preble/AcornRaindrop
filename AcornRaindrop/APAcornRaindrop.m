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

@implementation APAcornRaindrop

- (NSString *)pasteboardNameForTriggeredRaindrop
{
	NSString *path = @"/tmp/AcornImage.png";
	NSURL *fileURL = [NSURL fileURLWithPath:path];
	
	// Delete the file, if it already exists, so that we can test for its existence later:
	[[NSFileManager defaultManager] removeItemAtURL:fileURL error:nil];

	// Use osascript to run the AppleScript to ask Acorn to export the file.
	// Why not use NSAppleScript? Because it took about 30 seconds to run
	// within CloudApp.
	NSTask *task = [[NSTask alloc] init];
	task.arguments = [NSArray arrayWithObjects:
					  @"-e",
					  @"tell document 1 of application \"Acorn\" to web export in \"tmp:AcornImage.png\" as PNG", nil];
	task.launchPath = @"/usr/bin/osascript";
	[task launch];
	[task waitUntilExit];

	// Did Acorn export the file? If not, return nil (Raindrop Error).
	if (![[NSFileManager defaultManager] fileExistsAtPath:[fileURL path]])
		return nil;

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

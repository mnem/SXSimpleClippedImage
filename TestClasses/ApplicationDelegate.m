/**
 * Licensed under the MIT license:
 * 
 *     http://www.opensource.org/licenses/mit-license.php
 * 
 * (c) Copyright 2011 David Wagner.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

/// This file is copied from the Sparrow Framework AppScaffold project. For
/// more information, see:
///
///    http://www.sparrow-framework.org/

#import "ApplicationDelegate.h"
#import "Game.h" 

@implementation ApplicationDelegate

- (id)init
{
    if ((self = [super init]))
    {
        mWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        mSparrowView = [[SPView alloc] initWithFrame:mWindow.bounds]; 
        [mWindow addSubview:mSparrowView];
    }
    return self;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{    
    SP_CREATE_POOL(pool);    
    
    [SPStage setSupportHighResolutions:YES];
    [SPAudioEngine start];
    
    Game *game = [[Game alloc] init];        
    mSparrowView.stage = game;
    mSparrowView.multipleTouchEnabled = NO;
    mSparrowView.frameRate = 30.0f;
    [game release];
    
    [mWindow makeKeyAndVisible];
    [mSparrowView start];
    
    SP_RELEASE_POOL(pool);
}

- (void)applicationWillResignActive:(UIApplication *)application 
{    
    [mSparrowView stop];
}

- (void)applicationDidBecomeActive:(UIApplication *)application 
{
	[mSparrowView start];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [SPPoint purgePool];
    [SPRectangle purgePool];
    [SPMatrix purgePool];    
}

- (void)dealloc 
{
    [SPAudioEngine stop];
    [mSparrowView release];
    [mWindow release];    
    [super dealloc];
}

@end

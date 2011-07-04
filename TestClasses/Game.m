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

#import "Game.h" 
#import "SXSimpleClippedImage.h"

@implementation Game

- (id)initWithWidth:(float)width height:(float)height
{
    if ((self = [super initWithWidth:width height:height]))
    {
		// This simple test just tweens the dimensions of the clip rectangle
		// for the loaded image.
		//
		// P.S. Loaded image is a random waterfall photo I took in Scotland.
		// Come visit!
		//
		waterfall = [SXSimpleClippedImage imageWithContentsOfFile:@"waterfall.png"];
		[self addChild:waterfall];
		
		[self playTween];
    }
    return self;
}

- (void)playTween
{
	SPTween *tween = [SPTween tweenWithTarget:waterfall time:3.0];
	
	[tween animateProperty:@"x" targetValue:waterfall.originalWidth/2];
	[tween animateProperty:@"y" targetValue:waterfall.originalHeight/2];
	
	[tween animateProperty:@"clipX" targetValue:waterfall.originalWidth/2];
	[tween animateProperty:@"clipY" targetValue:waterfall.originalHeight/2];
	
	[tween animateProperty:@"clipWidth" targetValue:0];
	[tween animateProperty:@"clipHeight" targetValue:0];
	
	tween.loop = SPLoopTypeReverse;
	
	[self.stage.juggler addObject:tween];
}

@end
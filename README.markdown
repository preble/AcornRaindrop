# Acorn Raindrop

This [Raindrop][] makes it easy to upload the image you're working on in [Acorn][] using [CloudApp][].  Raindrops are CloudApp's plugin mechanism.

## Installation

Build the bundle, or download the binary on the [Downloads][] page.  Double-click the `.raindrop` bundle to install it in CloudApp.

## Usage

With Acorn active and a document open, hit the keyboard shortcut configured for Raindrops in CloudApp's Preferences.  The Raindrop will export the active document as a PNG and upload it using CloudApp.

## Release Notes

1.0.1

- Base the upload filename off of the image name, if available.
- Improvements by Gus Mueller - no more `osascript`.

## License

AcornRaindrop is made available under the MIT License.

The MIT License (MIT)
Copyright (c) 2012 Adam Preble

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[CloudApp]: http://getcloudapp.com
[Raindrop]: http://developer.getcloudapp.com/raindrops
[author]: http://adampreble.net
[downloads]: https://github.com/preble/AcornRaindrop/downloads
[Acorn]: http://flyingmeat.com/acorn/

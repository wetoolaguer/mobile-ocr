#import "OCR.h"
#import <TesseractOCR/TesseractOCR.h>

@implementation OCR

RCT_EXPORT_MODULE();

// Method available in Javascript runtime
RCT_EXPORT_METHOD(scanForText:(NSString *)url
                  coordinates:(NSDictionary *)coordinates
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
  
  // Run the block in a different thread
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    // Load the image
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image = [UIImage imageWithData:imageData];
    
    // Scan the image for text
    NSString *result = [self scanImageForText:image onCoordinates:coordinates];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      // Resolve the method with the scan result
      // (Returns a Javascript Promise object)
      resolve(result);
    });
  });
}

- (NSString *)scanImageForText:(UIImage *)image
                 onCoordinates:(NSDictionary *)coordinates {
  
  // Initialize Tesseract
  G8Tesseract *tesseract = [[G8Tesseract alloc] initWithLanguage:@"eng"];
  
  // Give the image to tesseract
  [tesseract setImage:image];
  
  // Give the coordinates to scan - must be within the image
  CGFloat x = [[coordinates objectForKey:@"x"] floatValue];
  CGFloat y = [[coordinates objectForKey:@"y"] floatValue];
  CGFloat width = [[coordinates objectForKey:@"width"] floatValue];
  CGFloat height = [[coordinates objectForKey:@"height"] floatValue];
  
  CGPoint origin = CGPointMake(x,y);
  CGSize size = CGSizeMake(width,height);
  tesseract.rect = CGRectMake(origin.x, origin.y, size.width, size.height);
  
  // Scan for text
  [tesseract recognize];
  
  // Return result
  return tesseract.recognizedText;
}

@end

#import <Foundation/Foundation.h>

%hook NSURLSession

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSMutableURLRequest *)request
                            completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    NSURL *url = request.URL;
    if (![url.absoluteString isEqualToString:@"https://www.forsakringskassan.se/fk_apps/APPCONFIGREST/public/v1/versioncheck?kanal=3"]) {
        return %orig;
    }

    // Respond with custom payload.
    void (^interceptedCompletionHandler)(NSData *, NSURLResponse *, NSError *) =
        ^void(NSData *responseObject, NSURLResponse *response, NSError *error) {
            NSDictionary *payload = @{
                @"buildNumber": @718 // v3.6.0
            };
            NSData *data = [NSJSONSerialization dataWithJSONObject:payload options:kNilOptions error:&error];
            completionHandler(data, response, error);
        };
    return %orig(request, interceptedCompletionHandler);
}

%end

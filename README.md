CocoaPushover
=============

CocoaPushover is a convenience wrapper around the Pushover (http://www.pushover.net) API.

The class lets you create send push notifications to your iOS and Android devices from within your applications in just a few lines of code:

Usage
-----

```
NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
[options setValue:@">>>>>YOURTOKEN<<<<<" forKey:@"token"];
[options setValue:@">>>>>YOURUSER<<<<<" forKey:@"user"];
[options setValue:@"Hello world!" forKey:@"message"];

NSError *err;
// Send the message
[CocoaPushover sendSynchronousNotification:options error:&err];
```

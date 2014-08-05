Expecta+ReactiveCocoa
=====================

Expecta+ReactiveCocoa provides a set of matchers for using Expecta with
ReactiveCocoa. Providing the following matchers:

- `expect(signal).will.complete()`
- `expect(signal).will.error()`

### Usage

```objective-c
#import <Expecta+ReactiveCocoa/Expecta+ReactiveCocoa.h>

describe(@"a coupon manager", ^{
  __block EDNSessionManager *manager;

  beforeAll(^{
    manager = [[EDNSessionManager alloc] init];
  });

  context(@"when redeeming a coupon code", ^{
    it(@"should complete with a successful coupon code", ^{
       RACSignal *signal = [manager redeemCoupon:@"XAXAXA"];
       expect(signal).will.complete();
     });

    it(@"should fail with an invalid coupon code", ^{
       RACSignal *signal = [manager redeemCoupon:@"XAXAXA"];
       expect(signal).will.error();
    });
  });
});
```

### Installation

```ruby
target 'PalaverTests' do
  pod 'Expecta+ReactiveCocoa'
end
```

### License

Expecta+ReactiveCocoa is available under the BSD license. See
[LICENSE](LICENSE) for more information.


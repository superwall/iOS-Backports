# SwiftUI-Backports

> ✨ A lightweight way to use the latest SwiftUI APIs while gracefully supporting older iOS versions.


## Solving the N-1 Problem

Every fall, a new version of iOS ships with shiny new SwiftUI APIs. However, a lot of apps will continue to support the last version of iOS (i.e., N-1). That often leads to code that looks like this:

```swift
if #available(iOS 26.0, *) {
    SomeView().glassEffect()
} else {
    SomeView()
}
```

Multiply that across your entire codebase, and suddenly you’re tangled in `#available` checks and duplicated code.

## The Solution

This project offers a simple `Backport` type that lets you use new SwiftUI APIs with a fallback — **without cluttering your UI code**.

- ✅ Write modern SwiftUI code that reads cleanly
- ✅ Seamlessly backport newer iOS modifiers to earlier versions
- ✅ No more nested `if #available` blocks
- ✅ Just one Swift file — easy to drop in and maintain

It’s based on [Dave DeLong’s elegant approach](https://davedelong.com/blog/2021/10/09/simplifying-backwards-compatibility-in-swift/) to backwards compatibility in Swift. Definitely read that before diving in.

## Example

Instead of writing:

```swift
if #available(iOS 26.0, *) {
    MyView().glassEffect()
} else {
    MyView()
}
```

You can write:

```swift
MyView()
    .backport.glasseffect()
```

And the `Backport` type handles the fallback internally. Since iOS version checks occur at compile time, you aren't hit with SwiftUI performance penalities from `if/else` checks.

## Installation

### Swift Package Manager (Recommended)
You can add this repo as a dependency in Xcode:
1. Open your project.
2. Go to File > Add Packages…
3. Enter the URL: https://github.com/superwall/iOS-Backports
4. Choose the latest version and add it to your app target.

Then, import the package:
```swift
import Backport

struct MyView: View {
    var body: some View {
        AwesomeView()
            .backport.glassEffect()
    }
}
```

### Manual 
Just copy the `Backport.swift` file into your project. That’s it.

## Contributing

Got a new SwiftUI modifier you'd like to backport? Open a PR or file an issue — contributions are welcome!

## License

MIT

---

> Made with ❤️ by [Superwall](https://superwall.com)

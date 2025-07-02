
![backporthero](https://github.com/user-attachments/assets/483d9db8-7fdf-4ce5-9ae4-6b6d0004184b)

# SwiftUI-Backports

> ✨ A lightweight way to use the latest SwiftUI modifier APIs while gracefully supporting older iOS versions.


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

And the `Backport` type handles the fallback internally. Since iOS version checks occur at compile time, you aren't hit with SwiftUI performance penalities from `if/else` checks. Here, the left side is using a thin material, while the right uses a glass effect on iOS 26 and above:

![example](https://github.com/user-attachments/assets/397a5b20-8d70-4caf-a3e6-70c382cb150e)


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

## Backported Modifiers

| iOS Version | Modifier                                | Description                                      |
|-------------|------------------------------------------|--------------------------------------------------|
| iOS 17.0    | `contentTransition(_:)`                 | Applies numeric text content transitions         |
| iOS 17.0    | `disfavoredLocations(_:for:)`           | Sets widget disfavored locations                 |
| iOS 18.0    | `presentationSizeForm()`                | Applies `.presentationSizing(.form)`            |
| iOS 18.0    | `zoom(sourceID:in:)`                    | Applies a zoom navigation transition             |
| iOS 18.0    | `matchedTransitionSource(id:in:)`       | Marks a view as a matched transition source      |
| iOS 18.0    | `widgetAccentedRenderingMode(_:)`       | Sets widget image accent rendering mode          |
| iOS 18.1    | `imagePlayground(_:completion:)`        | Presents an image playground sheet               |
| iOS 18.1    | `imagePlaygroundSheet(isPresented:onCompletion:)` | Presents Image Playground sheet            |
| iOS 26.0    | `glassEffect(_:in:isEnabled:)`          | Applies a glass effect                           |
| iOS 26.0    | `glassEffect(_:in:isEnabled:fallback:)`| Glass effect with fallback for unsupported OS    |
| iOS 26.0    | `glassButtonStyle()`                    | Applies the glass button style                   |
| iOS 26.0    | `glassEffectTransition(_:isEnabled:)`   | Animates glass transitions                       |
| iOS 26.0    | `glassEffectID(_:in:)`                  | Tags glass views for matched animations          |
| iOS 26.0    | `backgroundExtensionEffect()`           | Extends background beyond safe areas             |
| iOS 26.0    | `scrollEdgeEffectStyle(_:for:)`         | Customizes scroll view edge effects              |
| iOS 26.0    | `scrollEdgeEffectDisabled(_:for:)`      | Disables scroll edge effects                     |
| iOS 26.0    | `symbolColorRenderingMode(_:)`          | Sets symbol image rendering mode                 |
| iOS 26.0    | `symbolVariableValueMode(_:)`           | Sets variable value rendering mode               |

## Contributing

Got a new SwiftUI modifier you'd like to backport? Open a PR or file an issue — contributions are welcome!

## License

MIT

---

> Made with ❤️ by [Superwall](https://superwall.com)

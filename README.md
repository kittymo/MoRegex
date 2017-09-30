# MoRegex

![CocoaPods](https://img.shields.io/cocoapods/v/BaseJson4.svg) ![Platform](https://img.shields.io/badge/platforms-iOS%209.0+%20%7C%20macOS%2010.10+-3366AA.svg)

MoRegex 讓你輕鬆的在 Swift 裡使用正規表示式(Regular Expression)


## 為什麼要用這個?

iOS 原生的正規表示式並不友善, 我們經常只想做一些簡單的字串判斷, 但需要很多程式碼才能完成,
MoRegex 把這些繁瑣的程式碼封裝成一個簡易使用的運算子(Operator)判斷式, 
讓您只需要一行程式就可以做簡單的正規表示式判斷(Regular Expressions Matches)</br>
例如:

```swift
let str1 = "02-12345678"       
if let res = str1 =~ "(\\d\\d)\\-(\\d\\d\\d\\d\\d\\d\\d\\d)" {
  print("1 res=\(res)")
  // PRINT: 1 res=["02-12345678", "02", "12345678"]
 }
```

對 String 使用 =~ 運算子操作, 會回傳一個匹配的陣列, 如果匹配失敗會回傳 nil

## 系統需求 Requirements

- iOS 9.0+ | macOS 10.10+
- Xcode 9
- Swift 3 or 4

## 功能特徵 Features

- 運算子 =~ 操作
- 指定樣板替換字串
- 指定匹配欄位替換字串
- 內含簡易的常用判斷式

## 如何安裝 使用CocoaPods (iOS 9+, OS X 10.10+)

你可以使用 [CocoaPods](http://cocoapods.org/) 來安裝, 把`MoRegex`加到你的`Podfile`:

```ruby
platform :ios, '9.0'
use_frameworks!

target 'MyApp' do
	pod 'MoRegex'
end
```

## 如何安裝 手動Manually

1. 下載本套件的 [MoRegex.swift](https://github.com/kittymo/MoRegex/blob/master/MoRegex/MoRegex.swift) 檔
2. 把這個檔案加進你的 xcode 專案裡
3. 安裝完成了


## 如何使用 Usage
## 1. 使用 =~ 運算子

```swift
let str1 = "02-12345678"    // 想判斷的字串
       
if let res = str1 =~ "(\\d\\d)\\-(\\d\\d\\d\\d\\d\\d\\d\\d)" {
    // PRINT: res=["02-12345678", "02", "12345678"]
}

if let res = str1 =~ "(\\d\\d)\\-(\\d\\d\\d\\d)(\\d\\d\\d\\d)" {
    // PRINT: res=["02-12345678", "02", "1234", "5678"]
}

if let res = str1 =~ "12345" {
    // PRINT: res=["12345"]
}

if let res = str1 =~ "\\-(.*+)" {
    // PRINT: res=["-12345678", "12345678"]
}

if let res = str1.regexMatch("(\\d\\d)\\-(\\d\\d\\d\\d)(\\d\\d\\d\\d)") {
    // PRINT: res=["02-12345678", "02", "1234", "5678"]
}

if let res = str1.regexReplace("(\\d\\d)\\-(\\d\\d\\d\\d)(....)", template: "($1)$2-$3") {
    // PRINT: res=(02)1234-5678
}

if let res = str1.regexMatchSub("(\\d\\d)\\-(\\d\\d\\d\\d)(....)", replaces: ["AB", nil, "CDE"]) {
    // PRINT: res=["AB-1234CDE", "02", "1234", "5678"]
}
```


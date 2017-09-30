# MoRegex

![CocoaPods](https://img.shields.io/cocoapods/v/MoRegex.svg) ![Platform](https://img.shields.io/badge/platforms-iOS%209.0+%20%7C%20macOS%2010.10+-3366AA.svg)

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

// 取出前後2組字串
if let res = str1 =~ "(\\d\\d)\\-(\\d\\d\\d\\d\\d\\d\\d\\d)" {
    // PRINT: res=["02-12345678", "02", "12345678"]
}

// 取出3組字串
if let res = str1 =~ "(\\d\\d)\\-(\\d\\d\\d\\d)(\\d\\d\\d\\d)" {
    // PRINT: res=["02-12345678", "02", "1234", "5678"]
}

// 判斷是否含有 12345
if let res = str1 =~ "12345" {
    // PRINT: res=["12345"]
}

// 取出 - 符號後的字串
if let res = str1 =~ "\\-(.*+)" {
    // PRINT: res=["-12345678", "12345678"]
}

```

## 2. 使用 regexMatch

regexMatch 的功能與 =~ 運算子相同

```swift
if let res = str1.regexMatch("(\\d\\d)\\-(\\d\\d\\d\\d)(\\d\\d\\d\\d)") {
    // PRINT: res=["02-12345678", "02", "1234", "5678"]
}
```

## 3. 使用 regexReplace

regexReplace 可以讓你以樣板字串的方式重新組合取出的字串

```swift
if let res = str1.regexReplace("(\\d\\d)\\-(\\d\\d\\d\\d)(....)", template: "($1)$2-$3") {
    // PRINT: res=(02)1234-5678
}
```

## 4. 使用 regexMatchSub

regexMatchSub 允許你傳入一個字串陣列, 並依順序替換掉已匹配的字串

```swift
if let res = str1.regexMatchSub("(\\d\\d)\\-(\\d\\d\\d\\d)(....)", replaces: ["AB", nil, "CDE"]) {
    // PRINT: res=["AB-1234CDE", "02", "1234", "5678"]
    // res[0] "AB-1234CDE" 是替換後的結果
}
```

## 5. 檢查一些常用的判斷式

MoRegex 已經內建幾個常用的表示式, 您可以用更簡單的方式做這些常用的判斷

```swift
let str2 = "hello-kitty@mail.com"
if let res = str2.regexMatch(check: .mail) {        // 電子郵件
    // PRINT: res=["hello-kitty@mail.com", "hello-kitty", "mail", "com"]
}

let str3 = "2017-09-30"
if let res = str3.regexMatch(check: .date) {        // 日期 年-月-日
    // PRINT: res=["2017-09-30", "2017", "09", "30"]
}

let str4 = "02-12341234"
if let res = str4.regexMatch(check: .telphone) {    // 市話
    // PRINT: res=["02-12341234", "02", "1234", "1234"]
}

let str5 = "0901-123123"
if let res = str5.regexMatch(check: .mobile) {      // 行動電話
    // PRINT: res=["0901-123123", "0901", "123", "123"]
}

let str6 = "<center>TEST</center>"
if let res = str6.regexMatch(check: .htmlTag) {     // HTML標籤
    // PRINT: res=["<center>TEST</center>", "center", "", "TEST"]
}

let str7 = "21:05:43"
if let res = str7.regexMatch(check: .time) {    // 時間(24小時制)
    // PRINT: res=["21:05:43", "21", "05", "43"]
}

let str9 = "https://hello.kitty.com/index.html"
if let res = str9.regexMatch(check: .url) {    // 網址
    // PRINT: res=["https://hello.kitty.com/index.html", "https://", "hello.kitty", "com", ""]
}

let str10 = "#F390CC"
if let res = str10.regexMatch(check: .colorHex) {    // 色碼
    // PRINT: res=["#F390CC", "F390CC"]
}

let str11 = "-12345"
if let res = str11.regexMatch(check: .number) {    // 整數數字
    // PRINT: res=["-12345"]
}

```

上面的檢查範例也可以用 regexCheck 來完成

```swift
let str12 = "-12345"
if let res = str12.regexCheck(.number) {    // 整數數字
    print("res=\(res)")
    // PRINT: res=["-12345"]
}

```


## 6. 可以加入參數選項

MoRegex 是封裝 iOS 的 NSRegularExpression 函數, 因此也能傳入 NSRegularExpression 的 options 選項</br>
以區分大小寫來做示範

```swift
let str8 = "My name is Kitty"

// 若沒加 options 參數, 則預設文字比對為不區分大小寫 options: [.caseInsensitive]
if let res = str8.regexMatch("kitty") {
    // PRINT: res=["Kitty"]
}

if let res = str8.regexMatch("kitty", options: []) {   // 區分大小寫
    // 因為匹配不成功, 這裡不會被執行
} else {
    // PRINT: NOT MATCH
}

```





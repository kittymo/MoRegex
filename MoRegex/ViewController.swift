//
//  ViewController.swift
//  MoRegex
//
//  Created by Hello Kitty on 2017/9/30.
//  Copyright © 2017年 Hello Kitty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let str1 = "02-12345678"
        
        if let res = str1 =~ "(\\d\\d)\\-(\\d\\d\\d\\d\\d\\d\\d\\d)" {
            print("1 res=\(res)")
            // PRINT: 1 res=["02-12345678", "02", "12345678"]
        }
        
        if let res = str1 =~ "(\\d\\d)\\-(\\d\\d\\d\\d)(\\d\\d\\d\\d)" {
            print("2 res=\(res)")
            // PRINT: 2 res=["02-12345678", "02", "1234", "5678"]
        }
        
        if let res = str1 =~ "12345" {
            print("3 res=\(res)")
            // PRINT: 3 res=["12345"]
        }
        
        if let res = str1 =~ "\\-(.*+)" {
            print("4 res=\(res)")
            // PRINT: 4 res=["-12345678", "12345678"]
        }
        
        if let res = str1.regexMatch("(\\d\\d)\\-(\\d\\d\\d\\d)(\\d\\d\\d\\d)") {
            print("5 res=\(res)")
            // PRINT: 5 res=["02-12345678", "02", "1234", "5678"]
        }
        
        if let res = str1.regexReplace("(\\d\\d)\\-(\\d\\d\\d\\d)(....)", template: "($1)$2-$3") {
            print("6 res=\(res)")
            // PRINT: 6 res=(02)1234-5678
        }
        
        if let res = str1.regexMatchSub("(\\d\\d)\\-(\\d\\d\\d\\d)(....)", replaces: ["AB", nil, "CDE"]) {
            print("7 res=\(res)")
            // PRINT: 7 res=["AB-1234CDE", "02", "1234", "5678"]
        }

        let str2 = "hello-kitty@mail.com"
        if let res = str2.regexMatch(check: .mail) {        // 電子郵件
            print("8 res=\(res)")
            // PRINT: 8 res=["hello-kitty@mail.com", "hello-kitty", "mail", "com"]
        }
        
        let str3 = "2017-09-30"
        if let res = str3.regexMatch(check: .date) {        // 日期 年-月-日
            print("9 res=\(res)")
            // PRINT: 9 res=["2017-09-30", "2017", "09", "30"]
        }

        let str4 = "02-12341234"
        if let res = str4.regexMatch(check: .telphone) {    // 市話
            print("10 res=\(res)")
            // PRINT: 10 res=["02-12341234", "02", "1234", "1234"]
        }
        
        let str5 = "0901-123123"
        if let res = str5.regexMatch(check: .mobile) {      // 行動電話
            print("11 res=\(res)")
            // PRINT: 11 res=["0901-123123", "0901", "123", "123"]
        }
        
        let str6 = "<center>TEST</center>"
        if let res = str6.regexMatch(check: .htmlTag) {     // HTML標籤
            print("12 res=\(res)")
            // PRINT: 12 res=["<center>TEST</center>", "center", "", "TEST"]
        }
        
        let str7 = "21:05:43"
        if let res = str7.regexMatch(check: .time) {    // 時間(24小時制)
            print("13 res=\(res)")
            // PRINT: 13 res=["21:05:43", "21", "05", "43"]
        }
        
        let str8 = "My name is Kitty"
        if let res = str8.regexMatch("kitty") {   // 預設文字比對為不區分大小寫
            print("14 res=\(res)")
            // PRINT: 14 res=["Kitty"]
        }
        if let res = str8.regexMatch("kitty", options: []) {   // 區分大小寫
            print("15 res=\(res)")
        } else {
            print("15 NOT MATCH")
            // PRINT: 15 NOT MATCH
        }

        let str9 = "https://hello.kitty.com/index.html"
        if let res = str9.regexMatch(check: .url) {    // 網址
            print("16 res=\(res)")
            // PRINT: 16 res=["https://hello.kitty.com/index.html", "https://", "hello.kitty", "com", ""]
        }
        
        let str10 = "#F390CC"
        if let res = str10.regexMatch(check: .colorHex) {    // 色碼
            print("17 res=\(res)")
            // PRINT: 17 res=["#F390CC", "F390CC"]
        }
        
        let str11 = "-12345"
        if let res = str11.regexMatch(check: .number) {    // 整數數字
            print("18 res=\(res)")
            // PRINT: 18 res=["-12345"]
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


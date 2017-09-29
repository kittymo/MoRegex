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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


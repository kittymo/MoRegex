//
//  MoRegex.swift
//  MoRegex
//
//  Created by Hello Kitty on 2017/3/25.
//  Copyright © 2017年 Hello Kitty. All rights reserved.
//

import Foundation

class MoRegex {
    var internalExpression: NSRegularExpression? = nil
    var pattern: String? = nil
    
    init?(_ pattern: String) {
        self.pattern = pattern
        do {
            self.internalExpression = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        } catch {
            return nil
        }
    }

    func match2(_ input: String, template: String) -> String? {
        let range = NSRange(location: 0, length: input.characters.count)
        let trimmedString = self.internalExpression?.stringByReplacingMatches(in: input, options: .reportProgress, range:range, withTemplate:template)
        if let ts = trimmedString, ts.characters.count > 0 {
            return ts
        }
        return nil
    }

    func match(_ input: String, replaces: [String?]? = nil) -> [String]? {
        //print("test input=\(input)")
        
        let range = NSRange(location: 0, length: input.characters.count)
        //let trimmedString = self.internalExpression?.stringByReplacingMatches(in: input, options: .reportProgress, range:range, withTemplate:"$1")
        
        if let matches = self.internalExpression?.matches(in: input, options: .reportProgress, range: range) {
            if matches.count == 0 {
                return nil
            }
            var splits: [String] = []
            var arr: [String] = []
            if let n = self.internalExpression?.numberOfCaptureGroups {
                for m in matches {
                    var oldR: NSRange = NSMakeRange(0, 0)
                    for i in 0...n {
                        let r = m.range(at: i)
                        let capture = (input as NSString).substring(with: r)
                        if i > 0 {
                            let start = oldR.location + oldR.length
                            let r2 = NSMakeRange(start, r.location - start)
                            splits.append((input as NSString).substring(with: r2))
                            oldR = r
                        }
                        arr.append(capture)
                    }
                }
                if (n + 1) != arr.count {
                    return nil
                }
                if arr.count > 0 && splits.count > 0, let rs = replaces, rs.count > 0 {
                    var output = ""
                    for i in 0..<splits.count {
                        output += splits[i]
                        if i < rs.count, let rs = rs[i] {
                            output += rs
                        } else if i+1 < arr.count {
                            output += arr[i+1]
                        }
                    }
                    arr[0] = output
                }
            }
            return arr
        }
        return nil
    }
    
    func replace(_ input: String, template: String) -> String? {
        let range = NSRange(location: 0, length: input.characters.count)
        let trimmedString = self.internalExpression?.stringByReplacingMatches(in: input, options: .reportProgress, range: range, withTemplate: template)
        return trimmedString
    }
}

precedencegroup RegexPrecedence {
    associativity: left
    lowerThan: ComparisonPrecedence
    higherThan: LogicalConjunctionPrecedence
}

infix operator =~ : RegexPrecedence
func =~ (input: String?, pattern: String) -> [String]? {
    if input == nil {
        return nil
    }
    return MoRegex(pattern)?.match(input!)
}

extension String {
    func regexMatch(_ pattern: String) -> [String]? {
        return MoRegex(pattern)?.match(self)
    }
    
    func regexReplace(_ pattern: String, template: String) -> String? {
        return MoRegex(pattern)?.replace(self, template: template)
    }
    
    func regexMatchSub(_ pattern: String, replaces: [String?]?) -> [String]? {
        return MoRegex(pattern)?.match(self, replaces: replaces)
    }
    
}


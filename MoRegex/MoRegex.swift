//
//  MoRegex.swift
//  MoRegex
//
//  Created by Hello Kitty on 2017/9/30.
//  Copyright © 2017年 Hello Kitty. All rights reserved.
//

import Foundation

public class MoRegex {
    var internalRE: NSRegularExpression
    var pattern: String? = nil

    public enum Check: String {
        case mail = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        case url = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)\\/?$"
        case date = "(\\d{4}|\\d{2})-(1[0-2]|0?[1-9])-([12][0-9]|3[01]|0?[1-9])"
        case time = "(1|0?[0-9]|2[0-3]):([0-5][0-9]):?([0-5][0-9])?"
        case telphone = "(0\\d)\\-?(\\d{4})\\-?(\\d{4})"
        case mobile = "(09\\d\\d)\\-?(\\d{3})\\-?(\\d{3})"
        case htmlTag = "^<([a-z]+)([^<]+)*(?:>(.*)<\\/\\1>|\\s+\\/>)$"
        case colorHex = "^#?([a-f0-9]{6}|[a-f0-9]{3})$"
        case number = "^[0-9-]+$"
    }
    

    public init?(_ pattern: String, options: NSRegularExpression.Options = .caseInsensitive) {
        self.pattern = pattern
        do {
            self.internalRE = try NSRegularExpression(pattern: pattern, options: options)
        } catch {
            return nil
        }
    }

    public func match(_ input: String, replaces: [String?]? = nil) -> [String]? {
        let range = NSRange(location: 0, length: input.characters.count)
        let matches = self.internalRE.matches(in: input, options: .reportProgress, range: range)
        if matches.count == 0 {
            return nil
        }
        var splits: [String] = []
        var arr: [String] = []
        let n = self.internalRE.numberOfCaptureGroups
        for m in matches {
            var oldR: NSRange = NSMakeRange(0, 0)
            for i in 0...n {
#if swift(>=4.0)
                let r = m.range(at: i)
#else
                let r = m.rangeAt(i)
#endif
                if r.location == NSNotFound {
                    arr.append("")
                    continue
                }
                let capture = (input as NSString).substring(with: r)
                if i > 0 {
                    let start = oldR.location + oldR.length
                    let r2 = NSMakeRange(start, r.location - start)
                    if r2.location != NSNotFound && r2.length >= 0 {
                        splits.append((input as NSString).substring(with: r2))
                    }
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
        return arr
    }
    
    public func replace(_ input: String, template: String) -> String? {
        let range = NSRange(location: 0, length: input.characters.count)
        let trimmedString = self.internalRE.stringByReplacingMatches(in: input, options: .reportProgress, range: range, withTemplate: template)
        return trimmedString
    }
}

precedencegroup RegexPrecedence {
    associativity: left
    lowerThan: ComparisonPrecedence
    higherThan: LogicalConjunctionPrecedence
}

infix operator =~ : RegexPrecedence
public func =~ (input: String?, pattern: String) -> [String]? {
    if input == nil {
        return nil
    }
    return MoRegex(pattern)?.match(input!)
}

extension String {
    public func regexMatch(_ pattern: String, options: NSRegularExpression.Options = .caseInsensitive) -> [String]? {
        return MoRegex(pattern, options: options)?.match(self)
    }

    public func regexMatch(check: MoRegex.Check) -> [String]? {
        return MoRegex(check.rawValue)?.match(self)
    }

    public func regexCheck(_ check: MoRegex.Check) -> [String]? {
        return MoRegex(check.rawValue)?.match(self)
    }
    
    public func regexReplace(_ pattern: String, template: String, options: NSRegularExpression.Options = .caseInsensitive) -> String? {
        return MoRegex(pattern, options: options)?.replace(self, template: template)
    }
    
    public func regexMatchSub(_ pattern: String, replaces: [String?]?, options: NSRegularExpression.Options = .caseInsensitive) -> [String]? {
        return MoRegex(pattern, options: options)?.match(self, replaces: replaces)
    }
    
}





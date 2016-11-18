//
//  NSDate+Extension.swift
//  weibo
//
//  Created by herobin on 16/5/10.
//  Copyright © 2016年 herobin. All rights reserved.
//

// 此文件是之前用swift2.3写的, 和3.0的语法有变化, 直接用系统提示修改的, 有空再重新写一遍3.0版本

import UIKit

extension NSDate {
    
    ///  是否为今天
    func isToday() ->Bool {
        // 日历
        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        
        if let version = Float(UIDevice.current.systemVersion), version >= 8.0 {
            // iOS8 出了这个方法,一行就搞定了
            return calendar.isDateInToday(self as Date)
        }

        let unit = NSCalendar.Unit(arrayLiteral: .year, .month, .day)
        // 获取当前时间的年月日
        let nowCmps = calendar.components(unit, from: NSDate() as Date)
        // 获得self的年月日
        let selfCmps = calendar.components(unit, from: self as Date)
        
        return nowCmps.year == selfCmps.year && nowCmps.month == selfCmps.month && nowCmps.day == selfCmps.day
    }
    
    // 是否为昨天
    func isYesterday() ->Bool {
        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        if let version = Float(UIDevice.current.systemVersion) , version >= 8.0 {
            // iOS8 出了这个方法,一行就搞定了
            return calendar.isDateInYesterday(self as Date)
        }
        
        let nowDate = NSDate().dateWithYMD()
        let selfDate = self.dateWithYMD()
        
        // 比较差距
        let cmps = calendar.components(NSCalendar.Unit(arrayLiteral: .day), from: selfDate as Date, to: nowDate as Date, options: [])
        
        return cmps.day == 1
    }
    
    // 是否为明天
    func isTomorrow() ->Bool {
        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        if let version = Float(UIDevice.current.systemVersion) , version >= 8.0 {
            // iOS8 出了这个方法,一行就搞定了
            return calendar.isDateInTomorrow(self as Date)
        }
        
        let nowDate = NSDate().dateWithYMD()
        let selfDate = self.dateWithYMD()
        
        // 比较差距
        let cmps = calendar.components(NSCalendar.Unit(arrayLiteral: .day), from: selfDate as Date, to: nowDate as Date, options: [])
        
        return cmps.day == -1
    }

    // 是否为本周
    func isThisYear() ->Bool {
        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        let unit = NSCalendar.Unit(arrayLiteral: .year)
        
        let nowCmps = calendar.components(unit, from: NSDate() as Date)
        let selfCmps = calendar.components(unit, from: self as Date)
        
        return nowCmps.year == selfCmps.year
    }
    
    // 返回年月日的标准格式
    func dateWithYMD() ->NSDate {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = NSLocale(localeIdentifier: "zh-cn") as Locale!
        let str = formatter.string(from: self as Date)
        
        return formatter.date(from: str)! as NSDate
    }
    
    // 返回时间的比较
    func deltaWithNow() ->DateComponents {
        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        let unit = NSCalendar.Unit(arrayLiteral: .hour, .minute, .second)
        
        return calendar.components(unit, from: self as Date, to: NSDate() as Date, options: [])
    }
    
    // 返回日期字符串
    func dateString() ->String {
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "zh-cn") as Locale!
        
        //判断时间 和现在时间 的差距
        if isToday() {
            if deltaWithNow().hour! >= 1 {
                return String(format: "%d小时前",deltaWithNow().hour!)
            }else if deltaWithNow().minute! >= 1 {
                return String(format: "%d分钟前",deltaWithNow().minute!)
            }else {
                return "刚刚"
            }
        } else if isYesterday() {
            formatter.dateFormat = "昨天 HH:mm"
            return formatter.string(from: self as Date)
        } else if isThisYear() {
            formatter.dateFormat = "MM-dd HH:mm"
            return formatter.string(from: self as Date)
        } else {
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            return formatter.string(from: self as Date)
        }
    }
    
    class func dateString(dateString: String?, dateFormat: String) ->String? {
        guard let string = dateString else {
            return nil
        }
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = NSLocale(localeIdentifier: "zh-cn") as Locale!
        let date = formatter.date(from: string)! as NSDate
        return date.dateString()
    }
}

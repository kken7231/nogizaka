//
//  AppDelegate.swift
//  nogizaka-1
//
//  Created by kentaro on 2018/01/12.
//  Copyright © 2018 kken7231. All rights reserved.
//

import UIKit
import WebKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var pickUpInfo = [[[String]]]()
    var blogInfo = [[String]]()
    var webHTML = String()
    var fromwhere = String()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        WKWebsiteDataStore.default().removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), modifiedSince: Date(timeIntervalSince1970: 0), completionHandler: {})
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        WKWebsiteDataStore.default().removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), modifiedSince: Date(timeIntervalSince1970: 0), completionHandler: {})
    }


    //PickUp画面のHTMLをとってくるめそっど
    /*重要！！！！！https://dev.classmethod.jp/smartphone/iphone/ios-ats-cheats-info-plist-settings/#setting-info-plist-keys-for-nsexceptiondomains*/
    func getPickUpInfo(){
        //HTMLを取得
        let urlnogi: URL = URL(string: "http://www.nogizaka46.com")!
        var HTML: NSString
        
        do {
            HTML = try String(contentsOf: urlnogi, encoding: .utf8) as NSString
        } catch let error {
            print("Error: \(error)")
            HTML = "HTML Error"
        }
        
        //戻り値用意
        var newsArr = [[String]]()
        var scheArr = [[String]]()
        
        //newsArr
        let regex = try? NSRegularExpression(pattern: "<li class=\"clearfix noborder\">\n<span class=\"date\">20\\d\\d.([0123456789.]*)</span>\n<span class=\"([^ ]*)  txt\">\n\n<span class=\"title\"><strong><a href=\"([^\"]*)\">([^<]*)</a></strong></span>\n\n\n\n\n<span class=\"summary\">\n([\\s\\S&&[^<]]*)\n", options: NSRegularExpression.Options())
        let result = regex?.numberOfMatches(in: HTML as String, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, HTML.length))
        if (result != 0) {
            let matches = regex?.matches(in: HTML as String, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, HTML.length))
            for h in 0..<matches!.count{
                let results = matches![h]
                newsArr.append([String]())
                for i in 1..<results.numberOfRanges {
                    let strings = HTML.substring(with: results.range(at: i))
                    newsArr[h].append(strings)
                }
            }
        }
        
        //scheArr
        let regex2 = try? NSRegularExpression(pattern: "<li class=\"clearfix noborder\"><span class=\"date\">20\\d\\d.([0123456789.]*)</span><span class=\"(radio|tv|magazine) txt\"><span class=\"title\"><strong><a href=\"([^\"]*)\">([^<]*)", options: NSRegularExpression.Options())
        let result2 = regex2?.numberOfMatches(in: HTML as String, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, HTML.length))
        if (result2 != 0) {
            let matches2 = regex2?.matches(in: HTML as String, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, HTML.length))
            for h in 0..<matches2!.count{
                let results = matches2![h]
                scheArr.append([String]())
                for i in 1..<results.numberOfRanges {
                    var strings = HTML.substring(with: results.range(at: i))
                    if (i != 4){
                        if (strings.isEmpty){strings.append("nil")}
                        scheArr[h].append(strings)
                    }
                    if (i == 4){
                        if(scheArr[h][1] == "magazine"){
                            let regex3 = try? NSRegularExpression(pattern: "「([^」]*)」([^<]*)", options: NSRegularExpression.Options())
                            let matches3 = regex3?.matches(in: strings, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, strings.count))
                            let title: String = (strings as NSString).substring(with: matches3![0].range(at: 1)) as String
                            let member: String = (strings as NSString).substring(with: matches3![0].range(at: 2)) as String
                            scheArr[h].append(contentsOf: ["","",title,member])
                        }else{
                            let regex3 = try? NSRegularExpression(pattern: "([0-9:〜]*) ([^「]*)「([^」]*)」(.*)", options: NSRegularExpression.Options())
                            let matches3 = regex3?.matches(in: strings, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, strings.count))
                            let date: String = (strings as NSString).substring(with: matches3![0].range(at: 1)) as String
                            let company: String = (strings as NSString).substring(with: matches3![0].range(at: 2)) as String
                            let title: String = (strings as NSString).substring(with: matches3![0].range(at: 3)) as String
                            let member: String = (strings as NSString).substring(with: matches3![0].range(at: 4)) as String
                            scheArr[h].append(contentsOf: [date,company,title,member])
                        }
                    }
                }
            }
        }
        pickUpInfo = [newsArr,scheArr]
    }
    
    func getBlogInfo(){
        let urlnogi: URL = URL(string: "http://blog.nogizaka46.com")!
        var HTML: NSString
        
        do {
            HTML = try String(contentsOf: urlnogi, encoding: .utf8) as NSString
        } catch let error {
            print("Error: \(error)")
            HTML = "HTML Error"
        }
        
        //戻り値用意
        var blogArr = [[String]]()
        
        //前半と後半に分けて１記事を処理
        //前半
        let separated = HTML.components(separatedBy: "<span class=\"author\">")
        var separated2: [String]
        for i in 1..<separated.count{
            separated2 = separated[i].components(separatedBy: "<div class=\"entrybottom\">")
            let regex = try? NSRegularExpression(pattern: "([^<]*)</span><span class=\"entrytitle\"><a href=\"([^\"]*)\" rel=\"bookmark\">([^<]*)</a></span></span></h1><div class=\"fkd\"></div><div class=\"entrybody\">(.*)", options: NSRegularExpression.Options())
            let result = regex?.numberOfMatches(in: separated2[0], options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, separated2[0].count))
            if (result != 0) {
                let matches = regex?.matches(in: separated2[0], options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, separated2[0].count))
                let results = matches![0]
                blogArr.append([String]())
                for f in 1..<results.numberOfRanges {
                    var strings = (separated2[0] as NSString).substring(with: results.range(at: f))
                    if (f == 4){
                        strings = strings.replacingOccurrences(of: "<div></div>", with: " ")
                        strings = strings.replacingOccurrences(of: "<[^>]*>", with: "", options: .regularExpression, range: strings.range(of: strings))
                        strings = strings.replacingOccurrences(of: "&nbsp;", with: "")
                    }
                    if (strings.isEmpty){strings.append("nil")}
                    blogArr[i-1].append(strings)
                }
            }
            //後半
            let regex2 = try? NSRegularExpression(pattern: "([0-9:/ ]*)｜<a href=\"([^\"]*)\">個別ページ</a>｜<a href=\"([^\"]*)\">コメント([0-9()]*)", options: NSRegularExpression.Options())
            let result2 = regex2?.numberOfMatches(in: separated2[1], options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, separated2[1].count))
            if (result2 != 0) {
                let matches2 = regex2?.matches(in: separated2[1], options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, separated2[1].count))
                let results2 = matches2![0]
                for f in 1..<results2.numberOfRanges {
                    var strings2 = (separated2[1] as NSString).substring(with: results2.range(at: f))
                    if(f == 4){
                        //コメント数の取得文字列の調整
                        strings2 = String(strings2.suffix(strings2.count-1))
                        strings2 = String(strings2.prefix(strings2.count-1))
                    }
                    blogArr[i-1].append(strings2)
                }
            }
            blogInfo = blogArr
        }
    }
}


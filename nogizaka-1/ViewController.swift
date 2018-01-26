//
//  ViewController.swift
//  nogizaka-1
//
//  Created by kken7231 on 2018/01/12.
//  Copyright © 2018 kken7231. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet var mainView: UIView!
    var newsElts = [[String]](), scheElts = [[String]]()
    let ta_sche = UITableView(), ta_news = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let lb_sche = UILabel(), lb_news = UILabel()
        let im_sche = UIImageView(), im_news = UIImageView()
        let shadow_sche = UIView(), shadow_news = UIView()
        
        let viewWidth = mainView.frame.size.width - 32
        let fontSize: CGFloat = 20;
        let cellSize: CGFloat = 100;
        var everyones_y: CGFloat
        
        //レイアウトをリロード
        self.view.layoutIfNeeded()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(RefreshArticles), for: UIControlEvents.valueChanged)
        mainScroll.refreshControl = refreshControl

        //データを取得
        let delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        newsElts = delegate.pickUpInfo[0]
        scheElts = delegate.pickUpInfo[1]
        
        im_sche.image = UIImage(named: "ic_background")
        im_sche.frame = CGRect(x:8,y:8,width: viewWidth-16, height: fontSize+20)
        im_sche.layer.cornerRadius = 5
        im_sche.contentMode = .topLeft
        im_sche.layer.masksToBounds = true
        
        shadow_sche.frame = CGRect(x:8,y:8,width: viewWidth-16, height: fontSize+20)
        shadow_sche.layer.shadowColor = UIColor.black.cgColor
        shadow_sche.layer.shadowOffset = CGSize(width: 3, height: 2)
        shadow_sche.layer.shadowOpacity = 0.3
        shadow_sche.layer.shadowRadius = 4
        shadow_sche.layer.shadowPath = UIBezierPath(roundedRect: im_sche.bounds, cornerRadius: 5).cgPath
        
        lb_sche.text = "本日のスケジュール"
        lb_sche.frame = CGRect(x:24,y:16,width: viewWidth-20, height: fontSize+4)
        lb_sche.font = UIFont(name: "HiraKakuProN-W6", size: fontSize)
        lb_sche.adjustsFontSizeToFitWidth = true
        lb_sche.textColor = .white
        everyones_y = 8 + (fontSize+20) + 10
    
        ta_sche.restorationIdentifier = "scheCell"
        ta_sche.frame = CGRect(x:32,y:everyones_y,width: viewWidth-40, height: cellSize*CGFloat(scheElts.count))
        let nib = UINib(nibName: "ScheTableViewCell", bundle: nil)
        ta_sche.register(nib, forCellReuseIdentifier: "scheCell")
        ta_sche.dataSource = self
        ta_sche.delegate = self
        ta_sche.layer.cornerRadius = 10
        ta_sche.layer.masksToBounds = true
        everyones_y = everyones_y + (cellSize*CGFloat(scheElts.count)) + 32

        im_news.image = UIImage(named: "ic_background")
        im_news.frame = CGRect(x:8,y:everyones_y,width: viewWidth-16, height: fontSize+20)
        im_news.layer.cornerRadius = 5
        im_news.contentMode = .topLeft
        im_news.layer.masksToBounds = true
        
        shadow_news.frame = CGRect(x:8,y:everyones_y,width: viewWidth-16, height: fontSize+20)
        shadow_news.layer.shadowColor = UIColor.black.cgColor
        shadow_news.layer.shadowOffset = CGSize(width: 3, height: 2)
        shadow_news.layer.shadowOpacity = 0.3
        shadow_news.layer.shadowRadius = 4
        shadow_news.layer.shadowPath = UIBezierPath(roundedRect: im_sche.bounds, cornerRadius: 5).cgPath
        
        lb_news.text = "新着情報"
        lb_news.frame = CGRect(x:24,y:everyones_y+8,width: viewWidth-8, height: fontSize+4)
        lb_news.font = UIFont(name: "HiraKakuProN-W6", size: fontSize)
        lb_news.textColor = .white
        everyones_y = everyones_y + (fontSize+20) + 10

        ta_news.restorationIdentifier = "newsCell"
        ta_news.frame = CGRect(x:32,y:everyones_y,width: viewWidth-40, height: cellSize*CGFloat(newsElts.count))
        let nibs = UINib(nibName: "NewsTableViewCell", bundle: nil)
        ta_news.register(nibs, forCellReuseIdentifier: "newsCell")
        ta_news.dataSource = self
        ta_news.delegate = self
        ta_news.layer.cornerRadius = 10
        ta_news.layer.masksToBounds = true
        everyones_y = everyones_y + (cellSize*CGFloat(newsElts.count)) + 8
        
        mainScroll.contentSize = CGSize(width: viewWidth, height: everyones_y)

        mainScroll.backgroundColor = UIColor.init(white: 1.0, alpha: 0.6)
        mainScroll.addSubview(im_news)
        mainScroll.addSubview(shadow_news)
        mainScroll.addSubview(lb_news)
        mainScroll.addSubview(ta_news)
        mainScroll.addSubview(im_sche)
        mainScroll.addSubview(shadow_sche)
        mainScroll.addSubview(lb_sche)
        mainScroll.addSubview(ta_sche)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView.restorationIdentifier == "newsCell") {
            return newsElts.count
        }else if(tableView.restorationIdentifier == "scheCell"){
            return scheElts.count
        }else{ return 0 }
    }
    
    // Cellの高さを決める
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    //cellに値を設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView.restorationIdentifier == "newsCell") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
            cell.Title.text = newsElts[indexPath.row][3]
            //let date = newsElts[indexPath.row][0].replacingOccurrences(of: ".", with: "/")
            //cell.Date.text = date
            cell.Explanation.text = newsElts[indexPath.row][4]
            return cell
        }else if(tableView.restorationIdentifier == "scheCell"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "scheCell", for: indexPath) as! ScheTableViewCell
            cell.Title.text = scheElts[indexPath.row][5]
            var timeAndCompany: String
            if(scheElts[indexPath.row][1] != "magazine"){ timeAndCompany = "\(scheElts[indexPath.row][3])、\(scheElts[indexPath.row][4])" }
            else{ timeAndCompany = "-" }
            cell.TimeAndCompany.text = timeAndCompany
            if scheElts[indexPath.row][6].isEmpty{scheElts[indexPath.row][6] = "全員"}
            cell.Member.text = scheElts[indexPath.row][6]
            cell.KindImage.image = UIImage(named: "ic_\(scheElts[indexPath.row][1])")
            return cell
        }else{
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        if(tableView.restorationIdentifier == "newsCell") {
            delegate.webHTML = newsElts[indexPath.row][2]
        }else if (tableView.restorationIdentifier == "scheCell"){
            delegate.webHTML = scheElts[indexPath.row][2]
        }
        delegate.fromwhere = "PickUp"
        performSegue(withIdentifier: "pickUpToContent",sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func RefreshArticles() {
        //ここに更新動作
        let delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        delegate.getPickUpInfo()
        ta_news.reloadData()
        ta_sche.reloadData()
        mainScroll.refreshControl?.endRefreshing()
    }
}


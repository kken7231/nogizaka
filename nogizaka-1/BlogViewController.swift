//
//  BlogViewController.swift
//  nogizaka-1
//
//  Created by kentaro on 2018/01/14.
//  Copyright © 2018 kentaro kusumi. All rights reserved.
//

import UIKit

class BlogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var blogInfo = [[String]]()
    @IBOutlet weak var mainView: UIView!
    let blogTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(RefreshArticles), for: UIControlEvents.valueChanged)
        blogTableView.refreshControl = refreshControl
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        blogInfo = delegate.blogInfo
        let nib = UINib(nibName: "BlogTableViewCell", bundle: nil)
        blogTableView.register(nib, forCellReuseIdentifier: "BlogCell")
        blogTableView.restorationIdentifier = "BlogCell"
        blogTableView.frame = CGRect(x:0,y:0, width: mainView.bounds.width, height: mainView.bounds.height)
        blogTableView.dataSource = self
        blogTableView.delegate = self
        mainView.addSubview(blogTableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogInfo.count
    }
    
    // Cellの高さを決める
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    //cellに値を設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlogCell", for: indexPath) as! BlogTableViewCell
        cell.memberPic.image = UIImage(named: "\(blogInfo[indexPath.row][0]).jpg")
        cell.memberPic.layer.cornerRadius = 30
        cell.memberPic.layer.masksToBounds = true
        cell.titleLabel.text = blogInfo[indexPath.row][2]
        let nameAndTime = "\(blogInfo[indexPath.row][0]) \(blogInfo[indexPath.row][4])"
        cell.nameAndTime.text = nameAndTime
        cell.contentLabel.text =  blogInfo[indexPath.row][3]
        cell.comNumLabel.text = blogInfo[indexPath.row][7]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        delegate.webHTML = blogInfo[indexPath.row][1]
        delegate.fromwhere = "Blog"
        performSegue(withIdentifier: "blogToContent",sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func RefreshArticles() {
        //ここに更新動作
        let delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        delegate.getBlogInfo()
        blogTableView.reloadData()
        blogTableView.refreshControl?.endRefreshing()
    }
}

//
//  RootViewController.swift
//  nogizaka-1
//
//  Created by kentaro on 2018/01/13.
//  Copyright © 2018 kentaro kusumi. All rights reserved.
//

import UIKit

class RootViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.view.layoutIfNeeded()
        //ピックアップ画面のデータを更新
        delegate.getPickUpInfo()
        //ブログ画面のデータを更新
        delegate.getBlogInfo()
    }

    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    override func viewDidAppear(_ animated: Bool) {
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "tabbarcon")
        present(nextView, animated: true, completion: nil)
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

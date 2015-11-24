//
//  TransparentNaviBarViewController.swift
//  AdjustableNavigationBar
//
//  Created by Broccoli on 15/11/23.
//  Copyright © 2015年 Broccoli. All rights reserved.
//

import UIKit

class TransparentNaviBarViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.br_setBackgroundColor(UIColor.clearColor())
        tableView.bounces = false
    }
    
    override func viewDidLayoutSubviews() {
        debugPrint(self.tableView.frame)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        scrollViewDidScroll(tableView)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController!.navigationBar.br_reset()
    }
}

private let CellIdentifier = "FirstCell"
extension TransparentNaviBarViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath)
        cell.textLabel!.font = UIFont.systemFontOfSize(24.0)
        cell.textLabel!.text = "我是第\(indexPath.row)行"
        return cell
    }
}

extension TransparentNaviBarViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let color = UIColor.orangeColor()
        let offsetY = scrollView.contentOffset.y
        if offsetY > 0.0 {
            let alpha = 1 - ((0.0 + 64.0 - offsetY) / 64.0)
            
            navigationController!.navigationBar.br_setBackgroundColor(color.colorWithAlphaComponent(alpha))
        } else {
            navigationController!.navigationBar.br_setBackgroundColor(color.colorWithAlphaComponent(0))
        }
    }
}





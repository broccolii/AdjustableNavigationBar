//
//  AdjustableNaviBarViewController.swift
//  AdjustableNavigationBar
//
//  Created by Broccoli on 15/11/24.
//  Copyright © 2015年 Broccoli. All rights reserved.
//

import UIKit

class AdjustableNaviBarViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController!.navigationBar.br_reset()
    }
    
    func setNavigationBarTransformProgress(progress: CGFloat) {
        navigationController!.navigationBar.br_setTranslationY(-44.0 * progress)
        navigationController!.navigationBar.br_setElementsAlpha(1 - progress)
    }
}

private let CellIdentifier = "SecondCell"
extension AdjustableNaviBarViewController: UITableViewDataSource {
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

extension AdjustableNaviBarViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY > 0.0 {
            if offsetY >= 44.0 {
                setNavigationBarTransformProgress(1.0)
            } else {
                setNavigationBarTransformProgress(offsetY / 44.0)
            }
        } else {
            setNavigationBarTransformProgress(0.0)
            navigationController!.navigationBar.backIndicatorImage = UIImage()
        }
    }
}
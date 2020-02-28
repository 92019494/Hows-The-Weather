//
//  PageViewController.swift
//  Hows The Weather
//
//  Created by Anthony on 12/02/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    var pageControl = UIPageControl()
    let weatherStoryboardID = "weatherVC"

    
    lazy var viewControllerList:[UIViewController] = {
    
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = sb.instantiateViewController(identifier: weatherStoryboardID)
        let vc2 = sb.instantiateViewController(identifier: weatherStoryboardID)
        let vc3 = sb.instantiateViewController(identifier: weatherStoryboardID)
        return [vc1,vc2,vc3]
    }()
    var colors = [Constants.primaryColor,Constants.secondaryColor,Constants.supportingColor,Constants.titleColor]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageControl()
        dataSource = self
        delegate = self
        if let firstVC = viewControllerList.first {
            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func configurePageControl() {
           // The total number of pages that are available is based on how many available colors we have.
           pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
           pageControl.backgroundColor = UIColor.green
           pageControl.numberOfPages = viewControllerList.count
           pageControl.currentPage = 0
           pageControl.tintColor = UIColor.black
           pageControl.pageIndicatorTintColor = UIColor.white
           pageControl.currentPageIndicatorTintColor = UIColor.black
           view.addSubview(pageControl)
       }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        let pageContentViewController = pageViewController.viewControllers![0]
        pageControl.currentPage = viewControllerList.firstIndex(of: pageContentViewController)!
      }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //let ranNumber = Int.random(in: 0 ..< colors.count)
        
        guard let vcIndex = viewControllerList.firstIndex(of: viewController) else {return nil}
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else {return nil}
        guard viewControllerList.count > previousIndex else {return nil}
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.firstIndex(of: viewController) else {return nil}
        let nextIndex = vcIndex + 1
        guard viewControllerList.count != nextIndex else {return nil}
        guard viewControllerList.count > nextIndex else {return nil}
        return viewControllerList[nextIndex]
    }
    

}

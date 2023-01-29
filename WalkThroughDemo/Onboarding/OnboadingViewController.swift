//
//  OnboadingViewController.swift
//  WalkThroughDemo
//
//  Created by Taichi Yuki on 2023/01/25.
//

import UIKit

protocol Applicable {}
extension Applicable {
  func with(block: (Self) -> Void) -> Self {
    block(self)
    return self
  }
}
extension NSObject: Applicable {}



// MARK: -
final class OnboardingViewController: UIViewController, UIPageViewControllerDelegate {
  private lazy var skipButton = UIBarButtonItem(title: "スキップ", style: .plain, target: self, action: nil)
  private lazy var progressBar = UIProgressView().with { bar in
    bar.progressTintColor = .red
    bar.backgroundColor = .gray
  }
  private lazy var pageViewController = UIPageViewController()
  private lazy var pages: [UIViewController & OnboardingContentable] = [
    FirstViewController(), SecondViewController(), ThirdViewController()
  ]
  private var currentPageIndex: Int = 0

  override func viewDidLoad() {
    super.viewDidLoad()

    initializeViews()
  }

  private func initializeViews() {
    navigationItem.rightBarButtonItem = skipButton

    addChild(pageViewController)
    view.addSubview(pageViewController.view)
    pageViewController.didMove(toParent: self)
    pageViewController.delegate = self

    view.addSubview(progressBar)
    progressBar.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.left.right.equalToSuperview()
      make.height.equalTo(8)
    }
    pageViewController.view.snp.makeConstraints { make in
      make.top.equalTo(progressBar.snp.bottom)
      make.left.right.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }

    progressBar.setProgress(0.3, animated: true)
    pageViewController.setViewControllers([pages[currentPageIndex]], direction: .forward, animated: true)
  }
}

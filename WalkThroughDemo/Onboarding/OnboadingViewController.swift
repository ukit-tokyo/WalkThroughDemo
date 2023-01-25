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
final class OnboardingViewController: UIViewController {
  private lazy var skipButton = UIBarButtonItem(title: "スキップ", style: .plain, target: self, action: nil)
  private lazy var progressBar = UIProgressView().with { bar in
    bar.progressTintColor = .red
    bar.backgroundColor = .gray
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.rightBarButtonItem = skipButton

    view.addSubview(progressBar)
    progressBar.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.left.right.equalToSuperview()
      make.height.equalTo(8)
    }

    progressBar.setProgress(0.3, animated: true)
  }
}

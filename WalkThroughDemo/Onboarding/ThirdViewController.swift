//
//  ThirdViewController.swift
//  WalkThroughDemo
//
//  Created by Taichi Yuki on 2023/01/25.
//

import UIKit

final class ThirdViewController: UIViewController, OnboardingContentable {
  override func viewDidLoad() {
    super.viewDidLoad()

    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 20)
    label.text = "Third"

    view.backgroundColor = .magenta
    view.addSubview(label)
    label.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
}


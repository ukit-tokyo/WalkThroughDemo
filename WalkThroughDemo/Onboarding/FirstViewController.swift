//
//  FirstViewController.swift
//  WalkThroughDemo
//
//  Created by Taichi Yuki on 2023/01/25.
//

import UIKit

protocol OnboardingContentable where Self: UIViewController {}

final class FirstViewController: UIViewController, OnboardingContentable {
  override func viewDidLoad() {
    super.viewDidLoad()

    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 20)
    label.text = "First"

    view.backgroundColor = .yellow
    view.addSubview(label)
    label.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
}

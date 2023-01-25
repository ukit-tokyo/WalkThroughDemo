//
//  ViewController.swift
//  WalkThroughDemo
//
//  Created by Taichi Yuki on 2023/01/25.
//

import UIKit
import SnapKit
import ReactiveKit
import Bond

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let button = UIButton()
    button.backgroundColor = .orange
    button.layer.cornerRadius = 8
    button.layer.masksToBounds = true
    button.setTitle("Welcome onboard", for: .normal)

    view.addSubview(button)
    button.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.height.equalTo(44)
    }

    button.reactive.tap
      .bind(to: self) { me, _ in
        let vc = OnboardingViewController()
        me.navigationController?.pushViewController(vc, animated: true)
      }
  }
}


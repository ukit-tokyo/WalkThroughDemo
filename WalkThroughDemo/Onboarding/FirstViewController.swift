//
//  FirstViewController.swift
//  WalkThroughDemo
//
//  Created by Taichi Yuki on 2023/01/25.
//

import UIKit
import ReactiveKit

enum OnboardingStep: Int, CaseIterable {
  case first, second, third
}

protocol OnboardingContentable where Self: UIViewController {
  var step: OnboardingStep { get }
  var onNext: Subject<Void, Never> { get }
}

final class FirstViewController: UIViewController, OnboardingContentable {
  var step: OnboardingStep { .first }
  let onNext = Subject<Void, Never>()

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

    let button = UIButton()
    button.setTitle("Next", for: .normal)
    button.backgroundColor = .gray
    button.titleLabel?.font = .boldSystemFont(ofSize: 20)
    button.setTitleColor(.white, for: .normal)

    view.addSubview(button)
    button.snp.makeConstraints { make in
      make.top.equalTo(label.snp.bottom).offset(16)
      make.centerX.equalToSuperview()
      make.height.equalTo(40)
      make.width.equalTo(100)
    }
    button.reactive.tap
      .bind(to: self) { me, _ in
        me.onNext.send(())
      }
  }
}

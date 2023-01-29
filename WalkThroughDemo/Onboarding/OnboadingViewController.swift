//
//  OnboadingViewController.swift
//  WalkThroughDemo
//
//  Created by Taichi Yuki on 2023/01/25.
//

import UIKit
import Bond

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
  private lazy var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
  private lazy var pages: [UIViewController & OnboardingContentable] = [
    FirstViewController(), SecondViewController(), ThirdViewController()
  ]
  private let currentStep = Observable<OnboardingStep>(.first)

  override func viewDidLoad() {
    super.viewDidLoad()

    initializeViews()
    initializeBinding()
  }

  private func initializeViews() {
    navigationItem.rightBarButtonItem = skipButton

    addChild(pageViewController)
    view.addSubview(pageViewController.view)
    pageViewController.didMove(toParent: self)

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
  }

  private func initializeBinding() {
    skipButton.reactive.tap
      .bind(to: self) { me, _ in
        let nextIndex = me.currentStep.value.rawValue + 1
        if let nextStep = OnboardingStep(rawValue: nextIndex) {
          me.showStep(to: nextStep, direction: .forward)
        }
      }

    currentStep
      .map { step in // 現在のステップをプログレスバーの進捗率に変換
        (1.0 / Float(OnboardingStep.allCases.count + 1)) * Float(step.rawValue + 1)
      }
      .bind(to: self) { me, progress in
        me.progressBar.setProgress(progress, animated: true)
      }
  }

  private func showStep(to step: OnboardingStep, direction: UIPageViewController.NavigationDirection) {
    guard let nextPage = pages.first(where: { $0.step == step }) else { return }
    pageViewController.setViewControllers([nextPage], direction: direction, animated: true)
    currentStep.send(step)
  }
}

//
//  Extension+UIView.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 03/02/22.
//

import UIKit.UIView

extension UIView {
    static var nib: UINib {
       return UINib(nibName: "\(self)", bundle: nil)
    }

    static func instantiateFromNib() -> Self? {
       return nib.instantiate() as? Self
    }
    
    enum LoadingPosition {
        case top
        case center
    }

    static let loadingViewTag = 283982932
    static let loadingOverlayViewTag = 827162616

    func hideLoading() {
        let loadingIndicator = self.viewWithTag(UIView.loadingViewTag)
        let overlayView = self.viewWithTag(UIView.loadingOverlayViewTag)
        loadingIndicator?.removeFromSuperview()
        overlayView?.removeFromSuperview()
    }

    func showLoading(
        position: LoadingPosition = .center,
        withOverlay: Bool = false,
        style: UIActivityIndicatorView.Style = .medium
    ) {
        hideLoading()

        // overlay
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlay.tag = UIView.loadingOverlayViewTag
        if withOverlay {
            self.addSubview(overlay)
            overlay.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                overlay.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                overlay.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                overlay.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                overlay.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ])
        }

        let loadingContainer = UIView()
        loadingContainer.tag = UIView.loadingViewTag
        self.addSubview(loadingContainer)
        loadingContainer.translatesAutoresizingMaskIntoConstraints = false
        switch position {
        case .top:
            NSLayoutConstraint.activate([
                loadingContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
                loadingContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
                loadingContainer.heightAnchor.constraint(equalToConstant: 40),
                loadingContainer.widthAnchor.constraint(equalToConstant: 40)
            ])
        case .center:
            NSLayoutConstraint.activate([
                loadingContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
                loadingContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
                loadingContainer.heightAnchor.constraint(equalToConstant: 40),
                loadingContainer.widthAnchor.constraint(equalToConstant: 40)
            ])
        }

        // add default activity indicator
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.startAnimating()
        loadingContainer.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension UINib {
   func instantiate() -> Any? {
      return instantiate(withOwner: nil, options: nil).first
   }
}

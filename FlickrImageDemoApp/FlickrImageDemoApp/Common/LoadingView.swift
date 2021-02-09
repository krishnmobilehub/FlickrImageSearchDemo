//
//  LoadingView.swift
//  FlickrImageDemoApp
//
//  Created by Dev on 2021-02-09.
//


import UIKit

public class LoadingView {

    internal static var spinner: UIActivityIndicatorView?

    public static func show() {
        DispatchQueue.main.async {
            NotificationCenter.default.addObserver(self, selector: #selector(update), name: UIDevice.orientationDidChangeNotification, object: nil)
            if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
                if spinner == nil {
                    let frame = UIScreen.main.bounds
                    let spinner = UIActivityIndicatorView(frame: frame)
                    spinner.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                    spinner.style = .large
                    window.addSubview(spinner)
                    spinner.startAnimating()
                    self.spinner = spinner
                }
            }
        }
    }

    public static func hide() {
        DispatchQueue.main.async {
            guard let spinner = spinner else { return }
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            self.spinner = nil
        }
    }

    @objc public static func update() {
        DispatchQueue.main.async {
            if spinner != nil {
                hide()
                show()
            }
        }
    }
}

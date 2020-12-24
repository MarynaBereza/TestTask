//
//  ViewController.swift
//  TestTask
//
//  Created by Maryna Bereza on 12/23/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var textLabel: UILabel!
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    var objectsArray = [ObjectAPIModel]()
    var index = 0
    
    @IBAction func buttonNext(_ sender: UIButton) {
        
        if index < objectsArray.count - 1 {
            index = index + 1
        } else if (index == objectsArray.count - 1) {
            index = 0
        }
        self.activityIndicator.startAnimating()
        
        ServerManager.fetchRequestObject(with: objectsArray[index].id) { [weak self](object) in
            
            guard let `self` = self else {
                return
            }
            if object.isText {
                self.fillTextLabel(object: object)
                
            } else {
                self.fillWebView(object: object)
            }
            self.activityIndicator.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        
        webView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        ServerManager.fetchRequestObjectsList { [weak self](objects) in
            self?.objectsArray = objects
            
            guard let first = objects.first else {
                return
            }
            
            ServerManager.fetchRequestObject(with: first.id) { (object) in
                
                if object.isText {
                    self?.fillTextLabel(object: object)
                } else {
                    self?.fillWebView(object: object)
                }
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    // MARK: - Methods
    func fillTextLabel(object: ObjectTypeAPIModel) {
        textLabel.isHidden = false
        webView.isHidden = true
        textLabel.text = object.value
    }
    
    func fillWebView(object: ObjectTypeAPIModel) {
        webView.isHidden = false
        textLabel.isHidden = true
        webView.load(NSURLRequest(url: URL(string: object.value)! as URL) as URLRequest)
    }
}


//
//  IngredientsViewController.swift
//  expchef
//
//  Created by Colin To on 2022-04-20.
//

import UIKit
import SwiftUI

class IngredientsViewController: UIViewController{

    fileprivate let contentViewinHC = UIHostingController(rootView: MapSwiftUIView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHC()
        
        let navBarHeight = UIApplication.shared.statusBarFrame.size.height + (navigationController?.navigationBar.frame.height ?? 0.0)
        setupConstraints(navHeight: navBarHeight)
    }
    
    fileprivate func setupConstraints(navHeight: CGFloat){
        contentViewinHC.view.translatesAutoresizingMaskIntoConstraints = false
        contentViewinHC.view.heightAnchor.constraint(equalToConstant: 400).isActive = true
        contentViewinHC.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        contentViewinHC.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        contentViewinHC.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        contentViewinHC.view.layoutMargins = UIEdgeInsets(top:40,
                                                          left:self.view.layoutMargins.left,
                                                          bottom:0,
                                                          right:self.view.layoutMargins.right)
        contentViewinHC.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

    }
    
    fileprivate func setupHC(){
        addChild(contentViewinHC)
        view.addSubview(contentViewinHC.view)
        contentViewinHC.didMove(toParent: self)
    }
}

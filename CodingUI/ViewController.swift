//
//  ViewController.swift
//  CodingUI
//
//  Created by Jorge MR on 01/11/17.
//  Copyright © 2017 jorge Mtz R. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let marioImageView : UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "MarioYoshi"))
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    let descriptionTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string: "Mario and Yoshi are better friends!", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: "\n\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce id fringilla magna, condimentum eleifend justo. Sed justo ante, auctor at porta at, dignissim gravida enim. Lorem ipsum dolor sit amet, consectetur adipiscing elit.", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(descriptionTextView)
        setupLayout()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func setupLayout(){
        
        let topImageContainerView = UIView()
        topImageContainerView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        view.addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageContainerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        topImageContainerView.addSubview(marioImageView)

        //Mario ImageView Constraints
        marioImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        marioImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        marioImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        marioImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true

        //Description TextView constraints
        descriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


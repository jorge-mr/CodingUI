//
//  SwipingController.swift
//  CodingUI
//
//  Created by Jorge MR on 07/12/17.
//  Copyright © 2017 jorge Mtz R. All rights reserved.
//

import UIKit

class SwipingController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages = [
        Page(imageName: "Yoshi", headerText: "Mario and Yoshi are better friends", bodyText: "Ccondimentum eleifend justo. Sed justo ante, auctor at porta at, dignissim gravida enim. Lorem ipsum dolor sit amet, consectetur adipiscing elit." ),
        Page(imageName: "caparazon", headerText: "Mario is gonna drop that shell", bodyText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce id fringilla magna, condimentum eleifend justo. Sed justo ante, auctor at." ),
        Page(imageName: "luigi", headerText: "Mario and Luigi are better friends", bodyText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit." ),
        Page(imageName: "fox", headerText: "Mario is wearing a fox suit", bodyText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        //.register agrega un tipo de cellda al collectionView
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView?.isPagingEnabled = true
        setupBottonControls()
    }
    
    private let previousButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return button
    }()
    
    @objc private func handlePrevious(){
        let nextIndex = max(pageControl.currentPage - 1, 0)
        pageControl.currentPage = nextIndex
        let indexPath = IndexPath(item: nextIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private let nextButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainPink, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleNext(){
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        pageControl.currentPage = nextIndex
        let indexPath = IndexPath(item: nextIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private lazy var pageControl : UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.pageIndicatorTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        pc.currentPageIndicatorTintColor = .mainPink
        return pc
    }()
    
    fileprivate func setupBottonControls(){
        //view.addSubview(previousButton)
        let yellowView = UIView()
        yellowView.backgroundColor = .yellow
        let blueView = UIView()
        blueView.backgroundColor = .blue
        let greenView = UIView()
        greenView.backgroundColor = .green
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton,pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        bottomControlsStackView.axis = .horizontal
        
        view.addSubview(bottomControlsStackView)
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        cell.page = page
        
        return cell
    }
    
    //MARK:-- UICollectionViewDelegateFlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
        //REGRESA el tamaño de cada celda
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        //REGRESA el tamaño de separación entre cada celda
    }
    
    //ACTUALIZA el page control cuando se hace el drag en el scroll
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        //print(x, view.frame.width, x / view.frame.width)
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            //if por si se traba en la primer celda
            if self.pageControl.currentPage == 0 {
                self.collectionView?.contentOffset = .zero
            }else{
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }) { (_) in
            
        }
    }
    
    
    
    
    
}

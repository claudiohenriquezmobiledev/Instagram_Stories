//
//  IGHomeView.swift
//  InstagramStories
//
//  Created by  Boominadha Prakash on 01/11/17.
//  Copyright © 2017 DrawRect. All rights reserved.
//

import Foundation
import UIKit

protocol IGHomeViewDelegate: AnyObject {
    func callToIGStoryPreviewController(stories: [IGStory],
                                        videoIsMuted: Bool,
                                        handPickedStoryIndex:  Int,
                                        handPickedSnapIndex: Int)
}

public class IGHomeView: UIView {
    
    private var viewModel: IGHomeViewModel = IGHomeViewModel()
    private var stories: IGStories?
    weak var delegate: IGHomeViewDelegate?
    private var videoIsMuted: Bool = true
    
    //MARK: - iVars
    lazy var layout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(IGStoryListCell.self, forCellWithReuseIdentifier: IGStoryListCell.reuseIdentifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    //MARK: - Overridden functions
    public init(stories: IGStories?, videoIsMuted: Bool) {
        self.stories = stories
        self.videoIsMuted = videoIsMuted
        super.init(frame: .zero)
//        backgroundColor = UIColor.rgb(from: 0xEFEFF4)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        createUIElements()
        installLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private functions
    private func createUIElements(){
        addSubview(collectionView)
    }
    private func installLayoutConstraints(){
        NSLayoutConstraint.activate([
            igLeftAnchor.constraint(equalTo: collectionView.igLeftAnchor),
            igTopAnchor.constraint(equalTo: collectionView.igTopAnchor),
            collectionView.igRightAnchor.constraint(equalTo: igRightAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100)])
                    
    }
}

//MARK: - Extension|UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension IGHomeView: UICollectionViewDelegate,UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        debugPrint(viewModel.numberOfItemsInSection(section))
        return viewModel.numberOfItemsInSection(section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IGStoryListCell.reuseIdentifier,for: indexPath) as? IGStoryListCell else { fatalError() }
        let story = viewModel.cellForItemAt(indexPath: indexPath)
        cell.story = story
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       DispatchQueue.main.async {
           if let stories_copy = try? self.stories?.copy().stories {
               self.delegate?.callToIGStoryPreviewController(stories: stories_copy,
                                                             videoIsMuted: self.videoIsMuted,
                                                        handPickedStoryIndex:  indexPath.row, handPickedSnapIndex: 0)
            }
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return indexPath.row == 0 ? CGSize(width: 100, height: 100) : CGSize(width: 80, height: 100)
    }
}



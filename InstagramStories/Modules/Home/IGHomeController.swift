//
//  IGHomeController.swift
//  InstagramStories
//
//  Created by Ranjith Kumar on 9/6/17.
//  Copyright © 2017 DrawRect. All rights reserved.
//

import UIKit

fileprivate let isClearCacheEnabled = true
internal var isDeleteSnapEnabled = true

public final class IGHomeController: UIViewController {
    
    //MARK: - iVars
    private var viewModel: IGHomeViewModel = IGHomeViewModel()
    
    public lazy var homeView: IGHomeView = {
        let view = IGHomeView(stories: viewModel.getStories())
        view.delegate = self
        return view
    }()
    //    private var stories: IGStories
    
    //MARK: - Overridden functions
    override public func loadView() {
        super.loadView()
        view = homeView
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension IGHomeController: IGHomeViewDelegate {
    func callToIGStoryPreviewController(stories: [IGStory], handPickedStoryIndex: Int, handPickedSnapIndex: Int) {
        let storyPreviewScene = IGStoryPreviewController.init(stories: stories,
                                                              handPickedStoryIndex:  handPickedStoryIndex,
                                                              handPickedSnapIndex: handPickedSnapIndex)
        self.present(storyPreviewScene, animated: true, completion: nil)
    }
}

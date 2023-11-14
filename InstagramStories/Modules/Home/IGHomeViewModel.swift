//
//  IGHomeViewModel.swift
//  InstagramStories
//
//  Created by  Boominadha Prakash on 01/11/17.
//  Copyright © 2017 DrawRect. All rights reserved.
//

import Foundation

struct IGHomeViewModel {
    
    //MARK: - iVars
    //Keep it Immutable! don't get Dirty :P
    private let storiesData: IGStories? = {
        do {
            return try IGMockLoader.loadMockFile(named: "stories.json", bundle: .main)
        }catch let e as MockLoaderError {
            debugPrint(e.description)
        }catch{
            debugPrint("could not read Mock json file :(")
        }
        return nil
    }()
    
    //MARK: - Public functions
    public func getStories() -> IGStories? {
        return storiesData
    }
    public func numberOfItemsInSection(_ section:Int) -> Int {
        guard let count = storiesData?.stories.count else { return 0 }
        return count
    }
    public func cellForItemAt(indexPath:IndexPath) -> IGStory? {
        return storiesData?.stories[indexPath.row]
    }
    
}

//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by cyLAB on 2016. 4. 4..
//  Copyright © 2016년 cyLAB. All rights reserved.
//

import Foundation




// target capture, getter, custome init

class Videos {
    
    // data encap, capture target
    private var _vName:String
    private var _vImageUrl:String
    private var _vVideoUrl:String
    
    // getter
    var vName: String {
        return _vName
    }
    var vImageUrl: String {
        return _vImageUrl
    }
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    
    
    init(data: JSONDictionary) {
        
        
        // video name
        // json: object{1}/feed{8}/author{2}_entry[10]_...
        // entry[10]/0{11}/im:name{1}/label
        
        if let name = data["im:name"] as? JSONDictionary,
            vName = name["label"] as? String {
                self._vName = vName
        } else {
            _vName = ""
        }
        
        
        
        // video image
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            immage = image["label"] as? String {
                _vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            _vImageUrl = ""
        }
        
        
        
        // video url
        if let video = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String {
                self._vVideoUrl = vVideoUrl
        } else {
            _vVideoUrl = ""
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}
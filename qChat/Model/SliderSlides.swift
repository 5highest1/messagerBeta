//
//  SliderSlides.swift
//  qChat
//
//  Created by Highest on 15.10.2024.
//

import Foundation
class SliderSlides{
    var slides:[Slides] = []
    
    func getSlides()->[Slides] {
        let slide1 = Slides(text: "text1", img: .glassObjectGreenBackground)
        
        slides.append(slide1)
        
        return slides
    }
}

//
//  AnalysisPoint5Value.swift
//  UV_INTENCITY_METER
//
//  Created by youjin on 14/10/2019.
//  Copyright © 2019 youjin. All rights reserved.
//

class AnalysisPoint5Value{
   
    var id: Int
    var title: String?
    var uvsensor: Double
    var temp: Double
    var humidity: Double
    var point1: Double
    var point2: Double
    var point3: Double
    var point4: Double
    var point5: Double
    var average: Double
    var uni: Double
    
    init(id: Int, title: String?, uvsensor: Double, temp: Double, humidity: Double, point1: Double, point2: Double, point3: Double, point4: Double, point5: Double, average: Double, uni: Double){
        self.id = id
        self.title = title
        self.uvsensor = uvsensor
        self.temp = temp
        self.humidity = humidity
        self.point1 = point1
        self.point2 = point2
        self.point3 = point3
        self.point4 = point4
        self.point5 = point5
        self.average = average
        self.uni = uni
    }
}

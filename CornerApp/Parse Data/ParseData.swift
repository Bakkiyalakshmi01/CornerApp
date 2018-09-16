//
//  ParseData.swift
//  CornerApp
//
//  Created by Karthik Lakshmanan on 14/09/2018.
//  Copyright © 2018 Bakkiya. All rights reserved.
//

import Foundation

class ParseData {
    
    var wsbfvl_round  = WSBFvl_Round()
    func requestData(completion: ((_ data: WSBFvl_Round) -> Void)) {
        
        if let path = Bundle.main.path(forResource: "WSBFvI_Round1", ofType: "csv") {
           do {
            let data = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
             var parsedCSV: [[String:CustomStringConvertible]] = data
                .components(separatedBy: "\n")
                .map({
                    var result = [String: CustomStringConvertible]()
                    for (index, val) in $0.components(separatedBy: ",").enumerated() {
                        let value = val.replacingOccurrences(of: "\r", with: "", options: .regularExpression)
                        if(index == 0) {
                            result["ts"] = value
                        }else if(index == 1) {
                            result["punch_type_id"] = Int(value)
                        } else if(index == 2) {
                            result["speed_mph"] = Double(value)
                        } else if(index == 3) {
                            result["power_g"] = Double(value)
                        }
                    }
                    return result
                })
            parsedCSV.remove(at: 0)
            for eachArray in parsedCSV{
                let tsStr = (eachArray["ts"] as? String)!
                wsbfvl_round.ts.append(tsStr)
                let Id = (eachArray["punch_type_id"] as? Int)!
                wsbfvl_round.punch_type_id.append(Id)
                let speed = (eachArray["speed_mph"] as? Double)!
                wsbfvl_round.speed_mph.append(speed)
                let power = (eachArray["power_g"] as? Double)!
                wsbfvl_round.power_g.append(power)
            }
            
            wsbfvl_round.totalPunches = wsbfvl_round.punch_type_id.reduce(0,+)
            wsbfvl_round.avgSpeed = (wsbfvl_round.speed_mph.reduce(0, +))/Double(wsbfvl_round.speed_mph.count)
            wsbfvl_round.avgSpeed = (wsbfvl_round.avgSpeed * 10).rounded()/10
            wsbfvl_round.avgPower = (wsbfvl_round.power_g.reduce(0,+))/Double(wsbfvl_round.power_g.count)
            wsbfvl_round.avgPower = (wsbfvl_round.avgPower * 10).rounded()/10
        }catch _ as NSError {
            print("No CSV file found")
        }
        completion(wsbfvl_round)
        }
     }
    
}



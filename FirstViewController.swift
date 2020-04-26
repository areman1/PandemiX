//
//  FirstViewController.swift
//  PandemiX
//
//  Created by Abhinav Emani on 4/26/20.
//  Copyright © 2020 Abhinav Emani. All rights reserved.
//

import UIKit

var statsPage = 0
// 0 is america
//1 is global

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
}
class RoudView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
}

@IBDesignable
public class AngleView: UIView {

    @IBInspectable public var fillColor: UIColor = .blue { didSet { setNeedsLayout() } }

    var points: [CGPoint] = [
        .zero,
        CGPoint(x: 1, y: 0),
        CGPoint(x: 1, y: 1),
        CGPoint(x: 0, y: 0.5)
    ] { didSet { setNeedsLayout() } }

    private lazy var shapeLayer: CAShapeLayer = {
        let _shapeLayer = CAShapeLayer()
        self.layer.insertSublayer(_shapeLayer, at: 0)
        return _shapeLayer
    }()

    override public func layoutSubviews() {
        shapeLayer.fillColor = fillColor.cgColor

        guard points.count > 2 else {
            shapeLayer.path = nil
            return
        }

        let path = UIBezierPath()

        path.move(to: convert(relativePoint: points[0]))
        for point in points.dropFirst() {
            path.addLine(to: convert(relativePoint: point))
        }
        path.close()

        shapeLayer.path = path.cgPath
    }

    private func convert(relativePoint point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x * bounds.width + bounds.origin.x, y: point.y * bounds.height + bounds.origin.y)
    }
}

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    
    }
     @IBAction func ReadLiveData(_ sender: Any) {
        var data = readDataFromCSV(fileName: "Datasheet", fileType: "csv")
        data = cleanRows(file: data!)
        let csvRows = csv(data: data!)
        print(csvRows[0][0]) // UXM n. 166/167
    }
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ";")
            result.append(columns)
        }
        return result
    }
    
   func readDataFromCSV(fileName:String, fileType: String)-> String!{
           guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
               else {
                   return nil
           }
           do {
               var contents = try String(contentsOfFile: filepath, encoding: .utf8)
               contents = cleanRows(file: contents)
               return contents
           } catch {
               print("File Read Error for file \(filepath)")
               return nil
           }
       }


   func cleanRows(file:String)->String{
       var cleanFile = file
       cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
       cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
       //        cleanFile = cleanFile.replacingOccurrences(of: ";;", with: "")
       //        cleanFile = cleanFile.replacingOccurrences(of: ";\n", with: "")
       return cleanFile
   }

    @IBOutlet weak var affected: UILabel!
    @IBOutlet weak var deaths: UILabel!
    @IBOutlet weak var active: UILabel!
    @IBOutlet weak var serious: UILabel!
    @IBOutlet weak var recovered: UILabel!
    
    @IBAction func changeScope(_ sender: Any) {
        if (statsPage == 0){
            affected.text = "3,371,935"
            deaths.text = "235,957"
            active.text = "2,092,110"
            serious.text = "923,868"
            recovered.text = "71,553"
            statsPage = 1
        } else {
            affected.text = "1,012,798"
            deaths.text = "58,941"
            active.text = "852,224"
            serious.text = "158,633"
            recovered.text = "16,116"
            statsPage = 0
        }
    }
    //api rest http request covid19 api
    @IBAction func getRealLiveData(_ sender: Any) {
        guard let url = URL(string: "https://api.covid19api.com/dayone/country/united-states/status/confirmed") else {return}
            
            let session = URLSession.shared
            session.dataTask(with: url) { (data, response, error) in
                if let response = response {
                    //print(response)
                }
                if let data = data{
                    //print(data)
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) //as? [String: Any]
                        //print(json)
                        if let dictionary = json as? [String: Any] {
                            //print(dictionary)
                            guard let array = dictionary["Countries"] as? [Array<Any>] else {
                               return
                            }
                            print(array[1])
                            guard let arraynew = array[1] as? Array<Any> else {
                               return
                            }
                            print(arraynew[0])
                            print(arraynew[1])
                            print(arraynew[2])
                            print(arraynew[3])
                            
                            
                            //self.lighAPI.text = data as? String
                            
                            if let number = dictionary["values"] as? Double {
                                //print(number)
                                
        
                            }
                            
                            for (key, value) in dictionary {
                                //print(key)
                                //print(value)
                            }
                            
                            if let nestedDictionary = dictionary["anotherKey"] as? [String: Any] {
                                
                            }
                        }
                       
                        
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        
        
    }
    
}


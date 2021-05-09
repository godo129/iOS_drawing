//
//  ViewController.swift
//  drawing
//
//  Created by comsoft on 2021/05/07.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch // 현재 발생하 터치 이벤트 가지고 옴
        lastPoint = touch.location(in: imgView) // 터치된 위치를 lastPoint라는 변수에 저장
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)//라인의 끝 모양을 라운드로 설정합니다
        let touch = touches.first! as UITouch // 현재 발생한 터치 이벤트 가져옴
        let currPoint = touch.location(in: imgView)
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x , y: lastPoint.y)) //// 이전에 이동된 위치인 lastPoint로 시작 위치를 이동
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y)) // lastPoint에서 현재 위치는 currentPoint까지 선을 추가합니다
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        lastPoint = currPoint// 현재 터치된 위치를 lastPoint라는 변수에 할당됩니다
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize) // 라인의 끝 모양을 라운드로 설정
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0 , width: imgView.frame.size.width, height: imgView.frame.size.height))
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) // 이전에 이동된 위치인 lastPoint로 시작 위치를 이동시킵니다
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) // lastPoint에서 현재 위치는 currentPoint까지 선을 추가합니다
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    
    
    var lastPoint : CGPoint! // 바로 전에 터치하거나 이동한 위치
    var lineSize : CGFloat = 2.0 // 선의 두께
    var lineColor = UIColor.red.cgColor // 선의 색상
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clearimgView(_ sender: UIButton) {
        
        imgView.image = nil
    }
    
}


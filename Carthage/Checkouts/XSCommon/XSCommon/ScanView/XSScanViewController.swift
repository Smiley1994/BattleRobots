//
//  XSScanViewController.swift
//  XSCommon
//
//  Created by Good_Morning_ on 2018/7/2.
//  Copyright © 2018年 GoodMorning. All rights reserved.
//

import UIKit
import AVFoundation

class XSScanViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    let cameraView = XSScanBackgroundView(frame: UIScreen.main.bounds)
    let captureSession = AVCaptureSession()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.scannerStart()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Scan`s";
        self.view.backgroundColor = UIColor.clear
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.view.addSubview(cameraView)
        
        //初始化捕捉设备（AVCaptureDevice），类型AVMdeiaTypeVideo
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        let input :AVCaptureDeviceInput
        
        //创建媒体数据输出流
        let output = AVCaptureMetadataOutput()
        
        //捕捉异常
        do{
            //创建输入流
            input = try AVCaptureDeviceInput(device: captureDevice!)
            
            //把输入流添加到会话
            captureSession.addInput(input)
            
            //把输出流添加到会话
            captureSession.addOutput(output)
        }catch {
            print("异常")
        }
        
        //创建串行队列
        let dispatchQueue = DispatchQueue(label: "queue", attributes: [])
        
        //设置输出流的代理
        output.setMetadataObjectsDelegate(self, queue: dispatchQueue)
        
        //设置输出媒体的数据类型
        output.metadataObjectTypes = [.ean8, .ean13, .pdf417, .upce]
        
        //创建预览图层
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        //设置预览图层的填充方式
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        //设置预览图层的frame
        videoPreviewLayer.frame = cameraView.bounds
        
        //将预览图层添加到预览视图上
        cameraView.layer.insertSublayer(videoPreviewLayer, at: 0)
        
        //设置扫描范围
        output.rectOfInterest = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        
    }
    
    //扫描代理方法
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects != nil && metadataObjects.count > 0 {
            let metaData : AVMetadataMachineReadableCodeObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            
            print(metaData.stringValue!)
            
            DispatchQueue.main.async(execute: {
                
                if #available(iOS 10, *){
                    UIApplication.shared.open(URL(string: metaData.stringValue!)!, options: [:], completionHandler: {(success) in});
                }else{
                    UIApplication.shared.openURL(URL(string: metaData.stringValue!)!);
                }
            })
            captureSession.stopRunning()
        }
        
    }
    
    //从相册中选择图片
    func selectPhotoFormPhotoLibrary(_ sender : AnyObject){
        let picture = UIImagePickerController()
        picture.sourceType = UIImagePickerControllerSourceType.photoLibrary
        picture.delegate = self
        self.present(picture, animated: true, completion: nil)
        
    }
    //选择相册中的图片完成，进行获取二维码信息
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage]
        
        let imageData = UIImagePNGRepresentation(image as! UIImage)
        
        let ciImage = CIImage(data: imageData!)
        
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow])
        
        let array = detector?.features(in: ciImage!)
        
        let result : CIQRCodeFeature = array!.first as! CIQRCodeFeature
        //        let resultView = WebViewController()
        //        resultView.url = result.messageString
        //        self.navigationController?.pushViewController(resultView, animated: true)
        picker.dismiss(animated: true, completion: nil)
        print(result.messageString ?? String())
        
    }
    
    func scannerStart(){
        captureSession.startRunning()
        cameraView.scanning = "start"
    }
    
    func scannerStop() {
        captureSession.stopRunning()
        cameraView.scanning = "stop"
    }

}

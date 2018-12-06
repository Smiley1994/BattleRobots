//
//  ANN9JoinVipViewController.swift
//  BattleRobots
//
//  Created by 晓松 on 2018/6/20.
//  Copyright © 2018年 ann9. All rights reserved.
//

import UIKit
import SwiftyJSON
import StoreKit

class ANN9JoinVipViewController: UIViewController,SKProductsRequestDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "激活会员"
        createUI()
    }

    
    func createUI() {


        let headerView = ANN9JoinVipHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: fit(120)))
        headerView.backButton.addTarget(self, action: #selector(pop), for: .touchUpInside)
        self.view.addSubview(headerView)
        
        let vipRight = ANN9VIPRightView()
        self.view.addSubview(vipRight)
        vipRight.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(14)
            make.right.equalTo(self.view.snp.right).inset(14)
            make.top.equalTo(self.view.snp.top).offset(isX ? 90 : 78)
            make.height.equalTo(120)
        }
        
        let vipPrice = ANN9VIPPriceView()
        self.view.addSubview(vipPrice)
        vipPrice.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(14)
            make.right.equalTo(self.view.snp.right).inset(14)
            make.top.equalTo(vipRight.snp.bottom).offset(15)
            make.height.equalTo(160)
        }
        
        
        let configButton = UIButton(type: .custom)
        configButton.layer.cornerRadius = 45 / 2
        configButton.setTitle("立即开通", for: .normal)
//        configButton.setImage(UIImage(named: "icon_vip_Button"), for: .normal)
        configButton.backgroundColor = UIColor.hexColor(hexString: "7d30d9")
        configButton.addTarget(self, action: #selector(becomeVIP), for: .touchUpInside)
        self.view.addSubview(configButton)
        configButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(vipPrice.snp.bottom).offset(fit(50))
            make.size.equalTo(CGSize(width: ScreenWidth - 120, height: 45))
        }
        
        
        
    }
    
    @objc func becomeVIP() {
        
        if ANN9APP.shareInstace.UserType == IsVIP  {
            showAlert()
        } else {
            requestProductData(productId: InAppPurchaseId1)
        }
    }
    
    /// 内购
    func requestProductData(productId : String) {
//        MBProgressHUD.showMessage()
        let productSet : Set<String> = [productId]
        let request = SKProductsRequest(productIdentifiers: productSet)
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//        MBProgressHUD.hide()
        let productArray = response.products
        if productArray.count == 0 {
            return
        }
        let payment = SKPayment(product: productArray[0])
        
        SKPaymentQueue.default().add(payment)
        
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "您已经是会员了！！",
                                                message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: {
            action in
            print("点击了确定")
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {// 当交易队列里面添加的每一笔交易状态发生变化的时候调用
            switch transaction.transactionState {
            case .deferred:
                print("延迟处理")
            case .failed:
                print("支付失败")
                queue.finishTransaction(transaction)
            case .purchased:
                print("支付成功")
                markVIP(vipType: IsVIP)
                verifyPurchaseWithPayment(appsToreUrlString: AppStoreVerifyReceiptUrl)
                queue.finishTransaction(transaction)
            case .purchasing:
                print("正在支付")
            case .restored:
                print("恢复购买")
                queue.finishTransaction(transaction)
            }
        }
    }
    
    func markVIP(vipType : String) {
        
        do {
            let passwordItems = try KeychainPasswordItem.passwordItems(forService: KeychainConfiguration.serviceName, accessGroup: KeychainConfiguration.accessGroup)
            do {
                if passwordItems.count > 0 {
                    try passwordItems[0].deleteItem()
                }
            }
            catch {
                fatalError("Error deleting keychain item - \(error)")
            }
        }
        catch {
            fatalError("Error fetching password items - \(error)")
        }
        
        //        会员到期时间
        var date : Date!
        
        date = Date(timeIntervalSinceNow: 24 * 60 * 60 * 30 * 12)

        UserDefaults.standard.set(date, forKey: ANN9VIPDate)
        UserDefaults.standard.set(vipType, forKey: ANN9UserType)
        ANN9APP.shareInstace.UserType = vipType
        ANN9APP.shareInstace.InvalidVipDateFormate = date.formateTime()
        do {
            if vipType == IsVIP {
                var userItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: vipType, accessGroup: KeychainConfiguration.accessGroup)
                // Update the account name and password.
                try userItem.renameAccount(vipType)
                try userItem.savePassword(date.formateTime())
            } else {
                let userItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: vipType, accessGroup: KeychainConfiguration.accessGroup)
                // Save the password for the new item.
                try userItem.savePassword(date.formateTime())
            }
            
        } catch  {
            
        }
    }
    
    func verifyPurchaseWithPayment(appsToreUrlString : String) {
        let receiptUrl = Bundle.main.appStoreReceiptURL
        do {
            let receipt = try Data(contentsOf: receiptUrl!)
            
            let base64EncodeString = receipt.base64EncodedString()
            let requestContents = ["receipt-data" : base64EncodeString ,
                                   "password" : InAppPurchaseKey] as [String : Any]
            
            do {
                let requestJsonData = try JSONSerialization.data(withJSONObject: requestContents, options: [])
                let session = URLSession.shared
                let request = NSMutableURLRequest(url: URL(string: appsToreUrlString)!)
                request.httpMethod = "POST"
                request.httpBody = requestJsonData
                let dataTask = session.dataTask(with: request as URLRequest) { (data, response, err) in
                    let json = JSON(data!)
                    
                    if json["status"].number == 21007 {
                        self.verifyPurchaseWithPayment(appsToreUrlString: SandBoxVerifyReceiptUrl)
                    }
                    
                    if json["status"].number == 0 {

                    }
                    
                }
                
                dataTask.resume()
                
            } catch {
                return
            }
        } catch  {
            return
        }
    }
    
    
    @objc func pop() {
        self.navigationController?.popViewController(animated: true)
    }

}

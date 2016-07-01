//
//  ViewController.swift
//  ShareExtentionTest2
//
//  Created by bc0067042 on 2016/06/30.
//  Copyright © 2016年 maru.ishi. All rights reserved.
//

import UIKit
import MessageUI


class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var messageBody = "あばばば"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if MFMailComposeViewController.canSendMail()==false {
            print("Email Send Failed")
            return
        }
        
        guard let extensionContext = self.extensionContext else {
            return
        }
        
        guard let inputItem = extensionContext.inputItems.first as? NSExtensionItem else {
            return
        }
        
        guard let itemProvider = inputItem.attachments![0] as? NSItemProvider else {
            return
        }
        
        //        let inputItem = self.extensionContext!.inputItems.first as! NSExtensionItem
        //        let itemProvider = inputItem.attachments![0] as! NSItemProvider
        
        if (itemProvider.hasItemConformingToTypeIdentifier("public.url")) {
            itemProvider.loadItemForTypeIdentifier("public.url", options: nil, completionHandler: { (urlItem, error) in
                
                let url = urlItem as! NSURL;
                // 取得したURLを表示
                print("\(url.absoluteString)")
                
                self.messageBody = "\(url.absoluteString)"
                
                //                self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
                
            })
        }
        
        
        
                var mailViewController = MFMailComposeViewController()
                var toRecipients = ["toshiharu.ishimaru@gmail.com"] //Toのアドレス指定
                //        var CcRecipients = ["cc@1gmail.com","Cc2@1gmail.com"] //Ccのアドレス指定
                //        var BccRecipients = ["Bcc@1gmail.com","Bcc2@1gmail.com"] //Bccのアドレス指定
        
                mailViewController.mailComposeDelegate = self
                mailViewController.setSubject("メールの件名")
                mailViewController.setToRecipients(toRecipients) //Toアドレスの表示
                //        mailViewController.setCcRecipients(CcRecipients) //Ccアドレスの表示
                //        mailViewController.setBccRecipients(BccRecipients) //Bccアドレスの表示
                mailViewController.setMessageBody(messageBody, isHTML: false)
                self.presentViewController(mailViewController, animated: true, completion: nil)
        
    }
    
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        
        switch result {
        case MFMailComposeResultCancelled:
            print("Email Send Cancelled")
            break
        case MFMailComposeResultSaved:
            print("Email Saved as a Draft")
            break
        case MFMailComposeResultSent:
            print("Email Sent Successfully")
            break
        case MFMailComposeResultFailed:
            print("Email Send Failed")
            break
        default:
            break
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//
//  ViewController.swift
//  CBoost
//
//  Created by Tatsuya Moriguchi on 11/7/21.
//  Copyright © 2021 Tatsuya Moriguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CHBInterstitialDelegate, CHBRewardedDelegate {
    
    private lazy var interstitial = CHBInterstitial(location: CBLocationDefault, delegate: self)
    private lazy var rewarded = CHBRewarded(location: CBLocationDefault, delegate: self)
    //private lazy var banner = CHBBanner(size: CHBBannerSizeStandard, location: CBLocationDefault, delegate: self)
    private var logBeforeViewDidLoad = String()
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func cacheInterstitial(_ sender: Any) {
        interstitial.cache()
    }
    
    @IBAction func showInterstitial(_ sender: Any) {
        // If the interstitial is not cached didShowAd:error: will be called with an error.
        interstitial.show(from: self)
    }
    
    @IBAction func cacheRewarded(_ sender: Any) {
        rewarded.cache()
    }
    
    @IBAction func showRewarded(_ sender: Any) {
        // We can let showFromViewController: fail for not-cached ads as we do in showInterstitial:, or preemtively check against the isCached property before calling it:
        if rewarded.isCached {
            rewarded.show(from: self)
        } else {
            self.log(message: "Tried to show rewarded ad before it is cached")
        }
    }
    
    //MARK: - Other
        
    func log(message: String) {
        print(message)
        if self.textView != nil {
            self.textView.text = self.textView.text + "\n" + message
        } else {
            self.logBeforeViewDidLoad = message
        }
    }
    
    private func statusWithError(_ error: Any?) -> String {
        if let error = error {
            return "FAILED (\(error))"
        }
        return "SUCCESS"
    }
    
    // MARK: - Ad Delegate (Interstitial, Rewarded & Banner)
    
    func didCacheAd(_ event: CHBCacheEvent, error: CHBCacheError?) {
        log(message: "didCacheAd: \(type(of: event.ad)) \(statusWithError(error))")
    }
    
    func willShowAd(_ event: CHBShowEvent) {
        log(message: "willShowAd: \(type(of: event.ad))")
    }
    
    func didShowAd(_ event: CHBShowEvent, error: CHBShowError?) {
        log(message: "didShowAd: \(type(of: event.ad)) \(statusWithError(error))")
    }
    
    func didClickAd(_ event: CHBClickEvent, error: CHBClickError?) {
        log(message: "didClickAd: \(type(of: event.ad)) \(statusWithError(error))")
    }
    
    func didFinishHandlingClick(_ event: CHBClickEvent, error: CHBClickError?) {
        log(message: "didFinishHandlingClick: \(type(of: event.ad)) \(statusWithError(error))")
    }

    // MARK: - Ad Delegate (Interstitial & Rewarded)
    
    func didDismissAd(_ event: CHBDismissEvent) {
        log(message: "didDismissAd: \(type(of: event.ad))")
    }
    
    // MARK: - Ad Delegate (Rewarded)
    
    func didEarnReward(_ event: CHBRewardEvent) {
        log(message: "didEarnReward: " + String(event.reward))
    }
}


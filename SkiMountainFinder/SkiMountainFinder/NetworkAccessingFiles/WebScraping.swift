//
//  WebScraping.swift
//  SkiMountainFinder
//
//  Created by Peyton McKee on 1/13/22.
//

import Foundation
import WebKit
import SwiftSoup

func getGoogleData(webView: WKWebView, completion: @escaping (Result<String, Error>) -> Void){
    webView.evaluateJavaScript("document.body.innerHTML", completionHandler: { (value, error) in
        //            webView.evaluateJavaScript("document.getElementById('Email').value = '\(emailTF.text!)'", completionHandler: {(value, error) in
        guard let html = value as? String, error == nil else{
            print("ERROR: \(error!)")
            completion(.failure(error!))
            return
        }
        print(html.contains("Rated "))
        var rating : String
        if(html.contains("Rated ")){
            rating = html.components(separatedBy: "Rated ")[1].components(separatedBy: " out of 5")[0]
        }
        else{
            rating = "0"
        }
        print(rating)
        print(html.contains("href="))
        var link : String = ""
        if (html.contains("Web Result with Site Links"))
        {
            link = html.components(separatedBy: "Web Result with Site Links")[1].components(separatedBy: "href=\"")[1].components(separatedBy: "\"")[0]
        }
        print("heres the link" + link)
        completion(.success(rating + " " + link))
    })
}
func getWebsiteData(webView: WKWebView, completion: @escaping (Result<String, Error>) -> Void){
    webView.evaluateJavaScript("document.body.innerHTML", completionHandler: { (value, error) in
        //            webView.evaluateJavaScript("document.getElementById('Email').value = '\(emailTF.text!)'", completionHandler: {(value, error) in
        guard let html = value as? String, error == nil else{
            print("ERROR: \(error!)")
            completion(.failure(error!))
            return
        }
        var trailNumbers = ""
        var liftNumbers = ""
        var baseDepth = ""
        var newSnow = ""
        print(html.contains("trails"))
        print(html.contains("base"))
        if html.lowercased().contains("trails")
        {
            trailNumbers = parseCode(code: html, key: "trails")
        }
        if html.lowercased().contains("lift")
        {
            liftNumbers = parseCode(code: html, key: "lifts")
        }
        if(html.lowercased().contains("base depth"))
        {
            baseDepth = parseCode(code: html, key: "base depth")
        }
        if(html.lowercased().contains("new snow"))
        {
            newSnow = parseCode(code: html, key: "new snow")
        }
        print(baseDepth)
        print(trailNumbers)
        print(liftNumbers)
        print(newSnow)
        completion(.success(trailNumbers + "," + liftNumbers + "," + baseDepth + "," + newSnow))
    })
}

func parseCode(code: String, key: String) -> String
{
    return code.lowercased().components(separatedBy: key)[0].components(separatedBy: "=")[code.lowercased().components(separatedBy: key)[0].components(separatedBy: "=").count-1] + code.lowercased().components(separatedBy: key)[1].components(separatedBy: "<")[code.lowercased().components(separatedBy: key)[1].components(separatedBy: "<").count-1]
}

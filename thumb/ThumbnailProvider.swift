//
//  ThumbnailProvider.swift
//  thumb
//
//  Created by 驺虞茂弘 on 2025/8/24.
//

import QuickLookThumbnailing
import AppKit
//import CoreGraphics

class ThumbnailProvider: QLThumbnailProvider {
    
    override func provideThumbnail(for request: QLFileThumbnailRequest, _ handler: @escaping (QLThumbnailReply?, Error?) -> Void) {
        
        // There are three ways to provide a thumbnail through a QLThumbnailReply. Only one of them should be used.
        
        // First way: Draw the thumbnail into the current context, set up with UIKit's coordinate system.
        handler(QLThumbnailReply(contextSize: request.maximumSize, currentContextDrawing: { () -> Bool in
            // Draw the thumbnail here.
            print("Thumbnail requested for: \(request.fileURL.lastPathComponent), maxSize: \(request.maximumSize)")
            
            // 设置填充颜色为红色
            NSColor.red.setFill()
            
            // 创建并填充矩形
            NSBezierPath(rect: CGRect(origin: .zero, size: request.maximumSize))
            .fill()
            
            // Return true if the thumbnail was successfully drawn inside this block.
            return true
        }), nil)
        
        /*
        
        // Second way: Draw the thumbnail into a context passed to your block, set up with Core Graphics's coordinate system.
        handler(QLThumbnailReply(contextSize: request.maximumSize, drawing: { (context) -> Bool in
            // Draw the thumbnail here.
         
            // Return true if the thumbnail was successfully drawn inside this block.
            return true
        }), nil)
         
        // Third way: Set an image file URL.
        handler(QLThumbnailReply(imageFileURL: Bundle.main.url(forResource: "fileThumbnail", withExtension: "jpg")!), nil)
        
        */
    }
}

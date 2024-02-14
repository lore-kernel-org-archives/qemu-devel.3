Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DA2C4829D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 04:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra6wh-0001ux-Si; Tue, 13 Feb 2024 23:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra6wg-0001ub-OB
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:32:30 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra6we-00067w-9e
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:32:30 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d94b222a3aso42148685ad.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 20:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707885147; x=1708489947;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LY24CVC1YBoU/Hz2w0W3aUzItIgVLNe8my76vH7E4TA=;
 b=RvYkqn6ffce8RQmTCku5gN8j1fgW0RpmIyurWtnggvEguONO5qJfWt0W8mMlWza7vB
 iWK7sfa59uwoIr0CMWWbtLeUcYsPD/Bj1xK7aaUP5lviEfsILZBcXGnHB1YXEWdkEpPo
 ycSDd5KBBR5qEuWSQIqpLtesSfbXmOJ6hi7dHyIAiH8f/a4z4ogLdfSYitVrGXW0RQFY
 VIJnvUbmbZdpUep/IsZwduAwa3qBEOB8IPkPcXce/IDR2mulgxGQ76qABFGQZGjKU41W
 ttpehy4mj5dIygbTEv2BvUPX1/3x9rN+jsZylXKYU7rNp+OgF0rT2iBwtf+F6toJTzeE
 tybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707885147; x=1708489947;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LY24CVC1YBoU/Hz2w0W3aUzItIgVLNe8my76vH7E4TA=;
 b=Bz39tF5RCLaoJXIQ49LEv3+YnInHzAuVx+5ctW8tHEB9Cfxy6AsyMEcUPi9Nz7abi7
 vbPSZ968BqI+9aK1aiB3PXfjAqFJ1RfHMpOFPNhDLy4s8pNgtdihtvw2IMIcIpnYkXFt
 7nSnGJcLGCrsuFcgxx4FOzQmw65BbX8jS+miKL4cUbrr0Sqdj3K8QB9qCM2jIVUQMaVm
 uJBDXuvPoR6nEs6bvQOQuYfpGUQP98AiXoAwlBBW8V4wTzPclBAP+wMXc4qLgCKOrvk6
 j6W/zq8D5fnxfd8yk3yTeD+iD4HAjTpZmwDeH8ApO+2bqqMTrFG+ml4GU66aveZvfzV9
 pXVg==
X-Gm-Message-State: AOJu0Yx+z6bYdHuiVJRMMPOiE+KVU1/3hWY5NC2VFZdpW3jo4Hal9EEf
 ZC/cbIM9kOjtXlgt0m70+AB7t5ZDAIHzKOX0yQOyqQwZngY1UhUdQCQdWNoxftZgyQfyvjwXLZ7
 2
X-Google-Smtp-Source: AGHT+IE2hxlKwiImhrUDdBOKl1qIgd/bV4e80gm8+cE8WDP+W4ZEUrT8A/gOXJZDzuJBNvPhsZNT2g==
X-Received: by 2002:a17:902:ecc1:b0:1d8:e7a4:3474 with SMTP id
 a1-20020a170902ecc100b001d8e7a43474mr1815886plh.68.1707885146889; 
 Tue, 13 Feb 2024 20:32:26 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXGw50+XzAc3K2+zOJ1/dAT1sTy+8PZqWcL4MrKjEv9dmlcuf4T1S++xKXCMvCOkEa/OL6cOkgJIHCm5KXeo+EfyK4uaTxsOUwiaoMZOPURmcNFAZW/JwvzWN/4to1Nw5G+dwJmhLHn62qQOyHKEX6EVvpv7SoyfdLpelE5+/CEWXOT9EpZL6K7NfRj79mM/ytIKgNEgs2hz1Wx/2VL8d1Ir7WtXNyimWgGjNff+ZexsGbtBYo01KMYhS9U20MKh03tIzJVJP90NVyg
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 o9-20020a170902d4c900b001d739667fc3sm2741586plg.207.2024.02.13.20.32.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 20:32:26 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 14 Feb 2024 13:32:02 +0900
Subject: [PATCH v10 2/6] ui/cocoa: Scale with NSView instead of Core Graphics
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-cocoa-v10-2-c7ffe5d9f08a@daynix.com>
References: <20240214-cocoa-v10-0-c7ffe5d9f08a@daynix.com>
In-Reply-To: <20240214-cocoa-v10-0-c7ffe5d9f08a@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Core Graphics is not accelerated and slow.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index fe0eb74b0743..cb6090905999 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -496,10 +496,8 @@ - (void) drawRect:(NSRect) rect
 
         [self getRectsBeingDrawn:&rectList count:&rectCount];
         for (i = 0; i < rectCount; i++) {
-            clipRect.origin.x = rectList[i].origin.x / cdx;
-            clipRect.origin.y = (float)h - (rectList[i].origin.y + rectList[i].size.height) / cdy;
-            clipRect.size.width = rectList[i].size.width / cdx;
-            clipRect.size.height = rectList[i].size.height / cdy;
+            clipRect = rectList[i];
+            clipRect.origin.y = (float)h - (clipRect.origin.y + clipRect.size.height);
             clipImageRef = CGImageCreateWithImageInRect(
                                                         imageRef,
                                                         clipRect
@@ -545,6 +543,11 @@ - (void) setContentDimensions
     }
 }
 
+- (void) updateBounds
+{
+    [self setBoundsSize:NSMakeSize(screen.width, screen.height)];
+}
+
 - (void) updateUIInfoLocked
 {
     /* Must be called with the BQL, i.e. via updateUIInfo */
@@ -1292,6 +1295,7 @@ - (void)windowDidChangeScreen:(NSNotification *)notification
 
 - (void)windowDidResize:(NSNotification *)notification
 {
+    [cocoaView updateBounds];
     [cocoaView updateUIInfo];
 }
 
@@ -1940,16 +1944,7 @@ static void cocoa_update(DisplayChangeListener *dcl,
     COCOA_DEBUG("qemu_cocoa: cocoa_update\n");
 
     dispatch_async(dispatch_get_main_queue(), ^{
-        NSRect rect;
-        if ([cocoaView cdx] == 1.0) {
-            rect = NSMakeRect(x, [cocoaView gscreen].height - y - h, w, h);
-        } else {
-            rect = NSMakeRect(
-                x * [cocoaView cdx],
-                ([cocoaView gscreen].height - y - h) * [cocoaView cdy],
-                w * [cocoaView cdx],
-                h * [cocoaView cdy]);
-        }
+        NSRect rect = NSMakeRect(x, [cocoaView gscreen].height - y - h, w, h);
         [cocoaView setNeedsDisplayInRect:rect];
     });
 }

-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE01C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrTT-0002ht-NF; Tue, 13 Feb 2024 07:01:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZrTR-0002ad-IX
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:01:17 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZrTP-0000uN-Uc
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:01:17 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d7881b1843so38445715ad.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 04:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707825674; x=1708430474;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LY24CVC1YBoU/Hz2w0W3aUzItIgVLNe8my76vH7E4TA=;
 b=S9KmQXpcmIBEeY+EII/fhc1xjEklxUTD3bEPyzVBLOBpNivIIaAgYUbry8zSECt/Z8
 AfppmJ75h1mBjIQwk4RnRqKX5acIM8DJN0mvrbWCxNT816O7AWzRNvM5WYNRn642O2bx
 Bw2lpJDrrQsfcVEQ+Ok2aDWoBpy+qCJoGh3Tc+MgVvrHayYYiUi7mtL0dBwKIDNjLUpK
 OXGK5/LW2hBoc1qziq5e/Sxdgo7ZaX7ou1PNaZFvB3N2JprqF8WZ4Sjc2Er2/61cTc6o
 Eiw72CC6YQ/D/q8Z5U8LXNDRZRLWxkXPJm4LoXSCN0t1vuOevt22QzLYdq+jknp9gIGb
 bE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707825674; x=1708430474;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LY24CVC1YBoU/Hz2w0W3aUzItIgVLNe8my76vH7E4TA=;
 b=pBLVGllBtQJh1AU2c5ZcIy99ISJw1Pry2q4j9A09BilUXa2FDSl+lAMM7cpX700tih
 ubzoNnHgpiRINyVwsLWlGYQZ+NhwvSH6kgWWJrJ6yfaZ3NbpjrDtotWCmYvzlOmEJiky
 8entFAyI9r1+hCB+t7lWPCQZHr8pht2Y71Nx9u36ON/7lLsC6nQbc3Y83fm2Zavl+f4/
 kKnY5zG/J9/ZRQTMZBqwzIHiWUzy6g/J3VCPOqzVmzdLu9O5AQbKoWtaHWdkYYCpmlzf
 x3OvufOpIm5+6usb0Nk3hhxk2SvqUrcLvchWrB9h3SqghzY1uMLrSJPXwT0o+sIPxUVc
 4Jyw==
X-Gm-Message-State: AOJu0YxX4/yGoS/I5TXi/4ZNTk0mLsN/EThu4of3vKap0A6z6gvGpCOj
 VdySmXwFXnk+XpQHLg6+4mtxG4/alk4/R6I77QPOUOrCF8Edtpwipm75b3g1iZP13jD2cyzs5T+
 o
X-Google-Smtp-Source: AGHT+IFEPEgeUbLtBoYh+ZGl7O2zr+BI/9Rwjd81YpcoHv8+gSJsZ6/tS/OhtCsTyJHC8Y+rdgk6wg==
X-Received: by 2002:a17:902:680e:b0:1db:3d36:507b with SMTP id
 h14-20020a170902680e00b001db3d36507bmr931771plk.44.1707825674241; 
 Tue, 13 Feb 2024 04:01:14 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWMLEE+IW2DNt92xe60UZtqFhCGVy/DFF5MEMPlcTMZrMhKfDBMRZMvCjBwYQREbQHaU2zaMhgCy3T/ReuLg+0xZefSwg+MgTHiVtjC+9fXeE/nxO+iwxvFzTxoMt1BrV6lUFXX6bvkPB3cilqOeEB9CMbr2r1Piha+gGk16Zec4CMusMjHJxVlwIthspYDt9AJTiLknIqn2BCgNXPrrkLgUhL7NYLqEDubgcbziIyNucs2IMW/hKGUnPWTKhc06mgogzzuwmg5T7tn
Received: from localhost ([157.82.207.134])
 by smtp.gmail.com with UTF8SMTPSA id
 li15-20020a170903294f00b001d94678a76csm1963784plb.117.2024.02.13.04.01.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 04:01:13 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Feb 2024 21:00:56 +0900
Subject: [PATCH v9 2/6] ui/cocoa: Scale with NSView instead of Core
 Graphics
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-cocoa-v9-2-d5a5e1bf0490@daynix.com>
References: <20240213-cocoa-v9-0-d5a5e1bf0490@daynix.com>
In-Reply-To: <20240213-cocoa-v9-0-d5a5e1bf0490@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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



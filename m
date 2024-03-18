Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA94C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 07:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm7o5-0002w7-Gp; Mon, 18 Mar 2024 03:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7o2-0002v8-Pd
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:53:14 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7o1-0008W7-3Z
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:53:14 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dd10ae77d8so24332435ad.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 00:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710748391; x=1711353191;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g9Ua7pWiHoWuYMxwrSKvZGIZMCnickF81dt6ppg4bLA=;
 b=sfGQ3fQBt8FiFdYaZMcTkoD9S6qrPoEeFckkxSVPXcX48Np+98TGr6yP/wQlUXG6+h
 /NDbt+RxAcX2gTZshuQ1Kipxwm4/rgj2ascr3nrBjQsvBSmo66cuZXNe95Q9jjhkSNa1
 tCscSPsi1UhLPccUdMZR446VlYvRbRlE/2KTu0bEq1uMNgLOnu0BstSe6YzTA18x4SBo
 oj3mmBF6wUJeySyPcOndsY5N4Mf5NGcN0Bzs1DBjA7hhFRNYoI07HpEH/bvMmiMBGfg8
 JPsIEZl68/aRVro6vuhEdWSZBLQNlAn6G3uVvdchIAt3bl7YKgfRdm/VaPtDnL3SvOpU
 uAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710748391; x=1711353191;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g9Ua7pWiHoWuYMxwrSKvZGIZMCnickF81dt6ppg4bLA=;
 b=dJAbRt7SY6UMr/TzE4VM5VdlAkXjmsqUWc6dZL5Ve4aOL5k6DWuIJMiSra2uQ6C8wY
 vNAmbIr196v5RCEjZcMskcmunZ02G9hA4JUAOcsxCF8EyWBdi28Upycf7cGh2XtE+sVq
 IeIun0ng8eABooMCzNPxkOBU5YYL3s7BrQFXF3Z0nnzLgCvu+dGu5KeJL4Aa9FsW9Dtm
 TLBVuoBlBGxLr1eEwL0GguIOrtCpi35HS/Q2xqvb8ZbDGKjelV6cj6TcQH9X1Qha6Dwd
 BCWQ4WHretnAHrqad4G9YbOD4maZCwn2ySVvQuVD1ySaCRYoHau5zQRv6EmXYqivXXrI
 gHhA==
X-Gm-Message-State: AOJu0YwpX1X1ueGPd1VL6m8c6K84REPGMMMt1W3zf5Em+fSi29qNyENc
 jdM8o0COnx7+Gnmb/trVbVZRi6FrbwBAjF8WS814rKfMnZsV/AdG8PzT+nmLhvU=
X-Google-Smtp-Source: AGHT+IGkSACDk8LvYz29gEti3PvleXDUtJ6PYseLptjmUWV0QTJ5V40YJzE5/37k3fiMkEjsYJnPbA==
X-Received: by 2002:a17:903:13ce:b0:1df:fa1a:529f with SMTP id
 kd14-20020a17090313ce00b001dffa1a529fmr6936177plb.24.1710748391279; 
 Mon, 18 Mar 2024 00:53:11 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 z7-20020a170903018700b001def777afc5sm5602806plg.77.2024.03.18.00.53.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 00:53:11 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 18 Mar 2024 16:53:00 +0900
Subject: [PATCH 1/3] ui/cocoa: Fix aspect ratio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-fixes-v1-1-34f1a849b0d9@daynix.com>
References: <20240318-fixes-v1-0-34f1a849b0d9@daynix.com>
In-Reply-To: <20240318-fixes-v1-0-34f1a849b0d9@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
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

[NSWindow setContentAspectRatio:] does not trigger window resize itself,
so the wrong aspect ratio will persist if nothing resizes the window.
Call [NSWindow setContentSize:] in such a case.

Fixes: 91aa508d0274 ("ui/cocoa: Let the platform toggle fullscreen")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index fa879d7dcd4b..d6a5b462f78b 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -508,6 +508,25 @@ - (void) drawRect:(NSRect) rect
     }
 }
 
+- (NSSize)fixAspectRatio:(NSSize)original
+{
+    NSSize scaled;
+    NSSize fixed;
+
+    scaled.width = screen.width * original.height;
+    scaled.height = screen.height * original.width;
+
+    if (scaled.width < scaled.height) {
+        fixed.width = scaled.width / screen.height;
+        fixed.height = original.height;
+    } else {
+        fixed.width = original.width;
+        fixed.height = scaled.height / screen.width;
+    }
+
+    return fixed;
+}
+
 - (NSSize) screenSafeAreaSize
 {
     NSSize size = [[[self window] screen] frame].size;
@@ -525,8 +544,10 @@ - (void) resizeWindow
         [[self window] setContentSize:NSMakeSize(screen.width, screen.height)];
         [[self window] center];
     } else if ([[self window] styleMask] & NSWindowStyleMaskFullScreen) {
-        [[self window] setContentSize:[self screenSafeAreaSize]];
+        [[self window] setContentSize:[self fixAspectRatio:[self screenSafeAreaSize]]];
         [[self window] center];
+    } else {
+        [[self window] setContentSize:[self fixAspectRatio:[self frame].size]];
     }
 }
 

-- 
2.44.0



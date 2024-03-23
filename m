Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FF1C6FD1F
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 06:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnuk3-0005w6-9y; Sat, 23 Mar 2024 02:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rnuju-0005tW-D7
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 02:20:24 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rnujr-0007dA-2k
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 02:20:22 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e6f4ad4c57so2040470b3a.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 23:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711174815; x=1711779615;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EbyKf2p5kvOfhKqh3XRD8emzriRkVdu9uRtFgfGqp4o=;
 b=2MUcVtY4kyCbOdKUl+G8bdARjBMBRa1++0cXaZ2fwu8REtp4RHdi7WvDXmzcxRWoxz
 lNGsBGCJ2ZgHAE1PA5OmDevZGePYK3/wYXz4a7Su8HHEtfTmyDVKVzd5wiyn3O79ICdv
 BHxAVQlsnL3gesl1MQll4bUlDUvcrw+jyqxkDTR3wiEyqSJ3gbOoJ5Ywm9d8Ol4UBvNe
 CoCJFvslEujWYkW5nAJEnagpjuDhJ3YTGnbO7vxd+6W/foZf8bSxSuJS5eTsAb3Y5vIa
 MFY5Ddw1pd9e1m9b5VfMKGBbvor9NxwkdXSRBHSmvMo+wIMcnRBYHYUt4I6KfQQ5L1p2
 RrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711174815; x=1711779615;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EbyKf2p5kvOfhKqh3XRD8emzriRkVdu9uRtFgfGqp4o=;
 b=A01VoZYBRZr6nxGvjCH5lU8hgeolywsceOg4vvYuI1hnJK/v07t+yO0P3RRyvXDfkK
 SunTAKK420REmnBewKtCG8+50lj0kQqgmi7TmO60hl7DjwwdviuOGiygUV+EJCZuWKKb
 N5EOBhYYNZzU6B+j2GVcYM6gxX5r/K4bDxd2SjajW7P/QBSu1Tn31UFtMKOf+WYlfctH
 OhFxbkK4Q5n4R5mEvfaHxVzI6yjCxD8Wmz7A5PUw/pH0FMQC9LyLmrdcuqRdwQrG7pXT
 J+Xtx2OAdfilZ2Q4obupWJXXtrWKvR16Nh+m22/Hd448Ggw6pDSFJs0isSaWGmE6musm
 4TVQ==
X-Gm-Message-State: AOJu0YwavZbn2N8GugJYRF966TQyMHX4cD2kV9Ge5NA4EC+klhd7HxR+
 WyPKt3eJoxxC/VOPypuWgqfWFZDwYr6lIgFU9N60NgsS+jHHkdU7IL/TQUNQj9lglG1QBCvZsa1
 3//g=
X-Google-Smtp-Source: AGHT+IFMn5UfauL0MR85dxcof+9So+t3TjwyNRBX1TCXGsS35UG/OFUVUZpDDS8Q536XzblP2diIcg==
X-Received: by 2002:a05:6a20:2888:b0:1a3:4469:5967 with SMTP id
 q8-20020a056a20288800b001a344695967mr1480498pzf.57.1711174815058; 
 Fri, 22 Mar 2024 23:20:15 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 u4-20020a170902e5c400b001def0324a64sm803039plf.135.2024.03.22.23.20.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 23:20:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 23 Mar 2024 15:20:01 +0900
Subject: [PATCH v2 1/3] ui/cocoa: Fix aspect ratio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240323-fixes-v2-1-18651a2b0394@daynix.com>
References: <20240323-fixes-v2-0-18651a2b0394@daynix.com>
In-Reply-To: <20240323-fixes-v2-0-18651a2b0394@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
 ui/cocoa.m | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index fa879d7dcd4b..834ebf5f6175 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -508,6 +508,43 @@ - (void) drawRect:(NSRect) rect
     }
 }
 
+- (NSSize)fixAspectRatio:(NSSize)max
+{
+    NSSize scaled;
+    NSSize fixed;
+
+    scaled.width = screen.width * max.height;
+    scaled.height = screen.height * max.width;
+
+    /*
+     * Here screen is our guest's output size, and max is the size of the
+     * largest possible area of the screen we can display on.
+     * We want to scale up (screen.width x screen.height) by either:
+     *   1) max.height / screen.height
+     *   2) max.width / screen.width
+     * With the first scale factor the scale will result in an output height of
+     * max.height (i.e. we will fill the whole height of the available screen
+     * space and have black bars left and right) and with the second scale
+     * factor the scaling will result in an output width of max.width (i.e. we
+     * fill the whole width of the available screen space and have black bars
+     * top and bottom). We need to pick whichever keeps the whole of the guest
+     * output on the screen, which is to say the smaller of the two scale
+     * factors.
+     * To avoid doing more division than strictly necessary, instead of directly
+     * comparing scale factors 1 and 2 we instead calculate and compare those
+     * two scale factors multiplied by (screen.height * screen.width).
+     */
+    if (scaled.width < scaled.height) {
+        fixed.width = scaled.width / screen.height;
+        fixed.height = max.height;
+    } else {
+        fixed.width = max.width;
+        fixed.height = scaled.height / screen.width;
+    }
+
+    return fixed;
+}
+
 - (NSSize) screenSafeAreaSize
 {
     NSSize size = [[[self window] screen] frame].size;
@@ -525,8 +562,10 @@ - (void) resizeWindow
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



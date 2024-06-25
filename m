Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37362C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 13:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM6YZ-0006zJ-FF; Tue, 25 Jun 2024 09:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sM6YV-0006x0-Ok
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 09:49:55 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sM6YT-0007KH-Kc
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 09:49:54 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a6f8ebbd268so1085822866b.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 06:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1719323391; x=1719928191;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJhNG6W/u2QBb+Lr2mxjHC9Dx9KTVbi65U/cSPuIL0U=;
 b=x1/IXBqc0fKLBKQ0jl9Mr4me0mNZtKVp4veVJYLjZyA83eEjFIlM69nUwy6ifAOX1O
 rBGqvB7s1EDbsFdACIcs5EylrYEskK1nEWXt+1cViHhs/ndHsUzMkAyIqRYRVY/HQ2t9
 /CvBYxXXu+hgqXJuUA5FwfOxjHkcX/KofIE4DUCCDZKOsy3/OvzDpv0NBGZNK/t7IiHB
 7BjWmdgGy3Akc6X7yRNYCX0aolVpi4YnbF4I7A8ki3U6+3S5YU55a3NmNtpCFm5NXPHm
 2gyw2Yf/VnaCM+j+hyO0llLhJGo1qz8qgEIIG+PCL4UIn/ZIJ4XnDWSVG9HZBh+yiRZN
 RyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719323391; x=1719928191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RJhNG6W/u2QBb+Lr2mxjHC9Dx9KTVbi65U/cSPuIL0U=;
 b=f5DIEzowKgwgwRUEgX6hWcnppXAhU0oBtwyTSGYv1+LaZEsCh5Y1ppHbEbbbOkmzQ+
 rh2cjwYlnwR/CEUpAfeMtvWelFyzJCwLFbJfWdYbw4fKaBOzByS+8FyzOfLSQPZhHGoQ
 O68wsbFUgIw6/z2RdjleAXKzK2aZM3VmljCKXzeqapdYsb4x50dpooNIqJWsmRoTO3nd
 7+QLSMe0C7UWf5XPkrvfrEhMFcEM+Qw4hlG1bykQ+oxUqLSd8lZKnMJb10PPDjnP1N9J
 yH7NUE0AndpDUkjP/EkuSabIebfmHp31+UDaNAfd5c2e26kW286KPlM1zQV8vmvh9NN0
 6fkA==
X-Gm-Message-State: AOJu0YypOfysUTMM59xKiKlV2nOJvMBkLImlgdsiLUHLEiGYNsW9Q4/c
 6dtpfds6uMpp7W7/YXiCtekFnYI0J+0GWJHn/KQmULqvWpiK3J8siWYptZxwWZyE9BaRjTYE85P
 xwQ==
X-Google-Smtp-Source: AGHT+IHkWoyye5aFgxtGCab24XrPAMz+pZCcRPfDgntmT+aNwSZpZQdQrI8K/fY4jjOp778PEcE+vQ==
X-Received: by 2002:a17:906:57cb:b0:a6f:e3e4:e0b6 with SMTP id
 a640c23a62f3a-a700e70884emr725231766b.27.1719323390852; 
 Tue, 25 Jun 2024 06:49:50 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-17.customer.bnet.at.
 [89.104.8.17]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a726e13a4d7sm77299166b.19.2024.06.25.06.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 06:49:50 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, marcandre.lureau@redhat.com,
 akihiko.odaki@daynix.com, lists@philjordan.eu,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 1/2] ui/cocoa: Minor fixes to CALayer based cursors
Date: Tue, 25 Jun 2024 15:49:30 +0200
Message-Id: <20240625134931.92279-2-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240625134931.92279-1-phil@philjordan.eu>
References: <20240625134931.92279-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::636;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x636.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

This change fixes some object lifetime issues. (Unreleased reference
counts)

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 ui/cocoa.m | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 06ca114800..cca987eac7 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -395,6 +395,13 @@ - (void) dealloc
         CFRelease(eventsTap);
     }
 
+    if (cursor) {
+        cursor_unref(cursor);
+        cursor = NULL;
+    }
+
+    [cursorLayer release];
+    cursorLayer = nil;
     [super dealloc];
 }
 
@@ -474,6 +481,7 @@ - (void)setCursor:(QEMUCursor *)given_cursor
 
     bounds.size.width = cursor->width;
     bounds.size.height = cursor->height;
+    CGColorSpaceRef color_space = CGColorSpaceCreateWithName(kCGColorSpaceSRGB);
 
     provider = CGDataProviderCreateWithData(
         NULL,
@@ -488,7 +496,7 @@ - (void)setCursor:(QEMUCursor *)given_cursor
         8, //bitsPerComponent
         32, //bitsPerPixel
         cursor->width * 4, //bytesPerRow
-        CGColorSpaceCreateWithName(kCGColorSpaceSRGB), //colorspace
+        color_space, //colorspace
         kCGBitmapByteOrder32Little | kCGImageAlphaFirst, //bitmapInfo
         provider, //provider
         NULL, //decode
@@ -497,6 +505,7 @@ - (void)setCursor:(QEMUCursor *)given_cursor
     );
 
     CGDataProviderRelease(provider);
+    CGColorSpaceRelease(color_space);
     [CATransaction begin];
     [CATransaction setDisableActions:YES];
     [cursorLayer setBounds:bounds];
-- 
2.39.3 (Apple Git-146)



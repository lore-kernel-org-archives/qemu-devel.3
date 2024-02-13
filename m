Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26054C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrTn-0004Da-MX; Tue, 13 Feb 2024 07:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZrTj-0003yf-8P
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:01:36 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZrTg-0000wz-GT
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:01:33 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5dbd519bde6so3194019a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 04:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707825691; x=1708430491;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bIJbW/SZ9SYfRb/KZSq6u+h/C9wWWReaQ1TXj2N9m9M=;
 b=aDw/8hyIKE+BBO1tlZ2K1jB3ZYmmTX1Y3PFLrWd6vmxCEic4k6KD9SulVhfIBzhbOp
 z6zmwpHoiZySb+fE/jV+Pq2wXjXp7C6Xwwzry5d3r5wLSTLEOMv+9mtZ4mMWj05poy5l
 yAQsZq6rkaiTSCvZISoze1ixjiZNMl5NzjU+w+czybNm1dyFGGpHHWIM0JPshbMPW7NS
 Ut11bNnONk/b0I21TeM38802gudAbFTvVKd2Kkrz3QqCnIY+XhjI/Hlso6ImJz/vv4gX
 PHgJpzlfC6w+qhSPZgvk0aA2JzaSbWcSU0cLtOLVL8TyJCsWoA47QFATm0Hxu977qE15
 I3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707825691; x=1708430491;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bIJbW/SZ9SYfRb/KZSq6u+h/C9wWWReaQ1TXj2N9m9M=;
 b=voQ6oBcOk06izM33KpUWBGDB2opn228GtHHUao7RMjsQ9n/WQ7QAVHXfB99VLGjzp2
 9UfUqje+FV3ezrIC4zgVy3qy7/P0uBuWebi3KFD/ybV6EvQ8JjtiunfpXL+mJvqvHWOm
 JWE66sKED7gkHRZuRV19qdSQ2l24jKgq7+A0SUVthwEAC9gdsDSQhvRM9L69Cw5oR0g0
 6VHfQ8fO4wmvHLqBtS7iwmDv/AlMTu1AXGRO1JSNamXklhiusXT95+yhaQ8ZlGTHjiZ+
 CA4weja9sVK5tVfOAB+H/DHECIojrTJVLlF2xLIL4eAGkYUYP47eMUdR/oMt4jIZAa8J
 UkKQ==
X-Gm-Message-State: AOJu0Yza0j02MZqjptmXO8D5eVc62VF/TExWPVlK1XFt/kQORKtSUzOD
 qwEjNGtdJ48nyTFZ7cKmw1AjYwiPOlv5tQ4H6dGyE//0lidt5hh5M377c7bTRhW2l7UU9b++kij
 U
X-Google-Smtp-Source: AGHT+IG/ceVvKflKfWF6JB94qWVPWwcYIZYxsfsev0TMEwZTR9ywAr3KxbFQdVZuQqhowbOX26OuLw==
X-Received: by 2002:a17:90b:d98:b0:298:988f:4dcf with SMTP id
 bg24-20020a17090b0d9800b00298988f4dcfmr3044897pjb.0.1707825690942; 
 Tue, 13 Feb 2024 04:01:30 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXaECFEQzkw2TwOwyY8J7papXoOxs3vIFvTZl7rocpoXtvgPG7p07rrhlVf3UtZHG4anqQ5+LlYeJFX2SHTywHAsCKDrqbhcWQeUyG3PTZdutId7hbeAg3wWeyur4p5LwVV387wyjPti5YfbVhEmi0xCXKWkxV+G+q6AAfFja8XQ1EiKf4G5Sbv/79xtyMTQ4KXh9kNu2J4V0kMC1tJbyMPxwYGBJ/y39m1hfN+i6BICvXbB5Tu4VjXGzqKgXE+GhN+UAobuDv3Qgf3
Received: from localhost ([157.82.207.134])
 by smtp.gmail.com with UTF8SMTPSA id
 sx12-20020a17090b2ccc00b00296885dcef7sm2337698pjb.16.2024.02.13.04.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 04:01:30 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Feb 2024 21:00:59 +0900
Subject: [PATCH v9 5/6] ui/cocoa: Call console_select() with the BQL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-cocoa-v9-5-d5a5e1bf0490@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
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

console_select() can be called anytime so explicitly take the BQL.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 754539937ffe..93e761f09c6e 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1391,7 +1391,9 @@ - (void)zoomToFit:(id) sender
 /* Displays the console on the screen */
 - (void)displayConsole:(id)sender
 {
-    console_select([sender tag]);
+    with_bql(^{
+        console_select([sender tag]);
+    });
 }
 
 /* Pause the guest */

-- 
2.43.0



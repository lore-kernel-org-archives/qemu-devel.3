Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BC4C54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 06:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnuk2-0005vh-Ly; Sat, 23 Mar 2024 02:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rnujv-0005tX-Ip
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 02:20:24 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rnujs-0007dT-M7
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 02:20:23 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so1773921a12.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 23:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711174818; x=1711779618;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1/JZr2uStAFeg9hQSEj1pl6Z0un8Jhj/9vQLsQrKvwM=;
 b=XBZromdGEoViTHSN4DX7H164NvcrG6j8ntHu9F0LHU13k1LUGenxMMgaoGbw6UA6Y/
 n7B7fCw7RJJNAILGjRIOX0Xzx5ZQRWqvrfJhVE6tsHX9GGh5A5ekVkbnjSfxSnSfgK5p
 PwKPRPhIW0S00hiIBG3ax1gyIov2GBod+X6hlOYb2viOxO7avD+wYfo80ErVXhMK8BiX
 fyygLP64F8gTmM7KyR6Ok1KjD4ygIHvrOmyn4OzeDzsnyDi6+kHh1GYUzPnABxyOu/oa
 A0Vrg+ReUup2EqKFEj/w2DkkrAwRVSNQepVRNvhmRnV8RJR0EY8D+iIu1d2hgHGFHnpA
 IgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711174818; x=1711779618;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/JZr2uStAFeg9hQSEj1pl6Z0un8Jhj/9vQLsQrKvwM=;
 b=HUttY2UyLTfOfI6OeNXKy7jLHAX85cVSolu/TrXjCOFDAixhGjB0++NmRKna5m8XNI
 /h+excRkmMGWpSUHSeUX9QCWMGdq1YWbqNfpiC+OYRkwZ3roW6fCyp8GN1VTOCU3S5w4
 mwi3CBU5EgbyvEV7I0B4XQrCx9mxOWiZ0L5ia6Cl0wok6922utnQDNiyupKhJm0oqNyu
 7sj0jlufkGWbce3Vr6QvGqlS1KrXzJDfIjA7SV84BKyY98gC065LAuGyiMX0ReDxYzKa
 qUIm1ORGScTHjVbDbsl+BKAVJkEg4bIKzuiWGYiniYjcUbSazbRK/lSgY9sLvW8CNFk+
 +0XA==
X-Gm-Message-State: AOJu0YypfaNKYMJYIyItGu7IR7zjG75W+rb3qsAqXiByZeDuA6LoLARx
 kFTWgbWzL+5dT6QjcFE/OhOnJh11VuNqWzNbUecM5xT2+kU9U+48Jy6tFbcfPZI=
X-Google-Smtp-Source: AGHT+IFomI9bfec1sdiqmmlOhlLs1KuEUWBZQoB8BjmsuA4oneF6NWBe3W4j3cwOj10fDF1H9zDY4w==
X-Received: by 2002:a17:903:1111:b0:1dd:b3ef:4528 with SMTP id
 n17-20020a170903111100b001ddb3ef4528mr2060005plh.52.1711174818259; 
 Fri, 22 Mar 2024 23:20:18 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 b4-20020a170902d50400b001defa82b994sm801266plg.123.2024.03.22.23.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 23:20:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 23 Mar 2024 15:20:02 +0900
Subject: [PATCH v2 2/3] ui/cocoa: Resize window after toggling zoom-to-fit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240323-fixes-v2-2-18651a2b0394@daynix.com>
References: <20240323-fixes-v2-0-18651a2b0394@daynix.com>
In-Reply-To: <20240323-fixes-v2-0-18651a2b0394@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
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

Resize the window so that the content will fit without zooming.

Fixes: 91aa508d0274 ("ui/cocoa: Let the platform toggle fullscreen")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/cocoa.m | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 834ebf5f6175..3a1b899ba768 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1396,6 +1396,7 @@ - (void)zoomToFit:(id) sender
 
     [[cocoaView window] setStyleMask:styleMask];
     [sender setState:styleMask & NSWindowStyleMaskResizable ? NSControlStateValueOn : NSControlStateValueOff];
+    [cocoaView resizeWindow];
 }
 
 - (void)toggleZoomInterpolation:(id) sender

-- 
2.44.0



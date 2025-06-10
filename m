Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7658C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 13:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyXP-0006da-9c; Tue, 10 Jun 2025 08:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXM-0006cs-Sk
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:08 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXJ-0002bM-Lm
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:08 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451d54214adso44604735e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560222; x=1750165022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6dp7GpujhzFYh18zm/S+UkI0pyq2WLKkULJ1D7AE954=;
 b=Zc3Zrp+Cem/Xmt4c0mjt7Ujir2KRu1yqrSWcBErfOChtnJZ7+cx4cOREpn+iMljetO
 WWtX8c0htIR0GUXy4w2IEyx7VK8XASj0vr9h0k1l4OyGtv7yjWOkesR0sUSaBLicA2o0
 +yoWq0flhm9E+J3swE0Etm4AMe3gjui0obD0eKRm81+DMl7HVIwfUOYgt949zfo9hYRf
 fH7qAziF13JEynSKZj9zyDMeCrZDynnGo3/dDuphl/w81cLy5GfwG0SDmACfIV4CkAfY
 tOuwUBFQleSAPVZWiYFAe/ZFwdTmYqxGIlTBnfSWbWSWxuNVh/6WWzEeSEQmUow0qT0t
 Y5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560222; x=1750165022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6dp7GpujhzFYh18zm/S+UkI0pyq2WLKkULJ1D7AE954=;
 b=PAiMtHGgVlm5D7SZoNRfr96JnAbECWqhlAnOIQ9s3/tQ+bDaeHCCqW7qqNb1Ab2iOf
 Jg7CfrUrwBe53smW1vGRpxaJJ/PahIaQsC548df+d07AdvkWFeSjzYY6akbW7HUL0afK
 zfZZfGmiJLW/pEC2pm2kyANi7Dc2q0lMLLYheNR8+Kw8nSG/I+orZMKFFccui2okySLg
 on6z5qjEg9eB6rR/qztIndx8qYC8TSNajxwrwSReaqhblnBxvYYqR1U3AGZWaPpdUOkM
 AfX+mb17p3yMI0YM+zDgKIbZe12dkl9ENbOkW5bjuofq1ne6EMbmT5LFD8dTnAO8ZkIa
 0EMw==
X-Gm-Message-State: AOJu0Yxj+SqTQwL7mlu3CqhbKMqMMf9+OXAMcpOsdAs/EmWQ8jCl8kPr
 BUMvTrsRwO/ObUg197s3zhtXQrJjr12g4PxDargV4v5/wnPzM8UzU26lor55XoQ4VcZYPS3tv5I
 W1PCQr3Y=
X-Gm-Gg: ASbGncszz5NAQt3nFHQyrj9KoNQYePzYtebNG0Ez2CLAKEV8cPzlwsxrve/JAPeQLGr
 aIPj0tAXb7t/KVRAih5+IFdXfOE92urxU3D4kC7mbJE9ei905BCefG6cPZRwoqKyO++ZKvEuY9w
 p6WxTZn09PG4ZHfsNfHxHVXLnH8bXQLqKxhj4Dfq4C3d/3F+WYqADzFauQnemljhU7Obntrpb9m
 ea8lFxBVLBdSYFRFtTOViPyt5oK8O25Rgaz3dun/vWM6J1rumTcMhiOlKmGBmfVe/tU6n7HLjiV
 pzU5ZBvalMh/MH5V3Pk1TlEgilei4KXghNDT2aLF2PYaTOTeiF/o7fVfLlGMutssQoTbLWBMEPh
 Fxr50ecjFNK6zbvjMlhTwp114g18Nphh9WtFdz+YoTA==
X-Google-Smtp-Source: AGHT+IEfDYWaMws+y6OvpmpAlc5CKzMdJhaQmONxvarRJQntju1FOC0TY3TGUA096q/6ydMIREWEzg==
X-Received: by 2002:a05:600c:148a:b0:442:d9f2:ded8 with SMTP id
 5b1f17b1804b1-45320032194mr16320785e9.15.1749560222334; 
 Tue, 10 Jun 2025 05:57:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730d175dsm137297895e9.35.2025.06.10.05.57.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:57:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/24] hw/hyperv/balloon: Consolidate
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
Date: Tue, 10 Jun 2025 14:56:15 +0200
Message-ID: <20250610125633.24411-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

The QOM type of HvBalloon is declared by OBJECT_DECLARE_SIMPLE_TYPE,
which means it doesn't need the class!

Therefore, use OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES to implement
the type, then there's no need for class definition.

Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Message-ID: <20250514084957.2221975-6-zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hyperv/hv-balloon.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 94b0abbd683..6dbcb2d9a29 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -67,10 +67,6 @@
  * these requests
  */
 
-struct HvBalloonClass {
-    VMBusDeviceClass parent_class;
-} HvBalloonClass;
-
 typedef enum State {
     /* not a real state */
     S_NO_CHANGE = 0,
@@ -162,8 +158,9 @@ typedef struct HvBalloon {
     MemoryRegion *mr;
 } HvBalloon;
 
-OBJECT_DEFINE_TYPE_WITH_INTERFACES(HvBalloon, hv_balloon, HV_BALLOON, VMBUS_DEVICE, \
-                                   { TYPE_MEMORY_DEVICE }, { })
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(HvBalloon, hv_balloon, \
+                                          HV_BALLOON, VMBUS_DEVICE, \
+                                          { TYPE_MEMORY_DEVICE }, { })
 
 #define HV_BALLOON_SET_STATE(hvb, news)             \
     do {                                            \
-- 
2.49.0



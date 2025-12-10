Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A66D3E783
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 23:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTTd8-0004DH-5s; Wed, 10 Dec 2025 18:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ZgI6aQYKCqMbXELQcJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--yubinz.bounces.google.com>)
 id 1vTTcy-00049P-MU
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 18:29:48 -0500
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ZgI6aQYKCqMbXELQcJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--yubinz.bounces.google.com>)
 id 1vTTcu-0005j4-FT
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 18:29:47 -0500
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-bc240cdb249so317897a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 15:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765409383; x=1766014183; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=hqZ2qhWGGDuvHlPFLsB8stzNSOZI8NxOWfwLsS50KE0=;
 b=RgPMNeWrdZtbnAztSu7g/QjCqyGRA3A4mA7+hHtWDVPESaXuFyCgkth1E94O73tWvJ
 duSXeeqnCxuiPpS3HOK8DMHvvZKLCZt+13j2/aitnLot/E1tb2yBREi2duwiqTXG2c9X
 NxT2BBmtNRSumZASJOV7mlDxiLhYJcz2IVVwNnJmjs1nGt5zV9P78WRFE1N9gS6Hvdj6
 pjszupyJbVqA19to1l/M8Z7uLoMHd09a+rIJyz5+PUPBleYSM64+Ip5+8ggFSYscIyec
 eA0r967dHBOBZfdx3GWPYrkdUyzO6U2BQil9dRmTLibegST9UcJhJnCvzV9Cyo+QY8dh
 Bgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765409383; x=1766014183;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hqZ2qhWGGDuvHlPFLsB8stzNSOZI8NxOWfwLsS50KE0=;
 b=Cd5YiYZwozK+CWseu3D2qkKlr3y7TO39yTuogO8xPSZRkjhox5urvb7H0LocqjstzA
 TGHZesRoI/bE1zSFXjMTzDH+1/JwVcr0DOGLssbz0JwB+SsyvFG96oFWtRbP9dGh/Xzk
 ahBbxjFRVbaR1sLcFg7J/puoz1zxTDJZg+C4/q1FPJlyz+PHC3sQdZg4mVmODuKF5DRP
 EULCtgsKtLdWbG1P086rBBTjjyPlAw+E+l6O8Cu2BbP7RL1lAU2Ngd8ljxEp97cfSva4
 qAu4w2yMu6WLOL+C8PH2yEMQ5apNZYKCbIXRfCgXy4sxuqzfJU4Nc0SlgdbArIjvjdYs
 mYPw==
X-Gm-Message-State: AOJu0Yyef3rkTnX7KzgRIi0bSv0HZVwyBtJUOTaoMODAsIVnolPhrdF2
 BvHydfb07K1pgy7jIrRTStka2jLeaJ5MJCUFUwSlsjzjVGv6t7C/lBvOv+6k14n1biG2qAgWYOK
 QBMJYvzkd0BSvk0FWTBGmxbtJPPxjzUZvGdtJ0Ghsds5DvWL2HniXpN6ZgswnJ9n/bNgZkz37DI
 yIP2cVXGPI/Yc/AJJGqVeVw1uHNmpAatdj9+k=
X-Google-Smtp-Source: AGHT+IEn5a/inZouAECTkDQNNeEkn6ggqHKOx/PwjvTPQIlfd0iQs3c1dQXEPiI/UxHzNVgAzeSjxBSYxLo=
X-Received: from dlbbu30.prod.google.com
 ([2002:a05:7022:221e:b0:11d:fd0d:f00f])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:fd0b:b0:11b:9386:a386
 with SMTP id a92af1059eb24-11f296d7b96mr3265379c88.41.1765409382643; Wed, 10
 Dec 2025 15:29:42 -0800 (PST)
Date: Wed, 10 Dec 2025 23:29:16 +0000
In-Reply-To: <20251210-aspeed-sgpio-v3-0-eb8b0cf3dd51@google.com>
Mime-Version: 1.0
References: <20251210-aspeed-sgpio-v3-0-eb8b0cf3dd51@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251210-aspeed-sgpio-v3-5-eb8b0cf3dd51@google.com>
Subject: [PATCH v3 5/6] hw/arm/aspeed_ast27x0: Wire SGPIO controller to
 AST2700 SoC
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>, 
 Nabih Estefan <nabihestefan@google.com>, qemu-arm@nongnu.org, 
 Yubin Zou <yubinz@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3ZgI6aQYKCqMbXELQcJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--yubinz.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

This commit integrates the Aspeed SGPIO controller into the AST2700

Signed-off-by: Yubin Zou <yubinz@google.com>
---
 hw/arm/aspeed_ast27x0.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index e5f04bd16e80696e41005d9062a6df6d060b8088..787accadbecae376d0c747d054ec6372785375b1 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -519,6 +519,11 @@ static void aspeed_soc_ast2700_init(Object *obj)
     snprintf(typename, sizeof(typename), "aspeed.gpio-%s", socname);
     object_initialize_child(obj, "gpio", &s->gpio, typename);
 
+    snprintf(typename, sizeof(typename), "aspeed.sgpio-%s", socname);
+    for (i = 0; i < sc->sgpio_num; i++) {
+        object_initialize_child(obj, "sgpio[*]", &s->sgpiom[i], typename);
+    }
+
     object_initialize_child(obj, "rtc", &s->rtc, TYPE_ASPEED_RTC);
 
     snprintf(typename, sizeof(typename), "aspeed.sdhci-%s", socname);
@@ -973,6 +978,17 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_GPIO));
 
+    /* SGPIO */
+    for (i = 0; i < sc->sgpio_num; i++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->sgpiom[i]), errp)) {
+            return;
+        }
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sgpiom[i]), 0,
+                        sc->memmap[ASPEED_DEV_SGPIOM0 + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->sgpiom[i]), 0,
+                        aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_SGPIOM0 + i));
+    }
+
     /* RTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
         return;

-- 
2.52.0.239.gd5f0c6e74e-goog



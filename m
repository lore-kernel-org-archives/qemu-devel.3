Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0949E7718E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 08:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQj9h-0007XQ-MX; Thu, 26 Dec 2024 03:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3fxJtZwgKCpoQOB4INMBAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--wuhaotsh.bounces.google.com>)
 id 1tQj9Y-0007V7-Ko
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:23:32 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3fxJtZwgKCpoQOB4INMBAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--wuhaotsh.bounces.google.com>)
 id 1tQj9W-0000ZR-SQ
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:23:32 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2efc3292021so11519067a91.1
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 00:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1735201408; x=1735806208; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=IC2Oq7akfcisB2i2J+bOE64Sr4Q2OzTG/tLjT/6CTOs=;
 b=Evoovf74b7hQ097hsfHviCfCTlW8eFe/CyUj8wFrCOOSfriYorQ7qo2NpQy66AidFV
 oqRX9X7fJkmUjWZWxOEDfzsr6f8q4CLPNvgERUuPJCiQucFG5yJXvMfafe+ivIZGaLuA
 TDEHXeOEMwa8qOXwg+ThjuiTedsuHBL2bvvTUxmdUDbknY9XZZw4hG8uo1WDBz2vNOH6
 2qgdDUtMUC1WhbvFc7M9glMi8D1+XA/3k/Hd3xEDjwIVf6wUtCg6nDWaNWfflmZmDpbu
 1L+hjaLqx1CRpdGbP93FuGoUvNc0rarRn6TdJve6c7Upx8fTcbpiR1EsJHcXZwMS3Ig1
 wVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735201408; x=1735806208;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IC2Oq7akfcisB2i2J+bOE64Sr4Q2OzTG/tLjT/6CTOs=;
 b=D9gffwfPKuIYSQ7E05uQA5pj4vfJ6clPWAPb0XceG+3XgSShVPVcl4ZjPiVHEwZ7kN
 6SMdIGYirGm0BVBIejQVE2tn4zLJ0L2tFQa73NnH7RbnIriGoxjhs5I/3NYePoLRxStb
 VQKf/aZDxf88O76sMG1PoAUslQRSwf3FNRFNVL0kiwvVkTjAd5i11j5j99MSapZVdjm8
 xz6AdlxH/rOwvWOW68lv5dZNfWxSZaWNGyMhID3Afwc2iyFXMt6Xdz97y/XFZcvrI4KL
 BJKJEsgQ5eLCG+/hE7UQGxjdIif/mOfp/11MoLPA04GTdIwHpiEEjrooZaDjZwN59Ymn
 vNOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvo3UaQLvs7KxM21LsRKZi+HmcjYpXDzQc1N6L1xYemqHhaSGdXs5O1Skkm+7p4NCsZEL16EYUmMgh@nongnu.org
X-Gm-Message-State: AOJu0YxlWh47Q75TaC3FIq8dliKzhkWFOZy/3JEjIwsPiR9gDMHvKNP+
 nWRa3La7KEgrZV/PSw8Chkg/WzKyb5YcB+/3OgIbZ2ehrqtVGKj+NnuLMmDX1oninClp+/2LwBO
 zkSyV1I5uKA==
X-Google-Smtp-Source: AGHT+IFuNvb6oUezCH++mRfP3bKaVI+rzTgoI3vx3j19C22tTWFL5L3cWfA8U9kkO+K7NiCmxjexVTXUVI1MVg==
X-Received: from pfbeb15.prod.google.com
 ([2002:a05:6a00:4c8f:b0:728:e3af:6bb0])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8d8c:b0:729:597:4fa9 with SMTP id
 d2e1a72fcca58-72abdee24cbmr33253023b3a.22.1735201407809; 
 Thu, 26 Dec 2024 00:23:27 -0800 (PST)
Date: Thu, 26 Dec 2024 08:22:30 +0000
In-Reply-To: <20241226082236.2884287-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20241226082236.2884287-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241226082236.2884287-12-wuhaotsh@google.com>
Subject: [PATCH 11/17] hw/misc: Rename npcm7xx_clk to npcm_clk
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, mimik-dev@google.com, 
 hskinnemoen@google.com, venture@google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3fxJtZwgKCpoQOB4INMBAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--wuhaotsh.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

NPCM7XX and NPCM8XX have a different set of CLK registers. This
commit changes the name of the clk files to be used by both
NPCM7XX and NPCM8XX CLK modules.

Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/misc/meson.build                           | 2 +-
 hw/misc/{npcm7xx_clk.c => npcm_clk.c}         | 2 +-
 include/hw/arm/npcm7xx.h                      | 2 +-
 include/hw/misc/{npcm7xx_clk.h => npcm_clk.h} | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename hw/misc/{npcm7xx_clk.c => npcm_clk.c} (99%)
 rename include/hw/misc/{npcm7xx_clk.h => npcm_clk.h} (98%)

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 9bab048849..743066eb96 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -67,7 +67,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx_rngc.c',
 ))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
-  'npcm7xx_clk.c',
+  'npcm_clk.c',
   'npcm_gcr.c',
   'npcm7xx_mft.c',
   'npcm7xx_pwm.c',
diff --git a/hw/misc/npcm7xx_clk.c b/hw/misc/npcm_clk.c
similarity index 99%
rename from hw/misc/npcm7xx_clk.c
rename to hw/misc/npcm_clk.c
index 46f907b61c..2bcb731099 100644
--- a/hw/misc/npcm7xx_clk.c
+++ b/hw/misc/npcm_clk.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/misc/npcm7xx_clk.h"
+#include "hw/misc/npcm_clk.h"
 #include "hw/timer/npcm7xx_timer.h"
 #include "hw/qdev-clock.h"
 #include "migration/vmstate.h"
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 2e708471ec..e80fd91f20 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -23,7 +23,7 @@
 #include "hw/gpio/npcm7xx_gpio.h"
 #include "hw/i2c/npcm7xx_smbus.h"
 #include "hw/mem/npcm7xx_mc.h"
-#include "hw/misc/npcm7xx_clk.h"
+#include "hw/misc/npcm_clk.h"
 #include "hw/misc/npcm_gcr.h"
 #include "hw/misc/npcm7xx_mft.h"
 #include "hw/misc/npcm7xx_pwm.h"
diff --git a/include/hw/misc/npcm7xx_clk.h b/include/hw/misc/npcm_clk.h
similarity index 98%
rename from include/hw/misc/npcm7xx_clk.h
rename to include/hw/misc/npcm_clk.h
index 5ed4a4672b..0aef81e10c 100644
--- a/include/hw/misc/npcm7xx_clk.h
+++ b/include/hw/misc/npcm_clk.h
@@ -13,8 +13,8 @@
  * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
  * for more details.
  */
-#ifndef NPCM7XX_CLK_H
-#define NPCM7XX_CLK_H
+#ifndef NPCM_CLK_H
+#define NPCM_CLK_H
 
 #include "exec/memory.h"
 #include "hw/clock.h"
@@ -177,4 +177,4 @@ struct NPCM7xxCLKState {
 #define TYPE_NPCM7XX_CLK "npcm7xx-clk"
 OBJECT_DECLARE_SIMPLE_TYPE(NPCM7xxCLKState, NPCM7XX_CLK)
 
-#endif /* NPCM7XX_CLK_H */
+#endif /* NPCM_CLK_H */
-- 
2.47.1.613.gc27f4b7a9f-goog



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5979AC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 22:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgA6w-0005sY-2g; Thu, 06 Feb 2025 17:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3xzOlZwgKCgg42piw10powwotm.kwuymu2-lm3mtvwvov2.wzo@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6n-0005jg-Sh
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:29 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3xzOlZwgKCgg42piw10powwotm.kwuymu2-lm3mtvwvov2.wzo@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6l-0001Ss-SV
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:29 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-21f3aad4e0bso15778255ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 14:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738879944; x=1739484744; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=dxX6imhWZ2mg4ZjjitY6mh/e3sKQjimnzWB10ozPo74=;
 b=Q0T+U5zMkpTJVEenrITLIc3qFUaXFkrgUhkYKBRnZvkJDTN2mt0w0Oj4KJQvXQ2tse
 TZaSoeqJ+GNKPVqAw11sq7pQEaVb6B8o/CVH+iTzR3Rbg32Ykh+x6ZMSPqYr/oAdYRv5
 gIJqot/W8lvnUVsYFhQFmaDDSQRU7M1xVQhwhfMy6Ul1PnPUzAT3+bBRHyR9pdu4TehG
 Fp3aODPtRwBT4zm03AkxQQrgaI1DMySnCvwV9rW0BMwdSDNuj+CHrv4HK/cqwlt8vRRC
 bPrsxJoJXrK+4hwo5VZXv8K02BwICtVs4lVMqRtJtqj07iGFHFBv1SOeCIYN9vqXJJHT
 Z5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738879944; x=1739484744;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dxX6imhWZ2mg4ZjjitY6mh/e3sKQjimnzWB10ozPo74=;
 b=KREKNpiSyfMLg5kfEBXB+5MUwUvwzIsdOH6DHf+52j5ZSveIH9BwQqrNVtf4FO6YJs
 Ggi/5hV3CxJqFXC8dK3lUppUNcBUP64vTBc+KMUTop1RzIvJgt5jpB5AUiw9JEjuLJgD
 gY9lUfLSj+c+SttdvnvBBDfUjq2TdgX8S5O7fsyBZHmI7+jHB7+sohaAmMY4qxI6y+BC
 9kmDNXGe9+qpSwfjNfTU08jnrWspNQ8wx8BXlRsHYKOxA2vBs65LY+/1T+CmsBSyHGzm
 Yx7U62jvKdM7UPwa3FPWmgCKTl8VoXKlpbIX2FkDjXkiq+q8pnug0tL7SdorptoYVTFu
 ctjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBkg1ruRDSRbBBZBNWfTSMysxjM3GsiNraixWWOtUNGaWINFbueta/a8jR76en2zg/0NVNKrqpkg2Y@nongnu.org
X-Gm-Message-State: AOJu0YxgqSO1eKZW0BDJiKDJd/NBp240gbtnDpUx5rMcved0PRSZXgaH
 MbhKRzPJt6IVX2ySimUjNnjoxQsXfDf9L0Cvm3fFIYOokZvTzbcAfM7gc/Q4DreO9QTgkv5jxT1
 DD6EeCIyzbg==
X-Google-Smtp-Source: AGHT+IGVoOEmyJs4I9rn9/wdD8pWiEqvTZY/RZFGej0twbFkVaXylFzxv5VMbBjKDNLBWEgFP8WlSQXg6OEAOw==
X-Received: from plbmq6.prod.google.com ([2002:a17:902:fd46:b0:212:48d4:bf16])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e547:b0:212:996:3536 with SMTP id
 d9443c01a7336-21f4e1cb73fmr15396815ad.10.1738879943875; 
 Thu, 06 Feb 2025 14:12:23 -0800 (PST)
Date: Thu,  6 Feb 2025 14:11:56 -0800
In-Reply-To: <20250206221203.4187217-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250206221203.4187217-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250206221203.4187217-11-wuhaotsh@google.com>
Subject: [PATCH v4 10/17] hw/misc: Rename npcm7xx_clk to npcm_clk
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3xzOlZwgKCgg42piw10powwotm.kwuymu2-lm3mtvwvov2.wzo@flex--wuhaotsh.bounces.google.com;
 helo=mail-pl1-x649.google.com
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

NPCM7XX and NPCM8XX have a different set of CLK registers. This
commit changes the name of the clk files to be used by both
NPCM7XX and NPCM8XX CLK modules.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index 554eb8df5b..edd36a334d 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -69,7 +69,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
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
2.48.1.502.g6dc24dfdaf-goog



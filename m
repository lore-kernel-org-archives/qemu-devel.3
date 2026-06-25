Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3038ACDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 16:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcmna-0005er-IH; Thu, 25 Jun 2026 12:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wcmnY-0005eL-Qj
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:19:28 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wcmnX-0003oU-57
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:19:28 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2c7ebfbf2d4so726175ad.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782404366; x=1783009166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K82E4fxnYs4wa6spLteaHEu2eJm+SqxaqxjWMNVznqg=;
 b=H+/6C6rZKpb05NCd76x7iSgY8QA7IJgq2RrxvqXpYJnuH9eoOB3ZWTI/j5I6jasWSb
 WP0paVSg57tWIPswyBnZIJuZ2qW6E6txvxRCEXTZY5GCf7FUxkUJTGDaL224OcEoO6yd
 FEHO3VxlIhYvosJwG9bYLWCoy+/6X8yFxML7r6pfJ6r6NFAvy2+5GNOcDh1+pmok3luk
 +3j9VFlBYbWaKZSgvWOoNwb4KZCBrVJ7cr0KdScFHCBpzMZJ5c+xdAvJHwIHCk0mTgIR
 9k7JtrEsqsW//kQQDmE2cUD4J2LY+4va1e58bbiF5TB524QVGFD5+CqyqjKfltJ/TRAG
 5Amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782404366; x=1783009166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K82E4fxnYs4wa6spLteaHEu2eJm+SqxaqxjWMNVznqg=;
 b=JqRGbzV0l7J6lGg6X0oXc3bFfLQ8obtD6MncF/KpKkFRiuPzDGvIoLcML51glHN9Z8
 h09Yns2KcAIUrRiONOVhIWM0Rses4O5fkfHLSP8MPnCRp27114Qam9n961ohAengskiS
 KdKQxbpfLYo5mmHHZGipiNZRfNHIFyHJTGuryWwI7lhQzaDa9xGfsmyWB7y+Fps/WHMc
 8nQHZTLdA1mDgS5PGD84DCooNIl1kacz8M+m6g+BrtWlnALlKruMspQ9UZ+LE7y/LX6v
 mqinF/J4nju0rhic5oiu44UaedcdGJtMidq/mVt5jzo6fazHWLZVlqSlrK0QOU7JPGt6
 tk5A==
X-Gm-Message-State: AOJu0YwuqD1vy7B7vYp+YjptfdUzW7gkX/HiBHoye1H802tYpvBABc+G
 RoekKySOlU2AfxPUix6qp+M2zpBi9e9vVGNudDy3DqqnmKjYM26quZ6pHuG52aw8eq0=
X-Gm-Gg: AfdE7clRrTK4nS/S0yiBiVTsJ4dKT+KUbUoOB9518ZTcu7RPa327uMCNGAlVGmu+EYj
 Ehg2+JY8qBaxs/2Cex2iTe7B5s1RhA9AgBSl3Gf6cEsfG/Vz6uM2IdjXiSsELoavG9hWbm5co29
 YDfr7gcorKwF7L4+oMPaVMRpG03sDqeJ7L73Z2juIL4YQKpI3a8inSvBt3ElnP0jNGX1wrDSvq1
 Xmi7pHZRWZTTiDd02znBIZPtUnKHTh0nyrs76TKhTkg2Bontv5t9CwC4+2vX+QaqGsUXu/cRRcl
 0NiVL5rqjIr1vyxKV07L343B/YJutbGHG9crMUht1KKlMMEZzWgDnYTsbKXBbQ2WyyfoKvhSBMH
 piLRM2FvYJbOsNcks996bWY31nGrAXWJ1yQMqAq1VD8dkUIX9hKMGwNJeJrUXH3dDBEGOhAThPB
 QzlFV7zE46/Ud5DStXQxjRg5cH10c=
X-Received: by 2002:a17:903:32c8:b0:2b0:608d:d8a8 with SMTP id
 d9443c01a7336-2c7fc7098e9mr31300685ad.1.1782404365529; 
 Thu, 25 Jun 2026 09:19:25 -0700 (PDT)
Received: from localhost.localdomain ([212.135.211.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f64dc839sm22650235ad.68.2026.06.25.09.19.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Jun 2026 09:19:24 -0700 (PDT)
From: jack wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org
Cc: jack wang <163wangjack@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:i.MX31 (kzm))
Subject: [PATCH v3 3/3] hw/misc/imx31_ccm: Replace DPRINTF with trace events
Date: Fri, 26 Jun 2026 00:18:54 +0800
Message-ID: <20260625161855.5132-4-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625161855.5132-1-163wangjack@gmail.com>
References: <20260625161855.5132-1-163wangjack@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=163wangjack@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: jack wang <163wangjack@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/imx31_ccm.c  | 33 ++++++++++-----------------------
 hw/misc/trace-events | 10 ++++++++++
 2 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/hw/misc/imx31_ccm.c b/hw/misc/imx31_ccm.c
index 339458e859..e3edd6df8f 100644
--- a/hw/misc/imx31_ccm.c
+++ b/hw/misc/imx31_ccm.c
@@ -16,21 +16,10 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "hw/misc/trace.h"
 
 #define CKIH_FREQ 26000000 /* 26MHz crystal input */
 
-#ifndef DEBUG_IMX31_CCM
-#define DEBUG_IMX31_CCM 0
-#endif
-
-#define DPRINTF(fmt, args...) \
-    do { \
-        if (DEBUG_IMX31_CCM) { \
-            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX31_CCM, \
-                                             __func__, ##args); \
-        } \
-    } while (0)
-
 static const char *imx31_ccm_reg_name(uint32_t reg)
 {
     static char unknown[20];
@@ -120,7 +109,7 @@ static uint32_t imx31_ccm_get_pll_ref_clk(IMXCCMState *dev)
         freq = CKIH_FREQ;
     }
 
-    DPRINTF("freq = %u\n", freq);
+    trace_imx31_ccm_get_pll_ref_clk(freq);
 
     return freq;
 }
@@ -133,7 +122,7 @@ static uint32_t imx31_ccm_get_mpll_clk(IMXCCMState *dev)
     freq = imx_ccm_calc_pll(s->reg[IMX31_CCM_MPCTL_REG],
                             imx31_ccm_get_pll_ref_clk(dev));
 
-    DPRINTF("freq = %u\n", freq);
+    trace_imx31_ccm_get_mpll_clk(freq);
 
     return freq;
 }
@@ -150,7 +139,7 @@ static uint32_t imx31_ccm_get_mcu_main_clk(IMXCCMState *dev)
         freq = imx31_ccm_get_mpll_clk(dev);
     }
 
-    DPRINTF("freq = %u\n", freq);
+    trace_imx31_ccm_get_mcu_main_clk(freq);
 
     return freq;
 }
@@ -163,7 +152,7 @@ static uint32_t imx31_ccm_get_hclk_clk(IMXCCMState *dev)
     freq = imx31_ccm_get_mcu_main_clk(dev)
            / (1 + EXTRACT(s->reg[IMX31_CCM_PDR0_REG], MAX));
 
-    DPRINTF("freq = %u\n", freq);
+    trace_imx31_ccm_get_hclk_clk(freq);
 
     return freq;
 }
@@ -176,7 +165,7 @@ static uint32_t imx31_ccm_get_ipg_clk(IMXCCMState *dev)
     freq = imx31_ccm_get_hclk_clk(dev)
            / (1 + EXTRACT(s->reg[IMX31_CCM_PDR0_REG], IPG));
 
-    DPRINTF("freq = %u\n", freq);
+    trace_imx31_ccm_get_ipg_clk(freq);
 
     return freq;
 }
@@ -201,7 +190,7 @@ static uint32_t imx31_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
         break;
     }
 
-    DPRINTF("Clock = %d) = %u\n", clock, freq);
+    trace_imx31_ccm_get_clock_frequency(clock, freq);
 
     return freq;
 }
@@ -210,7 +199,7 @@ static void imx31_ccm_reset(DeviceState *dev)
 {
     IMX31CCMState *s = IMX31_CCM(dev);
 
-    DPRINTF("()\n");
+
 
     memset(s->reg, 0, sizeof(uint32_t) * IMX31_CCM_MAX_REG);
 
@@ -244,8 +233,7 @@ static uint64_t imx31_ccm_read(void *opaque, hwaddr offset, unsigned size)
                       HWADDR_PRIx "\n", TYPE_IMX31_CCM, __func__, offset);
     }
 
-    DPRINTF("reg[%s] => 0x%" PRIx32 "\n", imx31_ccm_reg_name(offset >> 2),
-            value);
+    trace_imx31_ccm_read(imx31_ccm_reg_name(offset >> 2), value);
 
     return (uint64_t)value;
 }
@@ -255,8 +243,7 @@ static void imx31_ccm_write(void *opaque, hwaddr offset, uint64_t value,
 {
     IMX31CCMState *s = (IMX31CCMState *)opaque;
 
-    DPRINTF("reg[%s] <= 0x%" PRIx32 "\n", imx31_ccm_reg_name(offset >> 2),
-            (uint32_t)value);
+    trace_imx31_ccm_write(imx31_ccm_reg_name(offset >> 2), value);
 
     switch (offset >> 2) {
     case IMX31_CCM_CCMR_REG:
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index ebe9b4fb22..0c2565ddb8 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -282,6 +282,16 @@ imx25_ccm_get_clock_frequency(unsigned clock, uint32_t freq) "(clock = %d) = %u"
 imx25_ccm_read(const char *reg, uint32_t value) "reg[%s] => 0x%" PRIx32
 imx25_ccm_write(const char *reg, uint32_t value) "reg[%s] <= 0x%" PRIx32
 
+# imx31_ccm.c
+imx31_ccm_get_mpll_clk(uint32_t freq) "freq = %u"
+imx31_ccm_get_pll_ref_clk(uint32_t freq) "freq = %u"
+imx31_ccm_get_mcu_main_clk(uint32_t freq) "freq = %u"
+imx31_ccm_get_hclk_clk(uint32_t freq) "freq = %u"
+imx31_ccm_get_ipg_clk(uint32_t freq) "freq = %u"
+imx31_ccm_get_clock_frequency(unsigned clock, uint32_t freq) "(clock = %u) = %u"
+imx31_ccm_read(const char *reg, uint32_t value) "reg[%s] => 0x%" PRIx32
+imx31_ccm_write(const char *reg, uint32_t value) "reg[%s] <= 0x%" PRIx32
+
 # iotkit-sysinfo.c
 iotkit_sysinfo_read(uint64_t offset, uint64_t data, unsigned size) "IoTKit SysInfo read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 iotkit_sysinfo_write(uint64_t offset, uint64_t data, unsigned size) "IoTKit SysInfo write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
-- 
2.53.0



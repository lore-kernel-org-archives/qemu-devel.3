Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96586C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggif-0007E2-Uf; Mon, 06 Jul 2026 06:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiX-00078d-RO
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:28 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiV-0003Sg-AK
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:24 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493d3135e9bso9791455e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334302; x=1783939102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=y/0Zd7CUzH0PPeoSVODnw+EEXZ3iP23Jw7rMZzP5HjM=;
 b=ISgee2/O2fHt+kQL2LcAtYx1B/xiS9y2P1YUXQH80OkpwuS3VJ6kPdRWMQjG7/YmyD
 BDI23yDwc/OR+5DNCR7eXJJo2CorCiI87t0INsbeuIVnLY02o32fqryNs6GlZDkV4/nM
 TIE0tyNBzbPGo6SUmwtokYMVliuEMYBeNnMBHuhUMgYherShqKkoh+bmv7aiopD/wzk5
 1YEtnWrRjhlp6o27rPVhYHwLw67IO9WXEcNIOykbsdvK0d9BSuibWw8xiZA5y2pRURwm
 L7HXMiHf0ZeedN1nTwalnFI2nOU1WhRJ8niX7lGB/S2bD3/4zsbDBZxaeihg0+skKW/a
 YBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334302; x=1783939102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=y/0Zd7CUzH0PPeoSVODnw+EEXZ3iP23Jw7rMZzP5HjM=;
 b=bSvEJptadwdT7oRHGM2lrAazrLHzo3NSNNfkBDRPs2B1Jk7N87TWdDwqNjySoegcOY
 qSxIztAkk41WjGoXxuLI/Q5/P7BXJp889WSmbC0AchKjFnMbebH5rftWs1MwCZibHp6N
 GXeDm25Zl7JgW/Vd8iZtgZwMtBcgLPJ8AFPTCv/8B9b+YsRiGLNNoN4EgDO2YE78DGrr
 lxPoukBrz1LqoOxgkj86dWsIoKmzItxCk0+6pv5aZTx4KG6kHBl/87VcXSokVFeRpiGj
 jabaHCroP7ToxJdCl0s46qnZ9dn/q8lqQHaP8VgSICMLky3RLWCVXZbEVkgntFtXqPRn
 UYaA==
X-Gm-Message-State: AOJu0Yz0/2n6/WdZOF8SgCINvGbVZOFPbjJrfX0st1vmG+FH/OIhnL0M
 GuUPc7qjcGg4CbH7lBan4O6A8rzxB30i2Fu3PAi0RFUx8E7Utqy7Ef3yUxleOqrl1lkNikSyHgC
 nJ4V6yX3fQQ==
X-Gm-Gg: AfdE7cmM0+PCt13WwofYkX2yhYHF0p4NRS495NVDzinNxJENmyYkM+AcpFmyjxb1mYG
 +NwoaYDLI44cAHTPVXCZXzaRm/RRNBYiLJIK+gdPEFs9+/7LAjUx2uiQQ0af1KEdnhxkJiASKMU
 Qk2RPtdfHH2g4FWllmhDhI4DY/VAFC8glduTzlfY0mYN/N2XzjVNDokqfaBa929UB/ztm7WDCn4
 c8sEuK3f+61Z+g/CrHurKRD+pRGDKfto+RJ0V6aoAZPUbM/n/jk46kcfaO/NkD20lsSNQH7BNd/
 ia5YusSUwYSn7nf2k0wcO8c7lQLm7ynHBi0VY98WT8fb5XfrdKljbhy4VJlIJOq6LDTrV31Ki/b
 zuF9pt9Kf/Xc8Rkl7ScAeBYX5KLfQG05yJHvd977WPaZ36UOHKNOU3cZT+1BXAcr4A3Z+7MQWWA
 0mwJ9ZPS4nZGjiVSSWTLx/1K689HNW2oMshWSxxlOkJDvYZPXQFVIUjSFiPZ+RFnCaRSWUVRhZY
 4+5doMBuoPCu0HtpPzUhQ==
X-Received: by 2002:a05:600c:4e92:b0:493:c337:db18 with SMTP id
 5b1f17b1804b1-493d11d81a4mr124399575e9.16.1783334301957; 
 Mon, 06 Jul 2026 03:38:21 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/49] hw/misc/imx31_ccm: Replace DPRINTF with trace events
Date: Mon,  6 Jul 2026 11:37:28 +0100
Message-ID: <20260706103752.320511-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
[PMM: Remove stray loss of a brace; use trace.h]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/imx31_ccm.c  | 33 +++++++++------------------------
 hw/misc/trace-events | 10 ++++++++++
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/hw/misc/imx31_ccm.c b/hw/misc/imx31_ccm.c
index 339458e859..8d620711dd 100644
--- a/hw/misc/imx31_ccm.c
+++ b/hw/misc/imx31_ccm.c
@@ -16,21 +16,10 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "trace.h"
 
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
@@ -210,8 +199,6 @@ static void imx31_ccm_reset(DeviceState *dev)
 {
     IMX31CCMState *s = IMX31_CCM(dev);
 
-    DPRINTF("()\n");
-
     memset(s->reg, 0, sizeof(uint32_t) * IMX31_CCM_MAX_REG);
 
     s->reg[IMX31_CCM_CCMR_REG]   = 0x074b0b7d;
@@ -244,8 +231,7 @@ static uint64_t imx31_ccm_read(void *opaque, hwaddr offset, unsigned size)
                       HWADDR_PRIx "\n", TYPE_IMX31_CCM, __func__, offset);
     }
 
-    DPRINTF("reg[%s] => 0x%" PRIx32 "\n", imx31_ccm_reg_name(offset >> 2),
-            value);
+    trace_imx31_ccm_read(imx31_ccm_reg_name(offset >> 2), value);
 
     return (uint64_t)value;
 }
@@ -255,8 +241,7 @@ static void imx31_ccm_write(void *opaque, hwaddr offset, uint64_t value,
 {
     IMX31CCMState *s = (IMX31CCMState *)opaque;
 
-    DPRINTF("reg[%s] <= 0x%" PRIx32 "\n", imx31_ccm_reg_name(offset >> 2),
-            (uint32_t)value);
+    trace_imx31_ccm_write(imx31_ccm_reg_name(offset >> 2), value);
 
     switch (offset >> 2) {
     case IMX31_CCM_CCMR_REG:
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 13f120d140..c9a868b3ef 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -284,6 +284,16 @@ imx25_ccm_get_clock_frequency(unsigned clock, uint32_t freq) "(clock = %d) = %u"
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
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8D5CDE002
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 16:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcmWw-0007dB-CM; Thu, 25 Jun 2026 12:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wcmWu-0007aT-Px
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:02:16 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wcmWs-0006Z7-SZ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:02:16 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c86307c4e6bso24096a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782403333; x=1783008133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GqaVVqTmkp/8EUEqbNbsHQkfMzS6zhGuIkW9Rs9oFcs=;
 b=l1obKsaHgwqq0qYsLqVj/GFP08/xTSTRNVE98ov+VujXRmUB52s3xjhICfT+iNnsDs
 LFvDj76zRF2z/R3JNJtVO4HHnqImlpvWGNHWTlpILk/uc1cv0AK6pGM5ePiiswk/+i/6
 HX8WBJAw52n6MG+8ObPXjhgJTmbnTG1SkbkiD5qMwt8M9f4tmuhldXbauc/fh4mX2vV0
 WIxYUEswDvJfx0iTKxWbGn82oWnwYEgYgJl+eBFHswt+JiZ6lveQakHJK2I8iyEp78X+
 C5WiKk4XJGNZ2HAwFk8mZ3CsS35AIB22Ir450gJV1ucDp7aL+o4IT68tND4SP5M6s7Fz
 SvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782403333; x=1783008133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GqaVVqTmkp/8EUEqbNbsHQkfMzS6zhGuIkW9Rs9oFcs=;
 b=j2iMguL/z+8RveuSZ6wI36mOd3625VmMh7aAdHK9PmOMVt+b+wiesZhuNV0zVER8lJ
 l5GrJ6H2bp8IeH8P/jIPD+kL/cM+kmvgKpOIdsMFzdwmb3S3Sjj6ZJ8mRboPmH5uyH8u
 mlE93gQuqkh4vXqpBI2F6FDdcMqHCBgPgV9ODbeEbdzR/8+TVwgGKnaPeF4zV1+49/gu
 o8svtn7/uym2xZUzktWAwLyKh+SMmBDWz0ZDNrlrM1rv0yXvdQNoYqS1R0zffQhAF/tt
 bJnMwUP59z7npraBS7RGhteqS2kMe2V/cyyYnZfEMYzoW+Esg8FDoghB8ulnQuxdcLMH
 kZRQ==
X-Gm-Message-State: AOJu0Yx7XYiKRq0AbfWuct7BHPs8rtZAIgbIrFhPKXHCXntE1/g/OzSY
 8y1ZeQPyPM+yUAr3mQ2pL38zOrbtNi4jkhYafHUU0G3EZRdx7m1JJjI0Z562ikqtzVA=
X-Gm-Gg: AfdE7cmoo9KlyxvM31pGFQ3F1bA3fKuJFUlnovrlIDWlWMVK32HRu4TG2mWT+BFJ+b4
 +wuoyalNg0hORQCk5W92Y9JRqgr4NMzhKtNyiN3T4yfeOUyw9f2WgOb/7bUdvV7XvkOxAt0cLe4
 mV4GpRyjbkvhnkSBuNpA8xn70v0GOtOyoBE0lFNTorHwHyd+6O1pTrXN8l6uRL/Jt+A7WUEQkyj
 DEgMpAccWm/n1BzR/bG2NjfoR+7dsrjEycIQhdnHNOoDP5ibzm5SO8dC92MtLEUtkUvaC55/pQx
 nVi6N/qFthkQhoXpCF+gMXcNcsohw9EXNOgWH9zIgYcXh9JkXGXBe2fHE3tZrdNU6ZFwPgWJs69
 K29Iik4AEMHh0UBjFrawiuK0IiqN/4E4xLvRehT8IE7TlZCen6k0WcV6GCglJyA0WQfotMY1Gld
 mq6k/w/mEew4tq+WCrgQkB/Wuu3A4=
X-Received: by 2002:a05:6a20:2324:b0:3b4:8f2c:6805 with SMTP id
 adf61e73a8af0-3bd4b01a2admr3745697637.42.1782403333122; 
 Thu, 25 Jun 2026 09:02:13 -0700 (PDT)
Received: from localhost.localdomain ([212.135.211.99])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c92bcb9c14asm1924522a12.24.2026.06.25.09.02.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Jun 2026 09:02:12 -0700 (PDT)
From: jack wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org
Cc: jack wang <163wangjack@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 qemu-arm@nongnu.org (open list:i.MX25 PDK)
Subject: [PATCH v2 3/3] hw/misc/imx31_ccm: Replace DPRINTF with trace events
Date: Fri, 26 Jun 2026 00:01:44 +0800
Message-ID: <20260625160144.94565-4-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625160144.94565-1-163wangjack@gmail.com>
References: <20260625160144.94565-1-163wangjack@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=163wangjack@gmail.com; helo=mail-pg1-x536.google.com
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
---
 hw/misc/imx25_ccm.c  |  2 +-
 hw/misc/imx31_ccm.c  | 33 ++++++++++-----------------------
 hw/misc/trace-events | 10 ++++++++++
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/hw/misc/imx25_ccm.c b/hw/misc/imx25_ccm.c
index d051e8a2d1..4ca4cb6672 100644
--- a/hw/misc/imx25_ccm.c
+++ b/hw/misc/imx25_ccm.c
@@ -102,7 +102,7 @@ static uint32_t imx25_ccm_get_mpll_clk(IMXCCMState *dev)
     uint32_t freq;
     IMX25CCMState *s = IMX25_CCM(dev);
 
-    if (EXTRACT(s->reg[IMX25_CCM_CCTL_REG], MPLL_BYPASS)) {
+    if (EXTRACT(s->reg[IMX25_CCM_CCTL_REG], MPLL_BYPASS)) 
         freq = CKIH_FREQ;
     } else {
         freq = imx_ccm_calc_pll(s->reg[IMX25_CCM_MPCTL_REG], CKIH_FREQ);
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB84CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZoyk-000460-GW; Wed, 17 Jun 2026 08:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wZowI-00033P-4m
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:00:14 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wZowG-0008JG-EZ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:00:13 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-37cae9b7536so457597a91.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 05:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781697610; x=1782302410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DcM1fU4v1GVwSrrIPjg6LuptyJklzv35LiIaFMncmqI=;
 b=OHo9YKBLDacoCXOGQjtXdi7fZIASFl2E+qUBuoKOFhsvlLLTesz6zaco6Fc5CR5WFt
 //jMaFCE4bFjzbautzeSWR3odwCPt6eblM8+Oc/UND73gfAsWivmx/Az9Knampnn/tIb
 YHUoUHeC8gr3KTRX6WGXD1+B9fudgHy70McDF4PyWptVtfSEgmxWbFP0i5gv2uBjunrw
 42mNNegs6kWW4i00p0SlggEom7rAbHos9Pv9/k+oMY8ozoJgXBBQH7YI2nz29zPxrh2F
 6ixC4tkmlmts9DRAg7buWYEQRNVNKkzYb4qJ0wkmXMCm7re6JYWg6rJt/Lgro2HxuiLv
 2cOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781697610; x=1782302410;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DcM1fU4v1GVwSrrIPjg6LuptyJklzv35LiIaFMncmqI=;
 b=hTkZfxznp8qtsu8lJVtXQ5r6A7pQt66Mod5talOE7Tn/lUm2YwAk5o9movCXCwYLQS
 Wkwk+qS00RGnnBi3ByTfZt32QyN2nfGCAfVbH8WeYfzyOhZB7lXpPFgMDdiH1BurrPZr
 pnfbdVndQXV/7kCeA5mSUfVaItXUFBccI5v8Uv75ggMDDmqOooI3SmzQvk3SceP53hFK
 o+NdiyOI5voomj7C7xk+6pONhL+uAeA3Lv9gjm3Qr8jUPP0qPmMJaK/XaauFshYhd495
 bSmM0NNCg7Bm81znrZCNGr40Uw2pmPDY+rTfkvA3lOVVL1cZHEZ3YFMnn8wh+mFb4Iou
 mFng==
X-Gm-Message-State: AOJu0YzRLFl90u975ZxRywj1xI4HkJwHxPla1/ZXPv3tXuXrdO+xnhzx
 /ZZfJnOE4Tx9QWin1C6hLNzY78HFx+h+8vMFH/+wro0gFag/tfZok97md19WmQ==
X-Gm-Gg: AfdE7cnrE3QC2HhRiaqdPdr3GyoaoDgYTkEryEylLRS8cziSXng5CqaqnewTGwQLuJB
 fEHUD7X/vDiytfMfnq8izLYX0dpOJNNLwXg0Vn84NIHy5SS9YOhuxx4uMo6SxL4hifSuZNN9rco
 ZiFb7K2ZPEnB+jZZ12gAWaE3+UJeWkzVV3MplKo2YwpOi8kfHhasSfTTmEgs3zpBdQIp3abgLe1
 VA8G3Bklj+8+zRVvIZ0a2BiTL76rgPlNbkecMGeUxaSTEi2I6lLx/fI3gsR0Z5Dq42BXugtDzhC
 drXAiSMaLys4eXsY0iIz2G2tTDDcdJcm0pxkj+HcOnSnh3uo6ebZeDLva6K2ENqvws8F4YoL7Ou
 Szwdh+Kn9eZNxs2AtFxEELg6ctbXhs0dKATKnFRPbj4ONNTIhZdw03TCPPQfxZNR6S9yCEiZkIT
 tffclQiOoVDeMzAR4FUXN2P9Dl
X-Received: by 2002:a17:90b:3805:b0:36b:71e6:3df1 with SMTP id
 98e67ed59e1d1-37c930e0adbmr3542661a91.3.1781697610391; 
 Wed, 17 Jun 2026 05:00:10 -0700 (PDT)
Received: from localhost.localdomain ([82.40.42.115])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521ae039sm5912367a91.1.2026.06.17.05.00.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 05:00:09 -0700 (PDT)
From: Wang Yuxin <163wangjack@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-trivial@nongnu.org
Cc: peter.maydell@linaro.org, mjt@tls.msk.ru, laurent@vivier.eu,
 Wang Yuxin <163wangjack@gmail.com>
Subject: [PATCH trivial v2] hw/timer/imx_epit: Replace DPRINTF with trace
 events
Date: Wed, 17 Jun 2026 19:59:49 +0800
Message-ID: <20260617115949.93529-1-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=163wangjack@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jun 2026 08:02:38 -0400
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

Clean up the codebase by removing the outdated DEBUG_IMX_EPIT
and DPRINTF macros, replacing them with modern QEMU trace events.

This also removes an empty and meaningless DPRINTF("\n") in the
imx_epit_realize function.

Signed-off-by: jw_mac <163wangjack@gmail.com>
Signed-off-by: Wang Yuxin <163wangjack@gmail.com>
---
 hw/timer/imx_epit.c   | 25 +++++--------------------
 hw/timer/trace-events |  8 ++++++++
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
index c67a39f10c..476e2771b3 100644
--- a/hw/timer/imx_epit.c
+++ b/hw/timer/imx_epit.c
@@ -20,18 +20,7 @@
 #include "hw/misc/imx_ccm.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
-
-#ifndef DEBUG_IMX_EPIT
-#define DEBUG_IMX_EPIT 0
-#endif
-
-#define DPRINTF(fmt, args...) \
-    do { \
-        if (DEBUG_IMX_EPIT) { \
-            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX_EPIT, \
-                                             __func__, ##args); \
-        } \
-    } while (0)
+#include "trace.h"
 
 static const char *imx_epit_reg_name(uint32_t reg)
 {
@@ -80,7 +69,7 @@ static uint32_t imx_epit_get_freq(IMXEPITState *s)
     uint32_t prescaler = 1 + extract32(s->cr, CR_PRESCALE_SHIFT, CR_PRESCALE_BITS);
     uint32_t f_in = imx_ccm_get_clock_frequency(s->ccm, imx_epit_clocks[clksrc]);
     uint32_t freq = f_in / prescaler;
-    DPRINTF("ptimer frequency is %u\n", freq);
+    trace_imx_epit_get_freq(freq);
     return freq;
 }
 
@@ -146,8 +135,7 @@ static uint64_t imx_epit_read(void *opaque, hwaddr offset, unsigned size)
                       HWADDR_PRIx "\n", TYPE_IMX_EPIT, __func__, offset);
         break;
     }
-
-    DPRINTF("(%s) = 0x%08x\n", imx_epit_reg_name(offset >> 2), reg_value);
+    trace_imx_epit_read(imx_epit_reg_name(offset >> 2), reg_value);
 
     return reg_value;
 }
@@ -328,8 +316,7 @@ static void imx_epit_write(void *opaque, hwaddr offset, uint64_t value,
 {
     IMXEPITState *s = IMX_EPIT(opaque);
 
-    DPRINTF("(%s, value = 0x%08x)\n", imx_epit_reg_name(offset >> 2),
-            (uint32_t)value);
+    trace_imx_epit_write(imx_epit_reg_name(offset >> 2), (uint32_t)value);
 
     switch (offset >> 2) {
     case 0: /* CR */
@@ -362,7 +349,7 @@ static void imx_epit_cmp(void *opaque)
     /* The cmp ptimer can't be running when the peripheral is disabled */
     assert(s->cr & CR_EN);
 
-    DPRINTF("sr was %d\n", s->sr);
+    trace_imx_epit_cmp(s->sr);
     /* Set interrupt status bit SR.OCIF and update the interrupt state */
     s->sr |= SR_OCIF;
     imx_epit_update_int(s);
@@ -399,8 +386,6 @@ static void imx_epit_realize(DeviceState *dev, Error **errp)
     IMXEPITState *s = IMX_EPIT(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    DPRINTF("\n");
-
     sysbus_init_irq(sbd, &s->irq);
     memory_region_init_io(&s->iomem, OBJECT(s), &imx_epit_ops, s, TYPE_IMX_EPIT,
                           0x00001000);
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index ac5afe84e8..3c282800c6 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -122,3 +122,11 @@ hpet_ram_write_tn_cmp(uint8_t reg_off) "hpet_ram_writel HPET_TN_CMP + %" PRIu8
 hpet_ram_write_invalid_tn_cmp(void) "invalid HPET_TN_CMP + 4 write"
 hpet_ram_write_invalid(void) "invalid hpet_ram_writel"
 hpet_ram_write_counter_write_while_enabled(void) "Writing counter while HPET enabled!"
+
+# imx_epit.c
+imx_epit_get_freq(uint32_t freq) "ptimer frequency is %u"
+imx_epit_read(const char *name, uint32_t value) "(%s) = 0x%08x"
+imx_epit_write(const char *name, uint32_t value) "(%s, value = 0x%08x)"
+imx_epit_cmp(uint32_t sr) "sr was %d"
+
+
-- 
2.53.0



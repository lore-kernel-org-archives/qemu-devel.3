Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3AFCDE000
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 16:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcmnU-0005ct-Az; Thu, 25 Jun 2026 12:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wcmnS-0005cX-G2
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:19:22 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wcmnQ-0003nU-Uz
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:19:22 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c88d1d4543fso562602a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 09:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782404359; x=1783009159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=227EW3L/59hcD2Q03G8dQiLU/RR2N6DLxA0E9gs88jY=;
 b=K21ur7LBwejVxdQMRVAHLB7vcMWgaI2zrwOeSxsh5819t+gx4rCOaXtZWHxNlNeXzy
 RAxZA9iuL+zum04wO4Ua7agJhU35rnyTNOHShzdvO7gQJSE9icysH67Yu9aQaJjBRpdR
 LqnXxZzeOzOuCZc13vNgiu1nT86tombWE3IVKKclTChA7xwrtT1P4fOHnAqx48lKYr38
 ICtqjyxCFx2DffYjLNsV87RnZtwQX9eOSXg5/s5cG+Mtz771D0Iyh5jPY1TpFgQyJwT4
 /Xe5pzDfn2g4WW336ofSr0SV9z5vpAzpUJm+P+8rL1ajwT2v3Poco99RCb47dz310GCL
 L5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782404359; x=1783009159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=227EW3L/59hcD2Q03G8dQiLU/RR2N6DLxA0E9gs88jY=;
 b=ichZkxDeIG6j+YZxkv5CiIK9IIHePrsajuCf+l332JL8mDi/uJjcUeVnF51OTZGCVp
 Ve5Q01RnvTuYjc81UutWM57yzrpCExxoP4KL1DaeWCM5kLjquAdZ43stSV09KNnfxZp3
 buViGqytIBHj7Y6mKWmNeexppa+mw6SF3RiXH+ZufPJgfVDJPXBKepl5VJdJzaSLHqmq
 CIE0mZC0ZppoVn3IjthJLNwQ6kKTFQOfjbGdwlh5obywwsJIVAIQZISYK63OWstO2FW+
 5RWcNcyoIcbHbIy/J+ggRE+aS4f+Q+5rmnpPOM6K4p9lBL+auIHq0eV9rHiz229D+FsS
 iriw==
X-Gm-Message-State: AOJu0YySOIXSNQfHNIikpQTHdIRwaMeP42hOocMOkQ9SumwpxOqkMdE0
 vbiGz0x5mBp+kRyKGKrcMcfDy8UkQeZunG17HrqgmSTtpbrUCyiUF5ehw1tQ+8CVBg0=
X-Gm-Gg: AfdE7cnpbThsrUJeJ5i8XWxed3oWNIWbrw6gY2e1LMJ9WQNDY/SrZkSujk1dpCnqrPs
 U/hSBINacsJJDkBZCqz+1iZjN/RmLGaWodz00Uq03Xh1DphfmtoBPhuxb3LtX1/meFg9M1Nkchq
 fuLbYMyW4AC5HZlpOHfTneM/wD05qYbN44+iq74V11jGofU+5VTplPv0wrXLmsQEw4JcqUpoltd
 y4SWiCDxpJnGq1UoEoCTCpW/dURP5Sh/ZRcHGgLV4hE0pEWrCO/O1gL7H8mwHxrmkft1QngCU9a
 bhVum1o5cKNBAQIeJCkobIWSoeyEduayQQAo2qeWlQ+8q7cvn0J3kFwl4tnuWSh/uQcCNdIeQXN
 FMNiABhwLMSH9gBYI5dloFN5WgY0izuxQfLr9I8674tgI9YLf6gaoNxUX4dN3L1/E5Ie+udV3dI
 4nLlbenpCNjHCWn/qfxfzuOup4BMc=
X-Received: by 2002:a17:903:1aed:b0:2bf:361e:3edc with SMTP id
 d9443c01a7336-2c7c3d2ad1bmr115880275ad.2.1782404359554; 
 Thu, 25 Jun 2026 09:19:19 -0700 (PDT)
Received: from localhost.localdomain ([212.135.211.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f64dc839sm22650235ad.68.2026.06.25.09.19.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Jun 2026 09:19:17 -0700 (PDT)
From: jack wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org
Cc: jack wang <163wangjack@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:i.MX31 (kzm))
Subject: [PATCH v3] hw/timer/imx_epit: Replace DPRINTF with trace events
Date: Fri, 26 Jun 2026 00:18:52 +0800
Message-ID: <20260625161855.5132-2-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625161855.5132-1-163wangjack@gmail.com>
References: <20260625161855.5132-1-163wangjack@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=163wangjack@gmail.com; helo=mail-pg1-x529.google.com
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

Clean up the codebase by removing the outdated DEBUG_IMX_EPIT
and DPRINTF macros, replacing them with modern QEMU trace events.

This also removes an empty and meaningless DPRINTF("\n") in the
imx_epit_realize function.

Signed-off-by: jack wang <163wangjack@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/timer/imx_epit.c   | 25 +++++--------------------
 hw/timer/trace-events |  8 ++++++++
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
index c67a39f10c..374ec7d324 100644
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
+    trace_imx_epit_write(imx_epit_reg_name(offset >> 2), value);
 
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
index ac5afe84e8..cd83adb03d 100644
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
+imx_epit_write(const char *name, uint64_t value) "(%s, value = 0x%08" PRIx64 ")"
+imx_epit_cmp(uint32_t sr) "sr was %d"
+
+
-- 
2.53.0



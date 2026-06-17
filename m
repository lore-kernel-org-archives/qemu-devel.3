Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AF0CD98F1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZoyg-00043z-Ca; Wed, 17 Jun 2026 08:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wZorT-0002Sm-6q
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 07:55:16 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wZorR-0006HC-7p
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 07:55:14 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2c6c101aeafso3284895ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 04:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781697312; x=1782302112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=934hamAJ+JSUr2HsPwZHL2EyxcVP/T+xXV5QPm/j1Y4=;
 b=bPwd/Jpm3tjFB+CmltKeI8d0kQ20twbWDHNKgCwUKnbNv9p/Abs2fipWtfSofUVBt2
 Gmvt4vEFm+PtJqlNsJjaVoPIfdITXbwKKGRzJWZK0sU90culoJxMrjoCkTlL9pXkcpnl
 gFh3yND+TlBj133ne0HR+mHAx0RzEPI9fzOCEQNFGXDWfWHHnjth8/apmuzbbZGG82uU
 Y8h0ya4Yo0NQV0SxPkQBLP9CSiVN3YyrwqhKwkHxOI/yUIVTsGf/X2GzY5VD2jcqSTfx
 ihkAbvijK9Gdkfvz9c4X80A+hzWehjpPOgdRoHdqLUcPGGWL2C2zWLiq0SskzrcukoIV
 auhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781697312; x=1782302112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=934hamAJ+JSUr2HsPwZHL2EyxcVP/T+xXV5QPm/j1Y4=;
 b=M59BZ0nREfOYhnwRlXkgrj2ifvLO1uqqPsCOkAaNrR8kMc6jGRZloOMK9xDY4ytUn9
 Z4zgNDWToNJlk6srQt0iQRIwaW6K442xzMKioAZeBJkZyN1njirEqexgrFkr1/XkWpQi
 3eUH/XulMDXwEHnf4OQX+sF0u9cyu/3leQMYlR3ibDGIR9slxJKphleMyyBg7CqB3Iu3
 BeRrB4LRdgssjr1kgMuc5lzStgyFHbIvpdZbZgTy0/8GsVO8ja85lvOtPzo4YI1XXmnD
 OjSIfBgusL5klTj1uyhxPnw0CP2LqfFCF4bKCHtraVJE9yp1/Bs9qy3fS79iNaYg7RTT
 woEA==
X-Gm-Message-State: AOJu0YwFTf9EeYOHMHaDXZem779wRdr/TmxtkWRiRjQoxk7Yok245DXb
 F29afksHgremD/MrT77QhoTrzq8K1/hozT5hQvWELd2gxu0PWWWd3uXIJNKmrw==
X-Gm-Gg: Acq92OF/D4Y0/GoIyvwB++uZisskmAffg5GD+MGSwbRjwrncykAx9TA3cf12+hzh3kX
 OFM5CAK3cEqoK2IOCqhWZlTcX2gvqqs7NnvagcxUq2waSITNOlAvsRY8mcHKgDJy3J3cn8TMznp
 b5rw6FTcdUyYPDCsgcZWzCuRTjwc5SbpZz+5TzLzUwfC5LJFfnBI6/0Cj443UVQmlPaf3mXGiyG
 5tiqRTRjS2SavNi3nYPbkCzZiF0WOLpqvf4T5ytfLst4dglbiF2X9IPtP8l2UlALhdSmJTONqf/
 UNXuQPQTM2yNFyduBRcB0U+TN5wKtorOl4i6rGwwO6W48mTdlNchjgxbjJ2CCNWqIDGPGUf6EDe
 bDIWOykHXQv7RySyUxmSfzU9iJW1HpcSC+v/SY2F/WWFFFq8Y4SwK9HfL+VqkkbsRoQ40iK2V3z
 8Ylic42LZ7jVoqW4Cqq+WRuv1Q
X-Received: by 2002:a17:903:b0d:b0:2c6:95d1:3bbc with SMTP id
 d9443c01a7336-2c6bc1e0086mr34999805ad.24.1781697311702; 
 Wed, 17 Jun 2026 04:55:11 -0700 (PDT)
Received: from localhost.localdomain ([82.40.42.115])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f1f1014sm163576605ad.16.2026.06.17.04.55.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 04:55:11 -0700 (PDT)
From: jw_mac <163wangjack@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-trivial@nongnu.org
Cc: peter.maydell@linaro.org, mjt@tls.msk.ru, laurent@vivier.eu,
 Wang Yuxin <163wangjack@gmail.com>
Subject: [PATCH trivial] git format-patch -1 --subject-prefix="PATCH
 trivial"Signed-off-by: jw_mac <163wangjack@gamil.com>
Date: Wed, 17 Jun 2026 19:54:42 +0800
Message-ID: <20260617115442.91715-2-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617115442.91715-1-163wangjack@gmail.com>
References: <20260617115442.91715-1-163wangjack@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=163wangjack@gmail.com; helo=mail-pl1-x630.google.com
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

From: Wang Yuxin <163wangjack@gmail.com>

hw/timer/imx_epit: Replace DPRINTF with trace events

Clean up the codebase by removing the outdated DEBUG_IMX_EPIT
and DPRINTF macros, replacing them with modern QEMU trace events.

This also removes an empty and meaningless DPRINTF("\n") in the
imx_epit_realize function.

Signed-off-by: jw_mac <163wangjack@gmail.com>
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



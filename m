Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E739CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZsuL-0008Ph-Rx; Wed, 17 Jun 2026 12:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wZsuK-0008PE-VA
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:14:28 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wZsuI-0003t7-KR
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:14:28 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-84226d0f1d2so3877579b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 09:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781712865; x=1782317665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=227EW3L/59hcD2Q03G8dQiLU/RR2N6DLxA0E9gs88jY=;
 b=mSHC2nobkId7LmT2pTZGC5rqijv4iwJSaEl4/QNiYNCo9QBG/BX5TCeAlYCLwM6Urp
 KoGQBFY4H3LV7F7S49IF112fwOdCgzlLfiSpl4wcjNCOiNgK/5SuNuA1pkfSgk6Tyh9R
 RRsUYhk5mKWO6DeGTJPNqTArFm8fCHK3MlSV5IgoDwOOrzxVXAzDlvXu+MMSqD2TA7X3
 ynvqc3BZ8jDpfFP27DO9s6GdVu1hq/WbfkPT/CqSybh2ZWm/8IlBZJITUm0b2R3gnivM
 PEzs4gPYw9NwBOQserHZZ0GALIqFiljfgxbMhDSj3Izc+tglN8wB1Np0shRlPZeIzWal
 Bwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781712865; x=1782317665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=227EW3L/59hcD2Q03G8dQiLU/RR2N6DLxA0E9gs88jY=;
 b=H0Hd6hZQ0Y4qRiB9pPFONKuLlA8RQk2F3tutZsn9BEVBwLeqG45+poPjF7/DikRPgK
 5d6zVPI9Nc0+B2z5JQOu8Blop1XOcGakbbIZsXKFzloF5tlvJrVO2lArCbuD5YSPXa2m
 IGI1plWT7R9FsdZC3W9wUW3y+VLU36AtVqrWTeGYN82OecUwsTWKRJQQbmjo+sMEKqh4
 WaEl8WKZ9RzLgjhxpkethmLjWhQdZUBLOiNG84chtODK9alGnXOJ9N2gt67VhzQoIojq
 QqD4UAxRo3ndFPZql66RWB6W8VqrmmQtvYqtKpzA6UWT1ygDfD6xZOiL9e3b7Znt7K+w
 fXHg==
X-Gm-Message-State: AOJu0YyOPVeYmGGktCBVu1bs1NdZv28mp5mCM3szOvXi21M7w6lT5+u9
 HnE7VngC7ucTyN3dQwPDUPmORWmGNYeeVUEyJPPkE8TCa19s2ym75xzGgQz8TwjrGWg=
X-Gm-Gg: AfdE7clLpvxRAQUER/K+YVUCjh6fjhUM8qUwsg7Fc4UxdqIt0qNkXz/VgAEvOTZSQLy
 ER/n6VSCrSn72rrgbYYAsHfOc4GvJVtABBi4Z6x0QnBRrQA/g0Ec2lBKfISP+iyKVJFdvXtC6wb
 bGxX5DMJieHkUmesM0mNk3pbAVIC9a4iZrPgj7a3uyipp0nA6OPIwsZdGGuRfE4rZ90VjpdJirx
 F02Lz6ck+7Yzed123a6MiVsma9mpFfaiVpQB1B4ijxFT/S1UXn/I884rcX0qw00pTI4dEFfL2hh
 eKrnRrsPJxrjEZBEkOnIMIV95n9X5ayTZ0tEbNJ1vKAQEFJG+c+qpK2kAzeYIDv6+fbqKsDKPlX
 IHYwKmxWFylotoVupOKrwmCTMPNiEpoEBDKVss2OdMXfvpEvD7lEs7+uwpb3Y4uie5ORaNmsoGq
 +WCaddBiH1W/e5mfhMqJDLgyhjmxt9+L7GBfak3Q==
X-Received: by 2002:a05:6a00:1907:b0:824:374a:1407 with SMTP id
 d2e1a72fcca58-84524480f94mr4809339b3a.16.1781712864975; 
 Wed, 17 Jun 2026 09:14:24 -0700 (PDT)
Received: from localhost.localdomain ([212.135.211.99])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434afc825csm16342800b3a.36.2026.06.17.09.14.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 09:14:24 -0700 (PDT)
From: jack wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-trivial@nongnu.org
Cc: peter.maydell@linaro.org, mjt@tls.msk.ru, laurent@vivier.eu,
 jack wang <163wangjack@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v5] hw/timer/imx_epit: Replace DPRINTF with trace events
Date: Thu, 18 Jun 2026 00:14:06 +0800
Message-ID: <20260617161406.14705-1-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=163wangjack@gmail.com; helo=mail-pf1-x429.google.com
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



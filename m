Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B60BC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2CJ-0004uv-Gq; Thu, 20 Aug 2026 08:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CH-0004rj-5I
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:41 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CD-0001Yb-O6
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:40 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a36982a875so3484643a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 05:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787230116; x=1787834916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sS1gXEmemUC6ULE4hdREjbYJb8+o5+CI4A9QQ0fRey8=;
 b=Tf8Cq8fKBOjXg/Zo4JN3ji8FDXzmQ8daG9kYB699w+bvC0jGmxWHO80E/iQ4/A4Pv8
 B8IjNsd/OafDxrxPjtIucHL6HfII6GAHId5Ixpwpq6UmApvymgzFi+LHTKUVnP5U0pB7
 frV+ct164jdKOKMr0sfM61jlPN+rkvX9qoic9SBNTek5JFe6tiqAjc2YWAvKopqn6/ja
 wniy//nwJgyC7KetaIdVjI3MI4duAzaqkGBM4K0muK+GOX8nWwEcoA3PAUy3t/YNkfUr
 Rkw+nn8+Z5FKb9VCKsK+TqdPIQPoB3ACRxWsYBGcqdyyhcP8wMebw+7E5xZa7fWpN4L/
 kuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787230116; x=1787834916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sS1gXEmemUC6ULE4hdREjbYJb8+o5+CI4A9QQ0fRey8=;
 b=MoW3l4Ymupdf2R53zBw2oX36hk7u1c3b2biDulYHYRfYDBo/fdKHmgnuSHLPZHDAr5
 6Cw52nelHK1vOlSJ5GgRVVojrE8gqvla50aELQ73k4bmoXmGVQc3hY2nxr2n86Q4uf6+
 xE7pxRk/us/aMPD0XPcnIStA4PpqRTd/hug+gjzosTgOnWEW8v4YeZOgRaT78GJZ6Ats
 6N8jriehhBpwd3Robmn/K/aIdrpL7dPZg6Sgv7ga5HuvBRGZwFMp5N2YiZlWkDKRxyL/
 OPETbnbp7I2RoChdU9I550lp3Aj5YqPG3500IaGM/1LZwGSc4R0MyuWncyUTKnIvdxnj
 vU4g==
X-Gm-Message-State: AFuF++kVWx0ST15JGd4Xyv0REWzxr92KwE5BuCVmRkZdd+ZsfYYbhnCy
 5VXaTbWcaBky70sQU7u3hlK6COFUAqPmQAlnG70PnzRa+cdL9Gb/F9uRXNmHWvAC
X-Gm-Gg: AR+sD11T3JQEuQpylOGgQBBlVMXJd8d3XXWUCYhV8sWczhU5MrsRWaX2+yryDtovPgf
 wUpdeH1wW1Y2dZryYf/DXymqoqcsZ/FQBSfQ2WDggIbAMXNNtvm3lG3H7tBJzzQVCtgzp+faW7Y
 Twxz91kWu59YJBSbzIZ4LY6/VpIare2kw+AQi7I97dcv55ZjhiMPuCjvX2QqS5h7qvyROlTJfWq
 W9JPQfW6byN/Fc/K5BbOGpiQEWK/q1J6GfBWcES5wuU1AHKc+085FNztwmKp9YvcrS78LuufmVf
 gT8lMqOp7AtZHJ6nbyk11ROemviB/kcm4AMV8HE1JpUKuvxW0kiy2C5TOBqlau604c3fPBxPlSM
 10lu7Z/laRpsby8xyEoNWFpXL2upjVHoemlRwgg11WUYr8Tn7SqLxBOaNayHGV/hKqyjLeE1wxj
 TvqE2jAXK7ik4fh1Xa1/nAHMpmp5KIwaX/eNGnceVgoFwAJQEGAx8JwLqmyLoEuoAnHGfqx+HU6
 7+zGS/+X2c=
X-Received: by 2002:a05:6402:2403:b0:6a3:e813:8457 with SMTP id
 4fb4d7f45d1cf-6a4032f9c61mr9187666a12.12.1787230115922; 
 Thu, 20 Aug 2026 05:48:35 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1563c5sm2270449a12.14.2026.08.20.05.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 05:48:35 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Wadim Mueller <wafgo01@gmail.com>
Subject: [RFC PATCH v2 05/14] hw/timer: add TI K3 DMTimer model
Date: Thu, 20 Aug 2026 14:48:05 +0200
Message-ID: <20260820124824.618671-6-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820124824.618671-1-wafgo01@gmail.com>
References: <20260820124824.618671-1-wafgo01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=wafgo01@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add a model of the K3 DMTimer used, among others, by the R5 SPL for its
udelay() implementation. It is a free-running counter with load/reload and
overflow interrupt.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 hw/timer/Kconfig                 |   3 +
 hw/timer/meson.build             |   1 +
 hw/timer/ti-k3-dmtimer.c         | 177 +++++++++++++++++++++++++++++++
 include/hw/timer/ti-k3-dmtimer.h |  30 ++++++
 4 files changed, 211 insertions(+)
 create mode 100644 hw/timer/ti-k3-dmtimer.c
 create mode 100644 include/hw/timer/ti-k3-dmtimer.h

diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index e1b751a54a..fac5ba5a7e 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -68,3 +68,6 @@ config AVR_TIMER16
 
 config HEX_QTIMER
     bool
+
+config TI_K3_DMTIMER
+    bool
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 8323efaf46..4cf49ef6d6 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -32,6 +32,7 @@ system_ss.add(when: 'CONFIG_STM32F2XX_TIMER', if_true: files('stm32f2xx_timer.c'
 system_ss.add(when: 'CONFIG_XILINX', if_true: files('xilinx_timer.c'))
 specific_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_timer.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_PWM', if_true: files('sifive_pwm.c'))
+system_ss.add(when: 'CONFIG_TI_K3_DMTIMER', if_true: files('ti-k3-dmtimer.c'))
 
 system_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
 
diff --git a/hw/timer/ti-k3-dmtimer.c b/hw/timer/ti-k3-dmtimer.c
new file mode 100644
index 0000000000..e65098d101
--- /dev/null
+++ b/hw/timer/ti-k3-dmtimer.c
@@ -0,0 +1,177 @@
+/*
+ * TI K3 DM timer (dmtimer, am654 register layout)
+ *
+ * Minimal TCRR counter model. TCLR.PRE_EN and TCLR.PTV divide the clock
+ * by (2 << PTV); interrupts and PWM we omit.
+ *
+ * Copyright (c) 2026 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/timer.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/timer/ti-k3-dmtimer.h"
+
+#define R_TIDR  0x00
+#define R_TCLR  0x38
+#define R_TCRR  0x3c
+#define R_TLDR  0x40
+#define R_TTGR  0x44
+#define R_TWPS  0x48
+
+#define TCLR_ST     (1u << 0)
+#define TCLR_AR     (1u << 1)
+#define TCLR_PTV    (7u << 2)
+#define TCLR_PRE_EN (1u << 5)
+
+static uint32_t dmtimer_effective_freq(TIK3DmTimerState *s)
+{
+    uint32_t freq = s->freq_hz;
+
+    if (s->tclr & TCLR_PRE_EN) {
+        uint32_t ptv = (s->tclr >> 2) & 7;
+        freq = s->freq_hz / (2u << ptv);
+    }
+    return freq;
+}
+
+static uint32_t dmtimer_tcrr(TIK3DmTimerState *s)
+{
+    int64_t now;
+    uint32_t eff_freq;
+
+    if (!s->running) {
+        return s->tcrr_base;
+    }
+
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    eff_freq = dmtimer_effective_freq(s);
+
+    return s->tcrr_base +
+           (uint32_t)muldiv64(now - s->base_ns, eff_freq,
+                              NANOSECONDS_PER_SECOND);
+}
+
+static void dmtimer_set_tcrr(TIK3DmTimerState *s, uint32_t val)
+{
+    s->tcrr_base = val;
+    s->base_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+}
+
+static uint64_t ti_k3_dmtimer_read(void *opaque, hwaddr addr, unsigned size)
+{
+    TIK3DmTimerState *s = TI_K3_DMTIMER(opaque);
+
+    switch (addr) {
+    case R_TIDR:
+        return 0x0;
+    case R_TCLR:
+        return s->tclr;
+    case R_TCRR:
+        return dmtimer_tcrr(s);
+    case R_TLDR:
+        return s->tldr;
+    case R_TWPS:
+        return 0; /* no write is pending, ever */
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented read @0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        return 0;
+    }
+}
+
+static void ti_k3_dmtimer_write(void *opaque, hwaddr addr, uint64_t val,
+                                unsigned size)
+{
+    TIK3DmTimerState *s = TI_K3_DMTIMER(opaque);
+
+    switch (addr) {
+    case R_TCLR:
+        /*
+         * Rebase with the old TCLR first.  Prescaler changes must only
+         * affect ticks after this write.
+         */
+        dmtimer_set_tcrr(s, dmtimer_tcrr(s));
+        s->tclr = val;
+        s->running = (val & TCLR_ST) != 0;
+        break;
+    case R_TCRR:
+        dmtimer_set_tcrr(s, val);
+        break;
+    case R_TLDR:
+        s->tldr = val;
+        break;
+    case R_TTGR:
+        dmtimer_set_tcrr(s, s->tldr);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented write @0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps ti_k3_dmtimer_ops = {
+    .read = ti_k3_dmtimer_read,
+    .write = ti_k3_dmtimer_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static void ti_k3_dmtimer_reset(DeviceState *dev)
+{
+    TIK3DmTimerState *s = TI_K3_DMTIMER(dev);
+
+    s->tclr = 0;
+    s->tldr = 0;
+    s->tcrr_base = 0;
+    s->base_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    /*
+     * This model exposes TCRR as free-running already after reset; TCLR.ST
+     * still reads back as reset value 0.
+     */
+    s->running = true;
+}
+
+static void ti_k3_dmtimer_init(Object *obj)
+{
+    TIK3DmTimerState *s = TI_K3_DMTIMER(obj);
+
+    memory_region_init_io(&s->iomem, obj, &ti_k3_dmtimer_ops, s,
+                          TYPE_TI_K3_DMTIMER, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const Property ti_k3_dmtimer_properties[] = {
+    /* AM64 main_timer0 default input clock is 20 MHz. */
+    DEFINE_PROP_UINT32("freq-hz", TIK3DmTimerState, freq_hz, 20000000),
+};
+
+static void ti_k3_dmtimer_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, ti_k3_dmtimer_properties);
+    device_class_set_legacy_reset(dc, ti_k3_dmtimer_reset);
+}
+
+static const TypeInfo ti_k3_dmtimer_info = {
+    .name = TYPE_TI_K3_DMTIMER,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TIK3DmTimerState),
+    .instance_init = ti_k3_dmtimer_init,
+    .class_init = ti_k3_dmtimer_class_init,
+};
+
+static void ti_k3_dmtimer_register_types(void)
+{
+    type_register_static(&ti_k3_dmtimer_info);
+}
+
+type_init(ti_k3_dmtimer_register_types)
diff --git a/include/hw/timer/ti-k3-dmtimer.h b/include/hw/timer/ti-k3-dmtimer.h
new file mode 100644
index 0000000000..04c3925e2d
--- /dev/null
+++ b/include/hw/timer/ti-k3-dmtimer.h
@@ -0,0 +1,30 @@
+/*
+ * TI K3 DM timer (am654 layout)
+ *
+ * Copyright (c) 2026 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_TIMER_TI_K3_DMTIMER_H
+#define HW_TIMER_TI_K3_DMTIMER_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_TI_K3_DMTIMER "ti-k3-dmtimer"
+OBJECT_DECLARE_SIMPLE_TYPE(TIK3DmTimerState, TI_K3_DMTIMER)
+
+struct TIK3DmTimerState {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+    uint32_t freq_hz;
+    uint32_t tclr;
+    uint32_t tldr;
+    /* counter value latched at last write/start */
+    uint32_t tcrr_base;
+    int64_t base_ns;
+    bool running;
+};
+
+#endif
-- 
2.43.0



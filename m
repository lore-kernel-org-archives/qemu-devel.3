Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0B6C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwsqZ-0002Cd-Ht; Wed, 19 Aug 2026 22:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwsq7-0001us-TH
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:13 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwsq4-0000Z9-Fg
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:49:11 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-66c67a73eb7so896521d50.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 19:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787194147; x=1787798947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ULA0rOEJS/remkRsu+3bK7hmpmH4SXzIjWLm8NTqxUk=;
 b=oZ3N+OPghaOt+GPVux4vdrz0IE0lGEBpj9PlJe61cP62uFZkLmYn907s6xVhXsekTI
 bIsMQILGtmD9DjhWF/697ww/PO3ndRfxxWkX4f2uubAA57q6Fyr4tOwaResOApO1+JIa
 mQJhAatP75mHtjleOv81k+DYAQOQmX3wFMoYMevk8ikFaKmfHXi61K+FbP7nXdgfBxpv
 Bh8vp6nkxKsnrLxa0pcyrQYHUA495zxLPfPD+fflfozd5Hc3GBjeZMe9feCCVgCeaDwj
 ExqZQtOOElbNLeKzPTTRhtIt0yzCRNxpQdBBuBMx2KRj3+cS8riWQHpGzYCV+uhRwctX
 rFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787194147; x=1787798947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ULA0rOEJS/remkRsu+3bK7hmpmH4SXzIjWLm8NTqxUk=;
 b=DxpEKaYKregRmBGcRWm5mTHAGsxtEKn8/ihlEohVDdipfuW79tZ64YhWl04xla73Iu
 z17EYpA4UaV6gnhpZbIyI07O9fmSZvaZS7PXjWma9D1fVEr46iB4M8y0Yc3JjCMh6FuD
 1XExju0U2CTtGan1LzzaOm8racl+rB8Sn25zAwvI2cgZJwce51gV6zHSy0ip7Cuc9mfH
 0nHzXt0fVamTByaQy+YfUB0aly4Zm5tt62H7lRukEd/YnmkbAoELgY8QtQjlrLngZM7o
 aMPVPEDHrMUd6snx2UGrgEJomYR0miJ39s/7iwd1zzlj7nr0mkGspK6/3g4fXyAxvzCP
 wkBA==
X-Gm-Message-State: AFuF++mLAhciCl4M7c44sEhlZkTn7EZcMb6aHYTvv3ZhAlihm+sDfX5T
 8ZxK+A04lMA79Eu7Z/gQGVB8iQLA+SvZx0saHo2vMpnzt+lvKIPiRqMg5VPH7A==
X-Gm-Gg: AR+sD11NBaQx40l4v/c0dFs1VwWq0XPCQxAorcx1u5agg3jsmwWrvxSY381UUzY5pkS
 UWhSxFXlkaW0Nv3GEYtQGb5i9uAGK2tVXZv2qk3rTyzZlOw6PBI/32h2+yd8EUqDdrlk1E4L8eP
 JJTHOhRyIiP2sT3G0RwOisr79vrYvtI6tKNjv2Cu684fcSx5Jea1jGgCpRHp6kMAyVW9tbD8OF5
 5mRahVP04S2wjnh/1/n7AqQ0iAflNOrTD2WHwS5V3BVw1h2Hzq1p4lLpuTw3FFgCeKdtbmEBpXV
 jFAx9s/eFJfbUjEVSAmYs3GTW43KDtjJNWuYniHYqVBy8uTMzKU3fVuorB293uVTDX/97inIGeN
 Yht02HeotuaxueBI66Evq4+qTSollUdhMznVoFdQlZ2XccVL/+PR3VuTRx86On4y4slsAE0GhJT
 yYF5dZSvNr9NNtY6GPIjTpA1kc4OcW2yfqFBD4B0VRytiRSs6mUOEtcmqw1+GfyMriTIsbCQu6i
 itZbmoAnW4vRx3Ndmdp+Ze5EaG9dLnu7tqed0XBOT+xlRovMnKJ8A==
X-Received: by 2002:a53:a810:0:b0:668:8d0:20c with SMTP id
 956f58d0204a3-66cd6a0718fmr915365d50.20.1787194147429; 
 Wed, 19 Aug 2026 19:49:07 -0700 (PDT)
Received: from skippy.localdomain (99-61-67-1.lightspeed.austtx.sbcglobal.net.
 [99.61.67.1]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafd03basm1986454d50.1.2026.08.19.19.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 19:49:07 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kyle Fox <kylefoxaustin.github@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:MCIMX95-19X19-EVK...)
Subject: [PATCH 13/16] hw/misc: add i.MX 95 DPU command-sequencer stub
 (headless)
Date: Wed, 19 Aug 2026 21:48:31 -0500
Message-Id: <20260820024834.3286721-14-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
References: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

A minimal stub for the i.MX 95 DPU (display controller) command
sequencer. This machine is headless, but Linux's dpu95 driver busy-waits
with no timeout on the sequencer status register during probe, so a
reads-as-zero stub would hang userspace bring-up. The stub reports the
sequencer idle with FIFO space so the probe completes. Real display
scanout is left to a follow-on series.

Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
---
 hw/misc/Kconfig      |   3 ++
 hw/misc/imx95_dpu.c  | 117 +++++++++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build  |   1 +
 hw/misc/trace-events |   1 +
 4 files changed, 122 insertions(+)
 create mode 100644 hw/misc/imx95_dpu.c

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index e1b8c390312..59c55cb5b83 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -290,3 +290,6 @@ config IMX95_PMIC
 
 config IMX95_XCACHE
     bool
+
+config IMX95_DPU
+    bool
diff --git a/hw/misc/imx95_dpu.c b/hw/misc/imx95_dpu.c
new file mode 100644
index 00000000000..4e09b399d85
--- /dev/null
+++ b/hw/misc/imx95_dpu.c
@@ -0,0 +1,117 @@
+/*
+ * NXP i.MX 95 DPU (Display Processing Unit) command-sequencer status stub
+ *
+ * Copyright (c) 2026, Kyle Fox
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * The DPU is not modelled: this base machine is headless, and real display
+ * scanout is a follow-on series. With the real System Manager powering the
+ * display mix, however, Linux's dpu95 driver stops deferring and probes - and
+ * its blit-engine bring-up busy-waits with NO
+ * timeout on the command sequencer status register:
+ *   dpu95_cs_wait_idle()       spins until CMDSEQ_STATUS.IDLE      is set
+ *   dpu95_cs_wait_fifo_space() spins until CMDSEQ_STATUS.FIFOSPACE >= 192
+ * A plain zero-returning stub never satisfies either, so the probe kthread
+ * hangs forever, which in turn wedges wait_for_device_probe() in
+ * kernel_init() and userspace never starts.
+ *
+ * This stub returns CMDSEQ_STATUS with IDLE set and a full FIFOSPACE so both
+ * polls pass instantly; every other register reads back zero and writes are
+ * dropped. That is enough to let the probe complete (the actual command
+ * submission / fence path runs only at runtime, which we never reach). A
+ * follow-on series that models the DPU for real (adding display scanout and
+ * Wayland output) removes this stub.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+#include "trace.h"
+
+#define TYPE_IMX95_DPU "imx95.dpu"
+OBJECT_DECLARE_SIMPLE_TYPE(IMX95DPUState, IMX95_DPU)
+
+#define IMX95_DPU_REG_SIZE 0x400000
+
+struct IMX95DPUState {
+    SysBusDevice    parent_obj;
+    MemoryRegion    iomem;
+};
+
+/* Command-sequencer status, from the dpu95 blit register map. */
+#define DPU_CMDSEQ_STATUS           0x1019c
+#define DPU_CMDSEQ_STATUS_IDLE      0x40000000u
+#define DPU_CMDSEQ_STATUS_FIFOSPACE 0x0001ffffu
+
+static uint64_t imx95_dpu_read(void *opaque, hwaddr offset, unsigned size)
+{
+    if (offset == DPU_CMDSEQ_STATUS) {
+        /*
+         * Report the sequencer idle with a full FIFO. This is deliberately
+         * NOT the reset value (0x41000080: IDLE set but FIFOSPACE = 128, below
+         * the driver's threshold of 192), because the dpu95 probe polls
+         * FIFOSPACE before the enable handshake that would raise it on real
+         * silicon. Returning a constant full FIFO is sound only because the
+         * model is probe-time-only: no actual command sequence is ever
+         * submitted. If real DPU command submission is ever modelled,
+         * FIFOSPACE must track the command FIFO occupancy instead.
+         */
+        uint32_t status = DPU_CMDSEQ_STATUS_IDLE | DPU_CMDSEQ_STATUS_FIFOSPACE;
+        trace_imx95_dpu_cmdseq_status(status);
+        return status;
+    }
+    return 0;
+}
+
+static void imx95_dpu_write(void *opaque, hwaddr offset,
+                            uint64_t value, unsigned size)
+{
+}
+
+static const MemoryRegionOps imx95_dpu_ops = {
+    .read = imx95_dpu_read,
+    .write = imx95_dpu_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void imx95_dpu_init(Object *obj)
+{
+    IMX95DPUState *s = IMX95_DPU(obj);
+
+    memory_region_init_io(&s->iomem, obj, &imx95_dpu_ops, s,
+                          TYPE_IMX95_DPU, IMX95_DPU_REG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static void imx95_dpu_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+    dc->desc = "NXP i.MX 95 DPU (status stub)";
+}
+
+static const TypeInfo imx95_dpu_info = {
+    .name           = TYPE_IMX95_DPU,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(IMX95DPUState),
+    .instance_init  = imx95_dpu_init,
+    .class_init     = imx95_dpu_class_init,
+};
+
+static void imx95_dpu_register_types(void)
+{
+    type_register_static(&imx95_dpu_info);
+}
+
+type_init(imx95_dpu_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index d7d283a191b..9d629c8efef 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -180,3 +180,4 @@ system_ss.add(when: 'CONFIG_IMX95_GPC', if_true: files('imx95_gpc.c'))
 system_ss.add(when: 'CONFIG_IMX95_SRC', if_true: files('imx95_src.c'))
 system_ss.add(when: 'CONFIG_IMX95_PMIC', if_true: files('imx95_pmic.c'))
 system_ss.add(when: 'CONFIG_IMX95_XCACHE', if_true: files('imx95_xcache.c'))
+system_ss.add(when: 'CONFIG_IMX95_DPU', if_true: files('imx95_dpu.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 0555b15a1f3..e921b5f290a 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -466,3 +466,4 @@ pcal6408a_reg_read(uint8_t reg, uint8_t val) "PCAL6408A reg 0x%02x -> 0x%02x"
 pcal6408a_reg_write(uint8_t reg, uint8_t val) "PCAL6408A reg 0x%02x <- 0x%02x"
 pf53_reg_read(uint8_t reg, uint8_t val) "PF53 reg 0x%02x -> 0x%02x"
 pf53_reg_write(uint8_t reg, uint8_t val) "PF53 reg 0x%02x <- 0x%02x"
+imx95_dpu_cmdseq_status(uint32_t value) "CMDSEQ_STATUS -> 0x%08x"
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A53E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt5MM-00043E-3U; Thu, 19 Feb 2026 09:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5Lt-0003lV-Fu
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:50:11 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5Ln-00083i-HT
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:49:58 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so668892f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771512584; x=1772117384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zaQNJ8ctjloGg8ogNJ9hZj1p+S+3oUkMGg8iiDuQ6N8=;
 b=PI1DRAsc0ObYLdX2t28bDsUraDpNMbwfJKk/fFqsELI1koOeQSQawnajHsNSS29Ey/
 V5VBOW/+ZAFxDQzQimp+8BF9m9C/YYGCW09SXZ+1BcclPbMhrA3PJ64c9CZvJXpPBT+8
 kRPoboAPvK6OodKd7OiHmfnl6W2dSNFvzolHB3y2MigsQTcpF9hBfYgck0OOmB6tcsw6
 AEa/x/WHpNg/M5oIxCPY3VR+FxSpjkkTrLEX2tQG8zGULI/QOGLJY27+3e4sfZHGCbkE
 hlE5n0fR3NP3+Bn338r5XFFKprp1Ji5qiT5ll2ndSbiOuD1Xtz7/f2zxVnaJLuVV+ysP
 p9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771512584; x=1772117384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zaQNJ8ctjloGg8ogNJ9hZj1p+S+3oUkMGg8iiDuQ6N8=;
 b=BkXQrpeesFh6Y0BZ2wm5jHDncALmpBMWFq0p/tDtRuw8GRzP/hKQINBs7KLwN4W9R6
 0IknHRNcwhjBRl51kR58qDIqMSq+tVesMTMDbFt1iXD2jTv5r3pLBi01NIgSh6oe8Ex4
 Vp+WHGV2+GKutoQT1uYP81RyDZf2qP9GgAwmR90LAXdlk2KxVWrGIQGNudA90JP6AKXX
 1j7SIxKnvLuvrAK1UJgtY1Lua68iaQjZ74hyl06GhzoA4HDrtDOtdAKosy1g1RSEtNLt
 1ohTyf6mA67kPPE+WiKyRpxllh6/NGR47UHIHeFOtFrBylOA/Ullm4LdkUX8e0ydX506
 BY4A==
X-Gm-Message-State: AOJu0Ywk9j5ZCVrn5noA7We6IqtBdBPqcb4PBw/3F0QOFRjmz7WhRWaV
 oiHI3VfRxvCaKpP4CIp0mPrfVuN7VkPY5dYyPxg3dtwLs3qCNtNs4G5lPInugxyW
X-Gm-Gg: AZuq6aLP4pbIZhiBJhAgbI6vSVVj4fE2Eebz33YrQnmiYYTQIjAW2IrcLoleXdQrhQw
 8O6/jz9ncwJnop8jrd7xiq7KZmS09r104JdanZkL6sld1kdsP9lUMfhjPyx+F6FoPZIM01l0ywT
 9TOZQWeMY/Hynz4E1Z8aKFLk0svCAc8Vv3b6GrJcQykUIOAYLr+p2+UMWIfOMxLdYSJB3sY7n23
 09uAPDF6GVtXQ53uNOoAskXaJ3Vh+CvsCMdAJLq9bmV6/fhqqUJW/lz7SwdzO/wU63HFwZqUeoB
 obhEiBZNjEQL1XAMg6lZRVWeN8jhQJdNTOkNzf/RW9fIWM64P5tH0bSBJIbgqAFWT3q5UbQa6PA
 KAXOee6W3VHyGuzEfd/fQZ8PBVEdDgUg3RvnkNnj0HDtltBrW9FG4BNVs6ABr1wjUf75qtEDvTy
 cA0DUeGektDbDUCiK2/Y25kxy6l9LXgCxV/GIS4bM5HdZa5aTqtigVOytTUUq/14OgNnbf
X-Received: by 2002:a05:6000:3101:b0:437:694d:fb6c with SMTP id
 ffacd0b85a97d-4395fd2ab83mr4252115f8f.9.1771512583932; 
 Thu, 19 Feb 2026 06:49:43 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm50163087f8f.31.2026.02.19.06.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:49:43 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v2 22/33] hw/intc/arm_gic: implement FDT_GENERIC_INTC and fdt
 support
Date: Thu, 19 Feb 2026 15:48:50 +0100
Message-ID: <20260219144901.3317747-4-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219144901.3317747-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
 <20260219144901.3317747-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

The patch implements TYPE_FDT_GENERIC_INTC interface, which
enables GIC to be instantiated and wired via the device tree
description.

The implemented interface method are following:
1. 'get_irq': Parses device tree interrupt specifiers
and return correct qemu_irq for devices which has IRQ's wired
to GIC.
2. 'auto_parent': Automatically connect the GIC's output signals
to the CPU's found in current machine configuration.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/intc/arm_gic.c        | 32 +++++++++++++++++++++++++
 hw/intc/arm_gic_common.c | 50 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 4d4b79e6f3..2be44d8e5b 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -24,12 +24,15 @@
 #include "gic_internal.h"
 #include "qapi/error.h"
 #include "hw/core/cpu.h"
+#include "hw/core/boards.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "trace.h"
 #include "system/kvm.h"
 #include "system/qtest.h"
 
+#include "hw/core/fdt_generic_util.h"
+
 /* #define DEBUG_GIC */
 
 #ifdef DEBUG_GIC
@@ -2162,12 +2165,41 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
 
 }
 
+static void arm_gic_fdt_auto_parent(FDTGenericIntc *obj, Error **errp)
+{
+    GICState *s = ARM_GIC(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    int num_cpus = current_machine->smp.cpus;
+    CPUState *cs;
+    int i = 0;
+
+    for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
+        if (i >= s->num_cpu) {
+            break;
+        }
+
+        sysbus_connect_irq(sbd, i,
+                           qdev_get_gpio_in(DEVICE(cs), 0));
+        sysbus_connect_irq(sbd, i + num_cpus,
+                           qdev_get_gpio_in(DEVICE(cs), 1));
+        sysbus_connect_irq(sbd, i + 2 * num_cpus,
+                           qdev_get_gpio_in(DEVICE(cs), 2));
+        sysbus_connect_irq(sbd, i + 3 * num_cpus,
+                           qdev_get_gpio_in(DEVICE(cs), 3));
+        i++;
+    }
+
+    /* FIXME: Add some error checking */
+}
+
 static void arm_gic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ARMGICClass *agc = ARM_GIC_CLASS(klass);
+    FDTGenericIntcClass *fgic = FDT_GENERIC_INTC_CLASS(klass);
 
     device_class_set_parent_realize(dc, arm_gic_realize, &agc->parent_realize);
+    fgic->auto_parent = arm_gic_fdt_auto_parent;
 }
 
 static const TypeInfo arm_gic_info = {
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 304d89cf56..04787cff79 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -28,6 +28,8 @@
 #include "migration/vmstate.h"
 #include "system/kvm.h"
 
+#include "hw/core/fdt_generic_util.h"
+
 static int gic_pre_save(void *opaque)
 {
     GICState *s = (GICState *)opaque;
@@ -348,6 +350,51 @@ static void arm_gic_common_linux_init(ARMLinuxBootIf *obj,
     }
 }
 
+static int arm_gic_common_fdt_get_irq(FDTGenericIntc *obj, qemu_irq *irqs,
+                                      uint32_t *cells, int ncells, int max,
+                                      Error **errp)
+{
+    GICState *gs = ARM_GIC_COMMON(obj);
+    int cpu = 0;
+    uint32_t idx;
+
+    if (ncells != 3) {
+        error_setg(errp, "ARM GIC requires 3 interrupt cells, %d cells given",
+                   ncells);
+        return 0;
+    }
+    idx = cells[1];
+
+    switch (cells[0]) {
+    case 0:
+        if (idx >= gs->num_irq) {
+            error_setg(errp, "ARM GIC SPI has maximum index of %" PRId32 ", "
+                       "index %" PRId32 " given", gs->num_irq - 1, idx);
+            return 0;
+        }
+        (*irqs) = qdev_get_gpio_in(DEVICE(obj), cells[1]);
+        return 1;
+    case 1: /* PPI */
+        if (idx >= 16) {
+            error_setg(errp, "ARM GIC PPI has maximum index of 15, "
+                       "index %" PRId32 " given", idx);
+            return 0;
+        }
+        for (cpu = 0; cpu < max && cpu < gs->num_cpu; cpu++) {
+            if (cells[2] & 1 << (cpu + 8)) {
+                *irqs = qdev_get_gpio_in(DEVICE(obj),
+                                         gs->num_irq - 16 + idx + cpu * 32);
+            }
+            irqs++;
+        }
+        return cpu;
+    default:
+        error_setg(errp, "Invalid cell 0 value in interrupt binding: %d",
+                   cells[0]);
+        return 0;
+    }
+}
+
 static const Property arm_gic_common_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", GICState, num_cpu, 1),
     DEFINE_PROP_UINT32("first-cpu-index", GICState, first_cpu_index, 0),
@@ -368,12 +415,14 @@ static void arm_gic_common_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     ARMLinuxBootIfClass *albifc = ARM_LINUX_BOOT_IF_CLASS(klass);
+    FDTGenericIntcClass *fgic = FDT_GENERIC_INTC_CLASS(klass);
 
     rc->phases.hold = arm_gic_common_reset_hold;
     dc->realize = arm_gic_common_realize;
     device_class_set_props(dc, arm_gic_common_properties);
     dc->vmsd = &vmstate_gic;
     albifc->arm_linux_init = arm_gic_common_linux_init;
+    fgic->get_irq = arm_gic_common_fdt_get_irq;
 }
 
 static const TypeInfo arm_gic_common_type = {
@@ -385,6 +434,7 @@ static const TypeInfo arm_gic_common_type = {
     .abstract = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_ARM_LINUX_BOOT_IF },
+        { TYPE_FDT_GENERIC_INTC },
         { },
     },
 };
-- 
2.43.0



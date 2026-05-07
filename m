Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E4ACD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11L-0003VA-Mx; Thu, 07 May 2026 11:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11C-0003PC-2t
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11A-0003ma-2Q
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:05 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b0046078so8991245e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169122; x=1778773922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HNhbXIYLPE3i7rsLfY3jqFMqXJBOaSPo/Us5CC4uauU=;
 b=EE9m49gIXScxwPvuHE2kHbERoHl/+iExOc6MpXsxVyjE0LAHMHNrQNowAtnLwPdU7F
 U7Xm4DwbHQ92pRFTJQfcbAy2+WLVb1Paqx693A5+qibRUGvvotQmcUUV1ZBKGT2ggL9I
 TiobCW67g6rfEEwcdZj6811n+jJ5pyGUVH7hMND3aWHHiZBalKZ2EcmN6X4KioDogu9M
 tatTwSh6DcqEaTuzeBgOqCM0kcM+R86oF7k97T0HFWoEa2jVUOOihBWhjPfRyjgB9JIN
 Di87AsZ3NnZIVgXIwgIGZ43MLyJf6xF/j1LlnCK5V0m4GTy0eU2ojqen7GNGJF2g4lKW
 GHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169122; x=1778773922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HNhbXIYLPE3i7rsLfY3jqFMqXJBOaSPo/Us5CC4uauU=;
 b=s3iVRhEvqzl6XoN6iu+YFsQD4QlbAWz2yadBijqlKIHc4iJL5A/eGsbqyRiEq0+BaJ
 Cgb0O1b6T4jRRTg+1tyvKYeFH32DkRc3F4Q3JTGaX4t+a6csc6sr6f313O2zR3WUzKYV
 KUYVsSpC8fn+51j0hwgNcv33R3fxdmEXiuIICW7tbH5sRGzZ4C4Q3/HDb7Kgxs0Rbebz
 KiX88c5xfwmuy61kwjB3k6Zm/kQP4jTNkZfPFRpPpuY/yMkGL4Q39ehibEfwjj3dVV6U
 KUQr4hMduMRgEV0tz0ZcsNOzAfSi6HI/XITTkxdpVqmWUzy0N41YeBy9zPhref6IBg1Y
 KB3Q==
X-Gm-Message-State: AOJu0YwDzRip6peJSwkWxwVUCwRakdkkgHxjrg57Z9yRfhUUZ9/jvW03
 hq2WW45rsECcznft+Gfc/QzOVbOt+eU5uGnOGmLO0bxN0C0wXga3GpxAX0aoUi/2ZHIPoxAdIDq
 nohbj
X-Gm-Gg: AeBDievqQl+gfj6btj7bIk4tCQZ1OZWMztLLPz2k4nwGBZLReJtx9Rw2HvboW4GHc7z
 TGkNckLDXJ569mXuoiS5WbEo1galSzdSiX24w9TuUDGNwh+1181L+bdPGQtnFQOUf6aKBulHw4B
 0I6iru5U+lFlc4w2qwGYHNmyVApUGg8RHP/M30Kv874hMr8lAzJUSq9fPDv33MFQs6H4mNFqqqd
 lqHfAqdfhuRIx1b9YG7+FdHEH5tvXjCvYWPF8Ju5V2W6Uv1ZbD4/XAkxda+BOzWMsws+vk9hweC
 xY5HoBWxptqCHuZTiBBCYb1io+4hbtyksJIKviNkbDEXiefIdYrMCN0lv+VyQ/iqdcChDtr5VdH
 CxeRDUYteLUKq70hb7UVSJhSAFdhTpsl3g47LLVdvm0+OsqlZisPS6hgtNZOb98CSaZtcm1xphM
 vAXdMqvhGnY8NVwHD8EiIBwDz5OnDEv3huE8jAEQLNmUApwpa04Z4YA1MGw62p2/RAZrY2rO8U4
 yu8P0nyDmt1JCpYNAF2S0g8WD7fInefSx/+IagxEg==
X-Received: by 2002:a05:600c:3f0b:b0:48a:6fd4:d3d3 with SMTP id
 5b1f17b1804b1-48e51f37fb8mr173105635e9.20.1778169122200; 
 Thu, 07 May 2026 08:52:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/67] hw/intc/arm_gicv5: Create and validate QOM properties
Date: Thu,  7 May 2026 16:50:54 +0100
Message-ID: <20260507155154.1886557-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Add code to the GICv5 skeleton which creates the QOM properties which
the board or SoC can use to configure the GIC, and the validation
code to check they are in range.  Generally these correspond to
fields in the IRS ID registers, and the properties are named
correspondingly.

Notable here is that unlike the GICv3 (which assumes its connected
CPUs are the system's CPUs starting from 0), we define a QOM array
property which is an array of pointers to the CPUs, and a QOM array
property which is an array of integers telling the GIC what the
IAFFID (interrupt affinity ID) for each CPU is; so a board or SoC
which wants to connect multiple CPUs to this GICv5 would do something
like:

    QList *cpulist = qlist_new(), *iaffidlist = qlist_new();

    for (int i = 0; i < ms->smp.cpus; i++) {
        qlist_append_link(cpulist, OBJECT(qemu_get_cpu(i)));
        qlist_append_int(iaffidlist, i);
    }
    qdev_prop_set_array(vms->gic, "cpus", cpulist);
    qdev_prop_set_array(vms->gic, "cpu-iaffids", iaffidlist);

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260327111700.795099-8-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5_common.c         | 80 ++++++++++++++++++++++++++++++
 hw/intc/trace-events               |  3 ++
 include/hw/intc/arm_gicv5_common.h | 25 ++++++++++
 3 files changed, 108 insertions(+)

diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index bf990bfa54..3448734686 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -8,9 +8,15 @@
 
 #include "qemu/osdep.h"
 #include "hw/intc/arm_gicv5_common.h"
+#include "hw/core/qdev-properties.h"
+#include "qapi/error.h"
+#include "trace.h"
 
 OBJECT_DEFINE_ABSTRACT_TYPE(GICv5Common, gicv5_common, ARM_GICV5_COMMON, SYS_BUS_DEVICE)
 
+/* Any value > 2^24 is out of the valid range for this property */
+#define GICV5_SPI_IRS_RANGE_NOT_SET 0xffffffff
+
 static bool bad_frame_accepts(void *opaque, hwaddr addr, unsigned size,
                               bool is_write, MemTxAttrs attrs)
 {
@@ -58,9 +64,83 @@ static void gicv5_common_finalize(Object *obj)
 {
 }
 
+static void gicv5_common_realize(DeviceState *dev, Error **errp)
+{
+    GICv5Common *cs = ARM_GICV5_COMMON(dev);
+
+    if (cs->num_cpus == 0) {
+        error_setg(errp, "The cpus array property must have at least one CPU");
+        return;
+    }
+    if (cs->num_cpus >= (1 << 16)) {
+        /* We'll hit other QEMU limits long before this one :-) */
+        error_setg(errp, "Number of CPUs exceeds GICv5 architectural maximum");
+        return;
+    }
+    if (cs->num_cpus != cs->num_cpu_iaffids) {
+        error_setg(errp, "The cpu-iaffids array property must be the same size "
+                   "as the cpus array property");
+        return;
+    }
+    if (cs->irsid >= (1 << 16)) {
+        error_setg(errp, "irsid (%u) is more than 2^16-1", cs->irsid);
+        return;
+    }
+    if (cs->spi_range > (1 << 24)) {
+        /*
+         * Note that IRS_IDR5.SPI_RANGE is a 25 bit field but the largest
+         * architecturally permitted value is 2^24 (not 2^25-1), hence
+         * use of > in the range check.
+         */
+        error_setg(errp, "spi-range (%u) is more than 2^24", cs->spi_range);
+        return;
+    }
+    if (cs->spi_irs_range == GICV5_SPI_IRS_RANGE_NOT_SET) {
+        /* spi-irs-range defaults to same as spi-range */
+        cs->spi_irs_range = cs->spi_range;
+    }
+    if (cs->spi_irs_range > (1 << 24)) {
+        /* Similarly IRS_IDR6.SPI_IRS_RANGE */
+        error_setg(errp, "spi-irs-range (%u) is more than 2^24",
+                   cs->spi_irs_range);
+        return;
+    }
+    if (cs->spi_base >= (1 << 24)) {
+        /* IRS_IDR7.SPI_BASE is a 24-bit field, so range check is >= */
+        error_setg(errp, "spi-base (%u) is more than 2^24-1", cs->spi_base);
+        return;
+    }
+    /* range checks above mean we know this addition won't overflow */
+    if (cs->spi_base + cs->spi_irs_range > cs->spi_range) {
+        error_setg(errp, "spi-base (%u) + spi-irs-range (%u) is "
+                   "more than spi-range (%u)",
+                   cs->spi_base, cs->spi_irs_range, cs->spi_range);
+        return;
+    }
+
+    trace_gicv5_common_realize(cs->irsid, cs->num_cpus,
+                               cs->spi_base, cs->spi_irs_range, cs->spi_range);
+}
+
+static const Property arm_gicv5_common_properties[] = {
+    DEFINE_PROP_LINK_ARRAY("cpus", GICv5Common, num_cpus,
+                           cpus, TYPE_ARM_CPU, ARMCPU *),
+    DEFINE_PROP_ARRAY("cpu-iaffids", GICv5Common, num_cpu_iaffids,
+                      cpu_iaffids, qdev_prop_uint32, uint32_t),
+    DEFINE_PROP_UINT32("irsid", GICv5Common, irsid, 0),
+    DEFINE_PROP_UINT32("spi-range", GICv5Common, spi_range, 0),
+    DEFINE_PROP_UINT32("spi-base", GICv5Common, spi_base, 0),
+    DEFINE_PROP_UINT32("spi-irs-range", GICv5Common, spi_irs_range,
+                       GICV5_SPI_IRS_RANGE_NOT_SET),
+};
+
 static void gicv5_common_class_init(ObjectClass *oc, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
 
     rc->phases.hold = gicv5_common_reset_hold;
+
+    dc->realize = gicv5_common_realize;
+    device_class_set_props(dc, arm_gicv5_common_properties);
 }
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index edd3c49c5f..54777f6da3 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -233,6 +233,9 @@ gicv5_badread(const char *domain, uint64_t offset, unsigned size) "GICv5 IRS %s
 gicv5_write(const char *domain, uint64_t offset, uint64_t data, unsigned size) "GICv5 IRS %s config frame write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 gicv5_badwrite(const char *domain, uint64_t offset, uint64_t data, unsigned size) "GICv5 IRS %s config frame write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u: error"
 
+# arm_gicv5_common.c
+gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
+
 # armv7m_nvic.c
 nvic_recompute_state(int vectpending, int vectpending_prio, int exception_prio) "NVIC state recomputed: vectpending %d vectpending_prio %d exception_prio %d"
 nvic_recompute_state_secure(int vectpending, bool vectpending_is_s_banked, int vectpending_prio, int exception_prio) "NVIC state recomputed: vectpending %d is_s_banked %d vectpending_prio %d exception_prio %d"
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index b7a17aac31..ea01b2a1db 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -12,10 +12,24 @@
 #include "qom/object.h"
 #include "hw/core/sysbus.h"
 #include "hw/intc/arm_gicv5_types.h"
+#include "target/arm/cpu-qom.h"
 
 /*
  * QEMU interface:
  *
+ * + QOM array property "cpus": CPUState pointers to each CPU
+ *   connected to this IRS.
+ * + QOM array property "cpu-iaffids": array of uint32_t giving the
+ *   IAFFID for each CPU in the "cpus" property array
+ * + QOM property "irsid": unique identifier for this IRS in the system
+ *   (this is IRS_IDR0.IRSID); default is 0
+ * + QOM property "spi-range": total number of SPIs in the system
+ *   IRS (this is IRS_IDR5.SPI_RANGE); must be set
+ * + QOM property "spi-base": minimum SPI INTID.ID implemented on this
+ *   IRS (this is IRS_IDR7.SPI_BASE); default is 0
+ * + QOM property "spi-irs-range": number of SPI INTID.ID managed on this
+ *   IRS (this is IRS_IDR6.SPI_IRS_RANGE); defaults to value of spi-range
+ *
  * sysbus MMIO regions (in order matching IRS_IDR0.INT_DOM encoding):
  * - IRS config frame for the Secure Interrupt Domain
  * - IRS config frame for the Non-secure Interrupt Domain
@@ -47,6 +61,17 @@ struct GICv5Common {
 
     /* Bits here are set for each physical interrupt domain implemented */
     uint8_t implemented_domains;
+
+    /* Properties */
+    uint32_t num_cpus;
+    ARMCPU **cpus;
+    uint32_t num_cpu_iaffids;
+    uint32_t *cpu_iaffids;
+
+    uint32_t irsid;
+    uint32_t spi_base;
+    uint32_t spi_irs_range;
+    uint32_t spi_range;
 };
 
 struct GICv5CommonClass {
-- 
2.43.0



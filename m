Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2EDEC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKG-0001Mt-M7; Mon, 23 Feb 2026 12:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKC-0001H4-Ge
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:24 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKA-0008W4-Dh
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:24 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso40269255e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866141; x=1772470941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5cft2ROe5R4C7Ip3bP/3xgfz9mph6PasFRNc4x+3lY0=;
 b=STW3xIMnlEKKmeCabu3QzBTWp4dQ2co0b5y0JP+ysA+wPnguuDx3mWhvCLHVPMC9TP
 iAyWq4HlEBUmubkmvd2FW19p8n2cWzeXjX4xlTRIfptl8MJW0//+WjOr+MLnh5yVdr2N
 ydt1aSGkvVY+8ZtiVJGMWfNR/6eWpl9Eo84j+J6aCVZ+vFRcG87MaEKYlm2GuQ+aRlXZ
 nXqnF2wySVbaHhyrti7XAB0j9XZLJ5SmwPxQnwzZssyJb82hynU4Pf/vlKZvpwRR8Wnh
 3lDBWPLmWUpygIm5RtkwMK99dF0RW8X8R4OguofLc77nTHbxBC7mCw/4eT8IZF11VArA
 Gj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866141; x=1772470941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5cft2ROe5R4C7Ip3bP/3xgfz9mph6PasFRNc4x+3lY0=;
 b=uLskmAQYeugoRdtVi2YJVWyd4yQrQa0NZGMPHDsVv3Mp6ONKa/8BYaBw4xAsvrSXNJ
 0SgFGZtOwUikf+dQKlSkUXu2/sw8G34qKTlro7q8IeMHjTNGWk5W8u21703HyUltYimh
 1QE/NcxHLEOxT6fcMxKuWGuGy8uHPYPKbWhA/GM9/QWyl8F82E1ci3jjnPrIhemYGkre
 lWJquNuL98JahqPsC/4cVJDaUM8T9nbfxvTloOL+uzYetnvDNesTiOFnXPp5oMQjse7E
 EKYEblD2a0kjwfxKmZdfbr9vIBFecO4LQBacFtklxUertU+BNFND0NmSZyiycae1UzCi
 0+/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP66Yruymi2GN6fk6nRacvrt+icuDhJNxR/+HtnT4c/LwHnwAuJa2NzjkqSvoFpqkym68WTzdGnPe1@nongnu.org
X-Gm-Message-State: AOJu0Yyb888HTc7Orer2LEhKGQMYVClxRX4HYit1IdeZv8+ZJ4ifxAXT
 GX2aJalx0YiUrjfC3fPXsBLeE12jqdkL76cjpiFfzx3eTNDIXEaQPcPXnxIlNnG0sKE=
X-Gm-Gg: AZuq6aLEuS6PB5ZwQ+h71+msZtqdf2x72Apv6+Lfyw85biKgh0e588o0XEhHBtOZcfG
 iK6ZQMRzzEsjGx3lJ8mTZShfT/zTj3jLl/v4z1b84tG0s26RmayqcYdy9TdjF3Y1e4Wi7El5orG
 pTQWP+1MRPZdkKfLWKdqIzbIYTWavpx5VZU/g1/FnbMGStvm3JcgzCyU2tIzO3qShDbBHKp5rrr
 p9yoGRSptd0rbxBA7pKCX+tlk4cRT2wLBNxBKd5YIKBOJOD7yWX4h5aMk893W30aFQL65m4r3wr
 Cy/dgUOLUvQUfp9Y9SncoLk7kCIObeHkwaswsCSeNYCVDczwh2Kg38rb1gxAh+47VnSYyRz9WIn
 jiBhJY376AoITLbOdh4wL1h8/Xjm7Zk9zerrEl6CLy7J4KrhkbKO+zvslls1O1cVxT+fGp5ko3R
 3H17nbHVAHEHRMlhOKWUWTdj0Bw2J2M5XyKd3b3SuzkqvG7Ya7CLVdl8JjKxMNLgIKSGHrVWHWZ
 T1sX2ep1Otq97/6jugTpkmKtflysBjBicWNaVuF+A==
X-Received: by 2002:a05:600c:4fd3:b0:480:4d38:7abc with SMTP id
 5b1f17b1804b1-483a95f8eebmr160065125e9.11.1771866140779; 
 Mon, 23 Feb 2026 09:02:20 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/65] hw/intc/arm_gicv5: Create and validate QOM properties
Date: Mon, 23 Feb 2026 17:01:13 +0000
Message-ID: <20260223170212.441276-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
---
 hw/intc/arm_gicv5_common.c         | 80 ++++++++++++++++++++++++++++++
 hw/intc/trace-events               |  3 ++
 include/hw/intc/arm_gicv5_common.h | 25 ++++++++++
 3 files changed, 108 insertions(+)

diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index cb80c8821c..c8b6704fe4 100644
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
index 8ba2e5c879..b22f020a53 100644
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



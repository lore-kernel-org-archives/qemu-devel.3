Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416AC60A261A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Kj2by8xv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKG3E-0003IA-Vu; Fri, 23 Oct 2026 10:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG39-0003Gx-7T
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:15 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG37-0006Ya-2L
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a218b13c4bso3559045e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792764911; x=1793369711; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3LKAZy34YndD6iJuQL7KIb5ycfRRUxBeUIboGwU86RU=;
 b=Kj2by8xvLHKOTCEkhYdLnXJwBDB80ZpcHThJa7zzxMl36oAbWd3MRVYxvCE4vCI5zS
 0ft+lp9AX+/Ij0zsChmoOuIc9nIVrt5CDGIM9vxPEQkSigQdGuDvsZTg15Dbm6e61vtk
 mOpavTCgoum0FvaeC7aeCIUR5MMK7KZOLxLmKzXw5MFUJoa3g34Zcgvfhj8cHJ6DgqjW
 C+w9RguYSLTzyeWLTevOOuCFyW0M/Zb8GrsQ82qQAmvJv6LpubYRXOtr+Ax7ptlsM/fN
 G5Uyti+DGjIRj1PZUzmYU22BjjSwXUmA7/AFgQX+eD9lt5vImOKJXDs+fXwBHv9LJnn/
 gPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764911; x=1793369711;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3LKAZy34YndD6iJuQL7KIb5ycfRRUxBeUIboGwU86RU=;
 b=OlSrt6e51ogoF59JO6BvFPmlBK3+WWXpfuQk//O8lAWGQ1gmFBgNOiZGIFGZwUKiYh
 676s1htIMAmej2vui+ujRYX9k4reT4WrziupltIhe4L3RZWEL6++kc86jwVbRLnyqV3l
 TrapPtC7z49BZdONFcm6t73ncYeNJvjoHbb5ELxxI9vYeXDruDVXVveXJk7/BZX3gvM2
 NrfWnrye7coejFi0B+INtK8MhPscIjvJ33J66iR5wkIQgGxvX4Di1bFWLf+6Tt5qxsQY
 d2V4EaJXxgr5mi8aK2nBq091W7zJmX652a7Dl80f/KYBIP9JBblzmHeCE3C4iafsYZ2k
 unQg==
X-Gm-Message-State: AFq9FYJ0d/DFrJ8c96p+t22lFSbPHt1v+f+vjz83+YplwlojFnPBhABG
 e7SyI3tWleMtc1rKSv6+NnuiEXs0+t39dJv5DKLnSnBrV6BljKb8Pe7c10Hzdtcf29Cglspnqwi
 NfEydIXo=
X-Gm-Gg: AYBFou2YOEQ15PsEPm6gvVHMKelswudgXjMUfh1AfWlyvdWH70mbDaxygEvURbteFe6
 +x1vmoUYESTGEm2120bJyLDjtjAxVEu+ZJvcRDUTik9eDhisYWNGfiC5PR3S9Ym0jhDo110aEjZ
 AwdVUC5DAqW0FSF3ZQj+dG6qXEuWeuUBhA5zO1CS9LzRdvfZteuraAVQokmbSfwYIeqCznUIIgC
 Kntff7WnE6bKKYaHaAvyyFB+hK0f0TsV/H3Zw3RN83C+P328xVyIGBm7K1MO3ZctqjUngauGIXw
 us/HKLgleh9fSg8K0xarhHYEa8SpZzIIlfDo9+zfMm1K1u9046x7L2YuyYR7kWRXJIukXdWMmTe
 Xw1NlHDAf011SxuYjpna9CwD1oZscG6IRuljHDuKOpTWarpHSYW1cgot9cq+TZYfmG7FfP94OHG
 PxI1Qrst85LfGqn+EKVetQlIPWpLcM6A50tedPj/rZLdB9G5DQztYZ3385MN0jWgUXfx96rVjl4
 ZrD51zSg2Bpv8O1rub+qqNRIx62GZ/+oe7Ks/HWGEGGXBHBQh0uX7jaysnDcH2Q+wNN80cj8X9E
 jViHv+uZAX9JaPhs7P8s2btApsVwgXvC6qa/hp39IaLcIqdAcMDVXaLHm0JV
X-Received: by 2002:a05:600c:3544:b0:4a2:883:4adb with SMTP id
 5b1f17b1804b1-4a211cb275amr41698325e9.22.1792764911170; 
 Fri, 23 Oct 2026 07:15:11 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe31a7a4sm1310675e9.0.2026.10.23.07.15.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:15:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/16] hw/misc/bcm2838_thermal: add BCM2838 thermal sensor
Date: Fri, 23 Oct 2026 15:14:50 +0100
Message-ID: <20261023141503.1397009-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023141503.1397009-1-peter.maydell@linaro.org>
References: <20261023141503.1397009-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sergey Kambalin <serg.oker@gmail.com>

Add a dummy BCM2838 (BCM2711/Raspberry Pi 4B) thermal sensor: a
single status register that always reports a fixed 25C reading with
both "valid" bits set. Real hardware reports live temperature; a
fixed reading is enough for guests that just probe the sensor and
read it, without modeling actual thermal behavior.

Part of Sergey Kambalin's original Raspberry Pi 4B series (patchwork
series 829638, posted to qemu-devel in 2024, never merged). Ported
to current master by Marcelo Manzo: header paths moved under
hw/core/, class_init()'s const void *data. No functional change
otherwise (this device has no reset or migration state to begin
with).

Boot-tested: guest's thermal_zone0/temp reports 25310 (25.31C),
matching the fixed reading this device returns.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261015181111.60491-4-marcelomanzo@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/bcm2838_thermal.h | 23 ++++++++
 hw/misc/bcm2838_thermal.c         | 98 +++++++++++++++++++++++++++++++
 hw/misc/meson.build               |  1 +
 3 files changed, 122 insertions(+)
 create mode 100644 include/hw/misc/bcm2838_thermal.h
 create mode 100644 hw/misc/bcm2838_thermal.c

diff --git a/include/hw/misc/bcm2838_thermal.h b/include/hw/misc/bcm2838_thermal.h
new file mode 100644
index 00000000000..1ba524ed8bd
--- /dev/null
+++ b/include/hw/misc/bcm2838_thermal.h
@@ -0,0 +1,23 @@
+/*
+ * BCM2838 dummy thermal sensor
+ *
+ * Copyright (C) 2022 Maksim Kopusov <maksim.kopusov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BCM2838_THERMAL_H
+#define BCM2838_THERMAL_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_BCM2838_THERMAL "bcm2838-thermal"
+OBJECT_DECLARE_SIMPLE_TYPE(Bcm2838ThermalState, BCM2838_THERMAL)
+
+struct Bcm2838ThermalState {
+    SysBusDevice busdev;
+    MemoryRegion iomem;
+};
+
+#endif /* BCM2838_THERMAL_H */
diff --git a/hw/misc/bcm2838_thermal.c b/hw/misc/bcm2838_thermal.c
new file mode 100644
index 00000000000..40148ddbb98
--- /dev/null
+++ b/hw/misc/bcm2838_thermal.c
@@ -0,0 +1,98 @@
+/*
+ * BCM2838 dummy thermal sensor
+ *
+ * Copyright (C) 2022 Maksim Kopusov <maksim.kopusov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/misc/bcm2838_thermal.h"
+#include "hw/core/registerfields.h"
+#include "migration/vmstate.h"
+#include "qemu/error-report.h"
+
+REG32(STAT, 0x200)
+FIELD(STAT, DATA, 0, 10)
+FIELD(STAT, VALID_1, 10, 1)
+FIELD(STAT, VALID_2, 16, 1)
+
+#define BCM2838_THERMAL_SIZE 0xf00
+
+#define THERMAL_OFFSET_C 410040
+#define THERMAL_COEFF  (-487.0f)
+#define MILLIDEGREE_COEFF 1000
+
+static uint16_t bcm2838_thermal_temp2adc(int temp_C)
+{
+    return (temp_C * MILLIDEGREE_COEFF - THERMAL_OFFSET_C) / THERMAL_COEFF;
+}
+
+static uint64_t bcm2838_thermal_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint32_t val = 0;
+
+    switch (addr) {
+    case A_STAT:
+        /* Temperature is always 25°C */
+        val = FIELD_DP32(val, STAT, DATA, bcm2838_thermal_temp2adc(25));
+        val = FIELD_DP32(val, STAT, VALID_1, 1);
+        val = FIELD_DP32(val, STAT, VALID_2, 1);
+
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s can't access addr: 0x%"HWADDR_PRIx,
+                     TYPE_BCM2838_THERMAL, addr);
+    }
+    return val;
+}
+
+static void bcm2838_thermal_write(void *opaque, hwaddr addr,
+                                      uint64_t value, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: write 0x%" PRIx64
+                                " to 0x%" HWADDR_PRIx "\n",
+                __func__, value, addr);
+}
+
+static const MemoryRegionOps bcm2838_thermal_ops = {
+    .read = bcm2838_thermal_read,
+    .write = bcm2838_thermal_write,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void bcm2838_thermal_realize(DeviceState *dev, Error **errp)
+{
+    Bcm2838ThermalState *s = BCM2838_THERMAL(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &bcm2838_thermal_ops,
+                          s, TYPE_BCM2838_THERMAL, BCM2838_THERMAL_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+}
+
+static void bcm2838_thermal_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2838_thermal_realize;
+
+    /* This device has no state: no need for vmstate or reset */
+}
+
+static const TypeInfo bcm2838_thermal_info = {
+    .name = TYPE_BCM2838_THERMAL,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Bcm2838ThermalState),
+    .class_init = bcm2838_thermal_class_init,
+};
+
+static void bcm2838_thermal_register_types(void)
+{
+    type_register_static(&bcm2838_thermal_info);
+}
+
+type_init(bcm2838_thermal_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 02e90b479ee..90f3f89de70 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -100,6 +100,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_cprman.c',
   'bcm2835_powermgt.c',
   'bcm2838_rng200.c',
+  'bcm2838_thermal.c',
 ))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAADD6B086
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUaL-0008Uk-So; Thu, 29 Jan 2026 11:09:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaI-0008Rs-HN
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:30 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaG-0006Y5-DG
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:30 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso931101f8f.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702966; x=1770307766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vSfhDkCekIUYfdNzWRcVdLrx+XPd/qEmA3R+NEN9G0A=;
 b=GGcqfDpTC+TtaYKKU1oTeU8QCe/xYvbEL9L38JjPINggM88urDhmBs9CfdHY5Z4JYs
 ph1NOKT1SVZFU4DS8RRQ1EyRX+8/JTDIxwBre+1MTU2kUWjirMhHkDoqfp568QHQcMp6
 VkjXP2ZX8fpcF84cz8pVcimYNnBMGcCv8g6WrgRePVJ+mAnjTtgQjuetnVIo/Ge3vWH5
 PW12phSYcpE2TIr/A52h+GW175Ej1HTraRMtzFui3tnkEZf2XTElhNCLbU6KCjwWT/Ur
 cSpjfxoaR+hZsu/gLQ79MUKLnymldzR8sUbJ2+NI9PDBNjWrk5xjxSdPzIa770VYOVbJ
 TEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702966; x=1770307766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vSfhDkCekIUYfdNzWRcVdLrx+XPd/qEmA3R+NEN9G0A=;
 b=g//5n27ooPLgXay4akk2jzq4enDqa+v/W2y/8BtMedV070nksCPOoUK7vi558rA1k9
 1J1KUfstVU/ZRDyaFLXapNw6HeI90PVj6gz7DGjb8rUxUxCR5QjIf/kB01c3pS3Jh9me
 Sw8mjKjuVg6fJ6xSb++0snoq2qsMIp60NgPD8aWM/nqTAEdGzA6Bm2/AzLVeyps44cwR
 ol8MPuOlJ5UqOojGAnFedIm7lN4sDqzv3MmTwPtZeX3CmuO6OI//pzn97xeItQIMLpxc
 iY04hVv+EGDZOBqbN3oA4RSrqRT+MxhhPGejJgQT6ZqCZzEo+W7VB8ewtnFalwQffyhR
 /2JQ==
X-Gm-Message-State: AOJu0YwKxAtug7s1O8+q4SttGXEHlaVYOxbs6xi2dgNBdF3JmvHWXr26
 aE6siyvlT+omjBbIysLysWui7OUZzGwqG4Cc4INeWRSBzJneJxhLB7JAW0h+jpxkkRzglO9+joU
 H/J5H5PA=
X-Gm-Gg: AZuq6aI95/4faJnRKCLVsajgdLhLBbixSX8v0HH6KvGcBaIsx2prhT9RS2wuVwaQUp1
 tzOF4F4YDoCl3jxJ3Ft5UWUMx8LSd6g/1jPeVJ7+TsmTQPJ+GwbsTj0Vc2ZQlSBUMHEduOe7bdJ
 vPZZkUxyPoFiCTo0ynhtse0Yo+dHzr8rwZurafjzwnBrk0KvJgaX32sTl6RwCjngjUO9+WkyOD+
 /PEqbwdN4whGNFP9TSruPRikdZrN6JFsCmKmZ9WXjlJuTKiR3BLNhyLbgfVyda83qORQSMPHvsS
 guhtlojR80c5mFbrNE6hjfxhh+yDwr1rAa2xShqiF1pGpfkV/cg/Zr8ZjTNoxpUsdNLiLenXVxM
 YHtSuLoSxDh/F9ExC8sjMAyT75kZhwbQWt3z22HCvXwlsYBkYuuBOiexPJs4N9HMwjU9Xj6CXHB
 Tw+VlfXMaOY0B274Zj3KTDr250I5331g==
X-Received: by 2002:a5d:64c7:0:b0:432:5c34:fb22 with SMTP id
 ffacd0b85a97d-435f3a7bee5mr169962f8f.22.1769702965784; 
 Thu, 29 Jan 2026 08:09:25 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/43] hw/arm/smmuv3-accel: Introduce smmuv3 accel device
Date: Thu, 29 Jan 2026 16:08:39 +0000
Message-ID: <20260129160917.1415092-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Set up dedicated PCIIOMMUOps for the accel SMMUv3, since it will need
different callback handling in upcoming patches. This also adds a
CONFIG_ARM_SMMUV3_ACCEL build option so the feature can be disabled
at compile time. Because we now include CONFIG_DEVICES in the header to
check for ARM_SMMUV3_ACCEL, the meson file entry for smmuv3.c needs to
be changed to arm_ss.add.

The “accel” property isn’t user visible yet and it will be introduced in
a later patch once all the supporting pieces are ready.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-6-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig          |  5 ++++
 hw/arm/meson.build      |  3 ++-
 hw/arm/smmuv3-accel.c   | 59 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h   | 27 +++++++++++++++++++
 hw/arm/smmuv3.c         |  5 ++++
 include/hw/arm/smmuv3.h |  3 +++
 6 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/smmuv3-accel.c
 create mode 100644 hw/arm/smmuv3-accel.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 97d747e206..c66c452737 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -626,8 +626,13 @@ config FSL_IMX8MP_EVK
     depends on TCG
     select FSL_IMX8MP
 
+config ARM_SMMUV3_ACCEL
+    bool
+    depends on ARM_SMMUV3
+
 config ARM_SMMUV3
     bool
+    select ARM_SMMUV3_ACCEL if IOMMUFD
 
 config FSL_IMX6UL
     bool
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index aeaf654790..c250487e64 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -84,7 +84,8 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
-arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
+arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
+arm_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
new file mode 100644
index 0000000000..99ef0db8c4
--- /dev/null
+++ b/hw/arm/smmuv3-accel.c
@@ -0,0 +1,59 @@
+/*
+ * Copyright (c) 2025 Huawei Technologies R & D (UK) Ltd
+ * Copyright (C) 2025 NVIDIA
+ * Written by Nicolin Chen, Shameer Kolothum
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/arm/smmuv3.h"
+#include "smmuv3-accel.h"
+
+static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
+                                               PCIBus *bus, int devfn)
+{
+    SMMUDevice *sdev = sbus->pbdev[devfn];
+    SMMUv3AccelDevice *accel_dev;
+
+    if (sdev) {
+        return container_of(sdev, SMMUv3AccelDevice, sdev);
+    }
+
+    accel_dev = g_new0(SMMUv3AccelDevice, 1);
+    sdev = &accel_dev->sdev;
+
+    sbus->pbdev[devfn] = sdev;
+    smmu_init_sdev(bs, sdev, bus, devfn);
+    return accel_dev;
+}
+
+/*
+ * Find or add an address space for the given PCI device.
+ *
+ * If a device matching @bus and @devfn already exists, return its
+ * corresponding address space. Otherwise, create a new device entry
+ * and initialize address space for it.
+ */
+static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
+                                              int devfn)
+{
+    SMMUState *bs = opaque;
+    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
+    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
+    SMMUDevice *sdev = &accel_dev->sdev;
+
+    return &sdev->as;
+}
+
+static const PCIIOMMUOps smmuv3_accel_ops = {
+    .get_address_space = smmuv3_accel_find_add_as,
+};
+
+void smmuv3_accel_init(SMMUv3State *s)
+{
+    SMMUState *bs = ARM_SMMU(s);
+
+    bs->iommu_ops = &smmuv3_accel_ops;
+}
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
new file mode 100644
index 0000000000..0dc6b00d35
--- /dev/null
+++ b/hw/arm/smmuv3-accel.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (c) 2025 Huawei Technologies R & D (UK) Ltd
+ * Copyright (C) 2025 NVIDIA
+ * Written by Nicolin Chen, Shameer Kolothum
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ARM_SMMUV3_ACCEL_H
+#define HW_ARM_SMMUV3_ACCEL_H
+
+#include "hw/arm/smmu-common.h"
+#include CONFIG_DEVICES
+
+typedef struct SMMUv3AccelDevice {
+    SMMUDevice sdev;
+} SMMUv3AccelDevice;
+
+#ifdef CONFIG_ARM_SMMUV3_ACCEL
+void smmuv3_accel_init(SMMUv3State *s);
+#else
+static inline void smmuv3_accel_init(SMMUv3State *s)
+{
+}
+#endif
+
+#endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 985dfb345f..95d44f81ed 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -32,6 +32,7 @@
 #include "qapi/error.h"
 
 #include "hw/arm/smmuv3.h"
+#include "smmuv3-accel.h"
 #include "smmuv3-internal.h"
 #include "smmu-internal.h"
 
@@ -1882,6 +1883,10 @@ static void smmu_realize(DeviceState *d, Error **errp)
     SysBusDevice *dev = SYS_BUS_DEVICE(d);
     Error *local_err = NULL;
 
+    if (s->accel) {
+        smmuv3_accel_init(s);
+    }
+
     c->parent_realize(d, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index d183a62766..bb7076286b 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -63,6 +63,9 @@ struct SMMUv3State {
     qemu_irq     irq[4];
     QemuMutex mutex;
     char *stage;
+
+    /* SMMU has HW accelerator support for nested S1 + s2 */
+    bool accel;
 };
 
 typedef enum {
-- 
2.43.0



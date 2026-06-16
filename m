Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D684CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAH-0005y8-Fp; Tue, 16 Jun 2026 15:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ83-0004VV-6n
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:28 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7u-0000xv-JH
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:14 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45eeea039ebso2830740f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636822; x=1782241622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8o5615QM/YZyebhfGAhf37s8TorbhzZ4P/CIGr3ijUc=;
 b=nttykw5zU+pFLNd16gqCrA7WnlyTDvjCPEalZdmJpD7O+pcX0vbnsBukPFdMIOrZw2
 Qm60jvyBYPFHoVPQNVks+zHOhx0CtfQWoyYc1oWTwCGd/BwHH31T3xeKq9WM1WRARngJ
 8W218agvKJrs1GLhFLenWL2JRORiW/BZ2jOoCKtEjl9Z22Drwsw4SjJhZDNlR8da9Otg
 QI37BvxEehV9Wo5x9VyfGld5Vi1gtca6Ah7Tx3tS+xhnJVVcHXIXZspWJXhG26dZx8Xb
 oTwCr8Q3tuTqNDOr2hexbCPuHE4oQD2FyF4Znx3ppM3zCZOk7dWuRD34y6ulAZwJgUB8
 q2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636822; x=1782241622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8o5615QM/YZyebhfGAhf37s8TorbhzZ4P/CIGr3ijUc=;
 b=bKUWeSlus40847v1SVnlOQ54XiS65i3aoHZEiy7vU4q8UOwySBFai3FOHhoAEdho4O
 zSuVUk2P4FwVm1y6M9/k9v1Koi+06Rv/gQwyl/rR8UWMFpVt20Wfr39BHoJ+GXmylFvx
 kv0eyzJhYHsFm+awnRMemF/JFbTTgwZGva9LHQeduuzPIQyqE2UN4rodJSsY8c4bAn/+
 zItCMgpWE8aYJBBNZeil9cES7JDIKn8J6U+R+13yWuFxDYJOOnuX/03vCgJ9WRDkYyzT
 /SutrTfAmMlspXBfEoKZ6fZU3KBAt4LyAFw4CZbOIaJxK5fjd6VTEJoDrgi605s+zjz+
 B4eQ==
X-Gm-Message-State: AOJu0YxIR473Inrq7usBnzDasTp1i/wyavG633YNM2qL//FrVRkVUIUU
 tbsW7cf/mH6vlPQZRQzJ5mP2r4WCB8FnqCwxtCBvIEFx96Sz6Ng9B4vsA7BAXJV2Vce2RQxoOyN
 vjBgx
X-Gm-Gg: Acq92OHOPNz5La7PrsXrmRS7MQFIsQood2zz3U166lkIyfpyXlQG+bwJe9WTRfC8MrM
 rKdGgwgmF9YawqIs2mbeaPnumPW1WBtz+QqPwVwmWWsHIXhjSO2GWXF4W7icCOb3FqcowhaGZkD
 yR2QVM/GY8/3TlI+M7NSQxE2oKHqIO2QNReHzRT9Rxh6AdRTdlQPsCcT4RVM/BcnfQcx5ZV2VvA
 oc3TYvnXY0Dr5DSZbUi7C5esHwZmDgQwJFG1MJ3XpqricaxtrsAX7Z/Hkwv/tFd9RjQY5qyeqZG
 ARciDeDRwIneDU9+mXnGymt5qsd7TvHU3RGsHDZn4zNL2DPpnbGbdSoh6KWsdfVWqFCZEF8XxIB
 6Q51HR7QIw3hqwFxLPE4SGDMY+dDu7UYoQxiYsIcmTlOSiQeIehrfi8rJij3ziIml1UyNLHpIC2
 aGYKUnp+Zgl4IcTqvbbBMWgBh2UynFjteZelVp6KBE6hDvbWfVyrKTZImBd3oFMNQQ2jCfAYUiy
 WkP5MmJWjkVm1DsQDP1C9XHdGh2KcCT
X-Received: by 2002:a05:6000:4023:b0:43c:fc5c:a9fe with SMTP id
 ffacd0b85a97d-46238ac9fc7mr1294621f8f.20.1781636821950; 
 Tue, 16 Jun 2026 12:07:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/61] hw/arm/tegra241-cmdqv: Add Tegra241 CMDQV ops backend
 stub
Date: Tue, 16 Jun 2026 20:05:54 +0100
Message-ID: <20260616190639.3462006-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Introduce a Tegra241 CMDQV backend that plugs into the SMMUv3 accelerated
CMDQV ops interface.

This patch wires up the Tegra241 CMDQV backend and provides a stub
implementation for CMDQV probe, initialization, vIOMMU allocation
and reset handling.

Functional CMDQV support is added in follow-up patches.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-8-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig                |  5 ++++
 hw/arm/meson.build            |  2 ++
 hw/arm/tegra241-cmdqv-stubs.c | 16 ++++++++++
 hw/arm/tegra241-cmdqv.c       | 56 +++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.h       | 15 ++++++++++
 5 files changed, 94 insertions(+)
 create mode 100644 hw/arm/tegra241-cmdqv-stubs.c
 create mode 100644 hw/arm/tegra241-cmdqv.c
 create mode 100644 hw/arm/tegra241-cmdqv.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index fb798ccbee..500bfdfe2a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -643,6 +643,10 @@ config FSL_IMX8MM_EVK
     depends on TCG
     select FSL_IMX8MM
 
+config TEGRA241_CMDQV
+    bool
+    depends on ARM_SMMUV3_ACCEL
+
 config ARM_SMMUV3_ACCEL
     bool
     depends on ARM_SMMUV3
@@ -650,6 +654,7 @@ config ARM_SMMUV3_ACCEL
 config ARM_SMMUV3
     bool
     select ARM_SMMUV3_ACCEL if IOMMUFD
+    imply TEGRA241_CMDQV
 
 config FSL_IMX6UL
     bool
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 8f66a80e10..4233a800be 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -89,6 +89,8 @@ arm_common_ss.add(when: 'CONFIG_FSL_IMX8MM_EVK', if_true: files('imx8mm-evk.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))
 stub_ss.add(files('smmuv3-accel-stubs.c'))
+arm_common_ss.add(when: 'CONFIG_TEGRA241_CMDQV', if_true: files('tegra241-cmdqv.c'))
+stub_ss.add(files('tegra241-cmdqv-stubs.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(
diff --git a/hw/arm/tegra241-cmdqv-stubs.c b/hw/arm/tegra241-cmdqv-stubs.c
new file mode 100644
index 0000000000..4669f5c5f5
--- /dev/null
+++ b/hw/arm/tegra241-cmdqv-stubs.c
@@ -0,0 +1,16 @@
+/*
+ * Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ *
+ * Stubs for Tegra241 CMDQ-Virtualization extension for SMMUv3
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "smmuv3-accel.h"
+#include "hw/arm/tegra241-cmdqv.h"
+
+const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void)
+{
+    return NULL;
+}
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
new file mode 100644
index 0000000000..ad5a0d4611
--- /dev/null
+++ b/hw/arm/tegra241-cmdqv.c
@@ -0,0 +1,56 @@
+/*
+ * Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ * NVIDIA Tegra241 CMDQ-Virtualization extension for SMMUv3
+ *
+ * Written by Nicolin Chen, Shameer Kolothum
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/arm/smmuv3.h"
+#include "smmuv3-accel.h"
+#include "tegra241-cmdqv.h"
+
+static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
+{
+}
+
+static bool
+tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+                            uint32_t *out_viommu_id, Error **errp)
+{
+    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
+    return false;
+}
+
+static void tegra241_cmdqv_reset(SMMUv3State *s)
+{
+}
+
+static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
+{
+    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
+    return false;
+}
+
+static bool tegra241_cmdqv_probe(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+                                 Error **errp)
+{
+    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
+    return false;
+}
+
+static const SMMUv3AccelCmdqvOps tegra241_cmdqv_ops = {
+    .probe = tegra241_cmdqv_probe,
+    .init = tegra241_cmdqv_init,
+    .alloc_viommu = tegra241_cmdqv_alloc_viommu,
+    .free_viommu = tegra241_cmdqv_free_viommu,
+    .reset = tegra241_cmdqv_reset,
+};
+
+const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void)
+{
+    return &tegra241_cmdqv_ops;
+}
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
new file mode 100644
index 0000000000..74a6954017
--- /dev/null
+++ b/hw/arm/tegra241-cmdqv.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ * NVIDIA Tegra241 CMDQ-Virtualization extension for SMMUv3
+ *
+ * Written by Nicolin Chen, Shameer Kolothum
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ARM_TEGRA241_CMDQV_H
+#define HW_ARM_TEGRA241_CMDQV_H
+
+const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
+
+#endif /* HW_ARM_TEGRA241_CMDQV_H */
-- 
2.43.0



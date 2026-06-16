Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08F9CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZBy-0001m5-KX; Tue, 16 Jun 2026 15:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8E-0004ZP-LT
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ87-0000yI-Nq
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:27 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so32653555e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636823; x=1782241623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G5wNENUz9ZKPTgkYLTujeqWRD9EO2XYzjjtZrcgsT3o=;
 b=bcbgvn0SjfagWDTyBuo/cesNT2rmP/KyiQvwmCfJh8XMEKJ8nvgP7HAdvFFBkZCjAZ
 NwKCYdvSi+bL1d8WbZ5FRRfLoIDtyKtWBsNxfe5R6uCbw2kjp/tVZkiyA5KeVwjvkOWi
 5Z2fh+iEOLDfl8vW5tWUrNrdX6Uh3hJ+DTyva6ebRAGHZoosY4o6wXe+/dK97DzdyoKh
 YSs0BxJIFHd0gA/If1ZwOyInYbr/WVY5E53IyH8cqqb3djGC6+GxYzb9ww8/1V1fYkMe
 adVTr2gfPR5qTBPNT9PQitOm5HccJYbWYkufN+k+5pA12CF89nQCth/8eiZqI8lpDfat
 N8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636823; x=1782241623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G5wNENUz9ZKPTgkYLTujeqWRD9EO2XYzjjtZrcgsT3o=;
 b=T47DPjWQW8dz5wsODA0qMWjMQKpbkEyYsW3fgQBBIcW7j1Yuj7cxT0TSd5bXKBRO5G
 ep+zmklJ+I9XSUFCb7VpOZph36e8MM+u7My13lXjIvsWm4fcrTg6i7Cc3Ojqqku7LyzC
 Pfn83gkWvjkRxs+Pi6/vR4OknT8JaC4c2HDeYirmwDbxH+esxKFuuDJQ1fPHa9A3KOTD
 SniOCLkMYjdRmONgteBI6t6wB2QeHQWaDqyMS9bO88MnKjwnLLUMLgsDFAWytWHlWR4+
 b6r/xrAIscCjxkDJanmT43c4vZ81q4LZ+AXB7omJTehFa6mWxHDko6cij3Br0vrZ5W9V
 tEeQ==
X-Gm-Message-State: AOJu0Yy8nlrM64w49Pa24BPduWA7yFwJUqVIA8pU/vPQBdQ+WVw1gGl9
 MVgroGIVHDy/a+zA8py+pQfgDOWCjfrNbnFCqS8TqRDunEi5XJ6cliYQcqKb8zGDMnLw6QPu2qq
 6OTys
X-Gm-Gg: Acq92OHKw74/rgKC6EHdOrfL3N3QJ7IPICQPhVDUhFoVsFcr0Ob7tKG68PZLEqqLG05
 VRs+dApEhX+Y8OJ0Mnw2BB/VjK2PjXRUnfylwZ5lsFkcNpWv00CyRyV92ui/JXLLfrdT49bOD2i
 wwwfIuXcFPoqjKe8PA1wK4yF602Z+E6bQMoy0vV7duPSPeg2xcHEdZtegtinmcpXCalaquoQGLM
 FqcWVUDgG1yqHNPjNA3Oju/vKvau9Njw4Qic2w34j5egEo3ipMiHJD7bB3L/oxLGepCORNUAzgz
 ODJIPWs+82x9n6vzcgy8CpesCjPArz43WnXa6y3IvhsbqNbV9jNlig0rLIbzSSj2gDygR9kW6Ig
 M0QPahK/6l+dwHVqrpCZxQO3XlSRg6rUVJZJiJuYiGDaVj4TVP9eYr7gWJ8Jb1SS4i6DkyxOXr7
 yZwWb6q4Ey0sxTAO9S7rjCT1sWIjpuFX5dlhTgVGfWMGBIhZLmpSw2tK6YawRlJgz/dV6AIzFL1
 q4MSXjk6fvDkmi/nQeaX1zKeSpw1vF7
X-Received: by 2002:a05:600c:19cb:b0:490:d354:d151 with SMTP id
 5b1f17b1804b1-492333c8e6dmr12107195e9.18.1781636823122; 
 Tue, 16 Jun 2026 12:07:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/61] hw/arm/smmuv3-accel: Wire CMDQV ops into accel lifecycle
Date: Tue, 16 Jun 2026 20:05:55 +0100
Message-ID: <20260616190639.3462006-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Add support for selecting and initializing a CMDQV backend based on the
cmdqv OnOffAuto property.

If set to OFF, CMDQV is not used and the default IOMMUFD-backed allocation
path is taken.

If set to AUTO, QEMU attempts to probe a CMDQV backend during device setup.
If probing succeeds, the selected ops are stored in the accelerated SMMUv3
state and used. If probing fails, QEMU silently falls back to the default
path.

If set to ON, QEMU requires CMDQV support. Probing is performed during
setup and failure results in an error.

When a CMDQV backend is active, its callbacks are used for vIOMMU
allocation, free, and reset handling. Otherwise, the base implementation
is used.

The current implementation wires up the Tegra241 CMDQV backend through the
generic ops interface. Functional CMDQV behaviour is added in subsequent
patches.

No functional change.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-9-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c   | 94 ++++++++++++++++++++++++++++++++++++++---
 include/hw/arm/smmuv3.h |  2 +
 2 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 70b2581c17..3ceca56a67 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -19,6 +19,7 @@
 #include "smmuv3-internal.h"
 #include "smmuv3-accel.h"
 #include "system/system.h"
+#include "tegra241-cmdqv.h"
 
 /*
  * The root region aliases the global system memory, and shared_as_sysmem
@@ -570,6 +571,7 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *hiodi,
                           Error **errp)
 {
     SMMUv3AccelState *accel = s->s_accel;
+    const SMMUv3AccelCmdqvOps *cmdqv_ops = accel->cmdqv_ops;
     struct iommu_hwpt_arm_smmuv3 bypass_data = {
         .ste = { SMMU_STE_CFG_BYPASS | SMMU_STE_VALID, 0x0ULL },
     };
@@ -580,10 +582,17 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *hiodi,
     uint32_t viommu_id, hwpt_id;
     IOMMUFDViommu *viommu;
 
-    if (!iommufd_backend_alloc_viommu(hiodi->iommufd, hiodi->devid,
-                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3, s2_hwpt_id,
-                                      NULL, 0, &viommu_id, errp)) {
-        return false;
+    if (cmdqv_ops) {
+        if (!cmdqv_ops->alloc_viommu(s, hiodi, &viommu_id, errp)) {
+            return false;
+        }
+    } else {
+        if (!iommufd_backend_alloc_viommu(hiodi->iommufd, hiodi->devid,
+                                          IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
+                                          s2_hwpt_id, NULL, 0, &viommu_id,
+                                          errp)) {
+            return false;
+        }
     }
 
     viommu = g_new0(IOMMUFDViommu, 1);
@@ -629,12 +638,70 @@ free_bypass_hwpt:
 free_abort_hwpt:
     iommufd_backend_free_id(hiodi->iommufd, accel->abort_hwpt_id);
 free_viommu:
-    iommufd_backend_free_id(hiodi->iommufd, viommu->viommu_id);
+    if (cmdqv_ops && cmdqv_ops->free_viommu) {
+        cmdqv_ops->free_viommu(s);
+    } else {
+        iommufd_backend_free_id(hiodi->iommufd, viommu->viommu_id);
+    }
     g_free(viommu);
     accel->viommu = NULL;
     return false;
 }
 
+static const SMMUv3AccelCmdqvOps *
+smmuv3_accel_probe_cmdqv(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+                         Error **errp)
+{
+    const SMMUv3AccelCmdqvOps *ops = tegra241_cmdqv_get_ops();
+
+    if (!ops) {
+        error_setg(errp, "No CMDQV ops found");
+        return NULL;
+    }
+    g_assert(ops->probe);
+    g_assert(ops->alloc_viommu);
+
+    if (!ops->probe(s, idev, errp)) {
+        return NULL;
+    }
+    return ops;
+}
+
+static bool
+smmuv3_accel_select_cmdqv(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+                          Error **errp)
+{
+    const SMMUv3AccelCmdqvOps *ops = NULL;
+
+    if (s->s_accel->cmdqv_ops) {
+        return true;
+    }
+
+    switch (s->cmdqv) {
+    case ON_OFF_AUTO_OFF:
+        s->s_accel->cmdqv_ops = NULL;
+        return true;
+    case ON_OFF_AUTO_AUTO:
+        ops = smmuv3_accel_probe_cmdqv(s, idev, NULL);
+        break;
+    case ON_OFF_AUTO_ON:
+        ops = smmuv3_accel_probe_cmdqv(s, idev, errp);
+        if (!ops) {
+            error_append_hint(errp, "CMDQV requested but not supported");
+            return false;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (ops && ops->init && !ops->init(s, errp)) {
+        return false;
+    }
+    s->s_accel->cmdqv_ops = ops;
+    return true;
+}
+
 static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                           HostIOMMUDevice *hiod, Error **errp)
 {
@@ -669,6 +736,10 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         goto done;
     }
 
+    if (!smmuv3_accel_select_cmdqv(s, hiodi, errp)) {
+        return false;
+    }
+
     if (!smmuv3_accel_alloc_viommu(s, hiodi, errp)) {
         error_append_hint(errp, "Unable to alloc vIOMMU: hiodi devid 0x%x: ",
                           hiodi->devid);
@@ -946,8 +1017,17 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
 
 void smmuv3_accel_reset(SMMUv3State *s)
 {
-     /* Attach a HWPT based on GBPA reset value */
-     smmuv3_accel_attach_gbpa_hwpt(s, NULL);
+    SMMUv3AccelState *accel = s->s_accel;
+
+    if (!accel) {
+        return;
+    }
+    /* Attach a HWPT based on GBPA reset value */
+    smmuv3_accel_attach_gbpa_hwpt(s, NULL);
+
+    if (accel->cmdqv_ops && accel->cmdqv_ops->reset) {
+        accel->cmdqv_ops->reset(s);
+    }
 }
 
 static void smmuv3_accel_as_init(SMMUv3State *s)
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 85be3d7467..34d0f65eaa 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -75,6 +75,8 @@ struct SMMUv3State {
     OnOffAuto ats;
     OasMode oas;
     SsidSizeMode ssidsize;
+    /* SMMU CMDQV extension */
+    OnOffAuto cmdqv;
 
     Notifier machine_done;
 };
-- 
2.43.0



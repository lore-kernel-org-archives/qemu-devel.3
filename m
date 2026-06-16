Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F39CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAc-0007nP-Jt; Tue, 16 Jun 2026 15:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8W-0004jL-NS
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:51 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8S-0000yl-Ua
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:48 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-491b390f9e9so41835015e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636826; x=1782241626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FXr9ylmZYOE7+E0t1jj2Ga4P2T/mevVY7GxsxYiycI4=;
 b=LnntycusGZnhGD+yTaGRFpeqT9OX3dvinnLfqbleh7998F7l7ilKYEKTNP+eesRrin
 N0DGI6qzBwNiRPZGrQvGHiGobMxrCCC5OSJTwLUN5janXfzSChRj1yDGk9Xdcf4t/6sk
 u7la2HEfM/N1J41Khr2jJRoDPh84qjnzkgObrkPm3dJ/xU0tdhLorFOdsZQwS2VzOtKY
 FcGueP8eAFLjl9Fl9cn/G/qq3Sv2kT/sIc8v4mq3yd6o2O0x5AVpPWa1BsWmEfJ4Fluz
 DA4zMfAuAJ7kRQRIczxuaYshrWEgQeml4SznN+C7kZwg7rX6blKhsLIYTcwS5DyAvzsI
 Uplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636826; x=1782241626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FXr9ylmZYOE7+E0t1jj2Ga4P2T/mevVY7GxsxYiycI4=;
 b=Suj2MyAtwf+i5dARNn0lN2KgNpHUmFOVdn5zD1Tnib4F5wFwzF/EsiiHnqclQT1SRQ
 XxpJrnvCMDFoPzn9vHiW6hQdfy0jgw8i2gfWa7WAyVtqjWAsCjyPQOIGsT5ckSHeRM5M
 aeqzwazT7iJc+wLt36iwF3l8HGfx/Qpw19Sx8343GSICz3fhx/e3IV85Oe1B2zx2MYfH
 8llDEYBvs0TGOWyFl7i1reMczVy8rwuTauhsjp9F1nzsSfDWPJXSlWFLczWuVZyUPwUu
 pFSuSdYSuVxB65UD/sUvqHL0GhNjC6CNWe1Q5xTjMEOJo/BHT2HiTG0OpfvwonULxFBH
 lOdg==
X-Gm-Message-State: AOJu0Yx1QYL1GIzVXaoUvalUrqdxselTbVte+Gd+ToxIG6fzEOniXhRM
 x4az0iAX0xzytlZMzkpnIhPd5F1ljONcVSs/e8Y46/OVcYRWDndwr328y6qnTk2ry2RYpkhnZet
 viVrw
X-Gm-Gg: Acq92OESghlezfQR+iTx+kksUsLQgoE/yuJPEYQCDZPD0+5vpYV5Wx1uB8sZOmZ4Gbo
 1f9gOgTmoWnVONarStb02b/dc/LYI6xjIRg0hNM3jdgluipKni5/lvZomBROsfoTIIb40WumDon
 eFI7Mk8BViQTyYEBxb3DY7Zn98MjsYdRak9vRud+1o/30YZcIwXyRx281gLRyaEwcrL2KU4MTQf
 YW/ehckA9R4weF9eZsVKc40/kx3D9bweQT/EiLoYjMDDGHJ/hbN7/eVdJIf0rWvRTlvUDsTGD3X
 JPcXZq7toXLJWiOeYCVw3PyZO/e2aolgBIJL/UPJgDmYEiCRy5O4D244K6tIi0wsy9xD4bUuE26
 lCm2RQnF0uFEhBEp7Bo7rvgRdCnH2yT6sCd05LACe3AE9/zSGpRXom0gftEiHRHGyvYArQPEKli
 bbClm9iCxtR33r6brUt3RikGklBbcx6coPihWd/oMae2PgnyS27gPwCd6qCfDL+6tatmAMH9k33
 CIvbj9XJZ9PdbA8GITNW9a6HqnH8RTi
X-Received: by 2002:a05:600c:3317:b0:492:1e36:552c with SMTP id
 5b1f17b1804b1-492333e3b6amr8268905e9.37.1781636826209; 
 Tue, 16 Jun 2026 12:07:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/61] hw/arm/tegra241-cmdqv: Implement CMDQV init
Date: Tue, 16 Jun 2026 20:05:58 +0100
Message-ID: <20260616190639.3462006-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Nicolin Chen <nicolinc@nvidia.com>

Tegra241 CMDQV extends SMMUv3 with support for virtual command queues
(VCMDQs) exposed via a CMDQV MMIO region. The CMDQV MMIO space is split
into 64KB pages:

0x00000  (CMDQ-V Config page)
0x10000  (CMDQ-V CMDQ Page0)
0x20000  (CMDQ-V CMDQ Page1)
0x30000  (Virtual Interface Page0)
0x40000  (Virtual Interface Page1)

This patch wires up the Tegra241 CMDQV init callback and allocates
vendor-specific CMDQV state. The state pointer is stored in
SMMUv3AccelState for use by subsequent CMDQV operations.

The CMDQV MMIO region and a dedicated IRQ line are registered with the
SMMUv3 device. The MMIO read/write handlers are currently stubs and will
be implemented in later patches.

The CMDQV interrupt is edge-triggered and indicates VCMDQ or VINTF
error conditions. This patch only registers the IRQ line. Interrupt
generation and propagation to the guest will be added in a subsequent
patch.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260609112552.378999-12-skolothumtho@nvidia.com
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.h   |  1 +
 hw/arm/tegra241-cmdqv.c | 40 ++++++++++++++++++++++++++++++++++++++--
 hw/arm/tegra241-cmdqv.h | 20 ++++++++++++++++++++
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index b45f25ad03..e0bbec8581 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -61,6 +61,7 @@ typedef struct SMMUv3AccelState {
     bool auto_mode;
     bool auto_finalised;
     const SMMUv3AccelCmdqvOps *cmdqv_ops;
+    void *cmdqv;  /* vendor specific CMDQV state */
 } SMMUv3AccelState;
 
 typedef struct SMMUS1Hwpt {
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 3a19a1af56..2875affc8d 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -13,6 +13,17 @@
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 
+static uint64_t tegra241_cmdqv_read_mmio(void *opaque, hwaddr offset,
+                                         unsigned size)
+{
+    return 0;
+}
+
+static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
+                                      uint64_t value, unsigned size)
+{
+}
+
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
 {
 }
@@ -29,10 +40,35 @@ static void tegra241_cmdqv_reset(SMMUv3State *s)
 {
 }
 
+static const MemoryRegionOps mmio_cmdqv_ops = {
+    .read = tegra241_cmdqv_read_mmio,
+    .write = tegra241_cmdqv_write_mmio,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
 static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
 {
-    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
-    return false;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(OBJECT(s));
+    SMMUv3AccelState *accel = s->s_accel;
+    Tegra241CMDQV *cmdqv;
+
+    cmdqv = g_new0(Tegra241CMDQV, 1);
+    cmdqv->cmdqv_data = g_new0(struct iommu_viommu_tegra241_cmdqv, 1);
+    memory_region_init_io(&cmdqv->mmio_cmdqv, OBJECT(s), &mmio_cmdqv_ops, cmdqv,
+                          "tegra241-cmdqv", TEGRA241_CMDQV_IO_LEN);
+    sysbus_init_mmio(sbd, &cmdqv->mmio_cmdqv);
+    sysbus_init_irq(sbd, &cmdqv->irq);
+    cmdqv->s_accel = accel;
+    accel->cmdqv = cmdqv;
+    return true;
 }
 
 static bool tegra241_cmdqv_probe(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 38c8b27b4d..a5f65a8991 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -14,6 +14,26 @@
 #define CMDQV_NUM_CMDQ_LOG2       1
 #define CMDQV_NUM_SID_PER_VI_LOG2 4
 
+/*
+ * Tegra241 CMDQV MMIO layout (64KB pages)
+ *
+ * 0x00000  (CMDQ-V Config page)
+ * 0x10000  (CMDQ-V CMDQ Page0)
+ * 0x20000  (CMDQ-V CMDQ Page1)
+ * 0x30000  (Virtual Interface Page0)
+ * 0x40000  (Virtual Interface Page1)
+ */
+#define TEGRA241_CMDQV_IO_LEN 0x50000
+
+struct iommu_viommu_tegra241_cmdqv;
+
+typedef struct Tegra241CMDQV {
+    struct iommu_viommu_tegra241_cmdqv *cmdqv_data;
+    SMMUv3AccelState *s_accel;
+    MemoryRegion mmio_cmdqv;
+    qemu_irq irq;
+} Tegra241CMDQV;
+
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
 
 #endif /* HW_ARM_TEGRA241_CMDQV_H */
-- 
2.43.0



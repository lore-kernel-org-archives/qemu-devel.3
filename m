Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABA4CD98EE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZ9J-0005L2-NX; Tue, 16 Jun 2026 15:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8E-0004ZO-KR
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:37 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ87-00010z-Pk
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:27 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45f3cf907ceso2636686f8f.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636835; x=1782241635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t/Eu9EnnFiSkjhm7/fYfR3ltbAVADI4vo+xpn1ePMDs=;
 b=oPiQ/H1AX1xNfXN8YQcAOtQb9Sqi2Wl9b5PWuK9y4ut5otSz3GR5syydtBUt21Jc+v
 PVIBAMLS4J9Ky1Y3Vi0QdDVblQcIlW0gKygBZ3x+npdmWaYYyzoVkO4c+FKpIEgV3DmW
 xBSu2r6kC2a7J9vzhIE1lt/HsKr8Ed3uj3o81Vt6DOjbLeUq/8RtrHjkw6+aASuqdXI6
 PDgcQK3CNiSlh80hde/j6gMP1ej+2dO+YKIWzQQB4VZz2dPtljrHOByAOC0oGMCqXG4m
 81YDGvpumhStfVj86IOkjOvOvV2ulfacPUW7XLRQ81j0a/bg43sgyY6Oc/xMhrtN4AEO
 J8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636835; x=1782241635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t/Eu9EnnFiSkjhm7/fYfR3ltbAVADI4vo+xpn1ePMDs=;
 b=sVibGlYBs84EScf73GBMJp380Mf8sC/z1zRObrh4qcyBgbEeVFNqlr8VUq2ULwLCVR
 DzeFyaZPJKU8Gp5GNDZ1JcXnxpJOyH+Bh+HnTJ1WBbO21I+CPSRZPD8/wZxnmpciPA/M
 V2wX7kRAytGN8/V9Rlp4W6QP47g7fMDIe/FgjJhaUXWwSWg1tO3BHUS+N0eXlIy8UE0j
 qywVuOycdWDG9TMb/LoD2gXqD/VINWrQqb/MnZZ0L3npAt5HjqcR6lwlzxI7IgM7kBLV
 +eHSFm/QiGPulquqcxjA4D4/Kcpqijpwj6mhmom80IwUX9kwWkxCgcBsCPJ9BkrI35WD
 5uKQ==
X-Gm-Message-State: AOJu0YyL7UWFBYEYtKDXMKUtoN3l6MF4B8oeQDfWryiEnofmBNZn5wt/
 sCjHNz5SSIDXiXQhvSvnNuLZ33an8KrEgv71aVRbRDd0qeNunvBPIa1CPpauf5lwkF7W/9Z5P9E
 0fOci
X-Gm-Gg: Acq92OHVX1HmLlVtn2lCaVCwpajiIgyM2QgU9XH1LUzrK1dLZaconJxbxusRB/SrXK3
 xXbu/pdXUF4Z+qlzUdrGbREJwnlJn/LO3pcBDwvpL9zsnVky4tZM5XUwlAv/oyDglJmuZjm/7RH
 DBmTP1vkV4FkEr0al3Y9qZno+yrawzaOpVFK0lzpJ61xLICUbz/URQvoMm/DBDzwciMuHSWvy1n
 yWGc1k65qt640bDCKX0WuuArPnX68PKvtWObo0npu8gprrXMwfXqQ+9hw86pLVz/+Mh5SgQVI/M
 6meo5fDFDEPwkCQNvig8pVy8MEaEQwWrV5YFAiM1ALB9HSmP+g2oJzyE/PygqyEK7j9YUn1zbii
 ToJgkMeUs0QyTqM7Jcw9LchMXL+NSFqvRmrYBRp5UxyzTnB4eigoU0UYqYi3hjPQvnQrM0amFQI
 eVibMFPm6zXFloMiVIfY4fK7wvd90tloN1/yMG2ncLUUkjmWOBKxFFcgTppbGi3ru6Lm0EQi6o4
 Sn5UAgWtGDSTMAMf3UBEZmB+pEEtr/q
X-Received: by 2002:a05:6000:a8d:b0:461:a16c:d88d with SMTP id
 ffacd0b85a97d-46237d5b74amr893724f8f.26.1781636834844; 
 Tue, 16 Jun 2026 12:07:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/61] hw/arm/tegra241-cmdqv: Route allocated VCMDQ Page0
 accesses to the mmap'd host VINTF page0
Date: Tue, 16 Jun 2026 20:06:06 +0100
Message-ID: <20260616190639.3462006-30-peter.maydell@linaro.org>
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

Introduce tegra241_cmdqv_vintf_lvcmdq_ptr() to route VCMDQ Page 0
register accesses through the mmap'd host VINTF Page 0 backing once a
hardware queue has been allocated for the VCMDQ.

The two QEMU-trapped Page 0 apertures (direct at 0x10000, VINTF at
0x30000) are hardware aliases of the same underlying registers. A
subsequent patch installs the VINTF aperture as a RAM-device into
guest MMIO; in this patch both remain QEMU-trapped.

The direct VCMDQ aperture stays QEMU-trapped (rather than aliased
to the VINTF mmap) so that writes to an unallocated VCMDQ remain
well-defined. The CMDQV architecture allows software to program a
VCMDQ through the direct aperture without first allocating it to a
VINTF; aliasing to the VINTF mmap would route those writes into
unallocated logical slots where the hardware silently drops them.

A VCMDQ Page 0 access is served from one of two sources:

  - Cache-backed: no hw_queue is allocated for the VCMDQ
    (HW_QUEUE_ALLOC has not yet succeeded). Both apertures use
    QEMU's register cache.

  - HW-backed: HW_QUEUE_ALLOC has succeeded. Both apertures access
    the registers directly through the mmap'd host VINTF Page 0.

tegra241_cmdqv_sync_vcmdq() copies any cached writes (CONS_INDX,
PROD_INDX, CONFIG, GERRORN) into the mmap'd page on the cache-to-HW
transition so the guest's earlier register state survives. Freeing a
VCMDQ clears the cached Page0 registers.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Message-id: 20260609112552.378999-20-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/tegra241-cmdqv.c | 89 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events     |  4 +-
 2 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 8cb39e87c4..63fe0ac681 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -16,6 +16,16 @@
 #include "tegra241-cmdqv.h"
 #include "trace.h"
 
+static void tegra241_cmdqv_reset_vcmdq_cache(Tegra241CMDQV *cmdqv, int index)
+{
+    cmdqv->vcmdq_cons_indx[index] = 0;
+    cmdqv->vcmdq_prod_indx[index] = 0;
+    cmdqv->vcmdq_config[index] = 0;
+    cmdqv->vcmdq_status[index] = 0;
+    cmdqv->vcmdq_gerror[index] = 0;
+    cmdqv->vcmdq_gerrorn[index] = 0;
+}
+
 static void tegra241_cmdqv_free_vcmdq(Tegra241CMDQV *cmdqv, int index)
 {
     IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
@@ -27,6 +37,7 @@ static void tegra241_cmdqv_free_vcmdq(Tegra241CMDQV *cmdqv, int index)
     iommufd_backend_free_id(viommu->iommufd, vcmdq->hw_queue_id);
     g_free(vcmdq);
     cmdqv->vcmdq[index] = NULL;
+    tegra241_cmdqv_reset_vcmdq_cache(cmdqv, index);
 }
 
 /*
@@ -45,6 +56,47 @@ static bool tegra241_cmdqv_vcmdq_ready_to_alloc(Tegra241CMDQV *cmdqv, int index)
            tegra241_cmdqv_enabled(cmdqv) && tegra241_vintf_enabled(cmdqv);
 }
 
+/*
+ * Return a pointer into the mmap'd VINTF page0 for the VCMDQ Page 0
+ * register at @offset0 in VCMDQ slot @index, or NULL when the VCMDQ
+ * has no hw_queue allocated or the host VINTF page0 is not mmap'd.
+ */
+static inline uint32_t *tegra241_cmdqv_vintf_lvcmdq_ptr(Tegra241CMDQV *cmdqv,
+                                                 int index, hwaddr offset0)
+{
+    if (!cmdqv->vcmdq[index] || !cmdqv->vintf_page0) {
+        return NULL;
+    }
+    return (uint32_t *)(cmdqv->vintf_page0 +
+                        (index * CMDQV_VCMDQ_STRIDE) +
+                        (offset0 - CMDQV_VCMDQ_PAGE0_BASE));
+}
+
+/*
+ * Flush cached register writes into the mmap'd host VINTF page0 after a
+ * successful HW_QUEUE_ALLOC, so the guest's earlier writes survive
+ * the cache-to-hardware transition.
+ */
+static void tegra241_cmdqv_sync_vcmdq(Tegra241CMDQV *cmdqv, int index)
+{
+    uint32_t *ptr;
+
+    ptr = tegra241_cmdqv_vintf_lvcmdq_ptr(cmdqv, index, A_VCMDQ0_CONS_INDX);
+    if (!ptr) {
+        return;
+    }
+    *ptr = cmdqv->vcmdq_cons_indx[index];
+
+    ptr = tegra241_cmdqv_vintf_lvcmdq_ptr(cmdqv, index, A_VCMDQ0_PROD_INDX);
+    *ptr = cmdqv->vcmdq_prod_indx[index];
+
+    ptr = tegra241_cmdqv_vintf_lvcmdq_ptr(cmdqv, index, A_VCMDQ0_CONFIG);
+    *ptr = cmdqv->vcmdq_config[index];
+
+    ptr = tegra241_cmdqv_vintf_lvcmdq_ptr(cmdqv, index, A_VCMDQ0_GERRORN);
+    *ptr = cmdqv->vcmdq_gerrorn[index];
+}
+
 /*
  * Allocate a host HW VCMDQ from the current cached BASE / size for @index.
  * No-op (returns true) until the VCMDQ is ready to be allocated.
@@ -85,6 +137,9 @@ static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
     cmdqv->vcmdq_gerror[index] &= ~R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK;
     cmdqv->vcmdq_status[index] |= R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
 
+    /* Push cached writes to HW; freeing resets the cache. */
+    tegra241_cmdqv_sync_vcmdq(cmdqv, index);
+
     return true;
 }
 
@@ -111,13 +166,23 @@ static void tegra241_cmdqv_setup_all_vcmdq(Tegra241CMDQV *cmdqv,
  *
  * The caller normalizes the MMIO offset such that @offset0 always refers
  * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
+ *
+ * If the VCMDQ is allocated and the host VINTF page0 is mmap'd, read
+ * directly from the host VINTF page0 backing. Otherwise, fall back to
+ * the cache.
  */
 static uint64_t tegra241_cmdqv_read_vcmdq_page0(Tegra241CMDQV *cmdqv,
                                                 hwaddr offset0, int index,
                                                 bool direct)
 {
+    uint32_t *ptr = tegra241_cmdqv_vintf_lvcmdq_ptr(cmdqv, index, offset0);
     uint64_t val = 0;
 
+    if (ptr) {
+        val = *ptr;
+        goto out;
+    }
+
     switch (offset0) {
     case A_VCMDQ0_CONS_INDX:
         val = cmdqv->vcmdq_cons_indx[index];
@@ -142,7 +207,9 @@ static uint64_t tegra241_cmdqv_read_vcmdq_page0(Tegra241CMDQV *cmdqv,
                       "%s unhandled read access at 0x%" PRIx64 "\n",
                       __func__, offset0);
     }
+out:
     trace_tegra241_cmdqv_read_vcmdq_page0(index, direct ? "direct" : "vi",
+                                          ptr ? "hw" : "cache",
                                           offset0, val);
     return val;
 }
@@ -218,11 +285,31 @@ static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
  *
  * Page 0 registers are all 32-bit; this helper is only called for 4-byte
  * writes.
+ *
+ * If the VCMDQ is allocated and the host VINTF page0 is mmap'd, write
+ * directly to the VINTF page0 backing. Otherwise, update the cache.
  */
 static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
                                              hwaddr offset0, int index,
                                              uint32_t value, bool direct)
 {
+    uint32_t *ptr = tegra241_cmdqv_vintf_lvcmdq_ptr(cmdqv, index, offset0);
+    bool hw = false;
+
+    if (ptr) {
+        switch (offset0) {
+        case A_VCMDQ0_CONS_INDX:
+        case A_VCMDQ0_PROD_INDX:
+        case A_VCMDQ0_CONFIG:
+        case A_VCMDQ0_GERRORN:
+            *ptr = value;
+            hw = true;
+            goto out;
+        default:
+            break;
+        }
+    }
+
     switch (offset0) {
     case A_VCMDQ0_CONS_INDX:
         cmdqv->vcmdq_cons_indx[index] = value;
@@ -253,7 +340,9 @@ static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
                       "%s unhandled write access at 0x%" PRIx64 "\n",
                       __func__, offset0);
     }
+out:
     trace_tegra241_cmdqv_write_vcmdq_page0(index, direct ? "direct" : "vi",
+                                           hw ? "hw" : "cache",
                                            offset0, value);
 }
 
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 666967dc5e..a8dcbc82db 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -75,9 +75,9 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
 # tegra241-cmdqv
 tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
-tegra241_cmdqv_read_vcmdq_page0(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
+tegra241_cmdqv_read_vcmdq_page0(int index, const char *aperture, const char *backing, uint64_t offset0, uint64_t val) "vcmdq[%d] %s (%s) offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_read_vcmdq_page1(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
-tegra241_cmdqv_write_vcmdq_page0(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
+tegra241_cmdqv_write_vcmdq_page0(int index, const char *aperture, const char *backing, uint64_t offset0, uint64_t val) "vcmdq[%d] %s (%s) offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_write_vcmdq_page1(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
 
 # strongarm.c
-- 
2.43.0



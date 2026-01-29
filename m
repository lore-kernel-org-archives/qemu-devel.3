Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922B0D6B087
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUap-0000Yf-G3; Thu, 29 Jan 2026 11:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaT-000081-7d
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:41 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaQ-0006bt-Ah
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:40 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-435a517be33so824990f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702977; x=1770307777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gbHjOlzLfWfxUKKF85FGXZfJKzaeA9V1JqrwxVe2r64=;
 b=RLa/wvZ3lWcA6PoLAmfjxq411ejis1waTjTe3FS2p9acf8uqkFgfenCPIlYEuUuuwe
 v5tcU/7LRUqKDuVoJlXgQgGLlMID/64cqAEew1/cKMLKv257kwvGv8VwZmsNt5yP47po
 X9dRg94rEZSOunXBvvZbBVQUt6WqJ/d56gn7q3zuf2cCIPA2CUDdniZ3cH297eDkA2ZV
 qcnQziRDB/tXiNyj1rxHfx/OHaBtE+AAvSj0atZvFQ+qK3P2ZvPT584pGvhT2LAQZ0kQ
 eVrTw9bWTEQKpBM12NWaaXO++t34X6KQkNiZmUdKn+KIPP0ayO6Q7ON9ngKipzs147Hk
 nidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702977; x=1770307777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gbHjOlzLfWfxUKKF85FGXZfJKzaeA9V1JqrwxVe2r64=;
 b=cmPr34pQ/h/2TEA08StPiGjKUarrQZzbHn0JHWJXOyXO1eeongnTf1oPe0ejrmPMXK
 96lfDjwiWenGgkiLixQfu3d2hzJiVJMdyEqJfOdyeXLDb2fsr0KFE3O80XprdTOK6KXY
 l7xb5A8Lgosz/yQpXQU/0JMTcm0iiXA7AJ1PZ7mV+3AlTdB65Ll2PasRioychgDfDlG3
 zJlma354rFQ0D3fRDFwA9NrJWmC/49+xDg23kcE8SaibKvUpm27ZdDMTqfhQBrhfa+/n
 t4/igKfsRmjG8xSIcYgHpJNtaK79IcKqut2GXz/MVsmAnD40SFxnl0uTAJW9laBACNeZ
 6VRQ==
X-Gm-Message-State: AOJu0Yxi5saVgTEB0+TGRDEDx6mSWFptHQcUwWSVIQKz7prgdJaItiCL
 DPzLCAZ7L8S7ex43ePRb+SBjmmHNdTyvDRdxwUqCD6AKKUyLms1MlOKiAD9927tNkOOsU76uqBl
 Xcgw7h3s=
X-Gm-Gg: AZuq6aLp9EeHpggE+Zvc0pSls0dLvYQXpF3b/kTLBP3BquLw48etL/WZICkwULIruGe
 AzmABDdB65rMHcG7fkZEXS5sldw0Mu7n0FoCewAhMepNhjo1mpiiE3mVZ2v/7rcRLzYJ4FTLc7x
 2cmsbGl6HH2iFVZqgQTkz0DwKrVADWO057LZ37fMZv33+e35m6PFBB5SX7m6AMFDDG1cmMoTZZ1
 5fNhQhhgq4GVlZKkcdhM5b7PLZJxdiGj7k0HF9Vnngigfc74cOkOL0jJB7588ooGnOQsp1BCbd1
 zuGpC6UoMxpjTFA3Pm6t3V8XTHkwReX7+kBBZ8JlsUTB72XdLfU/+0ueftBy9CAY5kBqrj2Y7E3
 R9ixxkz+ZjL4/EysU5XxLcgK7sJL6tGgB52KoYc7/B9htRbdhoPeSGwhGT4a/uAvnK+ypxoWDyL
 5ghlEswm4ZuSeSk7/GcfdiWaySWQR7GQ==
X-Received: by 2002:a05:6000:1a87:b0:431:a0:7dea with SMTP id
 ffacd0b85a97d-435f3aa91d3mr165372f8f.40.1769702976756; 
 Thu, 29 Jan 2026 08:09:36 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/43] hw/arm/smmuv3-accel: Add nested vSTE install/uninstall
 support
Date: Thu, 29 Jan 2026 16:08:48 +0000
Message-ID: <20260129160917.1415092-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

A device placed behind a vSMMU instance must have corresponding vSTEs
(bypass, abort, or translate) installed. The bypass and abort proxy nested
HWPTs are pre-allocated.

For translat HWPT, a vDEVICE object is allocated and associated with the
vIOMMU for each guest device. This allows the host kernel to establish a
virtual SID to physical SID mapping, which is required for handling
invalidations and event reporting.

An translate HWPT is allocated based on the guest STE configuration and
attached to the device when the guest issues SMMU_CMD_CFGI_STE or
SMMU_CMD_CFGI_STE_RANGE, provided the STE enables S1 translation.

If the guest STE is invalid or S1 translation is disabled, the device is
attached to one of the pre-allocated ABORT or BYPASS HWPTs instead.

While at it, export smmu_find_ste() for use here.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-15-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c          | 197 +++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h          |  22 ++++
 hw/arm/smmuv3-internal.h       |   1 +
 hw/arm/smmuv3.c                |  11 +-
 hw/arm/trace-events            |   2 +
 include/hw/arm/smmuv3-common.h |  18 +++
 6 files changed, 249 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 9c2b917a11..877b7e0e17 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -51,6 +51,188 @@ static uint32_t smmuv3_accel_gbpa_hwpt(SMMUv3State *s, SMMUv3AccelState *accel)
            accel->abort_hwpt_id : accel->bypass_hwpt_id;
 }
 
+static bool
+smmuv3_accel_alloc_vdev(SMMUv3AccelDevice *accel_dev, int sid, Error **errp)
+{
+    SMMUv3AccelState *accel = accel_dev->s_accel;
+    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
+    IOMMUFDVdev *vdev = accel_dev->vdev;
+    uint32_t vdevice_id;
+
+    if (!idev || vdev) {
+        return true;
+    }
+
+    if (!iommufd_backend_alloc_vdev(idev->iommufd, idev->devid,
+                                    accel->viommu->viommu_id, sid,
+                                    &vdevice_id, errp)) {
+            return false;
+    }
+
+    vdev = g_new(IOMMUFDVdev, 1);
+    vdev->vdevice_id = vdevice_id;
+    vdev->virt_id = sid;
+    accel_dev->vdev = vdev;
+    return true;
+}
+
+static SMMUS1Hwpt *
+smmuv3_accel_dev_alloc_translate(SMMUv3AccelDevice *accel_dev, STE *ste,
+                                 Error **errp)
+{
+    uint64_t ste_0 = (uint64_t)ste->word[0] | (uint64_t)ste->word[1] << 32;
+    uint64_t ste_1 = (uint64_t)ste->word[2] | (uint64_t)ste->word[3] << 32;
+    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
+    SMMUv3AccelState *accel = accel_dev->s_accel;
+    struct iommu_hwpt_arm_smmuv3 nested_data = {
+        .ste = {
+            cpu_to_le64(ste_0 & STE0_MASK),
+            cpu_to_le64(ste_1 & STE1_MASK),
+        },
+    };
+    uint32_t hwpt_id = 0, flags = 0;
+    SMMUS1Hwpt *s1_hwpt;
+
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
+                                    accel->viommu->viommu_id, flags,
+                                    IOMMU_HWPT_DATA_ARM_SMMUV3,
+                                    sizeof(nested_data), &nested_data,
+                                    &hwpt_id, errp)) {
+            return NULL;
+    }
+
+    s1_hwpt = g_new0(SMMUS1Hwpt, 1);
+    s1_hwpt->hwpt_id = hwpt_id;
+    trace_smmuv3_accel_translate_ste(accel_dev->vdev->virt_id, hwpt_id,
+                                     nested_data.ste[1], nested_data.ste[0]);
+    return s1_hwpt;
+}
+
+bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
+                              Error **errp)
+{
+    SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid,
+                           .inval_ste_allowed = true};
+    SMMUv3AccelState *accel = s->s_accel;
+    SMMUv3AccelDevice *accel_dev;
+    HostIOMMUDeviceIOMMUFD *idev;
+    uint32_t config, hwpt_id = 0;
+    SMMUS1Hwpt *s1_hwpt = NULL;
+    const char *type;
+    STE ste;
+
+    if (!accel || !accel->viommu) {
+        return true;
+    }
+
+    accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
+    if (!accel_dev->s_accel) {
+        return true;
+    }
+
+    idev = accel_dev->idev;
+    if (!smmuv3_accel_alloc_vdev(accel_dev, sid, errp)) {
+        return false;
+    }
+
+    if (smmu_find_ste(sdev->smmu, sid, &ste, &event)) {
+        /* No STE found, nothing to install */
+        return true;
+    }
+
+    /*
+     * Install the STE based on SMMU enabled/config:
+     * - attach a pre-allocated HWPT for abort/bypass
+     * - or a new HWPT for translate STE
+     *
+     * Note: The vdev remains associated with accel_dev even if HWPT
+     * attach/alloc fails, since the Guest–Host SID mapping stays
+     * valid as long as the device is behind the accelerated SMMUv3.
+     */
+    if (!smmu_enabled(s)) {
+        hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
+    } else {
+        config = STE_CONFIG(&ste);
+
+        if (!STE_VALID(&ste) || STE_CFG_ABORT(config)) {
+            hwpt_id = accel->abort_hwpt_id;
+        } else if (STE_CFG_BYPASS(config)) {
+            hwpt_id = accel->bypass_hwpt_id;
+        } else if (STE_CFG_S1_TRANSLATE(config)) {
+            s1_hwpt = smmuv3_accel_dev_alloc_translate(accel_dev, &ste, errp);
+            if (!s1_hwpt) {
+                return false;
+            }
+            hwpt_id = s1_hwpt->hwpt_id;
+       }
+    }
+
+    if (!hwpt_id) {
+        error_setg(errp, "Invalid STE config for sid 0x%x",
+                   smmu_get_sid(&accel_dev->sdev));
+        return false;
+    }
+
+    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
+        if (s1_hwpt) {
+            iommufd_backend_free_id(idev->iommufd, s1_hwpt->hwpt_id);
+            g_free(s1_hwpt);
+        }
+        return false;
+    }
+
+    /* Free the previous s1_hwpt */
+    if (accel_dev->s1_hwpt) {
+        iommufd_backend_free_id(idev->iommufd, accel_dev->s1_hwpt->hwpt_id);
+        g_free(accel_dev->s1_hwpt);
+    }
+
+    accel_dev->s1_hwpt = s1_hwpt;
+    if (hwpt_id == accel->abort_hwpt_id) {
+        type = "abort";
+    } else if (hwpt_id == accel->bypass_hwpt_id) {
+        type = "bypass";
+    } else {
+        type = "translate";
+    }
+
+    trace_smmuv3_accel_install_ste(sid, type, hwpt_id);
+    return true;
+}
+
+bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
+                                    Error **errp)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+    SMMUv3AccelDevice *accel_dev;
+    Error *local_err = NULL;
+    bool all_ok = true;
+
+    if (!accel || !accel->viommu) {
+        return true;
+    }
+
+    QLIST_FOREACH(accel_dev, &accel->device_list, next) {
+        uint32_t sid = smmu_get_sid(&accel_dev->sdev);
+
+        if (sid >= range->start && sid <= range->end) {
+            if (!smmuv3_accel_install_ste(s, &accel_dev->sdev,
+                                          sid, &local_err)) {
+                error_append_hint(&local_err, "Device 0x%x: Failed to install "
+                                  "STE\n", sid);
+                error_report_err(local_err);
+                local_err = NULL;
+                all_ok = false;
+            }
+        }
+    }
+
+    if (!all_ok) {
+        error_setg(errp, "Failed to install all STEs properly");
+    }
+    return all_ok;
+}
+
 static bool
 smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                           Error **errp)
@@ -161,6 +343,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     HostIOMMUDeviceIOMMUFD *idev;
     SMMUv3AccelDevice *accel_dev;
     SMMUv3AccelState *accel;
+    IOMMUFDVdev *vdev;
     SMMUDevice *sdev;
 
     if (!sbus) {
@@ -181,6 +364,20 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
                      "0x%x", idev->devid);
     }
 
+    if (accel_dev->s1_hwpt) {
+        iommufd_backend_free_id(accel_dev->idev->iommufd,
+                                accel_dev->s1_hwpt->hwpt_id);
+        g_free(accel_dev->s1_hwpt);
+        accel_dev->s1_hwpt = NULL;
+    }
+
+    vdev = accel_dev->vdev;
+    if (vdev) {
+        iommufd_backend_free_id(accel->viommu->iommufd, vdev->vdevice_id);
+        g_free(vdev);
+        accel_dev->vdev = NULL;
+    }
+
     accel_dev->idev = NULL;
     accel_dev->s_accel = NULL;
     QLIST_REMOVE(accel_dev, next);
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index efb631db4f..4e20b646dc 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -27,19 +27,41 @@ typedef struct SMMUv3AccelState {
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
 } SMMUv3AccelState;
 
+typedef struct SMMUS1Hwpt {
+    uint32_t hwpt_id;
+} SMMUS1Hwpt;
+
 typedef struct SMMUv3AccelDevice {
     SMMUDevice sdev;
     HostIOMMUDeviceIOMMUFD *idev;
+    SMMUS1Hwpt *s1_hwpt;
+    IOMMUFDVdev *vdev;
     QLIST_ENTRY(SMMUv3AccelDevice) next;
     SMMUv3AccelState *s_accel;
 } SMMUv3AccelDevice;
 
 #ifdef CONFIG_ARM_SMMUV3_ACCEL
 void smmuv3_accel_init(SMMUv3State *s);
+bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
+                              Error **errp);
+bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
+                                    Error **errp);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
 {
 }
+static inline bool
+smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
+                         Error **errp)
+{
+    return true;
+}
+static inline bool
+smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
+                               Error **errp)
+{
+    return true;
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 687ee6aaca..a6464425ec 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -353,6 +353,7 @@ typedef struct SMMUEventInfo {
     } while (0)
 
 void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
+int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event);
 
 static inline int oas2bits(int oas_field)
 {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ade2b43ab8..7e29284267 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -630,8 +630,7 @@ bad_ste:
  * Supports linear and 2-level stream table
  * Return 0 on success, -EINVAL otherwise
  */
-static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
-                         SMMUEventInfo *event)
+int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
 {
     dma_addr_t addr, strtab_base;
     uint32_t log2size;
@@ -1341,6 +1340,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
             }
 
             trace_smmuv3_cmdq_cfgi_ste(sid);
+            if (!smmuv3_accel_install_ste(s, sdev, sid, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             smmuv3_flush_config(sdev);
 
             break;
@@ -1361,6 +1364,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
             sid_range.end = sid_range.start + mask;
 
             trace_smmuv3_cmdq_cfgi_ste_range(sid_range.start, sid_range.end);
+            if (!smmuv3_accel_install_ste_range(s, &sid_range, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             smmu_configs_inv_sid_range(bs, sid_range);
             break;
         }
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 2aaa0c40c7..8135c0c734 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -69,6 +69,8 @@ smmu_reset_exit(void) ""
 #smmuv3-accel.c
 smmuv3_accel_set_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev devid=0x%x)"
 smmuv3_accel_unset_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev devid=0x%x)"
+smmuv3_accel_translate_ste(uint32_t vsid, uint32_t hwpt_id, uint64_t ste_1, uint64_t ste_0) "vSID=0x%x hwpt_id=0x%x ste=%"PRIx64":%"PRIx64
+smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vSID=0x%x ste type=%s hwpt_id=0x%x"
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 153310248d..415b7ccde5 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -99,10 +99,28 @@ REG32(STE_7, 28)
 #define STE_CFG_S2_ENABLED(config) (config & 0x2)
 #define STE_CFG_ABORT(config)      (!(config & 0x4))
 #define STE_CFG_BYPASS(config)     (config == 0x4)
+#define STE_CFG_S1_TRANSLATE(config)  (config == 0x5)
 
 #define SMMU_STE_VALID      (1ULL << 0)
 #define SMMU_STE_CFG_BYPASS (1ULL << 3)
 
+#define STE0_V       MAKE_64BIT_MASK(0, 1)
+#define STE0_CONFIG  MAKE_64BIT_MASK(1, 3)
+#define STE0_S1FMT   MAKE_64BIT_MASK(4, 2)
+#define STE0_CTXPTR  MAKE_64BIT_MASK(6, 50)
+#define STE0_S1CDMAX MAKE_64BIT_MASK(59, 5)
+#define STE0_MASK    (STE0_S1CDMAX | STE0_CTXPTR | STE0_S1FMT | STE0_CONFIG | \
+                      STE0_V)
+
+#define STE1_S1DSS    MAKE_64BIT_MASK(0, 2)
+#define STE1_S1CIR    MAKE_64BIT_MASK(2, 2)
+#define STE1_S1COR    MAKE_64BIT_MASK(4, 2)
+#define STE1_S1CSH    MAKE_64BIT_MASK(6, 2)
+#define STE1_S1STALLD MAKE_64BIT_MASK(27, 1)
+#define STE1_EATS     MAKE_64BIT_MASK(28, 2)
+#define STE1_MASK     (STE1_EATS | STE1_S1STALLD | STE1_S1CSH | STE1_S1COR | \
+                       STE1_S1CIR | STE1_S1DSS)
+
 /* Update STE fields */
 #define STE_SET_VALID(ste, v)                                                 \
     ((ste)->word[0] = FIELD_DP32((ste)->word[0], STE_0, VALID, (v)))
-- 
2.43.0



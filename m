Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13F6D3514F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 08:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7qYl-0000Y5-Mg; Wed, 01 Apr 2026 04:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w7qYj-0000XD-2K; Wed, 01 Apr 2026 04:04:17 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w7qYd-000436-AA; Wed, 01 Apr 2026 04:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775030652; x=1806566652;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4l4y4LlFEhKjXWkq3k86xtA6HKJV+oSTE6YEEsl87FE=;
 b=MfaQ41UvNSttbk4jSftRIbgnLEgluellGn/Pamn2D0BVPQavGGKkgtPV
 FeOERBrxYVBnMocZoPqM67y98qbYDogjT4cy3Q6CbxUJsx0HAlfH7mftb
 ldIKAdZA/Diq1M3gW4Wh6oXcduL4ObNuDh+5THay0U+6RP0Djrc5ErUZR
 /ta2wVrzM4vP3xoP6kAEzqGwcIV4C6gRd6EAo3Lya14NqeU1SpTAhXNuG
 zuL4Da14ZovEkdcCTLqiV41qZSkxzP4+0kjnBXM0WJDgGg+dvlsXBgE6a
 Cg1Lj2jxD1CFg4D9VZgukMiG1Q8t596SNOwctkKXMGMGdXNrz7GIaxPaY w==;
X-CSE-ConnectionGUID: lrSV2vB/QS2rBrjrCrS3RQ==
X-CSE-MsgGUID: mAknkGBrTEyF/On9fnxtVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87136640"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="87136640"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 01:04:05 -0700
X-CSE-ConnectionGUID: 0rePtZusRd69nY61sHxvWA==
X-CSE-MsgGUID: JDW1E45pQX+lOsM6Ikw5eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="223727290"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 01:04:00 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, yi.l.liu@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-arm@nongnu.org
Subject: [PATCH] iommufd: Rename all the idev and idevc variables to hiod and
 hiodc
Date: Wed,  1 Apr 2026 04:03:53 -0400
Message-ID: <20260401080354.1347212-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

We used idev and idevc naming for HostIOMMUDeviceIOMMUFD and corresponding
class variables which followed the iommufd_device naming in linux kernel.

This is mixed with the hiod naming for base type HostIOMMUDevice. Rename
HostIOMMUDeviceIOMMUFD* to hiodi* for consistency in QEMU.

No functional change intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/arm/smmuv3-accel.h       |  2 +-
 include/system/iommufd.h    | 12 ++---
 backends/iommufd.c          | 26 +++++------
 hw/arm/smmuv3-accel.c       | 93 +++++++++++++++++++------------------
 hw/i386/intel_iommu_accel.c | 44 +++++++++---------
 hw/vfio/container-legacy.c  | 10 ++--
 hw/vfio/iommufd.c           | 24 +++++-----
 7 files changed, 107 insertions(+), 104 deletions(-)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index dba6c71de5..908a13cbcc 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -34,7 +34,7 @@ typedef struct SMMUS1Hwpt {
 
 typedef struct SMMUv3AccelDevice {
     SMMUDevice sdev;
-    HostIOMMUDeviceIOMMUFD *idev;
+    HostIOMMUDeviceIOMMUFD *hiodi;
     SMMUS1Hwpt *s1_hwpt;
     IOMMUFDVdev *vdev;
     QLIST_ENTRY(SMMUv3AccelDevice) next;
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 7062944fe6..2925d116ac 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -136,7 +136,7 @@ struct HostIOMMUDeviceIOMMUFDClass {
      *
      * Mandatory callback.
      *
-     * @idev: host IOMMU device backed by IOMMUFD backend.
+     * @hiodi: host IOMMU device backed by IOMMUFD backend.
      *
      * @hwpt_id: ID of IOMMUFD hardware page table.
      *
@@ -144,7 +144,7 @@ struct HostIOMMUDeviceIOMMUFDClass {
      *
      * Returns: true on success, false on failure.
      */
-    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t hwpt_id,
+    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *hiodi, uint32_t hwpt_id,
                         Error **errp);
     /**
      * @detach_hwpt: detach host IOMMU device from IOMMUFD hardware page table.
@@ -152,17 +152,17 @@ struct HostIOMMUDeviceIOMMUFDClass {
      *
      * Mandatory callback.
      *
-     * @idev: host IOMMU device backed by IOMMUFD backend.
+     * @hiodi: host IOMMU device backed by IOMMUFD backend.
      *
      * @errp: pass an Error out when attachment fails.
      *
      * Returns: true on success, false on failure.
      */
-    bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, Error **errp);
+    bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *hiodi, Error **errp);
 };
 
-bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
                                            uint32_t hwpt_id, Error **errp);
-bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
                                            Error **errp);
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index e1fee16acf..410b044370 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -538,24 +538,24 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
     return true;
 }
 
-bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
                                            uint32_t hwpt_id, Error **errp)
 {
-    HostIOMMUDeviceIOMMUFDClass *idevc =
-        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
+    HostIOMMUDeviceIOMMUFDClass *hiodic =
+        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(hiodi);
 
-    g_assert(idevc->attach_hwpt);
-    return idevc->attach_hwpt(idev, hwpt_id, errp);
+    g_assert(hiodic->attach_hwpt);
+    return hiodic->attach_hwpt(hiodi, hwpt_id, errp);
 }
 
-bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
                                            Error **errp)
 {
-    HostIOMMUDeviceIOMMUFDClass *idevc =
-        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
+    HostIOMMUDeviceIOMMUFDClass *hiodic =
+        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(hiodi);
 
-    g_assert(idevc->detach_hwpt);
-    return idevc->detach_hwpt(idev, errp);
+    g_assert(hiodic->detach_hwpt);
+    return hiodic->detach_hwpt(hiodi, errp);
 }
 
 static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
@@ -591,10 +591,10 @@ static bool hiod_iommufd_get_pasid_info(HostIOMMUDevice *hiod,
 
 static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
 {
-    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
+    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
 
-    hioc->get_cap = hiod_iommufd_get_cap;
-    hioc->get_pasid_info = hiod_iommufd_get_pasid_info;
+    hiodc->get_cap = hiod_iommufd_get_cap;
+    hiodc->get_pasid_info = hiod_iommufd_get_pasid_info;
 };
 
 static const TypeInfo types[] = {
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 65c2f44880..3630078751 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -129,16 +129,16 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
 }
 
 static bool
-smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *hiodi,
                            Error **errp)
 {
     struct iommu_hw_info_arm_smmuv3 info;
     uint32_t data_type;
     uint64_t caps;
 
-    if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
-                                         &info, sizeof(info), &caps, NULL,
-                                         errp)) {
+    if (!iommufd_backend_get_device_info(hiodi->iommufd, hiodi->devid,
+                                         &data_type, &info, sizeof(info), &caps,
+                                         NULL, errp)) {
         return false;
     }
 
@@ -182,15 +182,15 @@ static bool
 smmuv3_accel_alloc_vdev(SMMUv3AccelDevice *accel_dev, int sid, Error **errp)
 {
     SMMUv3AccelState *accel = accel_dev->s_accel;
-    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
+    HostIOMMUDeviceIOMMUFD *hiodi = accel_dev->hiodi;
     IOMMUFDVdev *vdev = accel_dev->vdev;
     uint32_t vdevice_id;
 
-    if (!idev || vdev) {
+    if (!hiodi || vdev) {
         return true;
     }
 
-    if (!iommufd_backend_alloc_vdev(idev->iommufd, idev->devid,
+    if (!iommufd_backend_alloc_vdev(hiodi->iommufd, hiodi->devid,
                                     accel->viommu->viommu_id, sid,
                                     &vdevice_id, errp)) {
             return false;
@@ -209,7 +209,7 @@ smmuv3_accel_dev_alloc_translate(SMMUv3AccelDevice *accel_dev, STE *ste,
 {
     uint64_t ste_0 = (uint64_t)ste->word[0] | (uint64_t)ste->word[1] << 32;
     uint64_t ste_1 = (uint64_t)ste->word[2] | (uint64_t)ste->word[3] << 32;
-    HostIOMMUDeviceIOMMUFD *idev = accel_dev->idev;
+    HostIOMMUDeviceIOMMUFD *hiodi = accel_dev->hiodi;
     SMMUv3AccelState *accel = accel_dev->s_accel;
     struct iommu_hwpt_arm_smmuv3 nested_data = {
         .ste = {
@@ -220,7 +220,7 @@ smmuv3_accel_dev_alloc_translate(SMMUv3AccelDevice *accel_dev, STE *ste,
     uint32_t hwpt_id = 0, flags = 0;
     SMMUS1Hwpt *s1_hwpt;
 
-    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
+    if (!iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid,
                                     accel->viommu->viommu_id, flags,
                                     IOMMU_HWPT_DATA_ARM_SMMUV3,
                                     sizeof(nested_data), &nested_data,
@@ -242,7 +242,7 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
                            .inval_ste_allowed = true};
     SMMUv3AccelState *accel = s->s_accel;
     SMMUv3AccelDevice *accel_dev;
-    HostIOMMUDeviceIOMMUFD *idev;
+    HostIOMMUDeviceIOMMUFD *hiodi;
     uint32_t config, hwpt_id = 0;
     SMMUS1Hwpt *s1_hwpt = NULL;
     const char *type;
@@ -257,7 +257,7 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
         return true;
     }
 
-    idev = accel_dev->idev;
+    hiodi = accel_dev->hiodi;
     if (!smmuv3_accel_alloc_vdev(accel_dev, sid, errp)) {
         return false;
     }
@@ -300,9 +300,9 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
         return false;
     }
 
-    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
+    if (!host_iommu_device_iommufd_attach_hwpt(hiodi, hwpt_id, errp)) {
         if (s1_hwpt) {
-            iommufd_backend_free_id(idev->iommufd, s1_hwpt->hwpt_id);
+            iommufd_backend_free_id(hiodi->iommufd, s1_hwpt->hwpt_id);
             g_free(s1_hwpt);
         }
         return false;
@@ -310,7 +310,7 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
 
     /* Free the previous s1_hwpt */
     if (accel_dev->s1_hwpt) {
-        iommufd_backend_free_id(idev->iommufd, accel_dev->s1_hwpt->hwpt_id);
+        iommufd_backend_free_id(hiodi->iommufd, accel_dev->s1_hwpt->hwpt_id);
         g_free(accel_dev->s1_hwpt);
     }
 
@@ -524,7 +524,7 @@ free_veventq:
 }
 
 static bool
-smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *hiodi,
                           Error **errp)
 {
     SMMUv3AccelState *accel = s->s_accel;
@@ -534,11 +534,11 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     struct iommu_hwpt_arm_smmuv3 abort_data = {
         .ste = { SMMU_STE_VALID, 0x0ULL },
     };
-    uint32_t s2_hwpt_id = idev->hwpt_id;
+    uint32_t s2_hwpt_id = hiodi->hwpt_id;
     uint32_t viommu_id, hwpt_id;
     IOMMUFDViommu *viommu;
 
-    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
+    if (!iommufd_backend_alloc_viommu(hiodi->iommufd, hiodi->devid,
                                       IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
                                       s2_hwpt_id, &viommu_id, errp)) {
         return false;
@@ -547,21 +547,21 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     viommu = g_new0(IOMMUFDViommu, 1);
     viommu->viommu_id = viommu_id;
     viommu->s2_hwpt_id = s2_hwpt_id;
-    viommu->iommufd = idev->iommufd;
+    viommu->iommufd = hiodi->iommufd;
     accel->viommu = viommu;
 
     /*
      * Pre-allocate HWPTs for S1 bypass and abort cases. These will be attached
      * later for guest STEs or GBPAs that require bypass or abort configuration.
      */
-    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, viommu_id,
+    if (!iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid, viommu_id,
                                     0, IOMMU_HWPT_DATA_ARM_SMMUV3,
                                     sizeof(abort_data), &abort_data,
                                     &accel->abort_hwpt_id, errp)) {
         goto free_viommu;
     }
 
-    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, viommu_id,
+    if (!iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid, viommu_id,
                                     0, IOMMU_HWPT_DATA_ARM_SMMUV3,
                                     sizeof(bypass_data), &bypass_data,
                                     &accel->bypass_hwpt_id, errp)) {
@@ -575,7 +575,7 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
 
     /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
     hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
-    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
+    if (!host_iommu_device_iommufd_attach_hwpt(hiodi, hwpt_id, errp)) {
         goto free_veventq;
     }
     return true;
@@ -583,11 +583,11 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
 free_veventq:
     smmuv3_accel_free_veventq(accel);
 free_bypass_hwpt:
-    iommufd_backend_free_id(idev->iommufd, accel->bypass_hwpt_id);
+    iommufd_backend_free_id(hiodi->iommufd, accel->bypass_hwpt_id);
 free_abort_hwpt:
-    iommufd_backend_free_id(idev->iommufd, accel->abort_hwpt_id);
+    iommufd_backend_free_id(hiodi->iommufd, accel->abort_hwpt_id);
 free_viommu:
-    iommufd_backend_free_id(idev->iommufd, viommu->viommu_id);
+    iommufd_backend_free_id(hiodi->iommufd, viommu->viommu_id);
     g_free(viommu);
     accel->viommu = NULL;
     return false;
@@ -596,20 +596,20 @@ free_viommu:
 static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                           HostIOMMUDevice *hiod, Error **errp)
 {
-    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
+    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
     SMMUState *bs = opaque;
     SMMUv3State *s = ARM_SMMUV3(bs);
     SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
     SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
 
-    if (!idev) {
+    if (!hiodi) {
         return true;
     }
 
-    if (accel_dev->idev) {
-        if (accel_dev->idev != idev) {
-            error_setg(errp, "Device already has an associated idev 0x%x",
-                       idev->devid);
+    if (accel_dev->hiodi) {
+        if (accel_dev->hiodi != hiodi) {
+            error_setg(errp, "Device already has an associated hiodi 0x%x",
+                       hiodi->devid);
             return false;
         }
         return true;
@@ -619,7 +619,7 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
      * Check the host SMMUv3 associated with the dev is compatible with the
      * QEMU SMMUv3 accel.
      */
-    if (!smmuv3_accel_hw_compatible(s, idev, errp)) {
+    if (!smmuv3_accel_hw_compatible(s, hiodi, errp)) {
         return false;
     }
 
@@ -627,17 +627,17 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         goto done;
     }
 
-    if (!smmuv3_accel_alloc_viommu(s, idev, errp)) {
-        error_append_hint(errp, "Unable to alloc vIOMMU: idev devid 0x%x: ",
-                          idev->devid);
+    if (!smmuv3_accel_alloc_viommu(s, hiodi, errp)) {
+        error_append_hint(errp, "Unable to alloc vIOMMU: hiodi devid 0x%x: ",
+                          hiodi->devid);
         return false;
     }
 
 done:
-    accel_dev->idev = idev;
+    accel_dev->hiodi = hiodi;
     accel_dev->s_accel = s->s_accel;
     QLIST_INSERT_HEAD(&s->s_accel->device_list, accel_dev, next);
-    trace_smmuv3_accel_set_iommu_device(devfn, idev->devid);
+    trace_smmuv3_accel_set_iommu_device(devfn, hiodi->devid);
     return true;
 }
 
@@ -646,7 +646,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
 {
     SMMUState *bs = opaque;
     SMMUPciBus *sbus = g_hash_table_lookup(bs->smmu_pcibus_by_busptr, bus);
-    HostIOMMUDeviceIOMMUFD *idev;
+    HostIOMMUDeviceIOMMUFD *hiodi;
     SMMUv3AccelDevice *accel_dev;
     SMMUv3AccelState *accel;
     IOMMUFDVdev *vdev;
@@ -662,16 +662,16 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
     }
 
     accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
-    idev = accel_dev->idev;
+    hiodi = accel_dev->hiodi;
     accel = accel_dev->s_accel;
     /* Re-attach the default s2 hwpt id */
-    if (!host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, NULL)) {
-        error_report("Unable to attach the default HW pagetable: idev devid "
-                     "0x%x", idev->devid);
+    if (!host_iommu_device_iommufd_attach_hwpt(hiodi, hiodi->hwpt_id, NULL)) {
+        error_report("Unable to attach the default HW pagetable: hiodi devid "
+                     "0x%x", hiodi->devid);
     }
 
     if (accel_dev->s1_hwpt) {
-        iommufd_backend_free_id(accel_dev->idev->iommufd,
+        iommufd_backend_free_id(accel_dev->hiodi->iommufd,
                                 accel_dev->s1_hwpt->hwpt_id);
         g_free(accel_dev->s1_hwpt);
         accel_dev->s1_hwpt = NULL;
@@ -684,10 +684,10 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
         accel_dev->vdev = NULL;
     }
 
-    accel_dev->idev = NULL;
+    accel_dev->hiodi = NULL;
     accel_dev->s_accel = NULL;
     QLIST_REMOVE(accel_dev, next);
-    trace_smmuv3_accel_unset_iommu_device(devfn, idev->devid);
+    trace_smmuv3_accel_unset_iommu_device(devfn, hiodi->devid);
 
     if (QLIST_EMPTY(&accel->device_list)) {
         smmuv3_accel_free_viommu(accel);
@@ -879,10 +879,11 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
 
     hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
     QLIST_FOREACH(accel_dev, &accel->device_list, next) {
-        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev, hwpt_id,
+        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->hiodi, hwpt_id,
                                                    &local_err)) {
             error_append_hint(&local_err, "Failed to attach GBPA hwpt %u for "
-                              "idev devid %u", hwpt_id, accel_dev->idev->devid);
+                              "hiodi devid %u", hwpt_id,
+                               accel_dev->hiodi->devid);
             error_report_err(local_err);
             local_err = NULL;
             all_ok = false;
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 67d54849f2..ed3793602b 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -69,7 +69,7 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
     return NULL;
 }
 
-static bool vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+static bool vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
                                VTDPASIDEntry *pe, uint32_t *fs_hwpt_id,
                                Error **errp)
 {
@@ -81,27 +81,27 @@ static bool vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
     vtd.addr_width = vtd_pe_get_fs_aw(pe);
     vtd.pgtbl_addr = (uint64_t)vtd_pe_get_fspt_base(pe);
 
-    return iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, idev->hwpt_id,
-                                      0, IOMMU_HWPT_DATA_VTD_S1, sizeof(vtd),
-                                      &vtd, fs_hwpt_id, errp);
+    return iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid,
+                                      hiodi->hwpt_id, 0, IOMMU_HWPT_DATA_VTD_S1,
+                                      sizeof(vtd), &vtd, fs_hwpt_id, errp);
 }
 
-static void vtd_destroy_old_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+static void vtd_destroy_old_fs_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
                                     VTDAddressSpace *vtd_as)
 {
     if (!vtd_as->fs_hwpt_id) {
         return;
     }
-    iommufd_backend_free_id(idev->iommufd, vtd_as->fs_hwpt_id);
+    iommufd_backend_free_id(hiodi->iommufd, vtd_as->fs_hwpt_id);
     vtd_as->fs_hwpt_id = 0;
 }
 
 static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
                                       VTDAddressSpace *vtd_as, Error **errp)
 {
-    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
     VTDPASIDEntry *pe = &vtd_as->pasid_cache_entry.pasid_entry;
-    uint32_t hwpt_id = idev->hwpt_id;
+    uint32_t hwpt_id = hiodi->hwpt_id;
     bool ret;
 
     /*
@@ -116,21 +116,21 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     }
 
     if (vtd_pe_pgtt_is_fst(pe)) {
-        if (!vtd_create_fs_hwpt(idev, pe, &hwpt_id, errp)) {
+        if (!vtd_create_fs_hwpt(hiodi, pe, &hwpt_id, errp)) {
             return false;
         }
     }
 
-    ret = host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
-    trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, ret);
+    ret = host_iommu_device_iommufd_attach_hwpt(hiodi, hwpt_id, errp);
+    trace_vtd_device_attach_hwpt(hiodi->devid, vtd_as->pasid, hwpt_id, ret);
     if (ret) {
         /* Destroy old fs_hwpt if it's a replacement */
-        vtd_destroy_old_fs_hwpt(idev, vtd_as);
+        vtd_destroy_old_fs_hwpt(hiodi, vtd_as);
         if (vtd_pe_pgtt_is_fst(pe)) {
             vtd_as->fs_hwpt_id = hwpt_id;
         }
     } else if (vtd_pe_pgtt_is_fst(pe)) {
-        iommufd_backend_free_id(idev->iommufd, hwpt_id);
+        iommufd_backend_free_id(hiodi->iommufd, hwpt_id);
     }
 
     return ret;
@@ -139,27 +139,28 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
 static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
                                       VTDAddressSpace *vtd_as, Error **errp)
 {
-    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
     IntelIOMMUState *s = vtd_as->iommu_state;
     uint32_t pasid = vtd_as->pasid;
     bool ret;
 
     if (s->dmar_enabled && s->root_scalable) {
-        ret = host_iommu_device_iommufd_detach_hwpt(idev, errp);
-        trace_vtd_device_detach_hwpt(idev->devid, pasid, ret);
+        ret = host_iommu_device_iommufd_detach_hwpt(hiodi, errp);
+        trace_vtd_device_detach_hwpt(hiodi->devid, pasid, ret);
     } else {
         /*
          * If DMAR remapping is disabled or guest switches to legacy mode,
          * we fallback to the default HWPT which contains shadow page table.
          * So guest DMA could still work.
          */
-        ret = host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, errp);
-        trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->hwpt_id,
+        ret = host_iommu_device_iommufd_attach_hwpt(hiodi, hiodi->hwpt_id,
+                                                    errp);
+        trace_vtd_device_reattach_def_hwpt(hiodi->devid, pasid, hiodi->hwpt_id,
                                            ret);
     }
 
     if (ret) {
-        vtd_destroy_old_fs_hwpt(idev, vtd_as);
+        vtd_destroy_old_fs_hwpt(hiodi, vtd_as);
     }
 
     return ret;
@@ -211,13 +212,14 @@ static void vtd_flush_host_piotlb_locked(gpointer key, gpointer value,
     did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
 
     if (piotlb_info->domain_id == did && piotlb_info->pasid == PASID_0) {
-        HostIOMMUDeviceIOMMUFD *idev =
+        HostIOMMUDeviceIOMMUFD *hiodi =
             HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
         uint32_t entry_num = 1; /* Only implement one request for simplicity */
         Error *local_err = NULL;
         struct iommu_hwpt_vtd_s1_invalidate *cache = piotlb_info->inv_data;
 
-        if (!iommufd_backend_invalidate_cache(idev->iommufd, vtd_as->fs_hwpt_id,
+        if (!iommufd_backend_invalidate_cache(hiodi->iommufd,
+                                              vtd_as->fs_hwpt_id,
                                               IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
                                               sizeof(*cache), &entry_num, cache,
                                               &local_err)) {
diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index 625f151364..d301b27aa6 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -1244,12 +1244,12 @@ static void vfio_iommu_legacy_instance_init(Object *obj)
 
 static void hiod_legacy_vfio_class_init(ObjectClass *oc, const void *data)
 {
-    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
+    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
 
-    hioc->realize = hiod_legacy_vfio_realize;
-    hioc->get_cap = hiod_legacy_vfio_get_cap;
-    hioc->get_iova_ranges = hiod_legacy_vfio_get_iova_ranges;
-    hioc->get_page_size_mask = hiod_legacy_vfio_get_page_size_mask;
+    hiodc->realize = hiod_legacy_vfio_realize;
+    hiodc->get_cap = hiod_legacy_vfio_get_cap;
+    hiodc->get_iova_ranges = hiod_legacy_vfio_get_iova_ranges;
+    hiodc->get_page_size_mask = hiod_legacy_vfio_get_page_size_mask;
 };
 
 static const TypeInfo types[] = {
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 3e33dfbb35..399b36aa75 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -917,19 +917,19 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
 };
 
 static bool
-host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
                                            uint32_t hwpt_id, Error **errp)
 {
-    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
+    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(hiodi)->agent;
 
     return !iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
 }
 
 static bool
-host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
                                            Error **errp)
 {
-    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
+    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(hiodi)->agent;
 
     return iommufd_cdev_detach_ioas_hwpt(vbasedev, errp);
 }
@@ -938,7 +938,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
                                       Error **errp)
 {
     VFIODevice *vdev = opaque;
-    HostIOMMUDeviceIOMMUFD *idev;
+    HostIOMMUDeviceIOMMUFD *hiodi;
     HostIOMMUDeviceCaps *caps = &hiod->caps;
     VendorCaps *vendor_caps = &caps->vendor_caps;
     enum iommu_hw_info_type type;
@@ -958,10 +958,10 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     caps->hw_caps = hw_caps;
     caps->max_pasid_log2 = max_pasid_log2;
 
-    idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
-    idev->iommufd = vdev->iommufd;
-    idev->devid = vdev->devid;
-    idev->hwpt_id = vdev->hwpt->hwpt_id;
+    hiodi = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
+    hiodi->iommufd = vdev->iommufd;
+    hiodi->devid = vdev->devid;
+    hiodi->hwpt_id = vdev->hwpt->hwpt_id;
 
     return true;
 }
@@ -988,14 +988,14 @@ hiod_iommufd_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
 static void hiod_iommufd_vfio_class_init(ObjectClass *oc, const void *data)
 {
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
-    HostIOMMUDeviceIOMMUFDClass *idevc = HOST_IOMMU_DEVICE_IOMMUFD_CLASS(oc);
+    HostIOMMUDeviceIOMMUFDClass *hiodic = HOST_IOMMU_DEVICE_IOMMUFD_CLASS(oc);
 
     hiodc->realize = hiod_iommufd_vfio_realize;
     hiodc->get_iova_ranges = hiod_iommufd_vfio_get_iova_ranges;
     hiodc->get_page_size_mask = hiod_iommufd_vfio_get_page_size_mask;
 
-    idevc->attach_hwpt = host_iommu_device_iommufd_vfio_attach_hwpt;
-    idevc->detach_hwpt = host_iommu_device_iommufd_vfio_detach_hwpt;
+    hiodic->attach_hwpt = host_iommu_device_iommufd_vfio_attach_hwpt;
+    hiodic->detach_hwpt = host_iommu_device_iommufd_vfio_detach_hwpt;
 };
 
 static const TypeInfo types[] = {
-- 
2.47.3



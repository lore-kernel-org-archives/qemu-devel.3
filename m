Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C502CEFCD6E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 09:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzWnN-0004cp-J4; Mon, 09 Mar 2026 05:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vzWn9-0004aR-MY
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:20:48 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vzWn6-0004iR-Ne
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773048045; x=1804584045;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Fi4yPr1/nPgy/kdYnFnNlcnlkkWDD+kKHfKR6HC5Nyc=;
 b=P0KIQktqoR24q2M6OHG0juw0CjzbI40y7BT60dzaMB9I1jgHlwIVUCEh
 4B0x/MHtWUfZsV2F6YlKdhE4Nhuj3jqaMLTruSmmoKIl1mx8jmznSdyxt
 ZTqoDZs6vpXNG4AFR/Ep8GMilqtQVVHWAnZGtTaMa5foI23DeR4OpD0fy
 xDXMSE3RwwAeC3HIKk0nH58+FQhVgZUMAAXnijX3MxUfN2hbvxcgf/AGt
 mmut4pCYo/YQ4KLb/mieGOXfXj2jyPl6r65nB/Q8rI6Jk33qG4m8oaWVy
 1io+bPC+cGOlJ52zAMQCiOfu0e5TyLvpCSGAQEpKn9tRSn3HiTnnxy7KV g==;
X-CSE-ConnectionGUID: 4iw/+FtSQ2O2sFskMOkKTA==
X-CSE-MsgGUID: gneSZMPaSs6wU7aQCSbkeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="84777322"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="84777322"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 02:20:40 -0700
X-CSE-ConnectionGUID: x7qaNfr1THysLVTysBwVSA==
X-CSE-MsgGUID: CNvxuoXDQqqJeI9IJN915w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="219639052"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 02:20:35 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, berrange@redhat.com, clg@redhat.com,
 nathanc@nvidia.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] intel_iommu: Remove 'x-' prefix from 'x-scalable-mode' and
 'x-flts' properties
Date: Mon,  9 Mar 2026 05:20:27 -0400
Message-ID: <20260309092027.404489-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

We had 'x-scalable-mode' for more than 5 years and 'x-flts' for more than 1
year, it's fine to remove 'x-' now.

This is a prerequisite to enable intel_iommu's scalable mode and first stage
translation support in libvirt.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 docs/devel/vfio-iommufd.rst    | 10 +++++-----
 hw/i386/intel_iommu.c          |  8 ++++----
 hw/i386/intel_iommu_accel.c    |  4 ++--
 tests/qtest/intel-iommu-test.c |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
index 78bcdffac7..5755532443 100644
--- a/docs/devel/vfio-iommufd.rst
+++ b/docs/devel/vfio-iommufd.rst
@@ -153,22 +153,22 @@ RAM discarding for mdev.
 ``vfio-ap`` and ``vfio-ccw`` devices don't have same issue as their backend
 devices are always mdev and RAM discarding is force enabled.
 
-Usage with intel_iommu featuring x-flts=on
+Usage with intel_iommu featuring flts=on
 ------------------------------------------
 
 Only IOMMUFD backed VFIO device is supported when intel_iommu is configured
-with x-flts=on, for legacy container backed VFIO device, below error shows:
+with flts=on, for legacy container backed VFIO device, below error shows:
 
 .. code-block:: none
 
-    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0: vfio 0000:02:00.0: Failed to set vIOMMU: Need IOMMUFD backend when x-flts=on
+    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0: vfio 0000:02:00.0: Failed to set vIOMMU: Need IOMMUFD backend when flts=on
 
 VFIO device under PCI bridge is unsupported, use PCIE bridge if necessary,
 otherwise below error shows:
 
 .. code-block:: none
 
-    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0,bus=bridge1,iommufd=iommufd0: vfio 0000:02:00.0: Failed to set vIOMMU: Host device downstream to a PCI bridge is unsupported when x-flts=on
+    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0,bus=bridge1,iommufd=iommufd0: vfio 0000:02:00.0: Failed to set vIOMMU: Host device downstream to a PCI bridge is unsupported when flts=on
 
 If host IOMMU has ERRATA_772415_SPR17, running guest with "intel_iommu=on,sm_off"
 is unsupported, kexec or reboot guest from "intel_iommu=on,sm_on" to
@@ -177,4 +177,4 @@ below if it's not needed by guest:
 
 .. code-block:: bash
 
-    -device intel-iommu,x-scalable-mode=off
+    -device intel-iommu,scalable-mode=off
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d24ba989bf..001847ad37 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4200,8 +4200,8 @@ static const Property vtd_properties[] = {
     DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
                       VTD_HOST_ADDRESS_WIDTH),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
-    DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
-    DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, fsts, FALSE),
+    DEFINE_PROP_BOOL("scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
+    DEFINE_PROP_BOOL("flts", IntelIOMMUState, fsts, FALSE),
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
     DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
     DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
@@ -5564,7 +5564,7 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
     }
 
     if (!s->scalable_mode && s->fsts) {
-        error_setg(errp, "x-flts is only available in scalable mode");
+        error_setg(errp, "flts is only available in scalable mode");
         return false;
     }
 
@@ -5577,7 +5577,7 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
     }
 
     if (s->fsts && s->aw_bits != VTD_HOST_AW_48BIT) {
-        error_setg(errp, "Scalable mode(x-flts=on): supported value for "
+        error_setg(errp, "Scalable mode(flts=on): supported value for "
                    "aw-bits is: %d", VTD_HOST_AW_48BIT);
         return false;
     }
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 67d54849f2..b28d5eb9fa 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -26,7 +26,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
     PCIDevice *pdev = bus->devices[vtd_hiod->devfn];
 
     if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
-        error_setg(errp, "Need IOMMUFD backend when x-flts=on");
+        error_setg(errp, "Need IOMMUFD backend when flts=on");
         return false;
     }
 
@@ -44,7 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
 
     if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
         error_setg(errp, "Host device downstream to a PCI bridge is "
-                   "unsupported when x-flts=on");
+                   "unsupported when flts=on");
         return false;
     }
 
diff --git a/tests/qtest/intel-iommu-test.c b/tests/qtest/intel-iommu-test.c
index e5cc6acaf0..4f12c56260 100644
--- a/tests/qtest/intel-iommu-test.c
+++ b/tests/qtest/intel-iommu-test.c
@@ -29,7 +29,7 @@ static void test_intel_iommu_stage_1(void)
     uint64_t cap, ecap, tmp;
     QTestState *s;
 
-    s = qtest_init("-M q35 -device intel-iommu,x-scalable-mode=on,x-flts=on");
+    s = qtest_init("-M q35 -device intel-iommu,scalable-mode=on,flts=on");
 
     cap = vtd_reg_readq(s, DMAR_CAP_REG);
     g_assert((cap & CAP_STAGE_1_FIXED1) == CAP_STAGE_1_FIXED1);
-- 
2.47.3



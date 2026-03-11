Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8381049516
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 09:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0FnC-0003lH-5H; Wed, 11 Mar 2026 05:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w0Fn6-0003kS-Cf
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:23:44 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w0Fn2-0001RX-I8
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773221021; x=1804757021;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2BLZ+gdzQTiGO2LY5QP/f3NwaXocnxsMJX5+w8Re70Q=;
 b=m+Hwql9WRY5AvuJE+C/hSKuFA24rfrlF7eA3Zj8USdLDKr/KLyh8m+3g
 4Fti4wtykxos61TcbUDcay6WUr7Wo7WUH8eW9Z+8hWCYOpTy8M5IFo6AW
 wZomxTqbslhm6+1YOHX/AN5Iu6S8ctsBjXVg+QzKbahuy+iQUoanbzCiR
 lEZHzfW2zi52rvYX7bnkBuwFIDfD6SiArm1LF5I8wqdRZ33tYVLt91oG1
 IFTkQWuIhjOKsF5jmU9AkbgOuVJuBntGY7WJKibYKMw5FjejRWGpQ3h3W
 rxUhK7Or/lFBP0FPgMzr89h13qObx5F30uhNvqwIkDtwg8oAwbeFwgluK A==;
X-CSE-ConnectionGUID: wMIXCzDTTRmfoWRHf4E3dQ==
X-CSE-MsgGUID: CD4Ydvf+Q5e/c5U3c9ffTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="96899445"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="96899445"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 02:23:37 -0700
X-CSE-ConnectionGUID: 0Vuzzgm3SYKm12zJitC55Q==
X-CSE-MsgGUID: qpa5EK/yS4O8BO8mulIIDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="220354015"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 02:23:35 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, berrange@redhat.com, clg@redhat.com,
 nathanc@nvidia.com, clement.mathieu--drif@bull.com, philmd@linaro.org,
 yi.l.liu@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 2/2] intel_iommu: Change 'flts' property naming to 'fsts'
Date: Wed, 11 Mar 2026 05:23:20 -0400
Message-ID: <20260311092320.212849-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311092320.212849-1-zhenzhong.duan@intel.com>
References: <20260311092320.212849-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9;
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

Previous patch Removed 'x-' prefix from 'x-flts' property.
Opportunistically, this patch does s/flts/fsts for property name
in order to better align with newer spec since revision 3.4 which
changed terminology from "First-level" to "First-stage".

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 docs/devel/vfio-iommufd.rst    |  8 ++++----
 hw/i386/intel_iommu.c          | 10 +++++-----
 hw/i386/intel_iommu_accel.c    |  6 +++---
 tests/qtest/intel-iommu-test.c |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
index 5755532443..d5538461ba 100644
--- a/docs/devel/vfio-iommufd.rst
+++ b/docs/devel/vfio-iommufd.rst
@@ -153,22 +153,22 @@ RAM discarding for mdev.
 ``vfio-ap`` and ``vfio-ccw`` devices don't have same issue as their backend
 devices are always mdev and RAM discarding is force enabled.
 
-Usage with intel_iommu featuring flts=on
+Usage with intel_iommu featuring fsts=on
 ------------------------------------------
 
 Only IOMMUFD backed VFIO device is supported when intel_iommu is configured
-with flts=on, for legacy container backed VFIO device, below error shows:
+with fsts=on, for legacy container backed VFIO device, below error shows:
 
 .. code-block:: none
 
-    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0: vfio 0000:02:00.0: Failed to set vIOMMU: Need IOMMUFD backend when flts=on
+    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0: vfio 0000:02:00.0: Failed to set vIOMMU: Need IOMMUFD backend when fsts=on
 
 VFIO device under PCI bridge is unsupported, use PCIE bridge if necessary,
 otherwise below error shows:
 
 .. code-block:: none
 
-    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0,bus=bridge1,iommufd=iommufd0: vfio 0000:02:00.0: Failed to set vIOMMU: Host device downstream to a PCI bridge is unsupported when flts=on
+    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0,bus=bridge1,iommufd=iommufd0: vfio 0000:02:00.0: Failed to set vIOMMU: Host device downstream to a PCI bridge is unsupported when fsts=on
 
 If host IOMMU has ERRATA_772415_SPR17, running guest with "intel_iommu=on,sm_off"
 is unsupported, kexec or reboot guest from "intel_iommu=on,sm_on" to
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index fb6bbc3447..282c05ed19 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4201,7 +4201,7 @@ static const Property vtd_properties[] = {
                       VTD_HOST_ADDRESS_WIDTH),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
     DEFINE_PROP_BOOL("scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
-    DEFINE_PROP_BOOL("flts", IntelIOMMUState, fsts, FALSE),
+    DEFINE_PROP_BOOL("fsts", IntelIOMMUState, fsts, FALSE),
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
     DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
     DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
@@ -5560,20 +5560,20 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
     }
 
     if (!s->scalable_mode && s->fsts) {
-        error_setg(errp, "flts is only available in scalable mode");
+        error_setg(errp, "fsts is only available in scalable mode");
         return false;
     }
 
     if (!s->fsts && s->aw_bits != VTD_HOST_AW_39BIT &&
         s->aw_bits != VTD_HOST_AW_48BIT) {
         error_setg(errp, "%s: supported values for aw-bits are: %d, %d",
-                   s->scalable_mode ? "Scalable mode(flts=off)" : "Legacy mode",
+                   s->scalable_mode ? "Scalable mode(fsts=off)" : "Legacy mode",
                    VTD_HOST_AW_39BIT, VTD_HOST_AW_48BIT);
         return false;
     }
 
     if (s->fsts && s->aw_bits != VTD_HOST_AW_48BIT) {
-        error_setg(errp, "Scalable mode(flts=on): supported value for "
+        error_setg(errp, "Scalable mode(fsts=on): supported value for "
                    "aw-bits is: %d", VTD_HOST_AW_48BIT);
         return false;
     }
@@ -5590,7 +5590,7 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         }
 
         if (!s->fsts) {
-            error_setg(errp, "Need to set flts for svm");
+            error_setg(errp, "Need to set fsts for svm");
             return false;
         }
 
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index b28d5eb9fa..43d2993fb3 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -26,7 +26,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
     PCIDevice *pdev = bus->devices[vtd_hiod->devfn];
 
     if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
-        error_setg(errp, "Need IOMMUFD backend when flts=on");
+        error_setg(errp, "Need IOMMUFD backend when fsts=on");
         return false;
     }
 
@@ -44,7 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
 
     if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
         error_setg(errp, "Host device downstream to a PCI bridge is "
-                   "unsupported when flts=on");
+                   "unsupported when fsts=on");
         return false;
     }
 
@@ -105,7 +105,7 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
     bool ret;
 
     /*
-     * We can get here only if flts=on, the supported PGTT is FST or PT.
+     * We can get here only if fsts=on, the supported PGTT is FST or PT.
      * Catch invalid PGTT when processing invalidation request to avoid
      * attaching to wrong hwpt.
      */
diff --git a/tests/qtest/intel-iommu-test.c b/tests/qtest/intel-iommu-test.c
index 4f12c56260..30ee6524df 100644
--- a/tests/qtest/intel-iommu-test.c
+++ b/tests/qtest/intel-iommu-test.c
@@ -29,7 +29,7 @@ static void test_intel_iommu_stage_1(void)
     uint64_t cap, ecap, tmp;
     QTestState *s;
 
-    s = qtest_init("-M q35 -device intel-iommu,scalable-mode=on,flts=on");
+    s = qtest_init("-M q35 -device intel-iommu,scalable-mode=on,fsts=on");
 
     cap = vtd_reg_readq(s, DMAR_CAP_REG);
     g_assert((cap & CAP_STAGE_1_FIXED1) == CAP_STAGE_1_FIXED1);
-- 
2.47.3



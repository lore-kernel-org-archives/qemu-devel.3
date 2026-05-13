Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F8CCD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 06:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN3JL-0006dr-T7; Wed, 13 May 2026 02:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wN3JK-0006dG-5N
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:43:14 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wN3JF-0007Ax-KQ
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778654590; x=1810190590;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PTMH/4ANBKmow1t7dA8kVDSvahqWYBsa9VZCDOk+uiw=;
 b=jxV3jtl+qSk5hcd5MzNDlAeniVoBIrbUJlEuxJWEmAd4wmPLDzYJFKGb
 vDJEbkdPTsLMph/kRZr5N08uxca3cKSxD1L9WnbJCI0rvYTkWCn+csoVg
 Vf+XHYRNKQfAXMB1A7xp7k0kOdun6uxVS6YRaF54OPMbUGam2bNjEboQE
 NICru50EllrAqzXsoTtMvloUvgi6uWQOgRAux+7NxxoNFc+0rF56srGHI
 ICYULXACSyVhdzQsxIz8EX/AU1zamMOWr5xaCVXoldVaB7avhJYWAOcWj
 AtzKdjjqXInZhaAqBfmgMt9QLyXsWuNsxFZoQenm5E+MVfTo5WqDHTzf8 g==;
X-CSE-ConnectionGUID: Iz4EOz1lR0OWLOKaxRU4cA==
X-CSE-MsgGUID: 2RsiNZmKRhOezyLGKWhUYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="102240714"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="102240714"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 23:43:08 -0700
X-CSE-ConnectionGUID: o13ioLiPTwODeMP890TMjw==
X-CSE-MsgGUID: 87FnEjelSJyQyCZIkUQ3VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="239809246"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 23:43:05 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, berrange@redhat.com, clg@redhat.com,
 clement.mathieu--drif@bull.com, philmd@linaro.org, yi.l.liu@intel.com,
 zhenzhong.duan@intel.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 2/2] intel_iommu: Change 'flts' property naming to 'fsts'
Date: Wed, 13 May 2026 02:42:26 -0400
Message-ID: <20260513064227.2304854-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513064227.2304854-1-zhenzhong.duan@intel.com>
References: <20260513064227.2304854-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
 tests/qtest/iommu-intel-test.c |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

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
index f09a87b50b..4f8302d200 100644
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
@@ -5563,20 +5563,20 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
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
@@ -5593,7 +5593,7 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         }
 
         if (!s->fsts) {
-            error_setg(errp, "Need to set flts for svm");
+            error_setg(errp, "Need to set fsts for svm");
             return false;
         }
 
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 36dc5ac020..18ca5a801a 100644
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
diff --git a/tests/qtest/iommu-intel-test.c b/tests/qtest/iommu-intel-test.c
index 8125be9e28..703bbfef73 100644
--- a/tests/qtest/iommu-intel-test.c
+++ b/tests/qtest/iommu-intel-test.c
@@ -54,7 +54,7 @@ static const char *qvtd_iommu_args(QVTDTransMode mode)
 {
     switch (mode) {
     case QVTD_TM_SCALABLE_FLT:
-        return "-device intel-iommu,scalable-mode=on,flts=on ";
+        return "-device intel-iommu,scalable-mode=on,fsts=on ";
     case QVTD_TM_SCALABLE_PT:
     case QVTD_TM_SCALABLE_SLT:
         return "-device intel-iommu,scalable-mode=on ";
-- 
2.47.3



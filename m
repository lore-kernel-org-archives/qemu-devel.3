Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD22CD98D6
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYq9k-0007OG-0s; Sun, 14 Jun 2026 15:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9i-0007O4-7f
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9g-0001de-Fk
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781463959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IQsQD+5yZGlWsX1wL6CZL0yYjKsTMwNhTxRL1382bdw=;
 b=fJqJ7yhmemaN1M/3ySXN/qqDBjKSwy1MJvxfVvVJh2E1Hw1i1EZ5g7dl79c8hMeBeumg8F
 8Q7zu0NeimrIFLjUlfu4nkWcLxAFvt01D1uRRReNFNYpYtScS2KgIZuy3xjWYxNrHEi+KL
 qK4x5iFP6n/3CO6a7FXUxpZTi1uvsaY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-3K1LuEaaPGy6FWpDYz3z2Q-1; Sun, 14 Jun 2026 15:05:57 -0400
X-MC-Unique: 3K1LuEaaPGy6FWpDYz3z2Q-1
X-Mimecast-MFC-AGG-ID: 3K1LuEaaPGy6FWpDYz3z2Q_1781463957
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490d3f03883so22024675e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463957; x=1782068757; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IQsQD+5yZGlWsX1wL6CZL0yYjKsTMwNhTxRL1382bdw=;
 b=BJLJHHarLx757qOjELp3OnG/NuucMtLztqw/IF43jOkOlSek2Cz00zWgFA5w1TXkZ0
 t8pADswTLwmO4lc99T0paajRe1aXkYFlOT1GUDPezTUCPCFNv5aIIeS6dYbSXaazjJpb
 5lI+O7hLRIzvszR4Ch7c8u0cbJNkF0SMJ2wpeF/0mcdTsWB+ym35A3E9rwYEPLnMHpSf
 vo8Yv+O4tuVdVgWNBcW1pWk50U6UuojIdKJ8cygfrR3+3gDktuGVMTg5pBQy8qDOFFiy
 QeMMI5INkUhr0elz4xg+q67Cun8SFQrvjm+U1F6r9E45Cpb9eG4ROixhf6lIyKNZSLqm
 mXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463957; x=1782068757;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IQsQD+5yZGlWsX1wL6CZL0yYjKsTMwNhTxRL1382bdw=;
 b=EauseccxEb95ctKH3A/3avBRa3PZW4aaKio3gwJgbSO0R++lrB9euTgszaboV4YOmZ
 2rAH/j/6iD7sKj4RYjaz3flHiiuWzGwy+qrobcYNpViiT171ry+P70jqUMqRARmdGj96
 nUyNbRnRxUOu36UOann34YG1vOkXquswfwtDpCVaT0mwLFN6CewuRNXdoIfdTHF1D0ss
 5qX0ZsB9zrwDxil9Ng7xlKAMyPOBOewshJgQTzrArbiNmlX71x872sRj1XqaZ5mDy6xY
 FH5aqomkzqSU9i8v91wbdtY4LM/pI5ZheodVpwjyWl6e9JB91mTYHTVwNvFRyvx9ybyq
 DlZA==
X-Gm-Message-State: AOJu0Yx2tdrKlKYRohrv8CpJ7R6ghfz3mgEx7bL/FRhQ3sdzxFKL8wYu
 ef+CSiFe06CzFVb3pDxOD/vOsQ4aXzFClJ1zNP7K9YkhO2esJMHp6Nzr2ElcP7e0MFZR/LG/cw8
 4Px484fo9S7/7GxnwY1k3DmD4EYkdRiyLQ/rqxZ1S75gZy2fbPQusgoqbRdeCkbPsRdQctoVqsv
 FiGDVB7yRhRLV8CbktCTrRfgH+HbCSjDy0Rg==
X-Gm-Gg: Acq92OGOrziaNrt0ve8BH9FFN5MVF6TGO6SAae+wFOA5uZ/OIuog1NX71CeUuEFqHRm
 xJ65EEh4wXe9aiTI+ukWWO0UXxLMmblL47j8Mq5/OEWelnzbbf4cHmyyjH2X21EjDK+uYiYVMXE
 57FQR3NT3xDtc/DxRSIxrGzHANG5NkDHdAs3ZjqKgGXp5Pi8QVHMmhMwvvUOHim/oCvRLyG4hoe
 uRo024yEgmjpeyHyzVdfbho+/UDoEgAzgavofvF2vKYZ03TfX/kPyEOVZ0/1c6Kk2IK69VUu9rZ
 04v04YuFakCPfCN/I2qeuUzlIfYswXccXhOmJlw6z+Nfpzx6pPm36Il7uEhR1i0S4r2C4Si3fCE
 /Pe5v92ofCf45XEQAo8yXmZDa4JPmXPDNa4eNNYGW3ss=
X-Received: by 2002:a05:600c:314a:b0:490:da12:f1fa with SMTP id
 5b1f17b1804b1-490ec503f0cmr127637705e9.31.1781463956603; 
 Sun, 14 Jun 2026 12:05:56 -0700 (PDT)
X-Received: by 2002:a05:600c:314a:b0:490:da12:f1fa with SMTP id
 5b1f17b1804b1-490ec503f0cmr127637225e9.31.1781463956000; 
 Sun, 14 Jun 2026 12:05:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922031b21dsm176749485e9.6.2026.06.14.12.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:05:54 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:05:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 005/106] intel_iommu: Change 'flts' property naming to 'fsts'
Message-ID: <c068e00cff16a7560d974c957f1f1bde158573af.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Previous patch Removed 'x-' prefix from 'x-flts' property.
Opportunistically, this patch does s/flts/fsts for property name
in order to better align with newer spec since revision 3.4 which
changed terminology from "First-level" to "First-stage".

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260513064227.2304854-3-zhenzhong.duan@intel.com>
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
MST



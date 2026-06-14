Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAFCCD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYq9h-0007NI-Ky; Sun, 14 Jun 2026 15:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9d-0007MY-N4
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9b-0001aL-VZ
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781463955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EZa+Y4tLnxbfbTOlUtEtEC3z+5byRpb5C84fD6RI59Q=;
 b=E9NkZV73mEPtWsB94i/FtGu5EerHmd5wCRZtNwvF+5xt0BYf4aVTj9sCrHrIbp4zBfYZZn
 iHfjNeboh7P4WkVCmySjCRcFmXoERB7h9zupuCQN7wWwA19ktZE5hlz7/QoX0JK4rkezRn
 JNspPPl/Hl4Krx/AZSbTa3BXjf/RC9Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-r0TSFemNNp6cNnblH0Vscg-1; Sun, 14 Jun 2026 15:05:54 -0400
X-MC-Unique: r0TSFemNNp6cNnblH0Vscg-1
X-Mimecast-MFC-AGG-ID: r0TSFemNNp6cNnblH0Vscg_1781463953
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b79e6b94so22229535e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463953; x=1782068753; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EZa+Y4tLnxbfbTOlUtEtEC3z+5byRpb5C84fD6RI59Q=;
 b=FbsfrgfoA086vum93QfScpoFBoajADt+/Hf2FxldD9VkKacXNq3s3wpREbvzVPBgjl
 XN83nCe+PywfTDcggwQ89GN5CtDsoZjO3tuOU3PoqsGxjFaj/TIgK27df/dtmvRO6hP0
 bufAf3GxAD1S0W8iJZ7ZN4VW/PYOGYkGsdLblkZCsBfjxFwwdCJatpX9j7VkkeAIqmN9
 TREPvcjd+MEWT3F+VfYlMMo1tElr2WWnf1dZNLYnlGTSd5yEqhYZCy5nDhZbob2ohzjP
 JCWectMZWfSIT3467lQdUfvM0DYkC/CYIGKX+PU0rDaOodEc8M86bas9gSXbUXbHjNg7
 WAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463953; x=1782068753;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EZa+Y4tLnxbfbTOlUtEtEC3z+5byRpb5C84fD6RI59Q=;
 b=EvNPkvcu4fY1qchHKJ+TmxU6YjQRQt5d8+TKQw+NKd3odM9/6mqSbxP5ZZpFDtJ6h9
 tyltqwntQGTK8q/9xvDHWj3GSUPeJ05PVh+gRcuyGxk9xmnEpMHFZCYnKWZGRZxKgB1j
 xPQliMa+eikhPK1Tv3UzsKLmfGAWEFbQMH8Ab5F4oti6S/jJGgEMfg8mcY++H+Lq0ilc
 gx7UqczM9Lldsh0+FLBaTCiFZXF4WdYVHgLD9M2qaz/AIiv/6uNowoaCbN2lsfI3Lmct
 oxT/cvRA8Mz0J9hTZ5WLjky1F7lnoLCUibkBq0h/YGiTTo6xQ8fM4Y59Cz7t3qGhtUxE
 V6Xg==
X-Gm-Message-State: AOJu0YxC4HPjN4AZq39Gc8ADBvrX8xQJ/AtIRJjIsBAkSiVyOnGLkQRQ
 fZF1uecca83aKPz4Mhnou0iUcBzNp5vTe/pdMXpKhCTnIe9xzoZoePxgoFS9xHxkzy9RHZg7gL+
 EcfkyNzqGfaZfZ8Da6wrBsRdXc5H+k0TKF8rqVbSKUcVoheKGdqBQkJ90hAfapEQ/STh6vI3xIO
 f6kjhEhb8uPufVK83oWLwtu02VSnFlx+qo6w==
X-Gm-Gg: Acq92OEV9Muu2EU1TJ+NKPG7a1HiiX4/4y1mN4/iBypUHUoVTNQf/o/PTWfLtp9HAHA
 XnJb+7ndRoVYbQEub6ja4bEZDiTlYcOQzFbFeQ/yuGn23HEER4zOwt3FGI0jx6pWiUay1l+P8wA
 91VXWcM1p2+plqEH6g2ibnP3nnexKgN/rMNUvd3uyrCjmvfzSFkU/5xvqVLHqVuQsiDmeEDx03B
 /0/oYG64Hfx1CHAy3jZ44qs2Le5b89AF18Viw2dbqhhu684iNED0ojVgGYlopa5ItNqgntyjyux
 0B964ztSjtrCx+rMxHsV/xAqBnJfG3hqMKONHTuTNZBtr5IwCPDH3ZhepICt4nc38Omxa+WLbq/
 ZdDdJTxsml102p3nDpvKuYQ65oqecIreaV7E43Avo68w=
X-Received: by 2002:a05:600c:4712:b0:490:b55c:cec3 with SMTP id
 5b1f17b1804b1-490ec4dc8d8mr152467945e9.12.1781463952704; 
 Sun, 14 Jun 2026 12:05:52 -0700 (PDT)
X-Received: by 2002:a05:600c:4712:b0:490:b55c:cec3 with SMTP id
 5b1f17b1804b1-490ec4dc8d8mr152467365e9.12.1781463952034; 
 Sun, 14 Jun 2026 12:05:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492202edf89sm197084935e9.1.2026.06.14.12.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:05:51 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:05:49 -0400
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
Subject: [PULL 004/106] intel_iommu: Remove 'x-' prefix from
 'x-scalable-mode' and 'x-flts' properties
Message-ID: <08dc347e523005cf1e365c3c350a1721b36516e9.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We had 'x-scalable-mode' for more than 5 years and 'x-flts' for more than 1
year, it's fine to remove 'x-' now.

This is a prerequisite to enable intel_iommu's scalable mode and first stage
translation support in libvirt.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260513064227.2304854-2-zhenzhong.duan@intel.com>
---
 docs/devel/vfio-iommufd.rst    | 10 +++++-----
 hw/i386/intel_iommu.c          |  8 ++++----
 hw/i386/intel_iommu_accel.c    |  4 ++--
 tests/qtest/intel-iommu-test.c |  2 +-
 tests/qtest/iommu-intel-test.c |  4 ++--
 5 files changed, 14 insertions(+), 14 deletions(-)

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
index b784c5f10a..f09a87b50b 100644
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
@@ -5563,7 +5563,7 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
     }
 
     if (!s->scalable_mode && s->fsts) {
-        error_setg(errp, "x-flts is only available in scalable mode");
+        error_setg(errp, "flts is only available in scalable mode");
         return false;
     }
 
@@ -5576,7 +5576,7 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
     }
 
     if (s->fsts && s->aw_bits != VTD_HOST_AW_48BIT) {
-        error_setg(errp, "Scalable mode(x-flts=on): supported value for "
+        error_setg(errp, "Scalable mode(flts=on): supported value for "
                    "aw-bits is: %d", VTD_HOST_AW_48BIT);
         return false;
     }
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index ed3793602b..36dc5ac020 100644
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
diff --git a/tests/qtest/iommu-intel-test.c b/tests/qtest/iommu-intel-test.c
index a52c45e298..8125be9e28 100644
--- a/tests/qtest/iommu-intel-test.c
+++ b/tests/qtest/iommu-intel-test.c
@@ -54,10 +54,10 @@ static const char *qvtd_iommu_args(QVTDTransMode mode)
 {
     switch (mode) {
     case QVTD_TM_SCALABLE_FLT:
-        return "-device intel-iommu,x-scalable-mode=on,x-flts=on ";
+        return "-device intel-iommu,scalable-mode=on,flts=on ";
     case QVTD_TM_SCALABLE_PT:
     case QVTD_TM_SCALABLE_SLT:
-        return "-device intel-iommu,x-scalable-mode=on ";
+        return "-device intel-iommu,scalable-mode=on ";
     default:
         return "-device intel-iommu ";
     }
-- 
MST



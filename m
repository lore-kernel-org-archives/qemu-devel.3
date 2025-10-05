Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A94CCA472
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UGV-0006Kb-Hh; Sun, 05 Oct 2025 15:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFi-00042y-QS
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFe-0006f0-Lv
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9vjWwtD4aooS8gd5dv5Dc5knrdpDrnJ6iJ12o3b9lhw=;
 b=cfyupdR/q/+WYyTsg2lzdcpg6l49gNYlzoWG5QNRWNR2UuONPVLilF2IDyLJImEvICP9Pm
 hwmgzZEYbjiNMHBVDV214zylp/5uQVz7EFvwIJOxZKadqE6FxfpdG65kX2PSebs2Sk4sxt
 NuKLSDelymitXYEL5k0aVngu/N8oHGw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-Pojk_GhzMKOhBj9UcLsb0w-1; Sun, 05 Oct 2025 15:18:32 -0400
X-MC-Unique: Pojk_GhzMKOhBj9UcLsb0w-1
X-Mimecast-MFC-AGG-ID: Pojk_GhzMKOhBj9UcLsb0w_1759691911
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e4fa584e7so16710975e9.0
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691911; x=1760296711;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9vjWwtD4aooS8gd5dv5Dc5knrdpDrnJ6iJ12o3b9lhw=;
 b=BGgDlJr1/mySpOldiHZyowE/hAAg1+IJn9PGKLzqJk7au28S8diQcNIUl+xF8lqXfA
 bdh3bUm3xTQP+jkbGAg1Rr6xwKGYzQQbRjSh23Hl0xM/2N4nJPOtNEsLDFilK3+VYf32
 wmQ+K4Q+TeP6QcfP7QmeE9Q4cEXWOB4w7daMOzZ8vh0NmtX6dT9wLzpndpvDbDmmFHeS
 E39Tm8puJMXqz0IBXcUi41jDBUR4uO5GpSjTNE4fRs6VLoNwwWBf0CiP4sw248tbZKde
 blKTbAZxX1gyirvStTIvG/O3lb9maUefRr7GRxrMRCX4siZDkVI1CJu9WKWzpy4pTPSO
 Ztlg==
X-Gm-Message-State: AOJu0YxUOdtcTJYM5dm/gQoqa2jiSxM38ihlpo/gtsufy6UT3DakNNsc
 9hf8S07HrOGUTmOG5CkG6QGMsvRHRn8IVD+qj0A/YltPLhNSkiGjv0GS4AwnYwO3kKm8M8QXQ/m
 1e0VloXESmT6eLwliwypiIRWacJ8lIbVJpvVhUryeHNNC9Aq5O8GJTd12HGbg5zeAfZiABx2P09
 RQBpyfQGnYl+KIsnBQG+8ZnyCKDhkomyrhow==
X-Gm-Gg: ASbGnctpp20CluGYQKjF4r7416vvCQs0bjHt6PwORIYXkezOdLXVZWWNruATvSM5Ttr
 FWEeKYSyPdot+RI5p5RgyHIpanun8XBKZrSQEJK/sfDmFWpt5QcQW2hS8eXZQoCk8uj31fDRA/I
 75KYTnNTQckFYbS925m32t2wSEjkMXoY4IGV2KwUJ3d0gofP4ZIBN+AqLR4goa+RxT+I0hua/4A
 eGizSN4T7zXvaOCk5iroBQfC+0UZ+gWFWQZmYI6Hbhf2k0AtSAAdjKFVCi4unVUQFxhE4DP+BzF
 ZA8zqWAvT8U0EThIdsObXqIS1WYvZmiy6nQiY6Y=
X-Received: by 2002:a05:600c:8284:b0:46e:3d50:360e with SMTP id
 5b1f17b1804b1-46e7113f799mr72600075e9.18.1759691910559; 
 Sun, 05 Oct 2025 12:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbWRKR6YeXJCG6P0qO56u3m3wTUshuNv9AD2x7fZveX9Hb3spIE2rfYB9wZySbcODm9Zr2lg==
X-Received: by 2002:a05:600c:8284:b0:46e:3d50:360e with SMTP id
 5b1f17b1804b1-46e7113f799mr72599875e9.18.1759691909961; 
 Sun, 05 Oct 2025 12:18:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e7234f547sm131260915e9.9.2025.10.05.12.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:29 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 66/75] amd_iommu: Add dma-remap property to AMD vIOMMU device
Message-ID: <8a8837f903230919459c2df3c9584372fbe65312.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

In order to enable device assignment with IOMMU protection and guest DMA
address translation, IOMMU MAP notifier support is necessary to allow users
like VFIO to synchronize the shadow page tables i.e. to receive
notifications when the guest updates its I/O page tables and replay the
mappings onto host I/O page tables.

Provide a new dma-remap property to govern the ability to register for MAP
notifications, effectively providing global control over the DMA address
translation functionality that was implemented in previous changes.

Note that DMA remapping support also requires the vIOMMU is configured with
the NpCache capability, so a guest driver issues IOMMU invalidations for
both map() and unmap() operations. This capability is already set by default
and written to the configuration in amdvi_pci_realize() as part of
AMDVI_CAPAB_FEATURES.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-18-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h |  3 +++
 hw/i386/amd_iommu.c | 24 +++++++++++++++++-------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index b51aa74368..e1354686b6 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -418,6 +418,9 @@ struct AMDVIState {
     /* Interrupt remapping */
     bool ga_enabled;
     bool xtsup;
+
+    /* DMA address translation */
+    bool dma_remap;
 };
 
 uint64_t amdvi_extended_feature_register(AMDVIState *s);
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index e9ce7b46e8..ce5d4c3662 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -990,7 +990,9 @@ static void amdvi_iommu_address_space_sync_all(AMDVIState *s)
  */
 static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
 {
-    if (amdvi_as->addr_translation) {
+    AMDVIState *s = amdvi_as->iommu_state;
+
+    if (s->dma_remap && amdvi_as->addr_translation) {
         /* Enabling DMA region */
         memory_region_set_enabled(&amdvi_as->iommu_nodma, false);
         memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), true);
@@ -2193,12 +2195,19 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
     AMDVIAddressSpace *as = container_of(iommu, AMDVIAddressSpace, iommu);
     AMDVIState *s = as->iommu_state;
 
-    if (new & IOMMU_NOTIFIER_MAP) {
-        error_setg(errp,
-                   "device %02x.%02x.%x requires iommu notifier which is not "
-                   "currently supported", as->bus_num, PCI_SLOT(as->devfn),
-                   PCI_FUNC(as->devfn));
-        return -EINVAL;
+    /*
+     * Accurate synchronization of the vIOMMU page tables required to support
+     * MAP notifiers is provided by the dma-remap feature. In addition, this
+     * also requires that the vIOMMU presents the NpCache capability, so a guest
+     * driver issues invalidations for both map() and unmap() operations. The
+     * capability is already set by default as part of AMDVI_CAPAB_FEATURES and
+     * written to the configuration in amdvi_pci_realize().
+     */
+    if (!s->dma_remap && (new & IOMMU_NOTIFIER_MAP)) {
+        error_setg_errno(errp, ENOTSUP,
+            "device %02x.%02x.%x requires dma-remap=1",
+            as->bus_num, PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
+        return -ENOTSUP;
     }
 
     /*
@@ -2423,6 +2432,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
 static const Property amdvi_properties[] = {
     DEFINE_PROP_BOOL("xtsup", AMDVIState, xtsup, false),
     DEFINE_PROP_STRING("pci-id", AMDVIState, pci_id),
+    DEFINE_PROP_BOOL("dma-remap", AMDVIState, dma_remap, false),
 };
 
 static const VMStateDescription vmstate_amdvi_sysbus = {
-- 
MST



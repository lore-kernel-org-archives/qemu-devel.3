Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44808606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OEnnegl0;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gueMb+Ft
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Hk-0004WN-SR; Wed, 28 Oct 2026 13:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Gc-0001IZ-T2
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Ga-0003xA-DZ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DeYR6cmLH+YXpclTXj2Vsh91hiC53G/x5OKIn5+J3qQ=;
 b=OEnnegl0o9OQLEHNxl6z2Bxff0gyiDP7NqqpdQyY8+SDHQ+VT6cJ7UZgtw6ZgE09bgcJig
 EByoE2cUg1uHkJYFrjG4omWjgXA1N8MIvS5kbeGU9leLoriWedRoAUUtH8WIZOMaa5jsLL
 dIv/6MwO53ql9YplRuUoQm8CZVP89X4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-b_9ljd67PCW-uH3mUsBVvA-1; Wed, 28 Oct 2026 13:16:46 -0400
X-MC-Unique: b_9ljd67PCW-uH3mUsBVvA-1
X-Mimecast-MFC-AGG-ID: b_9ljd67PCW-uH3mUsBVvA_1793207805
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a4af69e06fso8928495e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207805; x=1793812605; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DeYR6cmLH+YXpclTXj2Vsh91hiC53G/x5OKIn5+J3qQ=;
 b=gueMb+Ft8Qknw+4F0XHpFhQU/bSrhI5R9VcMHCyp6LehhTJc0y3VHMC0C+vGhUetvk
 889g0JoWa91ULRaYs3mQQdzC56pgWslpF/DoUY1acKxK6hSmb7+ZOD62B9cTlr8E55qF
 jK0+xKke+JlFn4FH2k9ehdR7PKTljL4MAvjWK3hUv711/LRnZNcNZMr+XYLMCVAIiSYc
 RbcMJ8Mu6gUEiShrzx++EwmdyCeVDxOwfwPHmo8kFcNLbXRvVkVFyg731eh0W8wwN70a
 sFVVz5Lh0VXIefIhskYgAawBMfQaRDtsLfCxGa1LfNd46LlRn7HkRov/FcD7jd4Fy/ap
 +SnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207805; x=1793812605;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DeYR6cmLH+YXpclTXj2Vsh91hiC53G/x5OKIn5+J3qQ=;
 b=dcYxe9bkNuBgjtgqM+Jc0lbuVJZU1qJEaIwUGS6ow5xk1CAwIr3sTGZvb/3vtotO0+
 4tvnvSoHm6NKxEh9KUjh/B8Qd3uJln3HmNr0z/pGhw4iQJbnlMTspFVydE1Crp1nzSB4
 BA/kX8bBsjfxQHgyaEOiYuUhu1RZgBWagFSDpBZfs7H182uwhHFAKkcIZYxYOHXwJGUQ
 kHxQ+k2Wlg8pBrbBPYS/3X/ahbonp9AENIacd9xlGAg4y5iCg/7eHo9BSxGFdLnUvcsC
 /hC5mvIU38poF5hsgWLaCgdkI59DMYs9wRWqN0Z5O+1c2VevYwaTtE0I0zpEfw6FvQgA
 eFCw==
X-Gm-Message-State: AFq9FYIAUn/7P6PkBpYVnBaBkXux0VT9DY3TaTstW9/fy/nWk10Po4Ll
 HYfwSMQ5gUIJrJmh1ISAlSsyIa653EuMHHZ2LbvTBEoOuwFZtBEJYtp1QeF0SPnpSva9jb3V7da
 3wwgJF2akfU+1RHmi3oee1VK+9411NncBmXdYsmbdKCr7VrC+M8o9QIysLocZbLHLvxBMaxOVuM
 Jj/WGG1/y2n8oP0VueR8qomXQzt6bg9FOKrg==
X-Gm-Gg: AYBFou3aUZTsiePrbkh6qXYHUB9ZPyenc1d7oyexZC+d1SGOB+cqr3OEM7cFTYqH2ja
 SqsoHUI++osI8lLwwpssxwp4vd4rw/G3n1f9cVNI+T8ypl/ccdRaGIWrAFmXvGm2NxRrbuE+hlM
 bQ0GBUjthVJKiTXavvH567X56lj9Ta6/gE80acdcPfl/0glgd2M6lhvQfwxn+Dsk2zOjSMa5xrJ
 x/8C+dIRf4Rwn+gzJ/esmLZuaFGSjUo0JlP+jpg12B9a+6dXcxCdFH1H4rsilRyvNiRP2jtss9S
 YZRk7P2bTeIPMn/KNSOOCXMq/yhdnRUuP9PzruTfbcOIiAtovvDLucsJciJ50JhH5xIBMjJ+trf
 DnMvrY6Ce0Q7C3AGU99rGccXYOa+KVN0MlgxPutDj
X-Received: by 2002:a05:600d:16:b0:4a2:191f:7cb8 with SMTP id
 5b1f17b1804b1-4a9672f819fmr55524565e9.17.1793207804983; 
 Wed, 28 Oct 2026 10:16:44 -0700 (PDT)
X-Received: by 2002:a05:600d:16:b0:4a2:191f:7cb8 with SMTP id
 5b1f17b1804b1-4a9672f819fmr55523475e9.17.1793207804214; 
 Wed, 28 Oct 2026 10:16:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f7f4cdbsm6950265e9.7.2026.10.28.10.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:43 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 62/78] x86-iommu: Introduce x86_iommu_device_get() for
 x86-iommu retrieval
Message-ID: <095eef807ad24a3d388a9c4cb2144657a0f71166.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sairaj Kodilkar <sarunkod@amd.com>

kvm_arch_fixup_msi_route() and kvm_arch_add_msi_route_post() use
x86_iommu_get_default() whenever an IOMMU is present. This selects the
correct unit only when a single IOMMU is attached to the system bus.

The following patches allow an IOMMU to attach to a different bus and
isolate the subset of devices below it. Each IOMMU then serves only part
of the PCI topology, so interrupt remapping must determine the IOMMU that
actually serves a given device.

Add x86_iommu_device_get() to locate the IOMMU bus for a PCI device and
retrieve its X86IOMMUState through a new get_x86_iommu callback.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261014053433.24564-3-sarunkod@amd.com>
---
 include/hw/i386/x86-iommu.h |  6 ++++++
 include/hw/pci/pci.h        | 12 ++++++++++++
 hw/i386/x86-iommu-stub.c    |  5 +++++
 hw/i386/x86-iommu.c         | 16 ++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
index 0a1e1ba725..eb575271e9 100644
--- a/include/hw/i386/x86-iommu.h
+++ b/include/hw/i386/x86-iommu.h
@@ -134,6 +134,12 @@ struct X86IOMMU_MSIMessage {
  */
 X86IOMMUState *x86_iommu_get_default(void);
 
+/**
+ * x86_iommu_device_get - get IOMMU device for given PCI device
+ * @return: pointer to default IOMMU device
+ */
+X86IOMMUState *x86_iommu_device_get(PCIDevice *dev);
+
 /**
  * x86_iommu_iec_register_notifier - register IEC (Interrupt Entry
  *                                   Cache) notifiers
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 6520886855..359331102f 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -700,6 +700,18 @@ typedef struct PCIIOMMUOps {
      * Returns: the guest physical address of the MSI doorbell.
      */
     uint64_t (*get_msi_direct_gpa)(PCIBus *bus, void *opaque, int devfn);
+
+    /**
+     * @get_x86_iommu: get parent x86-iommu for given hardware (AMD/Intel)
+     *
+     * Callback is required if IOMMU defines x86->int_remap()
+     *
+     * @opaque: the data passed to pci_setup_iommu()
+     *
+     * @x86_iommu: A pointer to store the x86-iommu object
+     */
+    int (*get_x86_iommu)(void *opaque, void **x86_iommu);
+
 } PCIIOMMUOps;
 
 bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
diff --git a/hw/i386/x86-iommu-stub.c b/hw/i386/x86-iommu-stub.c
index 781b5ff922..b0383d2290 100644
--- a/hw/i386/x86-iommu-stub.c
+++ b/hw/i386/x86-iommu-stub.c
@@ -32,6 +32,11 @@ X86IOMMUState *x86_iommu_get_default(void)
     return NULL;
 }
 
+X86IOMMUState *x86_iommu_device_get(PCIDevice *dev)
+{
+    return NULL;
+}
+
 bool x86_iommu_ir_supported(X86IOMMUState *s)
 {
     return false;
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index a57445404e..601db5cfea 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -26,6 +26,7 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "system/kvm.h"
+#include "hw/pci/pci_bus.h"
 
 void x86_iommu_iec_register_notifier(X86IOMMUState *iommu,
                                      iec_notify_fn fn, void *data)
@@ -90,6 +91,21 @@ X86IOMMUState *x86_iommu_get_default(void)
     return NULL;
 }
 
+X86IOMMUState *x86_iommu_device_get(PCIDevice *dev)
+{
+    PCIBus *iommu_bus;
+    X86IOMMUState *iommu = NULL;
+
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
+
+    if (iommu_bus && iommu_bus->iommu_ops->get_x86_iommu) {
+        iommu_bus->iommu_ops->get_x86_iommu(iommu_bus->iommu_opaque,
+                                            (void **)&iommu);
+    }
+
+    return iommu;
+}
+
 static void x86_iommu_realize(DeviceState *dev, Error **errp)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
-- 
MST



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8961FCAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFk-0004Ja-Kp; Sun, 05 Oct 2025 15:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFU-0002iF-EA
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFR-0006cn-Aw
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CUXH9jflyEfZRN7jKCMdE7m/FyRWJE2tZCWeRtqscZ0=;
 b=LNlpb24t9P/VYXvSazp4RVckYnnkQXrAlzZ0/t4V6VD6SolhyAhD9gBhzOLWfrxnCHUtrS
 5ZYay0Rl0irA3SlBw2kxDSqIChqz2dKWG0zjmuDhQnr75AWB8WMeI5GdfpF5qESDDOMOTr
 9hLn2jgkfvtmGrAi5iLZqOra4HEBMGA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-kLz9QBIgOa-MZFZR5jFpGA-1; Sun, 05 Oct 2025 15:18:19 -0400
X-MC-Unique: kLz9QBIgOa-MZFZR5jFpGA-1
X-Mimecast-MFC-AGG-ID: kLz9QBIgOa-MZFZR5jFpGA_1759691898
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46eee58d405so1672535e9.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691898; x=1760296698;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUXH9jflyEfZRN7jKCMdE7m/FyRWJE2tZCWeRtqscZ0=;
 b=c0hvVmaDwIAzV8DysZQX4fqGKHldvTgQ5zhI+0dQkgoAEXE4TjXd507msFNQsWKcET
 24wlyZyn0y0nYbPX17AKMCkbNyowmPorpvaVjc+Vut7H8ehr5dDSz6uqSZySWp2burSN
 5KqOJA2UmtU9RnRIMVEyUAOu+GPHV7e+lJPabc3rvorA3JyuLTQTa6PsKOkh3RiTxMrI
 dPj9LOLK1iVMRGfQqQIRuTE9zHvxapqI7+U/awkPUy5QCPxqD6Gv4Yeh0O0eAVAlU2B3
 kyPKHe1MTyy8AJpPX6dwzqcn4vwecqzJDbbZgAJM5SS7fkl/C5ZuRc1cpEpug4fzxk6s
 5Teg==
X-Gm-Message-State: AOJu0YxR6LDLNw/Up8kJkHyX+e3yhdkHG51Xp+tzpJMqT/I8rRud65H9
 gEpKtp5nqj0Zt/5tBuSbFoAp9GFrOWzgxqqArDQOws88F8j3fRnzTFvnUp7ty+YwsOX4Yuc+x5v
 Sk994ZkdQ+zIv3RDU8arJF+AbdNUKJHW/bJLMhzvESC7xpw1Hsy8o9xzO/SFhYg3UFm9Iozx7uC
 lv7TvAdD8wRyyL9XN5jFLCs0sAajHAEK8lzA==
X-Gm-Gg: ASbGncv955C/jVdSH4e+5gSyyNnw1HXcJMzgpQ7IidgWaAdBX60+DgWovpVqCaD5+Xf
 jSzu5kPdErnIuEM1q0OSzamn3+vw6d7TOOvGyUUFKp6lTFo+ySqv0VmBxomEC2DBXzBCObSGfCk
 nDGzaeXdoeE+2yZGuP+lGn4DrEn3u6DRh60cC8VYwoudxs51Oud62sPlwnFP1ZPrzJssgsOaUAK
 nG90AVBaZcUUJU4k/NlMgdeYpTF/JI2yfEii3Sf90CxIrFOgwUrbTYtYUROksRFuJM5GyrtQ8fq
 AaOc99lytGPNWv8JtA5w5v4YipbRCs3RF2SoQZI=
X-Received: by 2002:a05:600c:3b27:b0:46e:42aa:75b5 with SMTP id
 5b1f17b1804b1-46e71101b0cmr73278055e9.4.1759691897899; 
 Sun, 05 Oct 2025 12:18:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEtfpA5hhxEWDmlp5HokQo5GHK1ZtQNkdLE5uMaEZaw22Hzea9y3hl4qkbsYRR/KUPL93V3A==
X-Received: by 2002:a05:600c:3b27:b0:46e:42aa:75b5 with SMTP id
 5b1f17b1804b1-46e71101b0cmr73277845e9.4.1759691897283; 
 Sun, 05 Oct 2025 12:18:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72343260sm123314755e9.4.2025.10.05.12.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:16 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 60/75] amd_iommu: Use iova_tree records to determine large
 page size on UNMAP
Message-ID: <95bc772592eb5560e9c78d313b118788ea6a3826.1759691708.git.mst@redhat.com>
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

Keep a record of mapped IOVA ranges per address space, using the iova_tree
implementation. Besides enabling optimizations like avoiding unnecessary
notifications, a record of existing <IOVA, size> mappings makes it possible
to determine if a specific IOVA is mapped by the guest using a large page,
and adjust the size when notifying UNMAP events.

When unmapping a large page, the information in the guest PTE encoding the
page size is lost, since the guest clears the PTE before issuing the
invalidation command to the IOMMU. In such case, the size of the original
mapping can be retrieved from the iova_tree and used to issue the UNMAP
notification. Using the correct size is essential since the VFIO IOMMU
Type1v2 driver in the host kernel will reject unmap requests that do not
fully cover previous mappings.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-12-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 95 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index caae65c4b3..4376e977f8 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -33,6 +33,7 @@
 #include "hw/i386/apic-msidef.h"
 #include "hw/qdev-properties.h"
 #include "kvm/kvm_i386.h"
+#include "qemu/iova-tree.h"
 
 /* used AMD-Vi MMIO registers */
 const char *amdvi_mmio_low[] = {
@@ -71,6 +72,8 @@ struct AMDVIAddressSpace {
     IOMMUNotifierFlag notifier_flags;
     /* entry in list of Address spaces with registered notifiers */
     QLIST_ENTRY(AMDVIAddressSpace) next;
+    /* Record DMA translation ranges */
+    IOVATree *iova_tree;
 };
 
 /* AMDVI cache entry */
@@ -685,6 +688,75 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
     return 0;
 }
 
+/*
+ * Invoke notifiers registered for the address space. Update record of mapped
+ * ranges in IOVA Tree.
+ */
+static void amdvi_notify_iommu(AMDVIAddressSpace *as, IOMMUTLBEvent *event)
+{
+    IOMMUTLBEntry *entry = &event->entry;
+
+    DMAMap target = {
+        .iova = entry->iova,
+        .size = entry->addr_mask,
+        .translated_addr = entry->translated_addr,
+        .perm = entry->perm,
+    };
+
+    /*
+     * Search the IOVA Tree for an existing translation for the target, and skip
+     * the notification if the mapping is already recorded.
+     * When the guest uses large pages, comparing against the record makes it
+     * possible to determine the size of the original MAP and adjust the UNMAP
+     * request to match it. This avoids failed checks against the mappings kept
+     * by the VFIO kernel driver.
+     */
+    const DMAMap *mapped = iova_tree_find(as->iova_tree, &target);
+
+    if (event->type == IOMMU_NOTIFIER_UNMAP) {
+        if (!mapped) {
+            /* No record exists of this mapping, nothing to do */
+            return;
+        }
+        /*
+         * Adjust the size based on the original record. This is essential to
+         * determine when large/contiguous pages are used, since the guest has
+         * already cleared the PTE (erasing the pagesize encoded on it) before
+         * issuing the invalidation command.
+         */
+        if (mapped->size != target.size) {
+            assert(mapped->size > target.size);
+            target.size = mapped->size;
+            /* Adjust event to invoke notifier with correct range */
+            entry->addr_mask = mapped->size;
+        }
+        iova_tree_remove(as->iova_tree, target);
+    } else { /* IOMMU_NOTIFIER_MAP */
+        if (mapped) {
+            /*
+             * If a mapping is present and matches the request, skip the
+             * notification.
+             */
+            if (!memcmp(mapped, &target, sizeof(DMAMap))) {
+                return;
+            } else {
+                /*
+                 * This should never happen unless a buggy guest OS omits or
+                 * sends incorrect invalidation(s). Report an error in the event
+                 * it does happen.
+                 */
+                error_report("Found conflicting translation. This could be due "
+                             "to an incorrect or missing invalidation command");
+            }
+        }
+        /* Record the new mapping */
+        iova_tree_insert(as->iova_tree, &target);
+    }
+
+    /* Invoke the notifiers registered for this address space */
+    memory_region_notify_iommu(&as->iommu, 0, *event);
+}
+
 /*
  * Walk the guest page table for an IOVA and range and signal the registered
  * notifiers to sync the shadow page tables in the host.
@@ -696,7 +768,7 @@ static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
 {
     IOMMUTLBEvent event;
 
-    hwaddr iova_next, page_mask, pagesize;
+    hwaddr page_mask, pagesize;
     hwaddr iova = addr;
     hwaddr end = iova + size - 1;
 
@@ -719,7 +791,6 @@ static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
         /* PTE has been validated for major errors and pagesize is set */
         assert(pagesize);
         page_mask = ~(pagesize - 1);
-        iova_next = (iova & page_mask) + pagesize;
 
         if (ret == -AMDVI_FR_PT_ENTRY_INV) {
             /*
@@ -752,15 +823,26 @@ static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
             event.type = IOMMU_NOTIFIER_MAP;
         }
 
-        /* Invoke the notifiers registered for this address space */
-        memory_region_notify_iommu(&as->iommu, 0, event);
+        /*
+         * The following call might need to adjust event.entry.size in cases
+         * where the guest unmapped a series of large pages.
+         */
+        amdvi_notify_iommu(as, &event);
+        /*
+         * In the special scenario where the guest is unmapping a large page,
+         * addr_mask has been adjusted before sending the notification. Update
+         * pagesize accordingly in order to correctly compute the next IOVA.
+         */
+        pagesize = event.entry.addr_mask + 1;
 
 next:
+        iova &= ~(pagesize - 1);
+
         /* Check for 64-bit overflow and terminate walk in such cases */
-        if (iova_next < iova) {
+        if ((iova + pagesize) < iova) {
             break;
         } else {
-            iova = iova_next;
+            iova += pagesize;
         }
     }
 }
@@ -1845,6 +1927,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
         iommu_as[devfn]->devfn = (uint8_t)devfn;
         iommu_as[devfn]->iommu_state = s;
         iommu_as[devfn]->notifier_flags = IOMMU_NOTIFIER_NONE;
+        iommu_as[devfn]->iova_tree = iova_tree_new();
 
         amdvi_dev_as = iommu_as[devfn];
 
-- 
MST



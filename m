Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32709606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QJZe0UVV;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TVcmMN/f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7IL-0005iX-P7; Wed, 28 Oct 2026 13:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7HG-0002Qb-AK
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7HD-00042J-V5
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2s+jqhvsiWOFEv7PUF/Ot7DfnI3LT5e3n4BWRVCm8To=;
 b=QJZe0UVVWN3PtBLBskgd4HWA81MLEF/prVC51C4EGAmuU7V6XY+6PStbCY5CPpriB9Gb3e
 0cPVw2tB/lNAlxi2jg9VKn3kJQygl/N4g1KoEpKmueda9j0k0BGkJ8EJPxf2wYgmsJ/wLd
 QM2ubm/xdUX4yV0HFJ6NueX0PKZWiUM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-QUyCDY6eO0OlJ4vXyRwSlA-1; Wed, 28 Oct 2026 13:17:25 -0400
X-MC-Unique: QUyCDY6eO0OlJ4vXyRwSlA-1
X-Mimecast-MFC-AGG-ID: QUyCDY6eO0OlJ4vXyRwSlA_1793207844
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a17741243eso9033725e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207844; x=1793812644; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2s+jqhvsiWOFEv7PUF/Ot7DfnI3LT5e3n4BWRVCm8To=;
 b=TVcmMN/f810Os11PE5K1fTNZuJPIlq7FzCoehSy47443CeMvNjq97BHcAiVQIWIHd1
 CtUehtHF2Ua4ozNJjZ4Eb7VTUFJN8brvFCAx3Sc+IRXzovtfZGyzKfB93dtwnLw1V86r
 85LaV3Os+T75jR+Yh7g1IIRHN370YuiXiCAPoaYP6+hc7ZD+m+1H+INkF/XRBHe2jKIS
 WoERo4cqjCQxhLt8TN0fVVYzsJFCYe3McF/eUxKLOQSS/EJzb+RVzmDmDdPIGOdy78EX
 fkSiq1FQ1VzzjK6zgVYk6dQlT15oU8FM5zfI+32bXm+MybiFBzV0d1GKCoasgufktaTl
 bYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207844; x=1793812644;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2s+jqhvsiWOFEv7PUF/Ot7DfnI3LT5e3n4BWRVCm8To=;
 b=CCXijVpWY+TqMV8C9ikHDhagY6t07hgC2/NDWfHFU9IRPI1O4XuezVahw024GXrdP3
 gdXsRwWom9ATlt3aCODUY7WidTyHoUwGVs18YfPS7az/pkcOH4e3mJmOoxaBckpFk6nT
 XyoteNpRWUmA1+li9Dh+pI2nHFX60MJJgiC9dDrh+OGXh5cRLlW1l1cn2H/5kICXM0m/
 bXPWWdmyo8+hAEtnelEzLYY0exheuqEc7Qd7/Bp+sNv4C7Fnzfuzm+t7Fig2rjoWWHd8
 ofqTFiK3ZwawZpWzqI+h/OTiojoL/tRDxlAEbhDk47iyt9v8a+P6siS5JKEjOafjSXdc
 l6uQ==
X-Gm-Message-State: AFq9FYLRJEMRnm40OTyA5YIxSqA2uBXO0D65PxTMHC+8i8xyI45Lusbq
 deRlxR1E8gLxdgRQp2Osf3UHSky161rh9cS0/4NwOvPvRIDnWgEJrB+8Q/izYQqKAcwl1kZVmxZ
 MSF8//BAQY0Ly3vxlDxR5mKwUa944oDgbJfgs+PwNLqVDPyuiPtdzYz+2oeC5DmchrRx4zwAIpi
 LCzrfhYggLR8cKVxdtQLb9WG4uTE4X9Ka2Sg==
X-Gm-Gg: AYBFou3Ppf0kZeDCfiJj0j1wAQWMuEW/AdFC83MZdZBdKzwSQ3C2InMeRyuhpQjjpc+
 VPLfuA7xei5k82jrM2Y+0Rm0Mn8uLYvqkaB/OJ50C8HyfZS9RjBqXM2P4CkPgyTAiyo4iCvZQZn
 ZrJ/TI3fB/CvOKzGvHRRZEmOuq8s7cWYfBN8qG09xANAzhv36rqydIVfeBZ8eOBT5c81isAwWbG
 aqyPzvO/83SwGLleZv6Yab1FufMNKz2d7YesBvaU2NNY0s3QTT3M5qT8JAKgfCHz1YjDHrEJhc1
 RBL4D92DJ0eadD7+ZNZ6Fh8wwpGXUzTAfhHd01qC7Z5it96N/1CZxyEAMRE4a5iDJqBtQ53twn8
 rmPQJZd3B0sViXp9FUumw+Gm7gkzpEXpIZArLxRN/
X-Received: by 2002:a05:600c:5246:b0:4a1:faa1:3813 with SMTP id
 5b1f17b1804b1-4a9674e813cmr64551075e9.27.1793207844220; 
 Wed, 28 Oct 2026 10:17:24 -0700 (PDT)
X-Received: by 2002:a05:600c:5246:b0:4a1:faa1:3813 with SMTP id
 5b1f17b1804b1-4a9674e813cmr64549445e9.27.1793207843333; 
 Wed, 28 Oct 2026 10:17:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a93103e72dsm45163925e9.2.2026.10.28.10.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:17:22 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:17:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Clement Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Yi Liu <yi.l.liu@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 73/78] intel_iommu_accel: Accept PRQ response for passthrough
 device
Message-ID: <fc656e7e186956261eb3b2f599a5f00098fa0de2.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Propagate guest's PRQ response to host by writing to fault_fd.
Create a new VTDPRQEntry to cache cookie for each fault group,
this cookie is used to mark the fault group on host side.

If there is either PRQ overflow or full error condition, propagate
a success response to host for LPIG request with the PRQ requests
dropped. For other error conditions, propagate response of invalid
request.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261020091955.1607161-6-zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.h   |  12 ++++
 include/hw/i386/intel_iommu.h |   6 ++
 hw/i386/intel_iommu.c         |   4 ++
 hw/i386/intel_iommu_accel.c   | 102 +++++++++++++++++++++++++++++++---
 hw/i386/trace-events          |   1 +
 5 files changed, 118 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index e0319749a5..0cc22b2cbb 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -20,6 +20,7 @@ typedef struct VTDAccelPASIDCacheEntry {
     uint32_t fs_hwpt_id;
     uint32_t fault_id;
     int fault_fd;
+    QLIST_HEAD(, VTDPRQEntry) vtd_prq_list;
     QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
 } VTDAccelPASIDCacheEntry;
 
@@ -31,6 +32,9 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
                                       uint64_t npages, bool ih);
 void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info);
 void vtd_accel_pasid_cache_reset(IntelIOMMUState *s);
+bool vtd_accel_propagate_page_group_response(IntelIOMMUState *s,
+                                             uint16_t rid, uint32_t pasid,
+                                             IOMMUPRIResponse *response);
 void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
 #else
 static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
@@ -69,6 +73,14 @@ static inline void vtd_accel_pasid_cache_reset(IntelIOMMUState *s)
 {
 }
 
+static inline
+bool vtd_accel_propagate_page_group_response(IntelIOMMUState *s,
+                                             uint16_t rid, uint32_t pasid,
+                                             IOMMUPRIResponse *response)
+{
+    return false;
+}
+
 static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
 {
 }
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 1842ba5840..5d44eac0ed 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -100,6 +100,12 @@ typedef struct VTDPASIDCacheEntry {
     bool valid;
 } VTDPASIDCacheEntry;
 
+typedef struct VTDPRQEntry {
+    uint32_t grpid;
+    uint32_t cookie;
+    QLIST_ENTRY(VTDPRQEntry) next;
+} VTDPRQEntry;
+
 struct VTDAddressSpace {
     PCIBus *bus;
     uint8_t devfn;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index adb8c79d57..b7da5d086d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3380,6 +3380,10 @@ static bool vtd_process_page_group_response_desc(IntelIOMMUState *s,
         response.response_code = IOMMU_PRI_RESP_FAILURE;
     }
 
+    if (vtd_accel_propagate_page_group_response(s, rid, pasid, &response)) {
+        return true;
+    }
+
     if (vtd_dev_as->pri_notifier) {
         vtd_dev_as->pri_notifier->notify(vtd_dev_as->pri_notifier, &response);
     }
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index bcd361bae3..243501f137 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -17,6 +17,9 @@
 #include "hw/pci/pci_bus.h"
 #include "trace.h"
 
+static void vtd_write_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce,
+                                uint32_t cookie, uint32_t code);
+
 bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp)
 {
@@ -84,6 +87,46 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
     return NULL;
 }
 
+static void vtd_prq_handle_pasid_response(VTDAccelPASIDCacheEntry *vtd_pce,
+                                          IOMMUPRIResponse *response)
+{
+    VTDPRQEntry *prqe, *tmp;
+
+    QLIST_FOREACH_SAFE(prqe, &vtd_pce->vtd_prq_list, next, tmp) {
+        if (prqe->grpid != response->prgi) {
+            continue;
+        }
+
+        vtd_write_fs_faultq(vtd_pce, prqe->cookie, response->response_code);
+
+        QLIST_REMOVE(prqe, next);
+        g_free(prqe);
+        break;
+    }
+}
+
+bool vtd_accel_propagate_page_group_response(IntelIOMMUState *s,
+                                             uint16_t rid, uint32_t pasid,
+                                             IOMMUPRIResponse *response)
+{
+    VTDAddressSpace *vtd_as = vtd_get_as_by_sid(s, rid);
+    VTDAccelPASIDCacheEntry *vtd_pce;
+    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
+
+    if (!vtd_hiod) {
+        return false;
+    }
+
+    QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
+        if (vtd_pce->pasid == pasid) {
+            vtd_prq_handle_pasid_response(vtd_pce, response);
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static void vtd_propagate_recoverable_faults(VTDAccelPASIDCacheEntry *vtd_pce,
                                              struct iommu_hwpt_pgfault *fault,
                                              unsigned cnt)
@@ -94,14 +137,42 @@ static void vtd_propagate_recoverable_faults(VTDAccelPASIDCacheEntry *vtd_pce,
 
     for (; cnt--; fault++) {
         bool last_page = fault->flags & IOMMU_PGFAULT_FLAGS_LAST_PAGE;
+        int ret;
 
-        vtd_pri_request_page(vtd_hiod->bus, vtd_hiod->iommu_state,
-                             vtd_hiod->devfn, pasid,
-                             fault->perm & IOMMU_PGFAULT_PERM_PRIV,
-                             fault->perm & IOMMU_PGFAULT_PERM_EXEC,
-                             fault->addr, last_page, fault->grpid,
-                             fault->perm & IOMMU_PGFAULT_PERM_READ,
-                             fault->perm & IOMMU_PGFAULT_PERM_WRITE);
+        ret = vtd_pri_request_page(vtd_hiod->bus, vtd_hiod->iommu_state,
+                                   vtd_hiod->devfn, pasid,
+                                   fault->perm & IOMMU_PGFAULT_PERM_PRIV,
+                                   fault->perm & IOMMU_PGFAULT_PERM_EXEC,
+                                   fault->addr, last_page, fault->grpid,
+                                   fault->perm & IOMMU_PGFAULT_PERM_READ,
+                                   fault->perm & IOMMU_PGFAULT_PERM_WRITE);
+        if (!last_page) {
+            continue;
+        }
+
+        if (!ret) {
+            VTDPRQEntry *prqe = g_malloc0(sizeof(*prqe));
+
+            prqe->grpid = fault->grpid;
+            prqe->cookie = fault->cookie;
+            QLIST_INSERT_HEAD(&vtd_pce->vtd_prq_list, prqe, next);
+            continue;
+        }
+
+        /*
+         * vt-d spec 7.4.1:
+         *
+         * Hardware generates page group response with code of success for
+         * PRQ overflow and PRQ full, with code of invalid request for
+         * other error conditions.
+         */
+        if (ret == -ENOSPC) {
+            vtd_write_fs_faultq(vtd_pce, fault->cookie,
+                                IOMMUFD_PAGE_RESP_SUCCESS);
+        } else {
+            vtd_write_fs_faultq(vtd_pce, fault->cookie,
+                                IOMMUFD_PAGE_RESP_INVALID);
+        }
     }
 }
 
@@ -138,6 +209,22 @@ static void vtd_read_fs_faultq(void *opaque)
                                      bytes / sizeof(faults[0]));
 }
 
+static void vtd_write_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce,
+                                uint32_t cookie, uint32_t code)
+{
+    struct iommu_hwpt_page_response resp = {.cookie = cookie, .code = code};
+    uint32_t id = vtd_pce->fault_id;
+    int fd = vtd_pce->fault_fd;
+    ssize_t bytes;
+
+    bytes = write(fd, &resp, sizeof(resp));
+    trace_vtd_write_fs_faultq(id, fd, cookie, code, bytes);
+    if (bytes < 0) {
+        error_report_once("FAULTQ(id %u): write failed "
+                          "[cookie 0x%x code 0x%x] (%m)", id, cookie, code);
+    }
+}
+
 static void vtd_destroy_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
                                   uint32_t fault_id, int fault_fd)
 {
@@ -438,6 +525,7 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
     vtd_pce->pasid = pasid;
     vtd_pce->pasid_entry = *pe;
     vtd_pce->fault_fd = -1;
+    QLIST_INIT(&vtd_pce->vtd_prq_list);
     QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
 
     if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index ad84d106a4..7bf4cddd38 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -78,6 +78,7 @@ vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int re
 vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret) "dev_id %d pasid %d ret: %d"
 vtd_device_reattach_def_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
 vtd_read_fs_faultq(uint32_t fault_id, uint32_t fault_fd, ssize_t ret) "fault_id %d fault_fd %d ret: %zd"
+vtd_write_fs_faultq(uint32_t fault_id, uint32_t fault_fd, uint32_t cookie, uint32_t code, ssize_t ret) "fault_id %d fault_fd %d cookie %d code %d ret: %zd"
 
 # amd_iommu.c
 amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
-- 
MST



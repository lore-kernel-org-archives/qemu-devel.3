Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A8960A260F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iAeT1gYa;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Tfg0VH1M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTykB-00063O-T6; Thu, 19 Nov 2026 04:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTyjm-0005jd-11
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:47:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTyjj-0006Nm-VT
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795081643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8sprDBXgETXdKNGbGvNgBVi0P3G5g8RTpuGM1LJEy5o=;
 b=iAeT1gYaHHUysRk8E8Eaewum0g1znHhCWNveKSliTERpp199KNOlbKdIztvDZJ15NZHSDl
 pcgunEIZV9f8IUsQQSY8mAIR1EmTcw8uRvataCCLkKj6Myhagqz8TKXRTtJvZBaPKeofyh
 SjK49sl3aMzF7B427t/HF/r80eTpfyc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-lMNNtdPjMVi9fZF06Axhfw-1; Thu, 19 Nov 2026 04:47:21 -0500
X-MC-Unique: lMNNtdPjMVi9fZF06Axhfw-1
X-Mimecast-MFC-AGG-ID: lMNNtdPjMVi9fZF06Axhfw_1795081641
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4bb6517ed8bso1660755e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 01:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795081641; x=1795686441; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8sprDBXgETXdKNGbGvNgBVi0P3G5g8RTpuGM1LJEy5o=;
 b=Tfg0VH1Mrbi/VFtFRodudVyZmegR++ya63iaFQgT87Kr3PwN7dLQX5YqzDdC4Mxchn
 MouLZ3WUQQpDnFtl72atLaOJbss3V4ButpxR1yx+bAFegqt4d8Jjfh63PLGwxWhLA2Gb
 4+cnMpCE3SpjOMtOKf6vPEPg7nGY8DyMCbHyARSapbPl7Wha/82FUwltVac2iFGotz2s
 2jPII/UiniTUFqLdIqkLZwFd9Zgu4k0OrFC13nVkSodE5Ybs40bK3MGPSVlSqW5NHYt6
 QjDR7WbGj4v+56s9X7MNQDi1vtGn3uavJ+mXS0HyZPNTn25czCT8wIH0OnXuxsJro4xW
 mJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795081641; x=1795686441;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8sprDBXgETXdKNGbGvNgBVi0P3G5g8RTpuGM1LJEy5o=;
 b=Qo0z1hkkaaQWOqLOu0ecUA/HbyJEqu3C2eNTx6TIZqqVZgEpbOhK3CartscA/+NLrH
 quiueLPnVoUCIB+y/KnTpHWX9dOI20VeriNbWpZdL5GP2gqZYuhRTeWuShmqxhK54Mm+
 lGktW5eLw/GFIfAth6W7kG3CTTlEPQyZPnYS2cjGkUciEJqhqna4LbbC6nvFQBSLwoo/
 BoytPcrmAn6DUtruFilOhLnay7VJSeqDfuDIngDEdLUptgBXjWXsMoKFSjIQj8RiBeyo
 oGZFkeSNboKU3/MIEj5TdEEbbbz2CQOSjqmCxc5mtTMk+QFXuiHoaeHgcQZlv951KVe8
 K6OA==
X-Gm-Message-State: APuU4Z++vKXH0rnMB3DE/A0uteQ6wast7gDNJrAeBZDE36wl7jdiRxdW
 HvnK/JzHsCm9f+JDpTEtIf37/deWh5WCZMHM+oNGx0AWbgw2pN/VCr/CKxokIsdpUseSw0VpU3n
 uqJQT0TbeCkGGGA8SXAv3WZdcwBqxNoDiG2R5jVL7ehIamz5EiKfSjstcBCuAr6l5r2uN9PgNTN
 AhZswZs4vw8QwnN8JE+f06YbYbyoozho4u8A==
X-Gm-Gg: AYBFou2JUqKPsXlszjUsZndKK1IOBWDQ8UuiTyB5+EQaYyz9rAkUrg6kWKR5e95+DkB
 YUuAfClcLRTVTsRLOBSWpTHRbim07Yd7ClMJrQf0Si1GCGV2pNAse1eXqjUlSCcQfEYqaybJ69e
 sV+hQRsWmyKtoS5o4CJBZFN+5KbKLfz7wCpCeQySsAeszkndhtN2IAY4q3VkXAZwUIUoplRs3GT
 9haDuprlcR1MdB4Chb/qsoWBoVn1WnnuJlifxBqFmOQjgrMybnsJ/DXLnEhQfyANxpRbNdC72bH
 Dz0ueSrpZomLe36hB1llac98W5910zpRs1j4Z9umYaFfnb+oOXPtuhzrqaRqZKOL1MsuNbvTJDn
 Tw2532OsAxoLQVrrlF3uXcwuSmzZFqGO0eeYQabBFxoU=
X-Received: by 2002:a05:600c:1d82:b0:4a3:59c9:a756 with SMTP id
 5b1f17b1804b1-4bb7da03e09mr101156015e9.6.1795081640546; 
 Thu, 19 Nov 2026 01:47:20 -0800 (PST)
X-Received: by 2002:a05:600c:1d82:b0:4a3:59c9:a756 with SMTP id
 5b1f17b1804b1-4bb7da03e09mr101155315e9.6.1795081639797; 
 Thu, 19 Nov 2026 01:47:19 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65560bd46sm9392110f8f.31.2026.11.19.01.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 01:47:19 -0800 (PST)
Date: Thu, 19 Nov 2026 04:47:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Clement Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowangio@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 5/8] intel_iommu: Keep PASID cache consistent with PT fast path
Message-ID: <e02728395177647e91799b958ea1824884d6dc0f.1795081539.git.mst@redhat.com>
References: <cover.1795081539.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1795081539.git.mst@redhat.com>
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

With caching mode disabled, a guest can install a scalable-mode
pass-through PASID entry without issuing a PASID-cache invalidation. The
first DMA enables the PT fast path, but leaves QEMU's PASID cache invalid.

When the guest tears down that entry to switch back to a DMA domain, the
invalidation handler sees both a non-present guest entry and an invalid
cached entry and returns without re-enabling the IOMMU memory region.
Subsequent DMA therefore continues to bypass translation.

The issue can be reproduced with an emulated device in scalable mode
with caching-mode=off:

1. Unbind the guest device driver and change the group's type to
   identity through /sys/kernel/iommu_groups/<group>/type.
2. Rebind the driver and issue a DMA write.
3. Unbind the driver, change the group's type back to DMA-FQ, and
   rebind the driver.
4. Issue another DMA write using an IOVA mapped to a different GPA.

The second write incorrectly bypasses translation instead of reaching
the mapped GPA.

Save the PASID entry when enabling the scalable-mode PT fast path so
teardown invalidation can restore the IOMMU address space. Return after
handling a non-present entry, and refresh the cached entry when a present
entry changes, pass vtd_as to vtd_try_enable_pt_fast_path() instead of
pick it from PASID 0.

Opportunistically clarify the invalidation modes in the fast-path comment
and merge trace event vtd_translate_pt and vtd_pt_enable_fast_path into
vtd_fast_path_translate_pt.

Fixes: c9cf33075a4c ("intel_iommu: Fix DMA failure when guest switches IOMMU domain")
Reported-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261112081509.442872-1-zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 62 ++++++++++++++++++++++++-------------------
 hw/i386/trace-events  |  3 +--
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b7da5d086d3..a5ff89a11a1 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1649,7 +1649,7 @@ static int vtd_address_space_sync(VTDAddressSpace *vtd_as)
  * or second stage translation, it depends on PGTT setting.
  */
 static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
-                               uint32_t pasid)
+                               uint32_t pasid, VTDPASIDEntry *pasid_entry)
 {
     VTDPASIDEntry pe;
     int ret;
@@ -1663,6 +1663,11 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
              */
             return false;
         }
+
+        if (pasid_entry) {
+            *pasid_entry = pe;
+        }
+
         return vtd_pe_pgtt_is_pt(&pe);
     }
 
@@ -1689,7 +1694,7 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
         return false;
     }
 
-    return vtd_dev_pt_enabled(s, &ce, as->pasid);
+    return vtd_dev_pt_enabled(s, &ce, as->pasid, NULL);
 }
 
 /* Return whether the device is using IOMMU translation. */
@@ -1701,8 +1706,8 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
     assert(as);
 
     s = as->iommu_state;
-    use_iommu = s->dmar_enabled && !vtd_as_pt_enabled(as);
     pt = s->dmar_enabled && vtd_as_pt_enabled(as);
+    use_iommu = s->dmar_enabled && !pt;
 
     /*
      * When guest enables scalable mode and sets up first stage page table,
@@ -1887,23 +1892,34 @@ VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
     return vtd_get_as_by_sid_and_pasid(s, sid, IOMMU_NO_PASID);
 }
 
-static void vtd_pt_enable_fast_path(IntelIOMMUState *s, uint16_t source_id)
+static bool vtd_try_enable_pt_fast_path(IntelIOMMUState *s,
+                                        VTDAddressSpace *vtd_as,
+                                        VTDContextEntry *ce, uint32_t pasid)
 {
-    VTDAddressSpace *vtd_as;
-    bool success = false;
+    VTDPASIDEntry pe;
 
-    vtd_as = vtd_get_as_by_sid(s, source_id);
-    if (!vtd_as) {
-        goto out;
+    if (!vtd_dev_pt_enabled(s, ce, pasid, &pe)) {
+        return false;
     }
 
-    if (vtd_switch_address_space(vtd_as) == false) {
-        /* We switched off IOMMU region successfully. */
-        success = true;
+    /*
+     * When this happens, it means firstly caching-mode is not
+     * enabled, and this is the first passthrough translation for
+     * the device. Let's enable the fast path for passthrough.
+     *
+     * When passthrough is disabled again for the device, we can
+     * capture it via context-cache invalidation in legacy mode or
+     * PASID-cache invalidation in scalable mode, then the IOMMU
+     * region can be swapped back.
+     */
+    if (!vtd_switch_address_space(vtd_as) && s->root_scalable) {
+        VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+
+        pc_entry->pasid_entry = pe;
+        pc_entry->valid = true;
     }
 
-out:
-    trace_vtd_pt_enable_fast_path(source_id, success);
+    return true;
 }
 
 /*
@@ -2167,23 +2183,12 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
      * We don't need to translate for pass-through context entries.
      * Also, let's ignore IOTLB caching as well for PT devices.
      */
-    if (vtd_dev_pt_enabled(s, &ce, pasid)) {
+    if (vtd_try_enable_pt_fast_path(s, vtd_as, &ce, pasid)) {
         entry->iova = addr & VTD_PAGE_MASK_4K;
         entry->translated_addr = entry->iova;
         entry->addr_mask = ~VTD_PAGE_MASK_4K;
         entry->perm = IOMMU_RW;
-        trace_vtd_translate_pt(source_id, entry->iova);
-
-        /*
-         * When this happens, it means firstly caching-mode is not
-         * enabled, and this is the first passthrough translation for
-         * the device. Let's enable the fast path for passthrough.
-         *
-         * When passthrough is disabled again for the device, we can
-         * capture it via the context entry invalidation, then the
-         * IOMMU region can be swapped back.
-         */
-        vtd_pt_enable_fast_path(s, source_id);
+        trace_vtd_fast_path_translate_pt(source_id, entry->iova);
         vtd_iommu_unlock(s);
         return true;
     }
@@ -3133,6 +3138,7 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
             vtd_address_space_unmap(vtd_as, n);
         }
         vtd_switch_address_space(vtd_as);
+        return;
     }
 
     /*
@@ -3158,11 +3164,11 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     }
 
     if (!pc_entry->valid) {
-        pc_entry->pasid_entry = pe;
         pc_entry->valid = true;
     } else if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
         return;
     }
+    pc_entry->pasid_entry = pe;
 
     vtd_switch_address_space(vtd_as);
     vtd_address_space_sync(vtd_as);
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 7bf4cddd389..3337a7e19c3 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -47,8 +47,7 @@ vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"P
 vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
 vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device %02x:%02x.%x switching address space (iommu enabled=%d)"
 vtd_as_unmap_whole(uint8_t bus, uint8_t slot, uint8_t fn, uint64_t iova, uint64_t size) "Device %02x:%02x.%x start 0x%"PRIx64" size 0x%"PRIx64
-vtd_translate_pt(uint16_t sid, uint64_t addr) "source id 0x%"PRIx16", iova 0x%"PRIx64
-vtd_pt_enable_fast_path(uint16_t sid, bool success) "sid 0x%"PRIx16" %d"
+vtd_fast_path_translate_pt(uint16_t sid, uint64_t addr) "source id 0x%"PRIx16", iova 0x%"PRIx64
 vtd_irq_generate(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64
 vtd_reg_read(uint64_t addr, uint64_t size) "addr 0x%"PRIx64" size 0x%"PRIx64
 vtd_reg_write(uint64_t addr, uint64_t size, uint64_t val) "addr 0x%"PRIx64" size 0x%"PRIx64" value 0x%"PRIx64
-- 
MST



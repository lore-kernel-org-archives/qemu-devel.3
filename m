Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA25C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 17:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sACZI-0006Rt-MY; Thu, 23 May 2024 13:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sACYx-000656-3f
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:49:12 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sACYl-0003gO-8w
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:49:05 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f3406f225bso7000055ad.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716486537; x=1717091337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FdMPl+cqllxYu/DQv6hq5NibyaBbgGeK2RHmqU1o/rQ=;
 b=ZU5NxjT+Uqfre8vR8AI72qJCLPgXgm1ZRAEsHk3d2YXqqGMvwCFkXd6QH5jg4RoZs0
 kk2CnlUqZGxCEFjRjiZcwaJTxFsL6OAHz2KvilXLB8xLPux+3cvirkgmrZ8Z1a9UsHFu
 lE8lRkosrgRQ/Y5eFiJ3tJ9/UIRKYGzXw5ehYe/l5EEVuQZUQJ+2khV01fYJUJfIkEz9
 Fg8NTZ8ZujtydZoGONuisCnWri9XXwp4FR2zKsYQbDOFhK6+wVqEv1VIw69cfE7dttU0
 tH3IfcFExdJt9QUqP4iks1PzaBLjQDp76wqLMGEku0m2EceRVGlV7PciyTxmrSYghHHh
 ZOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716486537; x=1717091337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FdMPl+cqllxYu/DQv6hq5NibyaBbgGeK2RHmqU1o/rQ=;
 b=HAXSFMKa21/vMYkBDrUWJKtGoTUsnhdrxZ+C5dmoRqY0LANDb1I3fRun6xhgG3WVwe
 DV8WZf7NqsV09kScVZFpO/+Ypt0PIzmDlIUVteoJkDP+1HGFiANUqRRKur5i7TwanWSt
 JhYytr+m5XQn0SwD05Q7BzxxlRqT8djaJeRasGUq4+IcasHEUPVcCUlZid53gVePQN4C
 7ORPkd2K9sVBsW3k+8p7LMbzDqspCeDdGU0mxRGOW9bnlW/75NwrzyRIzTjh/CCyGlIQ
 jGW4sP2Vhcw1btKN1dArUPs7dlurTigvedL7JXvTprm1GpUjR3trB+VPwkqCheqvxlvj
 2mGg==
X-Gm-Message-State: AOJu0YyghsgKLVWg7NVG46jxNXKsrOH3bNhW7WfO656CwbXo6qt1Sa/+
 0mpibjcTsQhMAR+LVIC7QDeCLdQF/XhCeSBTQSgGg97UQAa6PRqcv01rlA==
X-Google-Smtp-Source: AGHT+IHehiabqYnVUJQxYIy6yhBc7pdUHHNaYYN4bddYFtnk788KTzylMWc10q/piC8M/olLxZvAhQ==
X-Received: by 2002:a17:903:2347:b0:1f2:f9de:c9e8 with SMTP id
 d9443c01a7336-1f4486fd296mr777535ad.2.1716486537115; 
 Thu, 23 May 2024 10:48:57 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 10:48:56 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, armbru@redhat.com, mst@redhat.com,
 Fan Ni <fan.ni@samsung.com>, Svetly Todorov <svetly.todorov@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 12/14] hw/mem/cxl_type3: Add DPA range validation for
 accesses to DC regions
Date: Thu, 23 May 2024 10:44:52 -0700
Message-ID: <20240523174651.1089554-13-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523174651.1089554-1-nifan.cxl@gmail.com>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fan Ni <fan.ni@samsung.com>

All DPA ranges in the DC regions are invalid to access until an extent
covering the range has been successfully accepted by the host. A bitmap
is added to each region to record whether a DC block in the region has
been backed by a DC extent. Each bit in the bitmap represents a DC block.
When a DC extent is accepted, all the bits representing the blocks in the
extent are set, which will be cleared when the extent is released.

Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  3 ++
 hw/mem/cxl_type3.c          | 76 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  7 ++++
 3 files changed, 86 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ab71492697..045bce8f74 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1655,6 +1655,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
 
         cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
         ct3d->dc.total_extent_count += 1;
+        ct3_set_region_block_backed(ct3d, dpa, len);
     }
     /* Remove the first extent group in the pending list */
     cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
@@ -1813,10 +1814,12 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
      * list and update the extent count;
      */
     QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents, node, ent_next) {
+        ct3_clear_region_block_backed(ct3d, ent->start_dpa, ent->len);
         cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
     }
     copy_extent_list(&ct3d->dc.extents, &updated_list);
     QTAILQ_FOREACH_SAFE(ent, &updated_list, node, ent_next) {
+        ct3_set_region_block_backed(ct3d, ent->start_dpa, ent->len);
         cxl_remove_extent_from_extent_list(&updated_list, ent);
     }
     ct3d->dc.total_extent_count = updated_list_size;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 2161766b14..60cbaa9bb6 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -671,6 +671,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
             .flags = 0,
         };
         ct3d->dc.total_capacity += region->len;
+        region->blk_bitmap = bitmap_new(region->len / region->block_size);
     }
     QTAILQ_INIT(&ct3d->dc.extents);
     QTAILQ_INIT(&ct3d->dc.extents_pending);
@@ -682,6 +683,8 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
 {
     CXLDCExtent *ent, *ent_next;
     CXLDCExtentGroup *group, *group_next;
+    int i;
+    CXLDCRegion *region;
 
     QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents, node, ent_next) {
         cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
@@ -694,6 +697,11 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
         }
         g_free(group);
     }
+
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        g_free(region->blk_bitmap);
+    }
 }
 
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
@@ -925,6 +933,70 @@ static void ct3_exit(PCIDevice *pci_dev)
     }
 }
 
+/*
+ * Mark the DPA range [dpa, dap + len - 1] to be backed and accessible. This
+ * happens when a DC extent is added and accepted by the host.
+ */
+void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                 uint64_t len)
+{
+    CXLDCRegion *region;
+
+    region = cxl_find_dc_region(ct3d, dpa, len);
+    if (!region) {
+        return;
+    }
+
+    bitmap_set(region->blk_bitmap, (dpa - region->base) / region->block_size,
+               len / region->block_size);
+}
+
+/*
+ * Check whether the DPA range [dpa, dpa + len - 1] is backed with DC extents.
+ * Used when validating read/write to dc regions
+ */
+bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                  uint64_t len)
+{
+    CXLDCRegion *region;
+    uint64_t nbits;
+    long nr;
+
+    region = cxl_find_dc_region(ct3d, dpa, len);
+    if (!region) {
+        return false;
+    }
+
+    nr = (dpa - region->base) / region->block_size;
+    nbits = DIV_ROUND_UP(len, region->block_size);
+    /*
+     * if bits between [dpa, dpa + len) are all 1s, meaning the DPA range is
+     * backed with DC extents, return true; else return false.
+     */
+    return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) == nr + nbits;
+}
+
+/*
+ * Mark the DPA range [dpa, dap + len - 1] to be unbacked and inaccessible.
+ * This happens when a dc extent is released by the host.
+ */
+void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                   uint64_t len)
+{
+    CXLDCRegion *region;
+    uint64_t nbits;
+    long nr;
+
+    region = cxl_find_dc_region(ct3d, dpa, len);
+    if (!region) {
+        return;
+    }
+
+    nr = (dpa - region->base) / region->block_size;
+    nbits = len / region->block_size;
+    bitmap_clear(region->blk_bitmap, nr, nbits);
+}
+
 static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
 {
     int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
@@ -1029,6 +1101,10 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
         *as = &ct3d->hostpmem_as;
         *dpa_offset -= vmr_size;
     } else {
+        if (!ct3_test_region_block_backed(ct3d, *dpa_offset, size)) {
+            return -ENODEV;
+        }
+
         *as = &ct3d->dc.host_dc_as;
         *dpa_offset -= (vmr_size + pmr_size);
     }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index c69ff6b5de..0a4fcb2800 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -456,6 +456,7 @@ typedef struct CXLDCRegion {
     uint64_t block_size;
     uint32_t dsmadhandle;
     uint8_t flags;
+    unsigned long *blk_bitmap;
 } CXLDCRegion;
 
 struct CXLType3Dev {
@@ -577,4 +578,10 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
 void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
                                        CXLDCExtentGroup *group);
 void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
+void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                 uint64_t len);
+void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                   uint64_t len);
+bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                  uint64_t len);
 #endif
-- 
2.43.0



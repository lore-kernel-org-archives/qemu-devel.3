Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08702C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZVd-0002vd-LP; Tue, 04 Jun 2024 15:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZVb-0002dn-Hp
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZVZ-0000wj-4E
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J5j8n04Q1gRbmovO7PmlswqpHPYyPExcO8mAPNVjzhI=;
 b=fNTW3a6tYoQQZL51ICDhenu26svU1fMXTO2Vl4vPjN78LL5hu0clhZlwVrdHWsrSM654Sq
 gdtUG9FoJrs65HJlIkHibGgGLH8ZdpYd/8u1Dp2Z0TWcaCMR6JPjtGOLSUsQRVFF+R0rZQ
 Aonz7+aguCE30x3v0/RQx/BZL+WJ42A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-EAO8d4diPcGt8ESQJq9v5g-1; Tue, 04 Jun 2024 15:07:43 -0400
X-MC-Unique: EAO8d4diPcGt8ESQJq9v5g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4215604d4a2so1748845e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528061; x=1718132861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5j8n04Q1gRbmovO7PmlswqpHPYyPExcO8mAPNVjzhI=;
 b=naGff3m7i3YQn0wOm46dGuOvbk/5aJ/Fhn0bWN2vCG4F/Ktqi1MFco9VwLWlRyqvd1
 JRfrqiop4ZdUBd0HtewuPylF/Re7BSH6KpnHaSeLPUDtFjCjyZxt+/do+PeGjVskDIS+
 REu0Qvt4S9QqFdv4rEBDMqVO1wv2z80FeIJQcqHSUUk/mCb+JmDIIIpjiix0pIeZcyRS
 1Ya7SjQ4hh/kEsEo3rLrbBetES/bjA5Q3hiR8ZLl0dMRl3O/QfdhFEjCBHJXYM8qtbf0
 j12xTc3DsEip8HOBiPdeS+IVF6619hlYLztKEvBQ2F0Zl4nKl1Cv9v9GWF8wShlwoEDQ
 b7UA==
X-Gm-Message-State: AOJu0Yyye+CjC/1whlo4ocSrIc8BrUbPqJgtBKN4fvhGSdbr4l5bpkXS
 XXiKUL8A+S327MN/dU4txm6EsNQBBK0gePzkebgqQ1Kk8we+br34SAug6lxfxR424Aa0P1Hh+Ym
 BrQeNmXVUsTuuMFG0P/wt+/Je29qozzYjM+86zR155jpsf/h978eK8hzUlQoZDgdRm50oAlu4ue
 BPnlXtXAX3CPp0CCqu1IFBG62Xt3jo9w==
X-Received: by 2002:a05:600c:44d4:b0:41f:ed4b:93f9 with SMTP id
 5b1f17b1804b1-421562dc3abmr3687255e9.19.1717528060824; 
 Tue, 04 Jun 2024 12:07:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdReZCBXDXyZtoiS7EXWnfAw84sZEG3Z2ceLy8PRYCEJo3xhYUUd1HK0Zdl7PCksGgZJcaTA==
X-Received: by 2002:a05:600c:44d4:b0:41f:ed4b:93f9 with SMTP id
 5b1f17b1804b1-421562dc3abmr3687115e9.19.1717528060318; 
 Tue, 04 Jun 2024 12:07:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b8a4f98sm167172705e9.32.2024.06.04.12.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:07:39 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:07:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Svetly Todorov <svetly.todorov@memverge.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 28/46] hw/mem/cxl_type3: Add DPA range validation for accesses
 to DC regions
Message-ID: <7d324ec4556b188c58ab9578a512e0367692d6bd.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Message-Id: <20240523174651.1089554-13-nifan.cxl@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  7 ++++
 hw/cxl/cxl-mailbox-utils.c  |  3 ++
 hw/mem/cxl_type3.c          | 76 +++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)

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
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 64387f34ce..c4852112fe 100644
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
index f53bcca6d3..0d18259ec0 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -672,6 +672,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
             .flags = 0,
         };
         ct3d->dc.total_capacity += region->len;
+        region->blk_bitmap = bitmap_new(region->len / region->block_size);
     }
     QTAILQ_INIT(&ct3d->dc.extents);
     QTAILQ_INIT(&ct3d->dc.extents_pending);
@@ -683,6 +684,8 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
 {
     CXLDCExtent *ent, *ent_next;
     CXLDCExtentGroup *group, *group_next;
+    int i;
+    CXLDCRegion *region;
 
     QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents, node, ent_next) {
         cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
@@ -695,6 +698,11 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
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
@@ -926,6 +934,70 @@ static void ct3_exit(PCIDevice *pci_dev)
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
@@ -1030,6 +1102,10 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
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
-- 
MST



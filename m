Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76710C54E49
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 19:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhEEk-0005XU-V6; Mon, 04 Mar 2024 14:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhEEh-0005Wp-JI
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:31 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhEEf-0006xb-Ny
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:31 -0500
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-dcc80d6006aso5068175276.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 11:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709581468; x=1710186268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJmbpLHmX91RSD+FS2bbI4ESdtGu0icFFQqbt0j7En8=;
 b=QOW14upCueKGmhl7kqpIQXMJonky45CZaSrT9w5rW5nkEfu1vgILKNPuApPVDm4xTu
 r3gLa5E2dB7DgARnsnMFJmPLQYCzibL9ShQj5eE0VMMckagmL72spLd8qSETgTM2HfEW
 xqsNuRIQ0JZAB4bX9NtpEmH0AKruvwni4SvCCZoNwMsyS+DBDH7xFuIL3YlykZZRpXyW
 YufYMZf0/y1jzoK8AmeWYri/oP6PHdI7wQmpLZrgOU7pohqzJo9qUqSofXTKzbho+UMC
 OY9ZCZ1dQDUDIyVTx5Ezzvnex6qVSfTlS+iVvYIhmIF2NhA0vaI2UpINLIbgZOUt1/yl
 zh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709581468; x=1710186268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJmbpLHmX91RSD+FS2bbI4ESdtGu0icFFQqbt0j7En8=;
 b=YicfiJ8Mk/WwgR+WERI9dCWIrbejJJ/wtMLL30W9+Xh9ZPmc8ZtDaXwEc6yq5eO9OO
 nJH2kRR6I8OWcssLXc+FGKAyLCplrbxdprBkiDkOgYbIqtcb/7m/rgNOts4PJ2n/i59E
 xeprHxTLOtJD6O9M7zl1iedgDT92S/NbdMWAyfris0SSxvdjblRfg3vxdbCPeG0rYkGz
 ej4ZWo4MSGNgy0r2445T/LJ+fHQMxswlaH8gcZ/9AHOZQlrMl7jQyC6uypcgjAjfbKCq
 GtqIYVpNLa4c/Aof1fnO6ULHksl/03XsmSW9vn7bxFQuvFOLJKJbEdBlWgGhjpYeO+sa
 ecqQ==
X-Gm-Message-State: AOJu0Yx7RX6UcMksNQymiak9UuIHH7nIdNDPKvvIu6bOs+zwqiCxzmF5
 nfVx46CXdUhqqNM3Qva6svMebvcPzRcr4RFkJg3bb7sOlzWNVQtg8jQYrKf9
X-Google-Smtp-Source: AGHT+IFgVk4gFsTBw619+d2h77tRgbIEeyXBAg4E1CIdEk27elXaNIecJfX30qCONXyB3gh3/cBbGg==
X-Received: by 2002:a5b:644:0:b0:dc2:41de:b744 with SMTP id
 o4-20020a5b0644000000b00dc241deb744mr7144765ybq.32.1709581468003; 
 Mon, 04 Mar 2024 11:44:28 -0800 (PST)
Received: from localhost.localdomain ([50.205.20.42])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a255f41000000b00dc62edd58dasm2282646ybm.40.2024.03.04.11.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 11:44:27 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v5 10/13] hw/mem/cxl_type3: Add dpa range validation for
 accesses to DC regions
Date: Mon,  4 Mar 2024 11:34:05 -0800
Message-ID: <20240304194331.1586191-11-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304194331.1586191-1-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Not all dpa range in the DC regions is valid to access until an extent
covering the range has been added. Add a bitmap for each region to
record whether a DC block in the region has been backed by DC extent.
For the bitmap, a bit in the bitmap represents a DC block. When a DC
extent is added, all the bits of the blocks in the extent will be set,
which will be cleared when the extent is released.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  4 ++
 hw/mem/cxl_type3.c          | 76 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  7 ++++
 3 files changed, 87 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 53ebc526ae..b538297bb5 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1606,6 +1606,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
 
         cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
         ct3d->dc.total_extent_count += 1;
+        ct3_set_region_block_backed(ct3d, dpa, len);
     }
 
     /*
@@ -1681,17 +1682,20 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
                     found = true;
                     cxl_remove_extent_from_extent_list(extent_list, ent);
                     ct3d->dc.total_extent_count -= 1;
+                    ct3_clear_region_block_backed(ct3d, ent_start_dpa, ent_len);
 
                     if (len1) {
                         cxl_insert_extent_to_extent_list(extent_list,
                                                          ent_start_dpa, len1,
                                                          NULL, 0);
                         ct3d->dc.total_extent_count += 1;
+                        ct3_set_region_block_backed(ct3d, ent_start_dpa, len1);
                     }
                     if (len2) {
                         cxl_insert_extent_to_extent_list(extent_list, dpa + len,
                                                          len2, NULL, 0);
                         ct3d->dc.total_extent_count += 1;
+                        ct3_set_region_block_backed(ct3d, dpa + len, len2);
                     }
                     break;
                 } else {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index e9c8994cdb..c164cf4580 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -672,6 +672,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
 
         region_base += region->len;
         ct3d->dc.total_capacity += region->len;
+        region->blk_bitmap = bitmap_new(region->len / region->block_size);
     }
     QTAILQ_INIT(&ct3d->dc.extents);
     QTAILQ_INIT(&ct3d->dc.extents_pending_to_add);
@@ -682,6 +683,8 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
 static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
 {
     CXLDCExtent *ent;
+    int i;
+    CXLDCRegion *region;
 
     while (!QTAILQ_EMPTY(&ct3d->dc.extents)) {
         ent = QTAILQ_FIRST(&ct3d->dc.extents);
@@ -693,6 +696,11 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
         cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending_to_add,
                                            ent);
     }
+
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        g_free(region->blk_bitmap);
+    }
 }
 
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
@@ -924,6 +932,70 @@ static void ct3_exit(PCIDevice *pci_dev)
     }
 }
 
+/*
+ * Mark the DPA range [dpa, dap + len) to be backed and accessible. This
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
+ * Check whether the DPA range [dpa, dpa + len) is backed with DC extents.
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
+ * Mark the DPA range [dpa, dap + len) to be unbacked and inaccessible. This
+ * happens when a dc extent is released by the host.
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
index b524c5e699..b213149de2 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -450,6 +450,7 @@ typedef struct CXLDCRegion {
     uint64_t block_size;
     uint32_t dsmadhandle;
     uint8_t flags;
+    unsigned long *blk_bitmap;
 } CXLDCRegion;
 
 struct CXLType3Dev {
@@ -557,4 +558,10 @@ void cxl_insert_extent_to_extent_list(CXLDCExtentList *list, uint64_t dpa,
                                       uint16_t shared_seq);
 bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
                        unsigned long size);
+void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                 uint64_t len);
+void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                   uint64_t len);
+bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                  uint64_t len);
 #endif
-- 
2.43.0



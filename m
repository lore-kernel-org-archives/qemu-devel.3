Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302ABC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrDl-00088H-2r; Wed, 21 Feb 2024 13:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcrDj-000842-7c
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:21:27 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcrDg-0003Lu-Hg
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:21:26 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5c229dabbb6so4005150a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708539683; x=1709144483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lopfkfP/Wd4iBuj5Kqs/1syP004OyEXA8CH53rf8oR0=;
 b=Jd/5T/cFVaRqhykeOO9M5M0WYVUgsDT4OnavolpvLSdHNLVEmgFRODYUUKti3MlTPi
 e4HfEISIZVMeG0VvRK1n0MJwUT1tmQfZuKIw7aXvGfepNyafixhv8zBeNlGaKJPicRvB
 R3xnIpB5fuFQGP6TW8yir/1LQMQQOhKj8BY5hlxXF4LmdX0ed0e7hyHoDltaX0q5RuDp
 erpWYB+XoDbBpXSH0q9LvBUmw5qTQxg3Jvix17RlGgcc+lNgsaWubMHdfZHnCsu1T/pX
 5O6mXoMZNhKJA3ZvfNOgs1pchqK5yZfOqKl7K3gMgLgJdVCkbxi01ivcWHADWwAWUX0F
 gX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708539683; x=1709144483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lopfkfP/Wd4iBuj5Kqs/1syP004OyEXA8CH53rf8oR0=;
 b=rTz2EedPhPZjkLXs1iKhJ/C2dnYtNA/ACIRtGimEEVJCBN2oPXwdQaK1QmRxrIeHfc
 tw7wRVCRN2Ry2J4WUKnIE/7oCuUa6eu0ZEfSEQkGVMCOE2Cg9rc+Q4cJr6Rlnp9WmF5d
 JmldfpETDkpS5YtbMJsSgwKb2asXO+aSnJTbkV0M6EgVuzuDG8rCqEl+TEqkVm0DuqJf
 /54KGW2zbOIJAFP7h1XRV0pCkuu0x721c9Yzfn5kPhJ4ZQHYAvi5DcBiv0S0YmQFPRWW
 7pnJcNwPfX9+FXZaxLHzcmaOoZG9HI7TQDn/UPyYZdhWYm7JxsYIQmrLi6jxUFNYVuvd
 JALg==
X-Gm-Message-State: AOJu0Yy5wVPwVd1EP0002XBTQ/KcKcI6H72BbTtTbmlIxyTpsjUvgI7A
 mUbLiA3AmXMyHBnIQBsccu5UUYhy9I7dUF7rNiaLoeaAcfORoDPyDJVoNDbt
X-Google-Smtp-Source: AGHT+IGI8ZUHUmT+j5cQpkDxDF7pWt+w5yGxEq/geBFaBWFR/5DdTtSK+rbAurJexC4zeUi0z++sIQ==
X-Received: by 2002:a17:90a:f3cc:b0:29a:3bb5:7b91 with SMTP id
 ha12-20020a17090af3cc00b0029a3bb57b91mr601189pjb.2.1708539682849; 
 Wed, 21 Feb 2024 10:21:22 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:5692:7e41:13a2:69a])
 by smtp.gmail.com with ESMTPSA id
 cs16-20020a17090af51000b002992f49922csm9979009pjb.25.2024.02.21.10.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 10:21:22 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v4 10/10] hw/mem/cxl_type3: Add dpa range validation for
 accesses to DC regions
Date: Wed, 21 Feb 2024 10:16:03 -0800
Message-ID: <20240221182020.1086096-11-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221182020.1086096-1-nifan.cxl@gmail.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pg1-x52e.google.com
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
 hw/cxl/cxl-mailbox-utils.c  |  3 ++
 hw/mem/cxl_type3.c          | 82 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  7 ++++
 3 files changed, 92 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 34c4ebbd12..fd3be2f9cf 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1676,17 +1676,20 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
                 found = true;
                 cxl_remove_extent_from_extent_list(extent_list, ent);
                 ct3d->dc.total_extent_count -= 1;
+                ct3_clear_region_block_backed(ct3d, ent_start_dpa, ent_len);
 
                 if (len1) {
                     cxl_insert_extent_to_extent_list(extent_list,
                                                      ent_start_dpa, len1,
                                                      NULL, 0);
                     ct3d->dc.total_extent_count += 1;
+                    ct3_set_region_block_backed(ct3d, ent_start_dpa, len1);
                 }
                 if (len2) {
                     cxl_insert_extent_to_extent_list(extent_list, dpa + len,
                                                      len2, NULL, 0);
                     ct3d->dc.total_extent_count += 1;
+                    ct3_set_region_block_backed(ct3d, dpa + len, len2);
                 }
                 break;
                 /*Currently we reject the attempt to remove a superset*/
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b8c4273e99..a56906db25 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -660,6 +660,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
 
         region_base += region->len;
         ct3d->dc.total_capacity += region->len;
+        region->blk_bitmap = bitmap_new(region->len / region->block_size);
     }
     QTAILQ_INIT(&ct3d->dc.extents);
     QTAILQ_INIT(&ct3d->dc.extents_pending_to_add);
@@ -667,6 +668,17 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
     return true;
 }
 
+static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
+{
+    int i;
+    struct CXLDCDRegion *region;
+
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        g_free(region->blk_bitmap);
+    }
+}
+
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
@@ -860,6 +872,7 @@ err_free_special_ops:
     g_free(regs->special_ops);
 err_address_space_free:
     if (ct3d->dc.host_dc) {
+        cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
     }
     if (ct3d->hostpmem) {
@@ -881,6 +894,7 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     g_free(regs->special_ops);
     if (ct3d->dc.host_dc) {
+        cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
     }
     if (ct3d->hostpmem) {
@@ -891,6 +905,70 @@ static void ct3_exit(PCIDevice *pci_dev)
     }
 }
 
+/*
+ * Mark the DPA range [dpa, dap + len) to be backed and accessible. This
+ * happens when a DC extent is added and accepted by the host.
+ */
+void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                 uint64_t len)
+{
+    CXLDCDRegion *region;
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
+    CXLDCDRegion *region;
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
+    CXLDCDRegion *region;
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
@@ -996,6 +1074,10 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
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
index 1d31164bd3..10f0389b50 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -450,6 +450,7 @@ typedef struct CXLDCDRegion {
     uint64_t block_size;
     uint32_t dsmadhandle;
     uint8_t flags;
+    unsigned long *blk_bitmap;
 } CXLDCDRegion;
 
 struct CXLType3Dev {
@@ -557,4 +558,10 @@ void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
                                       uint8_t *tag,
                                       uint16_t shared_seq);
 bool test_any_bits_set(const unsigned long *addr, int nr, int size);
+void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                 uint64_t len);
+void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                   uint64_t len);
+bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                  uint64_t len);
 #endif
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9C3C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 19:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhEFG-0005sK-R8; Mon, 04 Mar 2024 14:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhEEl-0005XY-IK
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:36 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhEEj-0006yG-Na
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:35 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-dc238cb1b17so5221363276.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 11:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709581471; x=1710186271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=283fafKoCAhZyon638Mj48RQ1VuKIm6CVjiYXSW1c5Y=;
 b=SuzMFmzlEkvDTt/LOSPaTMBG7QDpwl1W4rbbUnitwLHJ54Iw5yBwrGwqB9lAMqi6PY
 ptiTUDUXuv/nrkN+Swx24fJcFlFeV2opWnOxrfk57KwT9tWHQsEFpn4AdOicFdOsnOHQ
 tM9Zrzm0P5ZmAull+5v649I6EYjTZXXHNYsOAw9F8+L/TeuwI/UhCt46S4/djyPPi2CI
 EgNXc/QZ1hJ3v1ZTPbINtfWue2WBpA/YeaVEyZXcvlirIkVgJdNTyyqfB7gcm/0XvpLD
 0L13PRZK9iSsEjAbi96S+aXCOlqYmDAYbVPvtKYIMqpqh4VeKShzz13yFUrag+0uuy84
 d9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709581471; x=1710186271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=283fafKoCAhZyon638Mj48RQ1VuKIm6CVjiYXSW1c5Y=;
 b=HJDV3f8n1G0YVUiAtZ0bxVJIj2mNlxXC2n9UFUlvN0WGf0IXQdE5KqAdzF2DgM0fuB
 DPtzGLsnUMgwkgBGOa8RbJK+G73cqw0AnWO8M06jfgkuX2SXVdyos/f7qWryI7PmDhCC
 E2qwPtB8hgOBsD7qvOWvGASZe9KG4nlfyX/WghcQmkTfGQtf8u3YP40fzeJqPH3Doozo
 923USUcZYJgpnK59GOa7zSyO7Opf6D3M0Te//tMzTYRnN14sU+8A8Ew5cN16AKf1xgfu
 YHoUoqw4udpOLq4QU6l4B1GHLLFtmXKWErD72oBTlhddpobTMc6ty1V72AYBACYnVgXa
 4L4Q==
X-Gm-Message-State: AOJu0YxYL5fCDZigbpt3KbBP2Xhp8Ui+0MDhv/omRLjscF9B8pCJHFg4
 YKlcnlj70Yt4xGzxwohLTgITdhSq1zBjVPPNr9FD5AUuQmS+J/t6EOqwP0/Q
X-Google-Smtp-Source: AGHT+IFK+f2/iwwB2tpKeab2vQ3PeNmoLam8Uf4HcS3wFtyitfX3H5sfkoJ3VHSCHggO5FT0xZVaWw==
X-Received: by 2002:a25:7412:0:b0:dcc:79ab:e51a with SMTP id
 p18-20020a257412000000b00dcc79abe51amr8056756ybc.57.1709581471312; 
 Mon, 04 Mar 2024 11:44:31 -0800 (PST)
Received: from localhost.localdomain ([50.205.20.42])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a255f41000000b00dc62edd58dasm2282646ybm.40.2024.03.04.11.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 11:44:31 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v5 11/13] hw/cxl/cxl-mailbox-utils: Add partial and superset
 extent release mailbox support
Date: Mon,  4 Mar 2024 11:34:06 -0800
Message-ID: <20240304194331.1586191-12-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304194331.1586191-1-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb2a.google.com
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

With the change, we extend the extent release mailbox command processing
to allow more flexible release. As long as the DPA range of the extent to
release is covered by valid extent(s) in the device, the release can be
performed.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 211 +++++++++++++++++++++++++++++++++----
 1 file changed, 188 insertions(+), 23 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index b538297bb5..eaff5c4c93 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1617,6 +1617,155 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * Return value: the id of the DC region that covers the DPA range
+ * [dpa, dpa+len) The assumption is that the range is valid and within
+ * a DC region.
+ */
+static uint8_t cxl_find_dc_region_id(const CXLType3Dev *ct3d, uint64_t dpa,
+                                     uint64_t len)
+{
+    int i;
+    const CXLDCRegion *region;
+
+    for (i = ct3d->dc.num_regions - 1; i >= 0; i--) {
+        region = &ct3d->dc.regions[i];
+        if (dpa >= region->base) {
+            break;
+        }
+    }
+    return i;
+}
+
+/*
+ * Copy extent list from src to dst
+ * Return value: number of extents copied
+ */
+static uint32_t copy_extent_list(CXLDCExtentList *dst,
+                                 const CXLDCExtentList *src)
+{
+    uint32_t cnt = 0;
+    CXLDCExtent *ent;
+
+    if (!dst || !src) {
+        return 0;
+    }
+
+    QTAILQ_FOREACH(ent, src, node) {
+        cxl_insert_extent_to_extent_list(dst, ent->start_dpa, ent->len,
+                                         ent->tag, ent->shared_seq);
+        cnt++;
+    }
+    return cnt;
+}
+
+/*
+ * Detect potential extent overflow caused by extent split during processing
+ * extent release requests, also allow releasing superset of extents where the
+ * extent to release covers the range of multiple extents in the device.
+ * Note:
+ * 1.we will reject releasing an extent if some portion of its rang is
+ * not covered by valid extents.
+ * 2.This function is called after cxl_detect_malformed_extent_list so checks
+ * already performed there will be skipped.
+ */
+static CXLRetCode cxl_detect_extent_overflow(const CXLType3Dev *ct3d,
+        const CXLUpdateDCExtentListInPl *in)
+{
+    uint64_t nbits, offset;
+    const CXLDCRegion *region;
+    unsigned long **bitmaps_copied;
+    uint64_t dpa, len;
+    int i, rid;
+    CXLRetCode ret = CXL_MBOX_SUCCESS;
+    long extent_cnt_delta = 0;
+    CXLDCExtentList tmp_list;
+    CXLDCExtent *ent;
+
+    QTAILQ_INIT(&tmp_list);
+    copy_extent_list(&tmp_list, &ct3d->dc.extents);
+
+    bitmaps_copied = g_new0(unsigned long *, ct3d->dc.num_regions);
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        nbits = region->len / region->block_size;
+        bitmaps_copied[i] = bitmap_new(nbits);
+        bitmap_copy(bitmaps_copied[i], region->blk_bitmap, nbits);
+    }
+
+    for (i = 0; i < in->num_entries_updated; i++) {
+        dpa = in->updated_entries[i].start_dpa;
+        len = in->updated_entries[i].len;
+
+        rid = cxl_find_dc_region_id(ct3d, dpa, len);
+        region = &ct3d->dc.regions[rid];
+        offset = (dpa - region->base) / region->block_size;
+        nbits = len / region->block_size;
+
+        /* Check whether range [dpa, dpa + len) is covered by valid range */
+        if (find_next_zero_bit(bitmaps_copied[rid], offset + nbits, offset) <
+                               offset + nbits) {
+            ret = CXL_MBOX_INVALID_PA;
+            goto free_and_exit;
+        }
+
+        QTAILQ_FOREACH(ent, &tmp_list, node) {
+            /* Only split within an extent can cause extent count increase */
+            if (ent->start_dpa <= dpa &&
+                dpa + len <= ent->start_dpa + ent->len) {
+                uint64_t ent_start_dpa = ent->start_dpa;
+                uint64_t ent_len = ent->len;
+                uint64_t len1 = dpa - ent_start_dpa;
+                uint64_t len2 = ent_start_dpa + ent_len - dpa - len;
+
+                extent_cnt_delta += len1 && len2 ? 2 : (len1 || len2 ? 1 : 0);
+                extent_cnt_delta -= 1;
+                if (ct3d->dc.total_extent_count + extent_cnt_delta >
+                    CXL_NUM_EXTENTS_SUPPORTED) {
+                    ret = CXL_MBOX_RESOURCES_EXHAUSTED;
+                    goto free_and_exit;
+                }
+
+                offset = (ent->start_dpa - region->base) / region->block_size;
+                nbits = ent->len / region->block_size;
+                bitmap_clear(bitmaps_copied[rid], offset, nbits);
+                cxl_remove_extent_from_extent_list(&tmp_list, ent);
+
+                 if (len1) {
+                    offset = (dpa - region->base) / region->block_size;
+                    nbits = len1 / region->block_size;
+                    bitmap_set(bitmaps_copied[rid], offset, nbits);
+                    cxl_insert_extent_to_extent_list(&tmp_list,
+                                                     ent_start_dpa, len1,
+                                                     NULL, 0);
+                 }
+
+                 if (len2) {
+                    offset = (dpa + len - region->base) / region->block_size;
+                    nbits = len2 / region->block_size;
+                    bitmap_set(bitmaps_copied[rid], offset, nbits);
+                    cxl_insert_extent_to_extent_list(&tmp_list, dpa + len,
+                                                     len2, NULL, 0);
+                 }
+                 break;
+             }
+         }
+    }
+
+free_and_exit:
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        g_free(bitmaps_copied[i]);
+    }
+    g_free(bitmaps_copied);
+
+    while (!QTAILQ_EMPTY(&tmp_list)) {
+        ent = QTAILQ_FIRST(&tmp_list);
+        cxl_remove_extent_from_extent_list(&tmp_list, ent);
+    }
+
+    return ret;
+}
+
 /*
  * CXL r3.1 section 8.2.9.9.9.4: Release Dynamic Capacity (Opcode 4803h)
  */
@@ -1644,15 +1793,28 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
         return ret;
     }
 
-    for (i = 0; i < in->num_entries_updated; i++) {
-        bool found = false;
+    ret = cxl_detect_extent_overflow(ct3d, in);
+    if (ret != CXL_MBOX_SUCCESS) {
+        return ret;
+    }
 
+    /*
+     * After this point, it is guaranteed that the extents in the
+     * updated extent list to release is valid, that means:
+     * 1. All extents in the list have no overlaps;
+     * 2. Each extent belongs to a valid DC region;
+     * 3. The DPA range of each extent is covered by valid extent
+     * in the device.
+     */
+    for (i = 0; i < in->num_entries_updated; i++) {
         dpa = in->updated_entries[i].start_dpa;
         len = in->updated_entries[i].len;
 
+process_leftover:
         QTAILQ_FOREACH(ent, extent_list, node) {
             /* Found the extent overlapping with */
             if (ent->start_dpa <= dpa && dpa < ent->start_dpa + ent->len) {
+                /* Case 1: The to-release extent is subset of ent */
                 if (dpa + len <= ent->start_dpa + ent->len) {
                     /*
                      * The incoming extent covers a portion of an extent
@@ -1669,17 +1831,6 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
                     uint64_t len1 = dpa - ent_start_dpa;
                     uint64_t len2 = ent_start_dpa + ent_len - dpa - len;
 
-                    /*
-                     * TODO: checking for possible extent overflow, will be
-                     * moved into a dedicated function of detecting extent
-                     * overflow.
-                     */
-                    if (len1 && len2 && ct3d->dc.total_extent_count ==
-                        CXL_NUM_EXTENTS_SUPPORTED) {
-                        return CXL_MBOX_RESOURCES_EXHAUSTED;
-                    }
-
-                    found = true;
                     cxl_remove_extent_from_extent_list(extent_list, ent);
                     ct3d->dc.total_extent_count -= 1;
                     ct3_clear_region_block_backed(ct3d, ent_start_dpa, ent_len);
@@ -1700,20 +1851,34 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
                     break;
                 } else {
                     /*
-                     * TODO: we reject the attempt to remove an extent that
-                     * overlaps with multiple extents in the device for now,
-                     * once the bitmap indicating whether a DPA range is
-                     * covered by valid extents is introduced, will allow it.
+                     * Case 2: the to-release extent overlaps with multiple
+                     * extents, including the superset case
                      */
-                    return CXL_MBOX_INVALID_PA;
+                    uint64_t ent_start_dpa = ent->start_dpa;
+                    uint64_t ent_len = ent->len;
+                    uint64_t len1 = dpa - ent_start_dpa;
+
+                    cxl_remove_extent_from_extent_list(extent_list, ent);
+                    ct3d->dc.total_extent_count -= 1;
+                    ct3_clear_region_block_backed(ct3d, ent_start_dpa, ent_len);
+
+                    if (len1) {
+                        cxl_insert_extent_to_extent_list(extent_list,
+                                                         ent_start_dpa, len1,
+                                                         NULL, 0);
+                        ct3d->dc.total_extent_count += 1;
+                        ct3_set_region_block_backed(ct3d, ent_start_dpa, len1);
+                    }
+                    /*
+                     * processing the portion of the range following current
+                     * extent
+                     */
+                    len = dpa + len - ent_start_dpa - ent_len;
+                    dpa = ent_start_dpa + ent_len;
+                    goto process_leftover;
                 }
             }
         }
-
-        if (!found) {
-            /* Try to remove a non-existing extent. */
-            return CXL_MBOX_INVALID_PA;
-        }
     }
 
     return CXL_MBOX_SUCCESS;
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFD8C54E49
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 19:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhEEs-0005Ym-CF; Mon, 04 Mar 2024 14:44:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhEEf-0005VT-Ea
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:29 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhEEd-0006xE-Bu
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:29 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dc23bf7e5aaso5404159276.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 11:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709581461; x=1710186261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nsJMpRBsiDoinCTIfmIF1KNqDp8uRG05Rbh+KLifL8w=;
 b=CpMLRzPOrDUM5ljvxsf++FHkHt5eYEFnXekmJecb1aRcy7sOUeKr0pglWskvq6i/Ol
 vavHNmeAD1VDloHmXR28pbk2UF9XwaeUsL0bwSGEA4wf8YJZXNNlIz9nivSUuWE4Oje8
 DUS/nkxRAxj5qeOXeCYNdufLIEkUJPAtW0Z5xAuYpfxfOGqDMWX37aKH4HOFM41p6f+2
 3QSPLn5OMKWw2leWHHzSdRU06fSWCJ9UUWU3OIYd8gjuEHvFJo54Uhiizdv89tjF0kk3
 kpx7gC5VErMNnQ8/dwMbkdggq7IaBA/HtGlRHooyy61gpmDfFXFyuo5BOA4Y8M90Tlkp
 rlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709581461; x=1710186261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nsJMpRBsiDoinCTIfmIF1KNqDp8uRG05Rbh+KLifL8w=;
 b=RiJ7ZGG9IZnAMHNsgID1enpz+CYNAZNTJCey+GbK8W2Cd5pUHqeXrW1iuaIRoyvI/6
 d72UqLtX6+F7vVywsHs2KDDWR7y6uM9SVP5b5GtL0SlmXj2Tw8NBz5nNvRBTqRCaeowL
 iL2hujHW3tfFQpTE4zko8UYZ7b5xXnfVZF3dBFWGvGgjC3mu+4zvfJyRfSLjNR8y99AP
 AO5fO9AJd9jYStuoWchdXF/b6HuEHMWM6wsWfdJWNpRM4oUJgA9Z2PPHmKnJyw2AiobQ
 4GpoEnrWBHx974/fn4etRzKOcosaas/jQTRafD+TW8iaI7ilVxOoC4M3XgGFAzkJCLKu
 xnmw==
X-Gm-Message-State: AOJu0Yw0nL0M+gKOs+aB6dyg0KSYclRbPpz238Z1YPQpXVO8AaPcQAz0
 06RRV6p5gsOvObuSh52iFO6sQLdSdp4oODm4AeBnToLH6uWq1q9N86dr7T0U
X-Google-Smtp-Source: AGHT+IEywjb671TDLGTuxKZsMTEqBabdGbzhbtW53K0+2HFJPtOshNZi3a6jONCN9Wy4Ur+BDkvDlw==
X-Received: by 2002:a05:6902:1890:b0:dcd:49d0:eece with SMTP id
 cj16-20020a056902189000b00dcd49d0eecemr9446480ybb.60.1709581461549; 
 Mon, 04 Mar 2024 11:44:21 -0800 (PST)
Received: from localhost.localdomain ([50.205.20.42])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a255f41000000b00dc62edd58dasm2282646ybm.40.2024.03.04.11.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 11:44:21 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v5 08/13] hw/cxl/cxl-mailbox-utils: Add mailbox commands to
 support add/release dynamic capacity response
Date: Mon,  4 Mar 2024 11:34:03 -0800
Message-ID: <20240304194331.1586191-9-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304194331.1586191-1-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb32.google.com
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

Per CXL spec 3.1, two mailbox commands are implemented:
Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.9.9.3, and
Release Dynamic Capacity (Opcode 4803h) 8.2.9.9.9.4.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 310 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  12 ++
 include/hw/cxl/cxl_device.h |   4 +
 3 files changed, 326 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 425b378a2c..8c59635a9f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -85,6 +85,8 @@ enum {
     DCD_CONFIG  = 0x48,
         #define GET_DC_CONFIG          0x0
         #define GET_DYN_CAP_EXT_LIST   0x1
+        #define ADD_DYN_CAP_RSP        0x2
+        #define RELEASE_DYN_CAP        0x3
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
@@ -1399,6 +1401,308 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * Check whether any bit between addr[nr, nr+size) is set,
+ * return true if any bit is set, otherwise return false
+ */
+static bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
+                              unsigned long size)
+{
+    unsigned long res = find_next_bit(addr, size + nr, nr);
+
+    return res < nr + size;
+}
+
+CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len)
+{
+    int i;
+    CXLDCRegion *region = &ct3d->dc.regions[0];
+
+    if (dpa < region->base ||
+        dpa >= region->base + ct3d->dc.total_capacity) {
+        return NULL;
+    }
+
+    /*
+     * CXL r3.1 section 9.13.3: Dynamic Capacity Device (DCD)
+     *
+     * Regions are used in increasing-DPA order, with Region 0 being used for
+     * the lowest DPA of Dynamic Capacity and Region 7 for the highest DPA.
+     * So check from the last region to find where the dpa belongs. Extents that
+     * cross multiple regions are not allowed.
+     */
+    for (i = ct3d->dc.num_regions - 1; i >= 0; i--) {
+        region = &ct3d->dc.regions[i];
+        if (dpa >= region->base) {
+            if (dpa + len > region->base + region->len) {
+                return NULL;
+            }
+            return region;
+        }
+    }
+
+    return NULL;
+}
+
+static void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
+                                             uint64_t dpa,
+                                             uint64_t len,
+                                             uint8_t *tag,
+                                             uint16_t shared_seq)
+{
+    CXLDCExtent *extent;
+
+    extent = g_new0(CXLDCExtent, 1);
+    extent->start_dpa = dpa;
+    extent->len = len;
+    if (tag) {
+        memcpy(extent->tag, tag, 0x10);
+    }
+    extent->shared_seq = shared_seq;
+
+    QTAILQ_INSERT_TAIL(list, extent, node);
+}
+
+void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
+                                        CXLDCExtent *extent)
+{
+    QTAILQ_REMOVE(list, extent, node);
+    g_free(extent);
+}
+
+/*
+ * CXL r3.1 Table 8-168: Add Dynamic Capacity Response Input Payload
+ * CXL r3.1 Table 8-170: Release Dynamic Capacity Input Payload
+ */
+typedef struct CXLUpdateDCExtentListInPl {
+    uint32_t num_entries_updated;
+    uint8_t flags;
+    uint8_t rsvd[3];
+    /* CXL r3.1 Table 8-169: Updated Extent */
+    struct {
+        uint64_t start_dpa;
+        uint64_t len;
+        uint8_t rsvd[8];
+    } QEMU_PACKED updated_entries[];
+} QEMU_PACKED CXLUpdateDCExtentListInPl;
+
+/*
+ * For the extents in the extent list to operate, check whether they are valid
+ * 1. The extent should be in the range of a valid DC region;
+ * 2. The extent should not cross multiple regions;
+ * 3. The start DPA and the length of the extent should align with the block
+ * size of the region;
+ * 4. The address range of multiple extents in the list should not overlap.
+ */
+static CXLRetCode cxl_detect_malformed_extent_list(CXLType3Dev *ct3d,
+        const CXLUpdateDCExtentListInPl *in)
+{
+    uint64_t min_block_size = UINT64_MAX;
+    CXLDCRegion *region = &ct3d->dc.regions[0];
+    CXLDCRegion *lastregion = &ct3d->dc.regions[ct3d->dc.num_regions - 1];
+    g_autofree unsigned long *blk_bitmap = NULL;
+    uint64_t dpa, len;
+    uint32_t i;
+
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        min_block_size = MIN(min_block_size, region->block_size);
+    }
+
+    blk_bitmap = bitmap_new((lastregion->base + lastregion->len -
+                             ct3d->dc.regions[0].base) / min_block_size);
+
+    for (i = 0; i < in->num_entries_updated; i++) {
+        dpa = in->updated_entries[i].start_dpa;
+        len = in->updated_entries[i].len;
+
+        region = cxl_find_dc_region(ct3d, dpa, len);
+        if (!region) {
+            return CXL_MBOX_INVALID_PA;
+        }
+
+        dpa -= ct3d->dc.regions[0].base;
+        if (dpa % region->block_size || len % region->block_size) {
+            return CXL_MBOX_INVALID_EXTENT_LIST;
+        }
+        /* the dpa range already covered by some other extents in the list */
+        if (test_any_bits_set(blk_bitmap, dpa / min_block_size,
+            len / min_block_size)) {
+            return CXL_MBOX_INVALID_EXTENT_LIST;
+        }
+        bitmap_set(blk_bitmap, dpa / min_block_size, len / min_block_size);
+   }
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/*
+ * CXL r3.1 section 8.2.9.9.9.3: Add Dynamic Capacity Response (Opcode 4802h)
+ * An extent is added to the extent list and becomes usable only after the
+ * response is processed successfully
+ */
+static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
+                                          uint8_t *payload_in,
+                                          size_t len_in,
+                                          uint8_t *payload_out,
+                                          size_t *len_out,
+                                          CXLCCI *cci)
+{
+    CXLUpdateDCExtentListInPl *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDCExtentList *extent_list = &ct3d->dc.extents;
+    CXLDCExtent *ent;
+    uint32_t i;
+    uint64_t dpa, len;
+    CXLRetCode ret;
+
+    if (in->num_entries_updated == 0) {
+        return CXL_MBOX_SUCCESS;
+    }
+
+    /* Adding extents causes exceeding device's extent tracking ability. */
+    if (in->num_entries_updated + ct3d->dc.total_extent_count >
+        CXL_NUM_EXTENTS_SUPPORTED) {
+        return CXL_MBOX_RESOURCES_EXHAUSTED;
+    }
+
+    ret = cxl_detect_malformed_extent_list(ct3d, in);
+    if (ret != CXL_MBOX_SUCCESS) {
+        return ret;
+    }
+
+    for (i = 0; i < in->num_entries_updated; i++) {
+        dpa = in->updated_entries[i].start_dpa;
+        len = in->updated_entries[i].len;
+
+        /*
+         * Check if the DPA range of the to-be-added extent overlaps with
+         * existing extent list maintained by the device.
+         */
+        QTAILQ_FOREACH(ent, extent_list, node) {
+            if (ent->start_dpa <= dpa &&
+                    dpa + len <= ent->start_dpa + ent->len) {
+                return CXL_MBOX_INVALID_PA;
+            /* Overlapping one end of the other */
+            } else if ((dpa < ent->start_dpa + ent->len &&
+                        dpa + len > ent->start_dpa + ent->len) ||
+                       (dpa < ent->start_dpa && dpa + len > ent->start_dpa)) {
+                return CXL_MBOX_INVALID_PA;
+            }
+        }
+
+        /*
+         * TODO: we will add a pending extent list based on event log record
+         * and verify the input response; also, the "More" flag is not
+         * considered at the moment.
+         */
+
+        cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
+        ct3d->dc.total_extent_count += 1;
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/*
+ * CXL r3.1 section 8.2.9.9.9.4: Release Dynamic Capacity (Opcode 4803h)
+ */
+static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
+                                          uint8_t *payload_in,
+                                          size_t len_in,
+                                          uint8_t *payload_out,
+                                          size_t *len_out,
+                                          CXLCCI *cci)
+{
+    CXLUpdateDCExtentListInPl *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDCExtentList *extent_list = &ct3d->dc.extents;
+    CXLDCExtent *ent;
+    uint32_t i;
+    uint64_t dpa, len;
+    CXLRetCode ret;
+
+    if (in->num_entries_updated == 0) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    ret = cxl_detect_malformed_extent_list(ct3d, in);
+    if (ret != CXL_MBOX_SUCCESS) {
+        return ret;
+    }
+
+    for (i = 0; i < in->num_entries_updated; i++) {
+        bool found = false;
+
+        dpa = in->updated_entries[i].start_dpa;
+        len = in->updated_entries[i].len;
+
+        QTAILQ_FOREACH(ent, extent_list, node) {
+            /* Found the extent overlapping with */
+            if (ent->start_dpa <= dpa && dpa < ent->start_dpa + ent->len) {
+                if (dpa + len <= ent->start_dpa + ent->len) {
+                    /*
+                     * The incoming extent covers a portion of an extent
+                     * in the device extent list, remove only the overlapping
+                     * portion, meaning
+                     * 1. the portions that are not covered by the incoming
+                     *    extent at both end of the original extent will become
+                     *    new extents and inserted to the extent list; and
+                     * 2. the original extent is removed from the extent list;
+                     * 3. DC extent count is updated accordingly.
+                     */
+                    uint64_t ent_start_dpa = ent->start_dpa;
+                    uint64_t ent_len = ent->len;
+                    uint64_t len1 = dpa - ent_start_dpa;
+                    uint64_t len2 = ent_start_dpa + ent_len - dpa - len;
+
+                    /*
+                     * TODO: checking for possible extent overflow, will be
+                     * moved into a dedicated function of detecting extent
+                     * overflow.
+                     */
+                    if (len1 && len2 && ct3d->dc.total_extent_count ==
+                        CXL_NUM_EXTENTS_SUPPORTED) {
+                        return CXL_MBOX_RESOURCES_EXHAUSTED;
+                    }
+
+                    found = true;
+                    cxl_remove_extent_from_extent_list(extent_list, ent);
+                    ct3d->dc.total_extent_count -= 1;
+
+                    if (len1) {
+                        cxl_insert_extent_to_extent_list(extent_list,
+                                                         ent_start_dpa, len1,
+                                                         NULL, 0);
+                        ct3d->dc.total_extent_count += 1;
+                    }
+                    if (len2) {
+                        cxl_insert_extent_to_extent_list(extent_list, dpa + len,
+                                                         len2, NULL, 0);
+                        ct3d->dc.total_extent_count += 1;
+                    }
+                    break;
+                } else {
+                    /*
+                     * TODO: we reject the attempt to remove an extent that
+                     * overlaps with multiple extents in the device for now,
+                     * once the bitmap indicating whether a DPA range is
+                     * covered by valid extents is introduced, will allow it.
+                     */
+                    return CXL_MBOX_INVALID_PA;
+                }
+            }
+        }
+
+        if (!found) {
+            /* Try to remove a non-existing extent. */
+            return CXL_MBOX_INVALID_PA;
+        }
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1449,6 +1753,12 @@ static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
     [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
         "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
         8, 0 },
+    [DCD_CONFIG][ADD_DYN_CAP_RSP] = {
+        "DCD_ADD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
+        ~0, IMMEDIATE_DATA_CHANGE },
+    [DCD_CONFIG][RELEASE_DYN_CAP] = {
+        "DCD_RELEASE_DYNAMIC_CAPACITY", cmd_dcd_release_dyn_cap,
+        ~0, IMMEDIATE_DATA_CHANGE },
 };
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 102fa8151e..dccfaaad3a 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -678,6 +678,16 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
     return true;
 }
 
+static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
+{
+    CXLDCExtent *ent;
+
+    while (!QTAILQ_EMPTY(&ct3d->dc.extents)) {
+        ent = QTAILQ_FIRST(&ct3d->dc.extents);
+        cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
+    }
+}
+
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
@@ -874,6 +884,7 @@ err_free_special_ops:
     g_free(regs->special_ops);
 err_address_space_free:
     if (ct3d->dc.host_dc) {
+        cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
     }
     if (ct3d->hostpmem) {
@@ -895,6 +906,7 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     g_free(regs->special_ops);
     if (ct3d->dc.host_dc) {
+        cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
     }
     if (ct3d->hostpmem) {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 8148bcc34b..341260e6e4 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -547,4 +547,8 @@ void cxl_event_irq_assert(CXLType3Dev *ct3d);
 
 void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
 
+CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
+
+void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
+                                        CXLDCExtent *extent);
 #endif
-- 
2.43.0



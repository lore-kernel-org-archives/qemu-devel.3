Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E416C3ABBF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 00:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoyc-00061M-Ao; Wed, 07 May 2025 20:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoya-00060X-RX
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:19:00 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoyY-0006w7-W6
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:19:00 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736aa9d0f2aso577564b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 17:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746663537; x=1747268337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6yBJJKeNr6AER/b7GVBjWusRo2VXtW9qLVii1bSraWw=;
 b=NC1FK76wsP96b4NkcKWYelS+56DOZyjGuif+duJ7k8sl+gAzXMygcmUPREO0Yei/w5
 JJICM+6a3A4kHsvtOt5Z1V6Z2NjLFeLTGj2wSxunQkLIV/Rk36hCsV9SMzp7oNZJhmPp
 XtyArOlp8NbOXSfzvBxQcJhMgUW4MrQeIeRvxDM5hZ0cieGAYGI6mxFHWm7WckFgCUqj
 1bPzUQJD6mm5d/mXJfVjTs1KRjWL7h35r82lb300fr/d4ir5NAu3xNtdpYLzEZne77/J
 vpaV+EBZKQtnEJOwFTe76u+SdKsLX7Yr6OmxE/xH4DaLpTFNfqWFrg0FuaLxTUa4Sweh
 6k+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746663537; x=1747268337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6yBJJKeNr6AER/b7GVBjWusRo2VXtW9qLVii1bSraWw=;
 b=Jlj6pjB4jWOZADy7nNZWbSy9wW2Y8JmVDRItktYBi33u3IG2URgqLD7PbUyAQ+5eqC
 lZarEyVf0sywgWuzp8ZdK8pl9tVR7LxfqohmZmDM8HdI+Ht/GJiE2ZrDxblOSxb+LcvQ
 FKR/vsQumr2PTq69AOt+qJPyl08c0WstJOmWkqyHF5Ifv/wUJPU7RZPG7Q8QF3R8S5FG
 jPuJJOvOc5E/zovWubtFMoa15uJ8pY6sS69i5n95RKiCmRhBd/r+E9CXWKkZsJeyUqpm
 YBLlyilA0l/Z/wVQZLb9FrvCRYzPbA7X31mWmgMkPgWWqD+pQoPCmm1e6pVG1pVJoP1z
 2+Dw==
X-Gm-Message-State: AOJu0YyXJANekhKGIZQCRbr9psIzcTk193GmmB4WOSZ6+tGFXODqX1J4
 LmlJxR4JsNhBIpyU8i5JUJ1awmS2gGgEqFW+Z4JW7vOo4s4LBVYgr+7u4g==
X-Gm-Gg: ASbGncsQymaseHI1tOMpO40ZMz1jgufA/AL8TuCh69jlqJYv0+DIfpasiYzeo53kmaE
 GkuuCn/lpr4/GI1xfT3IEHDvB80jxV0plGjT86c1/455ElH2spYE9Gjk9tceMyeinexVgXyZz72
 F5S0EW9j0ISdvzRL2ahxLvNZlckO7S6N6w7n/NIGsif2QDC7QKUDPwiBVrkp/Pn6Ag1RJaBISpD
 SVfZ+WCVPblTmPdRswVlRnoo7v0qlcFu4r2jz02Of4a5l6/OywhYfmLNghAD0T7RQK0cFjCkc+7
 RLORfd/kpQVakRTkannJMmE/AJv2KFXGRjLF04kTfx2dlKyYHCIx1eRGxDn+2Q==
X-Google-Smtp-Source: AGHT+IHcHANQRb6/Xx6ktsCkHqFQJ/4FwioJ4Qo/bn6EIdS/+halZw2P0l4KxuAGm9KFyUykROv8ig==
X-Received: by 2002:a05:6a00:3cc1:b0:740:a52f:9652 with SMTP id
 d2e1a72fcca58-740a52f96d6mr3819670b3a.6.1746663537511; 
 Wed, 07 May 2025 17:18:57 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 17:18:57 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 09/10] cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
Date: Thu,  8 May 2025 00:01:05 +0000
Message-ID: <20250508001754.122180-10-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250508001754.122180-1-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Anisa Su <anisa.su@samsung.com>

FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 195 +++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c           |   8 +-
 include/hw/cxl/cxl_device.h  |   4 +
 include/hw/cxl/cxl_opcodes.h |   1 +
 4 files changed, 204 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a897a34ef9..9b176dea08 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3589,6 +3589,194 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static CXLRetCode cxl_mbox_dc_prescriptive_sanity_check(CXLType3Dev *dcd,
+                                                        uint16_t host_id,
+                                                        uint32_t ext_count,
+                                                        CXLDCExtentRaw extents[],
+                                                        CXLDCEventType type)
+{
+    CXLDCExtentRaw ext;
+    CXLDCRegion *reg = NULL;
+    int i, j;
+
+    if (host_id != 0) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    for (i = 0; i < ext_count; i++) {
+        ext = extents[i];
+
+        if (ext.len == 0) {
+            return CXL_MBOX_INVALID_EXTENT_LIST;
+        }
+
+        reg = cxl_find_dc_region(dcd, ext.start_dpa, ext.len);
+        if (!reg) {
+            return CXL_MBOX_INVALID_EXTENT_LIST;
+        }
+
+        if (ext.len % reg->block_size || ext.start_dpa % reg->block_size) {
+            return CXL_MBOX_INVALID_EXTENT_LIST;
+        }
+
+        /* Check requested extents do not overlap with each other. */
+        for (j = i + 1; j < ext_count; j++) {
+            if (ranges_overlap(ext.start_dpa, ext.len, extents[j].start_dpa,
+                               extents[j].len)) {
+                return CXL_MBOX_INVALID_EXTENT_LIST;
+            }
+        }
+
+        if (type == DC_EVENT_ADD_CAPACITY) {
+            /* Check requested extents do not overlap with pending extents. */
+            if (cxl_extent_groups_overlaps_dpa_range(&dcd->dc.extents_pending,
+                ext.start_dpa, ext.len)) {
+                return CXL_MBOX_INVALID_EXTENT_LIST;
+            }
+            /* Check requested extents do not overlap with existing extents. */
+            if (cxl_extents_overlaps_dpa_range(&dcd->dc.extents,
+                                               ext.start_dpa, ext.len)) {
+                return CXL_MBOX_INVALID_EXTENT_LIST;
+            }
+        }
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
+static int cxl_mbox_get_pending_ext_count(CXLType3Dev *ct3d)
+{
+    CXLDCExtentGroup *group;
+    CXLDCExtentList *list;
+    CXLDCExtent *ent;
+    int count = 0;
+
+    QTAILQ_FOREACH(group, &ct3d->dc.extents_pending, node) {
+        list = &group->list;
+        QTAILQ_FOREACH(ent, list, node) {
+            count++;
+        }
+    }
+
+    return count;
+}
+
+static int cxl_mbox_get_accepted_ext_count(CXLType3Dev *ct3d)
+{
+    CXLDCExtent *ent;
+    int count = 0;
+
+    QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
+        count++;
+    }
+
+    return count;
+}
+
+static void cxl_mbox_dc_add_to_pending(CXLType3Dev *ct3d,
+                                       uint32_t ext_count,
+                                       CXLDCExtentRaw extents[])
+{
+    CXLDCExtentGroup *group = NULL;
+    int i;
+
+    for (i = 0; i < ext_count; i++) {
+        group = cxl_insert_extent_to_extent_group(group,
+                                                  extents[i].start_dpa,
+                                                  extents[i].len,
+                                                  extents[i].tag,
+                                                  extents[i].shared_seq);
+    }
+
+    cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
+}
+
+static void cxl_mbox_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
+                                                         CXLDCEventType type,
+                                                         CXLDCExtentRaw extents[],
+                                                         uint32_t ext_count)
+{
+    CXLEventDynamicCapacity event_rec = {};
+    int i;
+
+    cxl_mbox_dc_event_create_record_hdr(ct3d, &event_rec.hdr);
+    event_rec.type = type;
+    event_rec.validity_flags = 1;
+    event_rec.host_id = 0;
+    event_rec.updated_region_id = 0;
+    event_rec.extents_avail = ct3d->dc.total_extent_count -
+                              cxl_mbox_get_accepted_ext_count(ct3d) -
+                              cxl_mbox_get_pending_ext_count(ct3d);
+
+    for (i = 0; i < ext_count; i++) {
+        memcpy(&event_rec.dynamic_capacity_extent,
+               &extents[i],
+               sizeof(CXLDCExtentRaw));
+        event_rec.flags = 0;
+        if (i < ext_count - 1) {
+            /* Set "More" flag */
+            event_rec.flags |= BIT(0);
+        }
+
+        if (cxl_event_insert(&ct3d->cxl_dstate,
+                             CXL_EVENT_TYPE_DYNAMIC_CAP,
+                             (CXLEventRecordRaw *)&event_rec)) {
+            cxl_event_irq_assert(ct3d);
+        }
+    }
+}
+
+/* CXL r3.2 Section 7.6.7.6.5 Initiate Dynamic Capacity Add (Opcode 5604h) */
+static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLCCI *cci)
+{
+    struct {
+        uint16_t host_id;
+        uint8_t selection_policy;
+        uint8_t reg_num;
+        uint64_t length;
+        uint8_t tag[0x10];
+        uint32_t ext_count;
+        CXLDCExtentRaw extents[];
+    } QEMU_PACKED *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    int rc;
+
+    switch (in->selection_policy) {
+    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
+        /* Adding extents exceeds device's extent tracking ability. */
+        if (in->ext_count + ct3d->dc.total_extent_count >
+            CXL_NUM_EXTENTS_SUPPORTED) {
+            return CXL_MBOX_RESOURCES_EXHAUSTED;
+        }
+        rc = cxl_mbox_dc_prescriptive_sanity_check(ct3d,
+                                                   in->host_id,
+                                                   in->ext_count,
+                                                   in->extents,
+                                                   DC_EVENT_ADD_CAPACITY);
+        if (rc) {
+            return rc;
+        }
+        cxl_mbox_dc_add_to_pending(ct3d, in->ext_count, in->extents);
+        cxl_mbox_create_dc_event_records_for_extents(ct3d,
+                                                     DC_EVENT_ADD_CAPACITY,
+                                                     in->extents,
+                                                     in->ext_count);
+
+        return CXL_MBOX_SUCCESS;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "CXL extent selection policy not supported.\n");
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3724,6 +3912,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
          CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
     [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
         cmd_fm_get_dc_region_extent_list, 12, 0 },
+    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
+        cmd_fm_initiate_dc_add, ~0,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+        CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
 };
 
 /*
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index edc29f1ccb..71fad3391c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1991,8 +1991,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
  * the list.
  * Return value: return true if has overlaps; otherwise, return false
  */
-static bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
-                                           uint64_t dpa, uint64_t len)
+bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
+                                    uint64_t dpa, uint64_t len)
 {
     CXLDCExtent *ent;
     Range range1, range2;
@@ -2037,8 +2037,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
     return false;
 }
 
-static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
-                                                 uint64_t dpa, uint64_t len)
+bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
+                                          uint64_t dpa, uint64_t len)
 {
     CXLDCExtentGroup *group;
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 22823e2054..93b6df0ccd 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -824,4 +824,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
 void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                              const QemuUUID *uuid, uint32_t flags,
                              uint8_t length, uint64_t timestamp);
+bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
+                                    uint64_t dpa, uint64_t len);
+bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
+                                          uint64_t dpa, uint64_t len);
 #endif
diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
index ad4e614daa..72ea0a7d44 100644
--- a/include/hw/cxl/cxl_opcodes.h
+++ b/include/hw/cxl/cxl_opcodes.h
@@ -66,5 +66,6 @@ enum {
         #define GET_HOST_DC_REGION_CONFIG 0x1
         #define SET_DC_REGION_CONFIG 0x2
         #define GET_DC_REGION_EXTENT_LIST 0x3
+        #define INITIATE_DC_ADD           0x4
     GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
 };
-- 
2.47.2



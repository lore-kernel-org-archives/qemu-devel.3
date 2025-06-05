Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1640C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 23:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNKES-0000Ow-Ss; Thu, 05 Jun 2025 19:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKER-0000Oe-Oy
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:42:47 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKEP-0004ho-IS
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:42:47 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-742c7a52e97so1418787b3a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 16:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749166964; x=1749771764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmYgqthAafUrm+FgbTfR2HFhLvifKWfJ9zq0wwfT9zg=;
 b=TaVyl/31SOJLzWHwwzThbCP9wDGdTQXKjJOn6K7Gd/df2MLOXqemYTje5ZPF7Q53YR
 rYkTYX8gy8VnzPC58RdyFSi75zAL/F5TRkgAgtuQ1MXOPtDBF6m+XkPmMv2/gEzR33U8
 SubfA/N6ixElhjhIQVg6+KaidLvF/FgJIO4tgVj2ghMx692QajaNbzic9ic3N+611rl3
 NpMEiTPMUuXhQYJ8GXp1LdzlhHByadK3PwUxR1NEtMA0A1wdfjlYEXOeiwMbRB8Zx77I
 ooI2YfpYDRI+x0ydD6elr9xt+5j0vifLXdGJMmBeMmpFOvAwWtSAnltcF8NXujmUthlS
 VoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749166964; x=1749771764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lmYgqthAafUrm+FgbTfR2HFhLvifKWfJ9zq0wwfT9zg=;
 b=rWnm+nNUpV4LrXPk75WdzQq46ooxwPrTKM3wEdZ+1407ukjz+EeVK6M1hxfeqdR1h2
 292tNlpdSg4dEvGSzx7/AkNOQ/f5VZoOl5RaezBHLjbzfunGHU2j/A84F+8iVxEdBdi4
 i54b5uO/fEEIbIdWIahi/5mZUuty+1YHogDVA9AGCsPmZNryPpGf6RRUL6/Zx9rQ6ZEq
 Fv9mizahTcQxBZNbPQVtd7iECLqKwtBHqzWl00xs4N3myjEhllMXwoEAGR5od6Fi9NPr
 Dk3OQDDQcWzFGgnWtSggjx2AQFJXCgK/8pwktqK0Y5b6ko7IUPG5xhlHMOI+3/R0mvoO
 eQpg==
X-Gm-Message-State: AOJu0YxKwqMjTAXR/brRWLaYjd5cJM5RYs+LTYSGhlFLsmrgKidJTyOT
 0gR6spivjCpJfamK4TcGDaIbDjJVwAodZgYrVu8nQdH9gshd8JzgmRBL12Amfw==
X-Gm-Gg: ASbGncuiSWHjKYX/TsAUC2wZzXvXQrY67ziSKSlzSMC+cvTh5xraLMvFwhPpWIqEahY
 R1rLE5xVUaTkbkaDq+4SoViigtBZNuxs7rVNwlbnvyYxl30KhltLyayqi8KijSv4ofzvQf0fcvt
 EMt8/PsezmYembtX8Jy6PmG8/NZ24KZep4So4duZ/fmHK/wnQnFI+tY9onKVUFEDbvzxLUdi1Sf
 q0PrYeyqHjRYghVgaBwWRt7GzYASBHwhiMNo60GmF9iVVjvf9UeOQ4Yev+6cW0k08KieuWdcw93
 MUQEdUcZPsd7XXNOUVqqHslz1YCQjEglxhEOi0jJFsQ2E0ccQlEQwpu13rcNOxK4+48rVhh0BXh
 yKamZdAA=
X-Google-Smtp-Source: AGHT+IG2AXUrLdKYm+w+oLI5Xhyn8vldI70vnD4Eyvy/E39PZh1aBoU5Sck6Nwr7WLv8E8I3Y0W+dw==
X-Received: by 2002:a05:6a20:2586:b0:1f3:2e85:c052 with SMTP id
 adf61e73a8af0-21ee32b637bmr1538957637.35.1749166964110; 
 Thu, 05 Jun 2025 16:42:44 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0847b9sm213916b3a.104.2025.06.05.16.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 16:42:43 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [QEMU PATCH v3 8/9] cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
Date: Thu,  5 Jun 2025 23:42:22 +0000
Message-ID: <20250605234227.970187-9-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605234227.970187-1-anisa.su887@gmail.com>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x433.google.com
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
 hw/cxl/cxl-mailbox-utils.c  | 152 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |   8 +-
 include/hw/cxl/cxl_device.h |   4 +
 3 files changed, 160 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 004e502b22..7ee5be00bc 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -123,6 +123,7 @@ enum {
         #define GET_HOST_DC_REGION_CONFIG   0x1
         #define SET_DC_REGION_CONFIG        0x2
         #define GET_DC_REGION_EXTENT_LIST   0x3
+        #define INITIATE_DC_ADD             0x4
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3540,6 +3541,150 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
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
+    ct3d->dc.total_extent_count += ext_count;
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
+    cxl_assign_event_header(&event_rec.hdr,
+                            &dynamic_capacity_uuid,
+                            (1 << CXL_EVENT_TYPE_INFO),
+                            sizeof(event_rec),
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+    event_rec.type = type;
+    event_rec.validity_flags = 1;
+    event_rec.host_id = 0;
+    event_rec.updated_region_id = 0;
+    event_rec.extents_avail = CXL_NUM_EXTENTS_SUPPORTED -
+                              ct3d->dc.total_extent_count;
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
+/*
+ * Helper function to convert CXLDCExtentRaw to CXLUpdateDCExtentListInPl
+ * in order to reuse cxl_detect_malformed_extent_list() functin which accepts
+ * CXLUpdateDCExtentListInPl as a parameter.
+ */
+static void convert_raw_extents(CXLDCExtentRaw raw_extents[],
+                                CXLUpdateDCExtentListInPl *extent_list,
+                                int count)
+{
+    int i;
+
+    extent_list->num_entries_updated = count;
+
+    for (i = 0; i < count; i++) {
+        extent_list->updated_entries[i].start_dpa = raw_extents[i].start_dpa;
+        extent_list->updated_entries[i].len = raw_extents[i].len;
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
+    CXLUpdateDCExtentListInPl *list;
+    int i, rc;
+
+    switch (in->selection_policy) {
+    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
+        /* Adding extents exceeds device's extent tracking ability. */
+        if (in->ext_count + ct3d->dc.total_extent_count >
+            CXL_NUM_EXTENTS_SUPPORTED) {
+            return CXL_MBOX_RESOURCES_EXHAUSTED;
+        }
+
+        list = calloc(1, (sizeof(*list) +
+                          in->ext_count * sizeof(*list->updated_entries)));
+        convert_raw_extents(in->extents, list, in->ext_count);
+        rc = cxl_detect_malformed_extent_list(ct3d, list);
+
+        for (i = 0; i < in->ext_count; i++) {
+            CXLDCExtentRaw ext = in->extents[i];
+             /* Check requested extents do not overlap with pending extents. */
+            if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
+                                                     ext.start_dpa, ext.len)) {
+                return CXL_MBOX_INVALID_EXTENT_LIST;
+            }
+            /* Check requested extents do not overlap with existing extents. */
+            if (cxl_extents_overlaps_dpa_range(&ct3d->dc.extents,
+                                               ext.start_dpa, ext.len)) {
+                return CXL_MBOX_INVALID_EXTENT_LIST;
+            }
+        }
+
+        if (rc) {
+            return rc;
+        }
+
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
@@ -3667,6 +3812,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
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
index ee554a77be..ca9fe89e4f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1885,8 +1885,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
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
@@ -1931,8 +1931,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
     return false;
 }
 
-static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
-                                                 uint64_t dpa, uint64_t len)
+bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
+                                          uint64_t dpa, uint64_t len)
 {
     CXLDCExtentGroup *group;
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 76af75d2d0..d30f6503fa 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -724,4 +724,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
 void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                              const QemuUUID *uuid, uint32_t flags,
                              uint8_t length, uint64_t timestamp);
+bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
+                                    uint64_t dpa, uint64_t len);
+bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
+                                          uint64_t dpa, uint64_t len);
 #endif
-- 
2.47.2



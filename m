Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C66C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSMb-0003xT-CD; Mon, 14 Jul 2025 19:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJd-00064O-TV
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJb-0006Fk-Ft
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wWulbcsLNYze0iJnyHnRhlgI1t/NH3pKfYFfwzuX2pU=;
 b=eW+JhZ6yeox1oyxqMt9b/hHVsYDnkwzI67oQktbD/llgkxbrQrgadzTd9IUuKjhaLDmueP
 ohYjbP9QfibPT3yLQo6x+Qn5Czwjdzyl4F2tbUwsD9fmTsMYna0Lbz3JNegWRKmcVWmMwu
 QeBb5nnGYGx98y2toJPW+8yxQiRYK+Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-1Mw96gHhPIyipgNPL0FEvQ-1; Mon, 14 Jul 2025 19:10:29 -0400
X-MC-Unique: 1Mw96gHhPIyipgNPL0FEvQ-1
X-Mimecast-MFC-AGG-ID: 1Mw96gHhPIyipgNPL0FEvQ_1752534629
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b5f97cb8fbso812066f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534628; x=1753139428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWulbcsLNYze0iJnyHnRhlgI1t/NH3pKfYFfwzuX2pU=;
 b=r8AL+LSe5y3bR2agxaTUDJwHmOs01OXGoYxcVGghdLGSUz9nL9XZ8SiPKSs01aHhag
 4npYZNzC8pAQQYn77zps1erpVpZ9pGDBn0ArK8o5K7cjqhNyvCkmXw3IsXAYxRWoydV7
 Nj8/als49m8pre1GMMKrCrz8k8dmzRlLhzvvs38nwfikkNcpLVadIwpNU2ZrhLHTuEGZ
 GYWal8UHcfNH0h4Sm1tmY5H7JWo496LhvG7v7x0PJetgYDnPPh7T9WZg+qAb2Qsw3/QT
 YkRgURzXqCbn+F3dDfuLHCjBPlJwXSLm5KXB52snGtk/ep2FUxvPiIsBUWODL9cAwfqo
 Isqw==
X-Gm-Message-State: AOJu0Yz/fJt7uIWip62nwmH41MvVpiPQj41gF55xtxDMyYBEFn29NdPE
 43ztVYHSdEoiKsrO1TEC/pQrY/kVTajuzMCWWZmfJkWGOJGwBKr3Tmxx5vsVpuN8GPplh038UJ7
 +oCZUNAV7Ii8WBP6W5dXw/AyaZqyhwYklJ2IaD02R9QVmqoq9mKK/4bhVGP8BIPYkfoV0vgPH7R
 c374BUEunAfEPL0iWD5PbjBoCcXv9WHQUPAA==
X-Gm-Gg: ASbGnctQf7nSRoZ8ZaT4WRhKwI1SEuWAqfltgi/ScMPhNhVfWQNheTFykdAbIZrx/Su
 w4H4gB2/xi2n/e0i+SLox9wcWr3fTBROQ8jXpExBGUA/svy7cMHcvAONy3oqFO167qv4M11mn1v
 vRn8Xo4MErHf6EmKUmbrrznmtKdsuQhGU2OUgJODWC5AW36iLew7O39v0nODgMCC4TP50vkHIet
 ImxgBR5sVR4NpB+wan5JOUkvzGa0kVo0HHpTtoP8nCYXG6o1R3Z9e9L3feRSqwv/Cpxr2Ve9/9w
 e8Ppqf6gMK+BTKTIX1Ucq/eSmG/RVafi
X-Received: by 2002:a05:6000:21c9:b0:3b2:dfc6:2485 with SMTP id
 ffacd0b85a97d-3b5f187ebcfmr8505729f8f.4.1752534628193; 
 Mon, 14 Jul 2025 16:10:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkEBZ0u2GhYpNE1Zf5Uge7wmDwldIkufdqpycCefw6vCa9qQ27LmpHF2/WM4pZXa1GCeunIQ==
X-Received: by 2002:a05:6000:21c9:b0:3b2:dfc6:2485 with SMTP id
 ffacd0b85a97d-3b5f187ebcfmr8505710f8f.4.1752534627740; 
 Mon, 14 Jul 2025 16:10:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e14d07sm13733255f8f.66.2025.07.14.16.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:10:27 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:10:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Anisa Su <anisa.su@samsung.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 96/97] hw/cxl: mailbox-utils: 0x5604 - FMAPI Initiate DC Add
Message-ID: <bda33df370d4430885eabf21d4c0de5ecd5a209c.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250714174509.1984430-11-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |   4 ++
 hw/cxl/cxl-mailbox-utils.c  | 109 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |   8 +--
 3 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 71a5834c3d..89411c8093 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -728,4 +728,8 @@ void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
                                              CXLDCEventType type,
                                              CXLDCExtentRaw extents[],
                                              uint32_t ext_count);
+bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
+                                    uint64_t dpa, uint64_t len);
+bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
+                                          uint64_t dpa, uint64_t len);
 #endif
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index b6f30e8689..5d08525529 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -123,6 +123,7 @@ enum {
         #define GET_HOST_DC_REGION_CONFIG   0x1
         #define SET_DC_REGION_CONFIG        0x2
         #define GET_DC_REGION_EXTENT_LIST   0x3
+        #define INITIATE_DC_ADD             0x4
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3543,6 +3544,107 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * Helper function to convert CXLDCExtentRaw to CXLUpdateDCExtentListInPl
+ * in order to reuse cxl_detect_malformed_extent_list() function which accepts
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
+/* CXL r3.2 Section 7.6.7.6.5: Initiate Dynamic Capacity Add (Opcode 5604h) */
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
+    int i, rc;
+
+    switch (in->selection_policy) {
+        case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE: {
+            /* Adding extents exceeds device's extent tracking ability. */
+            if (in->ext_count + ct3d->dc.total_extent_count >
+                CXL_NUM_EXTENTS_SUPPORTED) {
+                return CXL_MBOX_RESOURCES_EXHAUSTED;
+            }
+
+            g_autofree CXLUpdateDCExtentListInPl *list =
+                g_malloc0(sizeof(*list) +
+                    in->ext_count * sizeof(*list->updated_entries));
+
+            convert_raw_extents(in->extents, list, in->ext_count);
+            rc = cxl_detect_malformed_extent_list(ct3d, list);
+
+            for (i = 0; i < in->ext_count; i++) {
+                CXLDCExtentRaw *ext = &in->extents[i];
+
+                /* Check requested extents do not overlap with pending ones. */
+                if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
+                                                         ext->start_dpa,
+                                                         ext->len)) {
+                    return CXL_MBOX_INVALID_EXTENT_LIST;
+                }
+                /* Check requested extents do not overlap with existing ones. */
+                if (cxl_extents_overlaps_dpa_range(&ct3d->dc.extents,
+                                                   ext->start_dpa,
+                                                   ext->len)) {
+                    return CXL_MBOX_INVALID_EXTENT_LIST;
+                }
+            }
+
+            if (rc) {
+                return rc;
+            }
+
+            CXLDCExtentGroup *group = NULL;
+            for (i = 0; i < in->ext_count; i++) {
+                CXLDCExtentRaw *ext = &in->extents[i];
+
+                group = cxl_insert_extent_to_extent_group(group, ext->start_dpa,
+                                                          ext->len, ext->tag,
+                                                          ext->shared_seq);
+            }
+
+            cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
+            ct3d->dc.total_extent_count += in->ext_count;
+            cxl_create_dc_event_records_for_extents(ct3d,
+                                                    DC_EVENT_ADD_CAPACITY,
+                                                    in->extents,
+                                                    in->ext_count);
+
+            return CXL_MBOX_SUCCESS;
+        }
+        default: {
+            qemu_log_mask(LOG_UNIMP,
+                          "CXL extent selection policy not supported.\n");
+            return CXL_MBOX_INVALID_INPUT;
+        }
+    }
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3670,6 +3772,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
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
index 4e975b1a42..be609ff9d0 100644
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
 
-- 
MST



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6256C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 19:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubOTT-0005Vv-En; Mon, 14 Jul 2025 15:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubNKN-0003I1-Iw
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:51:06 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubNKK-0008OS-IZ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:50:59 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgqZx5V3Nz6L4wk;
 Tue, 15 Jul 2025 01:49:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id E83071402ED;
 Tue, 15 Jul 2025 01:50:50 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 19:50:50 +0200
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>, Anisa Su
 <anisa.su887@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu v2 11/11] hw/cxl: mailbox-utils: 0x5605 - FMAPI Initiate
 DC Release
Date: Mon, 14 Jul 2025 18:45:07 +0100
Message-ID: <20250714174509.1984430-12-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714174509.1984430-1-Jonathan.Cameron@huawei.com>
References: <20250714174509.1984430-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Anisa Su <anisa.su@samsung.com>

FM DCD Management command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 88 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 5d08525529..68c7cc9891 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -124,6 +124,7 @@ enum {
         #define SET_DC_REGION_CONFIG        0x2
         #define GET_DC_REGION_EXTENT_LIST   0x3
         #define INITIATE_DC_ADD             0x4
+        #define INITIATE_DC_RELEASE         0x5
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3645,6 +3646,86 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
     }
 }
 
+#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x0F
+#define CXL_FORCED_REMOVAL_MASK (1 << 4)
+/*
+ * CXL r3.2 Section 7.6.7.6.6:
+ * Initiate Dynamic Capacity Release (Opcode 5605h)
+ */
+static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    struct {
+        uint16_t host_id;
+        uint8_t flags;
+        uint8_t reg_num;
+        uint64_t length;
+        uint8_t tag[0x10];
+        uint32_t ext_count;
+        CXLDCExtentRaw extents[];
+    } QEMU_PACKED *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    int i, rc;
+
+    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
+        case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE: {
+            CXLDCExtentList updated_list;
+            uint32_t updated_list_size;
+            g_autofree CXLUpdateDCExtentListInPl *list =
+                g_malloc0(sizeof(*list) +
+                    in->ext_count * sizeof(*list->updated_entries));
+
+            convert_raw_extents(in->extents, list, in->ext_count);
+            rc = cxl_detect_malformed_extent_list(ct3d, list);
+            if (rc) {
+                return rc;
+            }
+
+            /*
+             * Fail with Invalid PA if an extent is pending and Forced Removal
+             * flag not set.
+             */
+            if (!(in->flags & CXL_FORCED_REMOVAL_MASK)) {
+                for (i = 0; i < in->ext_count; i++) {
+                    CXLDCExtentRaw ext = in->extents[i];
+                    /*
+                     * Check requested extents don't overlap with pending
+                     * extents.
+                     */
+                    if (cxl_extent_groups_overlaps_dpa_range(
+                            &ct3d->dc.extents_pending,
+                            ext.start_dpa,
+                            ext.len)) {
+                        return CXL_MBOX_INVALID_PA;
+                    }
+                }
+            }
+
+            rc = cxl_dc_extent_release_dry_run(ct3d,
+                                               list,
+                                               &updated_list,
+                                               &updated_list_size);
+            if (rc) {
+                return rc;
+            }
+            cxl_create_dc_event_records_for_extents(ct3d,
+                                                    DC_EVENT_RELEASE_CAPACITY,
+                                                    in->extents,
+                                                    in->ext_count);
+            return CXL_MBOX_SUCCESS;
+        }
+        default: {
+            qemu_log_mask(LOG_UNIMP,
+                "CXL extent removal policy not supported.\n");
+            return CXL_MBOX_INVALID_INPUT;
+        }
+    }
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3779,6 +3860,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
+    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
+        cmd_fm_initiate_dc_release, ~0,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
 };
 
 /*
-- 
2.48.1



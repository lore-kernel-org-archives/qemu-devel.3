Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E7AC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 15:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc58d-0007qV-6c; Mon, 19 Feb 2024 10:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1rc58Z-0007pM-Qd
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:00:55 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1rc58W-0000yb-8x
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:00:55 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tdlwr44JZz6D8YY;
 Mon, 19 Feb 2024 22:56:28 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
 by mail.maildlp.com (Postfix) with ESMTPS id DFC12140B38;
 Mon, 19 Feb 2024 23:00:42 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 15:00:42 +0000
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
 <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v4 1/3] hw/cxl/cxl-mailbox-utils: Add support for feature
 commands (8.2.9.6)
Date: Mon, 19 Feb 2024 23:00:23 +0800
Message-ID: <20240219150025.1531-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240219150025.1531-1-shiju.jose@huawei.com>
References: <20240219150025.1531-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  <shiju.jose@huawei.com>
From: shiju.jose--- via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
CXL devices supports features with changeable attributes.
Get Supported Features retrieves the list of supported device specific
features. The settings of a feature can be retrieved using Get Feature and
optionally modified using Set Feature.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 175 +++++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 80a80f1ec2..779ce80e3c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -66,6 +66,10 @@ enum {
     LOGS        = 0x04,
         #define GET_SUPPORTED 0x0
         #define GET_LOG       0x1
+    FEATURES    = 0x05,
+        #define GET_SUPPORTED 0x0
+        #define GET_FEATURE   0x1
+        #define SET_FEATURE   0x2
     IDENTIFY    = 0x40,
         #define MEMORY_DEVICE 0x0
     CCLS        = 0x41,
@@ -965,6 +969,165 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.1 section 8.2.9.6: Features */
+/*
+ * Get Supported Features output payload
+ * CXL r3.1 section 8.2.9.6.1 Table 8-96
+ */
+typedef struct CXLSupportedFeatureHeader {
+    uint16_t entries;
+    uint16_t nsuppfeats_dev;
+    uint32_t reserved;
+} QEMU_PACKED CXLSupportedFeatureHeader;
+
+/*
+ * Get Supported Features Supported Feature Entry
+ * CXL r3.1 section 8.2.9.6.1 Table 8-97
+ */
+typedef struct CXLSupportedFeatureEntry {
+    QemuUUID uuid;
+    uint16_t feat_index;
+    uint16_t get_feat_size;
+    uint16_t set_feat_size;
+    uint32_t attr_flags;
+    uint8_t get_feat_version;
+    uint8_t set_feat_version;
+    uint16_t set_feat_effects;
+    uint8_t rsvd[18];
+} QEMU_PACKED CXLSupportedFeatureEntry;
+
+enum CXL_SUPPORTED_FEATURES_LIST {
+    CXL_FEATURE_MAX
+};
+
+/* Get Feature CXL 3.1 Spec 8.2.9.6.2 */
+/*
+ * Get Feature input payload
+ * CXL r3.1 section 8.2.9.6.2 Table 8-99
+ */
+/* Get Feature : Payload in selection */
+enum CXL_GET_FEATURE_SELECTION {
+    CXL_GET_FEATURE_SEL_CURRENT_VALUE,
+    CXL_GET_FEATURE_SEL_DEFAULT_VALUE,
+    CXL_GET_FEATURE_SEL_SAVED_VALUE,
+    CXL_GET_FEATURE_SEL_MAX
+};
+
+/* Set Feature CXL 3.1 Spec 8.2.9.6.3 */
+/*
+ * Set Feature input payload
+ * CXL r3.1 section 8.2.9.6.3 Table 8-101
+ */
+typedef struct CXLSetFeatureInHeader {
+        QemuUUID uuid;
+        uint32_t flags;
+        uint16_t offset;
+        uint8_t version;
+        uint8_t rsvd[9];
+} QEMU_PACKED QEMU_ALIGNED(16) CXLSetFeatureInHeader;
+
+/* Set Feature : Payload in flags */
+#define CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK   0x7
+enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
+    CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_INITIATE_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_CONTINUE_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
+};
+
+/* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
+static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    struct {
+        uint32_t count;
+        uint16_t start_index;
+        uint16_t reserved;
+    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_in = (void *)payload_in;
+
+    struct {
+        CXLSupportedFeatureHeader hdr;
+        CXLSupportedFeatureEntry feat_entries[];
+    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_out = (void *)payload_out;
+    uint16_t index;
+    uint16_t entry, req_entries;
+    uint16_t feat_entries = 0;
+
+    if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
+        get_feats_in->start_index > CXL_FEATURE_MAX) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    req_entries = (get_feats_in->count -
+                   sizeof(CXLSupportedFeatureHeader)) /
+                   sizeof(CXLSupportedFeatureEntry);
+    req_entries = MIN(req_entries, CXL_FEATURE_MAX);
+    index = get_feats_in->start_index;
+
+    entry = 0;
+    while (entry < req_entries) {
+        switch (index) {
+        default:
+            break;
+        }
+        index++;
+        entry++;
+    }
+
+    get_feats_out->hdr.nsuppfeats_dev = CXL_FEATURE_MAX;
+    get_feats_out->hdr.entries = feat_entries;
+    *len_out = sizeof(CXLSupportedFeatureHeader) +
+                      feat_entries * sizeof(CXLSupportedFeatureEntry);
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/* CXL r3.1 section 8.2.9.6.2: Get Feature (Opcode 0501h) */
+static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
+                                           uint8_t *payload_in,
+                                           size_t len_in,
+                                           uint8_t *payload_out,
+                                           size_t *len_out,
+                                           CXLCCI *cci)
+{
+    struct {
+        QemuUUID uuid;
+        uint16_t offset;
+        uint16_t count;
+        uint8_t selection;
+    } QEMU_PACKED QEMU_ALIGNED(16) * get_feature;
+    uint16_t bytes_to_copy = 0;
+
+    get_feature = (void *)payload_in;
+
+    if (get_feature->selection != CXL_GET_FEATURE_SEL_CURRENT_VALUE) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+    if (get_feature->offset + get_feature->count > cci->payload_max) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    *len_out = bytes_to_copy;
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/* CXL r3.1 section 8.2.9.6.3: Set Feature (Opcode 0502h) */
+static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
+                                           uint8_t *payload_in,
+                                           size_t len_in,
+                                           uint8_t *payload_out,
+                                           size_t *len_out,
+                                           CXLCCI *cci)
+{
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 Section 8.2.9.9.1.1: Identify Memory Device (Opcode 4000h) */
 static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -2166,6 +2329,18 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
                               0, 0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
+                                  cmd_features_get_supported, 0x8, 0 },
+    [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
+                                cmd_features_get_feature, 0x15, 0 },
+    [FEATURES][SET_FEATURE] = { "FEATURES_SET_FEATURE",
+                                cmd_features_set_feature,
+                                ~0,
+                                (CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+                                 CXL_MBOX_IMMEDIATE_DATA_CHANGE |
+                                 CXL_MBOX_IMMEDIATE_POLICY_CHANGE |
+                                 CXL_MBOX_IMMEDIATE_LOG_CHANGE |
+                                 CXL_MBOX_SECURITY_STATE_CHANGE)},
     [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
         cmd_identify_memory_device, 0, 0 },
     [CCLS][GET_PARTITION_INFO] = { "CCLS_GET_PARTITION_INFO",
-- 
2.34.1



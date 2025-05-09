Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9177C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 17:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDRgd-0006bv-V1; Fri, 09 May 2025 13:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1uDRgZ-0006al-84
 for qemu-devel@nongnu.org; Fri, 09 May 2025 13:38:59 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1uDRgV-000835-6Q
 for qemu-devel@nongnu.org; Fri, 09 May 2025 13:38:58 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZvG3Q4RCCz6L5JJ;
 Sat, 10 May 2025 01:20:18 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id AAE0B1402EC;
 Sat, 10 May 2025 01:22:52 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.35.8) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 May 2025 19:22:52 +0200
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
 <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH 2/7] hw/cxl/events: Updates for rev3.2 general media event
 record
Date: Fri, 9 May 2025 18:22:24 +0100
Message-ID: <20250509172229.726-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250509172229.726-1-shiju.jose@huawei.com>
References: <20250509172229.726-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.195.35.8]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500007.china.huawei.com (7.182.85.172)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  <shiju.jose@huawei.com>
From: shiju.jose--- via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec rev3.2 section 8.2.10.2.1.1 Table 8-57, general media event
table has updated with following new fields.
1. Advanced Programmable Corrected Memory Error Threshold Event Flags
2. Corrected Memory Error Count at Event
3. Memory Event Sub-Type

Add updates for the above spec changes in the CXL general media event
reporting and QMP command to inject general media event.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/mem/cxl_type3.c          |  9 +++++++++
 hw/mem/cxl_type3_stubs.c    |  3 +++
 include/hw/cxl/cxl_events.h |  7 +++++--
 qapi/cxl.json               | 14 +++++++++++++-
 4 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 841d04d925..14e146b74f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1716,6 +1716,7 @@ static const QemuUUID memory_module_uuid = {
 #define CXL_GMER_VALID_RANK                             BIT(1)
 #define CXL_GMER_VALID_DEVICE                           BIT(2)
 #define CXL_GMER_VALID_COMPONENT                        BIT(3)
+#define CXL_GMER_VALID_COMPONENT_ID_FORMAT              BIT(4)
 
 static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
 {
@@ -1743,6 +1744,9 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
                                         bool has_rank, uint8_t rank,
                                         bool has_device, uint32_t device,
                                         const char *component_id,
+                                        uint8_t cme_ev_flags,
+                                        uint32_t cme_count,
+                                        uint8_t sub_type,
                                         Error **errp)
 {
     Object *obj = object_resolve_path(path, NULL);
@@ -1801,10 +1805,15 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
         strncpy((char *)gem.component_id, component_id,
                 sizeof(gem.component_id) - 1);
         valid_flags |= CXL_GMER_VALID_COMPONENT;
+        valid_flags |= CXL_GMER_VALID_COMPONENT_ID_FORMAT;
     }
 
     stw_le_p(&gem.validity_flags, valid_flags);
 
+    gem.cme_ev_flags = cme_ev_flags;
+    st24_le_p(gem.cme_count, cme_count);
+    gem.sub_type = sub_type;
+
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&gem)) {
         cxl_event_irq_assert(ct3d);
     }
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 9f95e4e6ec..63ef5763e1 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -23,6 +23,9 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
                                         bool has_rank, uint8_t rank,
                                         bool has_device, uint32_t device,
                                         const char *component_id,
+                                        uint8_t cme_ev_flags,
+                                        uint32_t cme_count,
+                                        uint8_t sub_type,
                                         Error **errp) {}
 
 void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 79a40f88bb..7542599534 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -115,10 +115,10 @@ typedef struct CXLEventInterruptPolicy {
 
 /*
  * General Media Event Record
- * CXL r3.1 Section 8.2.9.2.1.1; Table 8-45
+ * CXL r3.2 Section 8.2.10.2.1.1; Table 8-57
  */
 #define CXL_EVENT_GEN_MED_COMP_ID_SIZE  0x10
-#define CXL_EVENT_GEN_MED_RES_SIZE      0x2e
+#define CXL_EVENT_GEN_MED_RES_SIZE      0x29
 typedef struct CXLEventGenMedia {
     CXLEventRecordHdr hdr;
     uint64_t phys_addr;
@@ -130,6 +130,9 @@ typedef struct CXLEventGenMedia {
     uint8_t rank;
     uint8_t device[3];
     uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+    uint8_t cme_ev_flags;
+    uint8_t cme_count[3];
+    uint8_t sub_type;
     uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
 } QEMU_PACKED CXLEventGenMedia;
 
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 2518d3d32a..6442d68113 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -82,6 +82,16 @@
 # @component-id: Device specific component identifier for the event.
 #     May describe a field replaceable sub-component of the device.
 #
+# @cme-ev-flags: Advanced programmable corrected memory error
+#     threshold event flags.
+#     See CXL r3.2 Table 8-57 General Media Event Record.
+#
+# @cme-count: Corrected memory error count at event.
+#     See CXL r3.2 Table 8-57 General Media Event Record.
+#
+# @sub-type: Memory event sub-type.
+#     See CXL r3.2 Table 8-57 General Media Event Record.
+#
 # Since: 8.1
 ##
 { 'command': 'cxl-inject-general-media-event',
@@ -91,7 +101,9 @@
             'dpa': 'uint64', 'descriptor': 'uint8',
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8',
-            '*device': 'uint32', '*component-id': 'str' } }
+            '*device': 'uint32', '*component-id': 'str',
+            'cme-ev-flags':'uint8', 'cme-count':'uint32',
+            'sub-type':'uint8' } }
 
 ##
 # @cxl-inject-dram-event:
-- 
2.43.0



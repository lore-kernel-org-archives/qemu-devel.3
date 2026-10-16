Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633EECCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhaI-0007WV-Ii; Fri, 16 Oct 2026 09:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXs-00061g-HW
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:14 -0400
Received: from out203-205-221-245.mail.qq.com ([203.205.221.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXm-0007k9-Og
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792144079; bh=AbcdgKH9AK7bfdRKzKd3M4uaiSr1qE9FyIsrcQZVUYk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vGRySs55Zc4sUhqyqA4/XlGUh3xO0xPZcrgx869JR1x6AxCcgJQEk71C+MVWCrI3q
 EN4X/gAv9XwSYKhzortGH/4YLbiZzp24iW0KOJflqaKfInww3xxfc/fOzVkN8Ji0K/
 3E5xjgIZMiprkI5xn5MhKitTwPw9bxQ/0cE7LPPQ=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id BF4A1837; Fri, 16 Oct 2026 17:47:52 +0800
X-QQ-mid: xmsmtpt1792144077tfvhwfwid
Message-ID: <tencent_F9C68A515AC6C40BE2C32DB314E14CCB7106@qq.com>
X-QQ-XMAILINFO: MQAOa38Yz/8/kZ+8TYeq/wMS0Vhhq30td0qS0yaubzjDPtbH1lnxIohpyaNhPj
 56ehd0NCycnUSGcTAN7puB0Ok9Ioj+Mac35K8exyRwr4tF2WxhI1esX7nbug6rIn6qfd+zRFj8on
 iMmaaiDmSqEjfgU/SCxT9zFQLrKPAWTtZ0OHNfoLGG+CsOgrB00p7cTr/Ba76W6qXpyaS2AsTi+3
 XcDMIvTIPFUMHvPWJhFV1HCWw8O65AUtFvLIyQ0hbvOZDuT6Yz+QFLSgXM80upAtuKpR6raH/j29
 C8YCt7XVHAVSCqnQVLp/pkiKIaTurP9LmJE9I7puMpE+DPwO3XkZKHR5FybGdeaVw34q5m+v1cZR
 jO8C9CljDzZwtGXUQdbkaJVSqN1xku6jBJJCQAXT0Tu1PZ5dvez1uoWHsRAXW4eQQo232KtitDvq
 iOsGsElCVy1FAxVK23momHgpBbsuPTf0//lWdFavVeRHP328jdGaZlCABMLpi0atlV/URyVOgeSo
 berhU+1dri/4v0zC6Y56SuQRyod13Ifn/2VrVp9QnAY6ANY9XRQwAMqog+ZKuDUazyv0u/LzoLOZ
 xM+PRzELx/C3VrjnZheo9MwHibKSFe1pPvrGVNx0or5qoy5eHDS+1BZ+Hoe5h9v6lmbN71FJXkXT
 U0E8Y+OW9t5EDmqnKhmrWeQS93ckDat/7eTuC+ke0ObzsaQb9eIv8obKRMRTzni56jGEYsJIid4M
 1N6ZBSBDINtI4CSQ1lizKy5ER6InsE1f7uY+/NNeBILaH4Pyz/dB5dIYjYUpthOumDDBSrVPPo31
 g2/Ze5fxGsFzxWnucRV6qRx+4t/XcXrY2EvdcjOHKSEZo4BvgYnfO08wdeCzB+kYPqMtr3JxdbIe
 BjX6nh06GIiAu1jm5WFyrtV2nAQA1d6yeDr046vkdfcr+bAkH79fNvglB7JkFn/czW85WwPrqMC3
 rhPiNLzzvHpR/tUowyXYNOIHaxtY+34N6Ka/Rh5axoLs2N5wgwZMzEyZsFmdt37hMIuqpXoCYgbS
 6xI5qsOD0fJ7vKzobzJXl+H/jHlyq5iX7lbxg7U2Oj8q8v375UW6XLQt+yD1Gt+VR9LXkZHQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 04/37] hw/acpi: Build PPTT rev 3 with cache IDs for MPAM
 cross-references
Date: Fri, 16 Oct 2026 17:46:58 +0800
X-OQ-MSGID: <20261016094733.1898485-5-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016094733.1898485-1-2118537295@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.245; envelope-from=2118537295@qq.com;
 helo=out203-205-221-245.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:33 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jinjie Ruan <ruanjinjie@huawei.com>

The MPAM ACPI table points at cache MSCs via a cache_reference that
the kernel resolves against a PPTT cache node carrying a Cache ID
(only present in PPTT revision 3, with the Cache ID valid flag).
Without it, a guest MPAM driver cannot associate cache MSCs with
caches and rejects them.

Bump the PPTT to revision 3 and give every cache node an ID derived
from its type, level and the first CPU of the topology container it
belongs to. The virt machine's MPAM cache MSC creation uses the same
topology levels (L3 at socket, L2 at cluster) as the PPTT builder and
derives the same IDs, so MSC locators resolve to real cache nodes.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/acpi/aml-build.c         | 31 ++++++++++++++++++++++---------
 include/hw/acpi/aml-build.h |  8 ++++++++
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 990abc6..2e09a39 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2185,16 +2185,16 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
  * 5.2.29.2 Cache Type Structure (Type 1)
  */
 static void build_cache_nodes(GArray *tbl, CPUCoreCaches *cache,
-                              uint32_t next_offset)
+                              uint32_t next_offset, uint32_t cache_id)
 {
-    const uint8_t node_length = 24;
+    const uint8_t node_length = 28;
     int start_len = tbl->len;
     int val;
 
     build_append_byte(tbl, 1);                         /* Type 1 - cache */
     build_append_byte(tbl, node_length);               /* Length */
     build_append_int_noprefix(tbl, 0, 2);              /* Reserved */
-    build_append_int_noprefix(tbl, 0x7f, 4);           /* Flags */
+    build_append_int_noprefix(tbl, 0xff, 4);           /* Flags */
     build_append_int_noprefix(tbl, next_offset, 4);    /* Next Level of Cache */
     build_append_int_noprefix(tbl, cache->size, 4);    /* Size */
     build_append_int_noprefix(tbl, cache->sets, 4);    /* Number of sets */
@@ -2213,6 +2213,7 @@ static void build_cache_nodes(GArray *tbl, CPUCoreCaches *cache,
     }
     build_append_byte(tbl, val);                        /* Attributes */
     build_append_int_noprefix(tbl, cache->linesize, 2); /* Line size */
+    build_append_int_noprefix(tbl, cache_id, 4);        /* Cache ID (v1) */
     g_assert(tbl->len == start_len + node_length);
 }
 
@@ -2230,7 +2231,8 @@ static bool build_caches(GArray *table_data, uint32_t pptt_start,
                          uint8_t level_high, /* Inclusive */
                          uint8_t level_low,  /* Inclusive */
                          uint32_t *data_offset,
-                         uint32_t *instr_offset)
+                         uint32_t *instr_offset,
+                         uint32_t base_cpu)
 {
     uint32_t next_level_offset_data = 0, next_level_offset_instruction = 0;
     uint32_t this_offset, next_offset = 0;
@@ -2240,10 +2242,20 @@ static bool build_caches(GArray *table_data, uint32_t pptt_start,
     /* Walk caches from top to bottom */
     for (level = level_high; level >= level_low; level--) {
         for (c = 0; c < num_caches; c++) {
+            uint32_t cache_id;
+
             if (caches[c].level != level) {
                 continue;
             }
 
+            /*
+             * MPAM cross-references caches from the MPAM table using
+             * this id. base_cpu identifies the topology container the
+             * cache belongs to (the id at which this call was made).
+             */
+            cache_id = PPTT_CACHE_ID(caches[c].type, caches[c].level,
+                                     base_cpu);
+
             /* Assume only unified above l1 for now */
             this_offset = table_data->len - pptt_start;
             switch (caches[c].type) {
@@ -2258,7 +2270,7 @@ static bool build_caches(GArray *table_data, uint32_t pptt_start,
                 next_offset = next_level_offset_instruction;
                 break;
             }
-            build_cache_nodes(table_data, &caches[c], next_offset);
+            build_cache_nodes(table_data, &caches[c], next_offset, cache_id);
             switch (caches[c].type) {
             case INSTRUCTION_CACHE:
                 next_level_offset_instruction = this_offset;
@@ -2316,7 +2328,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
     uint32_t num_priv = 0;
     bool cache_at_topo_level;
 
-    AcpiTable table = { .sig = "PPTT", .rev = 2,
+    AcpiTable table = { .sig = "PPTT", .rev = 3,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
 
     acpi_table_begin(&table, table_data);
@@ -2353,7 +2365,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
             if (cache_at_topo_level) {
                 build_caches(table_data, pptt_start, num_caches, caches,
                              top_node, bottom_node, &node_data_offset,
-                             &node_instr_offset);
+                             &node_instr_offset, n);
                 priv_rsrc[0] = node_instr_offset;
                 priv_rsrc[1] = node_data_offset;
                 if (node_instr_offset || node_data_offset) {
@@ -2384,7 +2396,8 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 if (cache_at_topo_level) {
                     build_caches(table_data, pptt_start, num_caches, caches,
                                  top_cluster, bottom_cluster,
-                                 &cluster_data_offset, &cluster_instr_offset);
+                                 &cluster_data_offset, &cluster_instr_offset,
+                                 n);
                     priv_rsrc[0] = cluster_instr_offset;
                     priv_rsrc[1] = cluster_data_offset;
                     if (cluster_instr_offset || cluster_data_offset) {
@@ -2423,7 +2436,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
             if (cache_at_topo_level) {
                 build_caches(table_data, pptt_start, num_caches, caches,
                              top_core, bottom_core, &core_data_offset,
-                             &core_instr_offset);
+                             &core_instr_offset, n);
                 priv_rsrc[0] = core_instr_offset;
                 priv_rsrc[1] = core_data_offset;
                 num_priv = core_instr_offset == core_data_offset ? 1 : 2;
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index eaff025..f64e04e 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -501,6 +501,14 @@ void build_srat_acpi_generic_port(GArray *table_data, uint32_t node,
 void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 const char *oem_id, const char *oem_table_id);
 
+/*
+ * PPTT rev 3 Cache ID (ACPI 6.5 Table 5.157): cache type and level in
+ * the high bytes, the first CPU of the topology container in the low
+ * half.  The MPAM table cache locator uses the same encoding.
+ */
+#define PPTT_CACHE_ID(type, level, cpu)                          \
+    (((uint32_t)(type) << 24) | ((uint32_t)(level) << 16) | (cpu))
+
 void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 const char *oem_id, const char *oem_table_id,
                 int num_caches, CPUCoreCaches *caches);
-- 
2.43.0



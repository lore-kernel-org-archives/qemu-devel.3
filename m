Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02279606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 04:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qdwP+Ole
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPB8K-0002vX-J8; Thu, 05 Nov 2026 23:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>) id 1xPB7d-0002rV-TV
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 23:00:14 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>) id 1xPB7Y-0004L6-Tx
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 23:00:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v893HCkifNSPmTrFQIDHYjyOppI3Gf3ZHwFeNlt1Hfiyk5MkI1AmL1UVnsv+C57Tjxk0NNDTUjcV57XPJtMP18WiIbvbsjTati43k4LbOvDzyUFBxW2/o33DE4xURSNAilJoSihPmNxiepQW/WI6cAG5E/+EjWGCDzt1lbCjlUykNzDPbgVSE66rlhusYglJaSeLnN91q4ikMXx/WVPG68T5e0a+TG7cx4KnC+K2Bv/CGFz2HPIjMT1QD+NCG3UXLe3yAcaPyJz4T/T3jqyCA1l94v/MmSvmYyG/cgfJTL3f/fsV+vcP4wLQe3S0s1i0sGZNJIKZiDQTaYpIXHmw7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpTjsvLdfF0JRzEK0jn4AYM32zTmjQzUDSS8hvbEX2c=;
 b=T8K9gEFMe/m+Pl10tZZFR1lKJgaX6sEL/iYNvK6x/LZjfDxpV0zNToKwSbIoANX6+QbUFKUJdbM8f094Bou6JVSZbYuQoTk/Iy84uHC5Vibt2VxuvyvyL8fSDkLqQ2sH8ng4/OFOU8KnvF5QJfias7yuzVb9GW8fUWC8hL363I6uSLFeR6EwdRYJhnwPt4tpD7qksJ7QkXvBNI/wRPr/kD/FaLfMkGkz5MgBBaV3pslDJG7pldqKBi1HmDeEv3dJNHFIEoMvWag+c6vrA0q5E4b9pjBC+ZDdzJnMC3Ud1JxlLeqIq65TLzYca0ech6SYlqjBCU3Vn12lTPdB8T18yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpTjsvLdfF0JRzEK0jn4AYM32zTmjQzUDSS8hvbEX2c=;
 b=qdwP+Ole+8rMRX6ul33Aa8jGI5alzr9+/dG7pYplbsnVVHU1hD+/NaRgm+oHw/UxqKM/TBtWrcD5ksR6ummp7gYnzHm2HU6NSVS5B3ycgyhjQPVNEeLoiFd24qoPr7BmGpNtdkq1pmn2Crp/1Yn13bzPs+4QzGpb/KAImd9p10aWhcnXhITycJVSzjMCCXTmnCZ55GIgIirngshLpFYhFqiXWKqhDpDOje3fDbzCHrDD07G5imlT6cIhOnz21ss93QcawipSbfhkXOi0a0vTy2KeqePGJdJz4kPcStkE1AaHJ+Gfj706CqBRMz3lvKAh0NGTm7vzxBaD5t5bdpCTjQ==
Received: from BN9PR03CA0585.namprd03.prod.outlook.com (2603:10b6:408:10d::20)
 by BN7PPFEE0F400A9.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:00:03 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:10d:cafe::15) by BN9PR03CA0585.outlook.office365.com
 (2603:10b6:408:10d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 04:00:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:00:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 19:59:49 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 19:59:44 -0800
From: <mhonap@nvidia.com>
To: <jic23@kernel.org>, <alwilliamson@nvidia.com>, <clg@redhat.com>,
 <xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
 <mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
 <junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
 <ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
 <mochs@nvidia.com>
CC: <cjia@nvidia.com>, <mhonap@nvidia.com>, <kjaju@nvidia.com>,
 <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: [RFC 03/18] hw/cxl: Introduce cxl_component_update_dvsec()
Date: Fri, 6 Nov 2026 09:28:56 +0530
Message-ID: <20261106035911.1280066-4-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106035911.1280066-1-mhonap@nvidia.com>
References: <20261106035911.1280066-1-mhonap@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|BN7PPFEE0F400A9:EE_
X-MS-Office365-Filtering-Correlation-Id: a589d436-54ac-4771-957f-08df3bba6f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|7416014|18002099003|22082099003|921020|10067099003|11063799006|56012099006|5023799004|261026140227099003|261026130827099003|261026121527099003|261028144727099003|261021130227099003|261009223027099003|261022075727099003|261021135927099003|261022113327099003|261022105027099003|261021133027099003|261021123027099003|261026135527099003|261102123227099003|261021121427099003|261022115727099003;
X-Microsoft-Antispam-Message-Info: K/ckC5sNVxv+UZ6xtGtLlKEhy+Jx3FIFX5a3trAc+Tw4XveYcrLalsP5oGOIh0vD95kz36LLnsGxMTyL426bm43CnkO+jBTVKY0NllzOw7IkcZFtQuNWiZnkr/jmtiH51mZC2hP3fQFwIIQgIBAj7yB8K+ZOLICqRIEQcw6YtKYyyMu/hT/XCPoxI8AdC5CGB2Bt1/kvbBSxz9Y2TcwW6Y6uC4yTS+SbBjZj0fc1X/Q+kRrnUNgWwzVkAin80j7vsM/3YS/rgPXZ+VX31sJ8kojslXNAEGerbFkWjmBeLYi5aFqwGowIK44RO3PN0BxHyYXG9tPWfpmfV/EDjxWWcYVrDLJ++L5mvimA7/cz/xR5bNEzk9bPD4cu0qqVlypdhGYMmtUIr4Ok2hfOQO2FhhXJzInoOfPKF5c/m+RUflCZcpDewoqVfTT5rKb4w5jvzrwop9fTpxQgUo+wrlKTf49F/5wQpa/t+rBzsdg+r8lh5if5e0WVIdi10Z52CJoCzsajTo2Ds06RNK0KE1Cdc34iKTid3GuP2oeia6HrMU7bk48pasgM8R4110tKJ3NPADxkd3ROunas7WCSBx9GXs9+MSvKpuB6LLkTdL8cgyF3cHd5i8GPHmKurw5wNMjqf6FgPT6k7elKlOIIpW/4C2eAmYY0B982ZEhAbvUyCL6LT7gjGVaV6NRHJO+Dj45Thr7MHg4176pST2aPIKC2X5Drv2sOOTDw9cgfoRf1Bv+eyXoLgpLr7R2A7ZL78SWA
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(7416014)(18002099003)(22082099003)(921020)(10067099003)(11063799006)(56012099006)(5023799004)(261026140227099003)(261026130827099003)(261026121527099003)(261028144727099003)(261021130227099003)(261009223027099003)(261022075727099003)(261021135927099003)(261022113327099003)(261022105027099003)(261021133027099003)(261021123027099003)(261026135527099003)(261102123227099003)(261021121427099003)(261022115727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M6qZ+YSC1T/pOyl00v7MzufkGl3wV2MuGYml9uULD4TV+uKuj8oDFvn1/6/lwILUqp/EHiSluB2MYFYcoiM7n/uOGPzY3eX4995Hbd0avcWDiK73tUMW2OvK7gpWHp2g1gTFr8u35CspWc5m02uIB1Nxtt9f0l875H3Gl/ZVb7XloktjJJhONE87/nGmIqDqwvGRAlRoanWkHyW2wGFQQ8nDDLXvI7++QMFlpotcfIVyJE85uDTFSeIleTlSsrXdI6AvpLTHFUubbSuUccfmPJnghJb4Mdqk4F7FRU0AZXjG/Svf1kEjuvOSO/laFapzFIZXHTN4WUzZon2OeeXpdavnCLnZdVtzJG9AwPHFhBeMrDOWGpjoKar0xQRLfXpMR5KWswF0R3C+geWBlnfTD5xXHs+SUQSRXNJxYQb7gM/SCpoDpY/iw1qlUL0p5w69
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:00:02.9667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a589d436-54ac-4771-957f-08df3bba6f8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEE0F400A9
Received-SPF: pass client-ip=2a01:111:f403:c112::5;
 envelope-from=mhonap@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zhi Wang <zhiw@nvidia.com>

cxl_component_create_dvsec() sets the DVSEC registers once, at realize,
and nothing resets them. DVSEC Control Mem_Enable then stays 1 across a
system reset. The Linux CXL core takes that as HDM decoders set up by
firmware, uses whatever the decoders hold, and fails to probe the
device.

Add cxl_component_update_dvsec() so that a device can rewrite its DVSEC
registers at reset.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
[ mhonap: comment and indentation fixes, commit message update ]
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/cxl/cxl-component-utils.c   | 33 +++++++++++++++++++++++++++------
 include/hw/cxl/cxl_component.h |  3 +++
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 5db57f7394..bb4c3f541d 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -490,9 +490,10 @@ void cxl_component_register_init_common(uint32_t *reg_state,
  * Helper to creates a DVSEC header for a CXL entity. The caller is responsible
  * for tracking the valid offset.
  *
- * This function will build the DVSEC header on behalf of the caller and then
- * copy in the remaining data for the vendor specific bits.
- * It will also set up appropriate write masks.
+ * This function will build the DVSEC header on behalf of the caller and set
+ * up appropriate write masks. With @body it also copies in the remaining
+ * data; otherwise the caller fills it in later with
+ * cxl_component_update_dvsec().
  */
 void cxl_component_create_dvsec(CXLComponentState *cxl,
                                 enum reg_type cxl_dev_type, uint16_t length,
@@ -512,9 +513,12 @@ void cxl_component_create_dvsec(CXLComponentState *cxl,
     pci_set_long(pdev->config + offset + PCIE_DVSEC_HEADER1_OFFSET,
                  (length << 20) | (rev << 16) | CXL_VENDOR_ID);
     pci_set_word(pdev->config + offset + PCIE_DVSEC_ID_OFFSET, type);
-    memcpy(pdev->config + offset + sizeof(DVSECHeader),
-           body + sizeof(DVSECHeader),
-           length - sizeof(DVSECHeader));
+
+    if (body) {
+        memcpy(pdev->config + offset + sizeof(DVSECHeader),
+               body + sizeof(DVSECHeader),
+               length - sizeof(DVSECHeader));
+    }
 
     /* Configure write masks */
     switch (type) {
@@ -606,6 +610,23 @@ void cxl_component_create_dvsec(CXLComponentState *cxl,
     cxl->dvsec_offset += length;
 }
 
+void cxl_component_update_dvsec(CXLComponentState *cxl, uint16_t length,
+                                uint16_t type, uint8_t *body)
+{
+    PCIDevice *pdev = cxl->pdev;
+    struct Range *r;
+
+    assert(type < CXL20_MAX_DVSEC);
+
+    r = &cxl->dvsecs[type];
+
+    assert(range_size(r) == length);
+
+    memcpy(pdev->config + r->lob + sizeof(DVSECHeader),
+           body + sizeof(DVSECHeader),
+           length - sizeof(DVSECHeader));
+}
+
 /* CXL r3.1 Section 8.2.4.20.7 CXL HDM Decoder n Control Register */
 uint8_t cxl_interleave_ways_enc(int iw, Error **errp)
 {
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 7929a39b73..d6fdb6c1ab 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -320,6 +320,9 @@ void cxl_component_create_dvsec(CXLComponentState *cxl_cstate,
                                 enum reg_type cxl_dev_type, uint16_t length,
                                 uint16_t type, uint8_t rev, uint8_t *body);
 
+void cxl_component_update_dvsec(CXLComponentState *cxl, uint16_t length,
+                                uint16_t type, uint8_t *body);
+
 int cxl_decoder_count_enc(int count);
 int cxl_decoder_count_dec(int enc_cnt);
 
-- 
2.53.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7793606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=J28ex+b1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPBAB-0003q2-QI; Thu, 05 Nov 2026 23:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>) id 1xPB8i-0002zc-PB
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 23:01:28 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>) id 1xPB8h-0004Oe-58
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 23:01:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skRDGOI6T5cU76mvikzvpz+UlUPC7McnKK810+2MsG5bPiPDTY8DeGYHFhSjY/Uz93xhm5bVHBiL1vFEJDRWABvQgvGqDGoUe+P7xBGN6Tkz2QuoZdgnry+1Z9s9p90kvETOxmVLXcGDUncE4SFUJUEdc8pk+Mv3X3JOT+cQRk+GXCTj2lDMc3Wc9RPlx/5F1Nfte/aj8WUQRh4avToOV0tX6f346Yu5qbrDaRfZxI8cnJSD6xStDoY6JWdDseNWz2Xy2gBCyYo3FxN8vU87MhZ7EhmFXycksdWws6lcjcNiU529ifhu3vguKMY5lw94bRt1yULkgT0asBhGKdcw+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIh9DSgb96wInW3XUBNa1+tchOKgUmuJ+1pnNE0byfw=;
 b=gkiBlC02Gi+LLpCeGDW9ln///qyEomRQPOD7bwCwFxIxWAIAy+XiB9AKsa5biOfyZRu3owFt5g86EFW/ztJsDpVqHpY3uuu2CVZq8Yw2decsHbjLJ1T4ir1RrX4KHLIAlKG71TtXvvpaRYjXwSebBnJwCRN7v2yKD3UkKDQLgwj8ErzqMCYie1U/RYUvL67Deh0s2wr4JhAITzdWXvKeGZgLXdYsg8QKPoaduMBIQVcx/jCsg+yARQYLxln8l9xl3LtTGCA/uCt0WP54HWS+SkpDwsWwLT4pChkvz2F2J526wd3pvgDSPPLaW27ycDb5xHmagpi0FykjvEUboksRBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIh9DSgb96wInW3XUBNa1+tchOKgUmuJ+1pnNE0byfw=;
 b=J28ex+b1t1nbWoofs1e3ji8h8m9shg0DyHIMBjkZUcntfrfN20dl1nEOexZlpM1NK+bS48VV4jw+M9qvTvEiU++TUdCFleUWhbHu5292x4fJgfVCepNt+5OzzLfUeHpqadWLZvkM7+KHhDjucmiqu5uJPtLyK8pVtE1VPL/nI0C9TnPT8+z0ac+NJPJ/Sz3vYY/K4i138ejrchZFvb5bZOpuHGPcxOEimSx5EvDUGfJKwoZtizqiCMN2x8JRVFHDTY9mxjWGCxlqOdMqfZ4dEDFEC6wKF4OJ8voavoIXh6AqJWAppzeP7Vo8dCKSIMfkdegdERw4Q2ohzMnObQf9Ng==
Received: from BY3PR05CA0045.namprd05.prod.outlook.com (2603:10b6:a03:39b::20)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:01:11 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:39b:cafe::9e) by BY3PR05CA0045.outlook.office365.com
 (2603:10b6:a03:39b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.5 via Frontend Transport; Fri, 6
 Nov 2026 04:01:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:01:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:50 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:00:44 -0800
From: <mhonap@nvidia.com>
To: <jic23@kernel.org>, <alwilliamson@nvidia.com>, <clg@redhat.com>,
 <xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
 <mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
 <junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
 <ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
 <mochs@nvidia.com>
CC: <cjia@nvidia.com>, <mhonap@nvidia.com>, <kjaju@nvidia.com>,
 <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: [RFC 14/18] hw/mem: Commit the cxl-type2 HDM decoder at reset
Date: Fri, 6 Nov 2026 09:29:07 +0530
Message-ID: <20261106035911.1280066-15-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106035911.1280066-1-mhonap@nvidia.com>
References: <20261106035911.1280066-1-mhonap@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb3c634-8304-4476-0226-08df3bba9869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|7416014|376014|22082099003|18002099003|921020|11063799006|261026121527099003|261026140227099003|10067099003|261028144727099003|261102123227099003|261021121427099003|261022105027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: qG7T4Iij0TZRa3nvJx+cwjanAhlCxLIcxvxFpILJhebiCJcUVtq/cq8PwoCRxPVJdgPu55M59iW156V25WFt1o9A2thEqCTPhqMcrUCxALFlDXNvH1uhTS3W2oG+9090hEz+pAFQjB0AqjtE30NeY8gpbRsSnn1EnxTUQjV+khNENFt9u07BVk7/E9lFVX/EDZK5m7j4nugvL5uaqShBfM+ux9V5yXYBTtXCGHdJq1Hr72qcQRhsp+jls+wx7ITc1DZDANm5TQnOHM56jf38WTfYuLR1zrPwQNLgz/tTzl3XIzXWKw/Y2qKMUvinKJB2Djnb3JgzP9KLsQBH0WKhVsHmwFxCcc95InpFpsq2dSAyFGtqRPYib/jw6LSatVsCaUq+lNIuQks0EUDZggANhkr/BoWgdayGGvIY+yUy/rp+k5HVBldk2EUEeHTf/pLxnxz0CZQ/4F2c0OMKkzpLt792z81hNGpZazydDwIVIdNgkGGbaCkZDCDFNKFMpPMBs+dv6pIHycmTV1PtaHAOeCV91iVNm3YyrtQFTDUvFWXrF+1r7O29McHPZqQ3aEfrKcIbMywQC7Yqi/Q5lU1WK/8qE67Iwz2yZ/DDWjXJnwpXxqdu5p18uGNJOx7ogpXTtpNVeJ5VxRxR970vhRfZQVnyrGsbMSvszz+TbeBmNC50Xmb6QEetk98UDzhNUaEooBfXwrwUshsEtYe4PCTGTi/UoKHb8DjIBjZqAKsK1QT4bByuYUWUaIYEs6ndAvqg
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(376014)(22082099003)(18002099003)(921020)(11063799006)(261026121527099003)(261026140227099003)(10067099003)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1DeN+7vn2TrivxCRHx+DOZzR6GvCC82ftLhdJ7JJ9vMeFry2DY3pXXKHAlC4f5US10LXpW5AigV+kN2MToysYx+6pEvyAjckVGYvzYwQBLMCcONK0ngv9qVrG+AAmyEF0NvgAR+Tqa5Qv0mpduZdgfWYNuAU2ieKgKKs8HMD7QnsicztK52IZkGhs2p05aFZ1Gy2sUbjXrQbeE21DpK6KVRhD8d7m2T7bxS40bj8tO+yrZylIAjvZpgAymN/8d9AsgY4RzT8kVXga0YSqeJngrO/yCVgVU/+/+vHtjx2eXbYCfaFczKGhMQWkYjTtj6rjZVsTe9hOv3m4BnOktnwoE6874ujx3SpXHmf1D83d5a4iqUZHyBkqxcOhM8wEu/fUtI2co/72Aq0KZpXah2jFGMo5F1scSOrtf97Zo4vANVTmA+MjoJhzaz+m9fFXvcH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:01:11.6626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb3c634-8304-4476-0226-08df3bba9869
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
Received-SPF: pass client-ip=2a01:111:f403:c005::5;
 envelope-from=mhonap@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

From: Manish Honap <mhonap@nvidia.com>

A Linux driver for a CXL Type-2 device attaches to a region that
platform firmware committed at boot; devm_cxl_probe_mem() does not
create one.

At every reset, do what such firmware does: enable CXL.mem and the HDM
decoders, and commit decoder 0 over the volatile memory at the window
base with Lock On Commit set. The locked decoder registers are read
only until the next reset.

AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/mem/cxl_type2.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hw/mem/cxl_type2.c b/hw/mem/cxl_type2.c
index 86fcc1a94a..d0fe14afda 100644
--- a/hw/mem/cxl_type2.c
+++ b/hw/mem/cxl_type2.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/range.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/core/qdev-properties.h"
@@ -306,6 +307,43 @@ static void cxl_type2_exit(PCIDevice *pci_dev)
     clean_memory(pci_dev);
 }
 
+/* CXL r4.0 Section 8.2.4.20.7: a locked decoder is read only until reset */
+static void cxl_type2_lock_decoder(CXLComponentState *cxl_cstate)
+{
+    uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
+
+    write_msk[R_CXL_HDM_DECODER0_BASE_LO] = 0;
+    write_msk[R_CXL_HDM_DECODER0_BASE_HI] = 0;
+    write_msk[R_CXL_HDM_DECODER0_SIZE_LO] = 0;
+    write_msk[R_CXL_HDM_DECODER0_SIZE_HI] = 0;
+    write_msk[R_CXL_HDM_DECODER0_CTRL] = 0;
+    write_msk[R_CXL_HDM_DECODER0_DPA_SKIP_LO] = 0;
+    write_msk[R_CXL_HDM_DECODER0_DPA_SKIP_HI] = 0;
+}
+
+static void cxl_type2_firmware_init(CXLType2Dev *ct2d)
+{
+    CXLComponentState *cxl_cstate = &ct2d->cxl_cstate;
+    uint32_t *cache_mem = cxl_cstate->crb.cache_mem_registers;
+    uint16_t ctrl = range_lob(&cxl_cstate->dvsecs[PCIE_CXL_DEVICE_DVSEC]) +
+                    offsetof(CXLDVSECDevice, ctrl);
+    CXLFirmwareHDM range = {
+        .valid = true,
+        .base = ct2d->fmw->base,
+        .size = memory_region_size(
+            host_memory_backend_get_memory(ct2d->hostvmem)),
+    };
+
+    pci_set_word(PCI_DEVICE(ct2d)->config + ctrl,
+                 CXL_DVSEC_CTRL_IO_EN | CXL_DVSEC_CTRL_MEM_EN);
+    ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER_GLOBAL_CONTROL,
+                     HDM_DECODER_ENABLE, 1);
+    cxl_firmware_hdm_program(&range, cache_mem);
+    ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, LOCK_ON_COMMIT, 1);
+    cxl_type2_lock_decoder(cxl_cstate);
+    cfmws_update_non_interleaved(true);
+}
+
 static void cxl_type2_reset(DeviceState *dev)
 {
     CXLType2Dev *ct2d = CXL_TYPE2(dev);
@@ -319,6 +357,10 @@ static void cxl_type2_reset(DeviceState *dev)
     cxl_component_register_init_count(cxl_cstate->crb.cache_mem_registers,
                                       cxl_cstate->crb.cache_mem_regs_write_mask,
                                       CXL3_TYPE2_DEVICE, false, 1);
+
+    if (ct2d->fmw) {
+        cxl_type2_firmware_init(ct2d);
+    }
 }
 
 static const Property cxl_type2_props[] = {
-- 
2.53.0



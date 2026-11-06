Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007CC606A31B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 04:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WHf2C854
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPB8N-0002xC-Lm; Thu, 05 Nov 2026 23:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>) id 1xPB7g-0002sZ-2X
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 23:00:23 -0500
Received: from mail-westusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c001::5] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhonap@nvidia.com>) id 1xPB7b-0004Ld-09
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 23:00:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJETNGBdDW+ijC4Ku6Nn7FNkuqnEAaLHK00ZxAbROwLT8TC3gYsFBA54PeBAhHL2nUzWMVPJaGKAoq62npUoyHe3cWAcFZm8lkjbIXwLROZ18hn+2KlDdluYg+8YUP1Aa58xwvU73qbj5byN8TBjd1qzr/b4P9m1UirDnyb8BkoyvRKe99XxPcvPGgIThIivUj5G/SITmO1IbSjBXi7VO9rle/b7VFNLFYQz1aVEV3U5LkvnZ88g4h3Ei2Yjuf0F9DSrEkPmxdwFRCq7BoiIG+USMc1TBc/ixKfa6/wibuqUpSZkHAuOqSy9uQsB8iEIzFnVBPit8LT6kQf4d3s7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQzEbRFlb45l/3vLO6wwVxw329s9L0S30+s2bIGVAvo=;
 b=AsIuCPZ0R6RzP/x0OiKiZNo1kevWy1wbqivSHhKAyswLE6yg5HgNHn0kHSuAXE7rtBVIBUb/oYoffZCTgNHl+6ZJYUabyXmeEH1uTKNjnHh881GE68uZpb/Kahc0dFLdJrBTKS2AX1MWwCraAieCsZZrskNDwXs1dT8bpmibp6h6SsZ/ZZW+529vnud8186BwWpelGGM2Dh2gmMr6ilppDeHZ5006e8w1Oe91y0SHgm41YQaVsgYMoEvZ2BDZV5ou088A9efX2qLl3UIYqP9rWEQo4OU225GCV2cCnxCXB+HiHRAeI9tPHNCMKfRRIwi/mrJENwWkE40Ut548SqxTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQzEbRFlb45l/3vLO6wwVxw329s9L0S30+s2bIGVAvo=;
 b=WHf2C854UW5rkS4FRWVl5fhaxKFdATGspGF+8Y8x5tRza6KJYkw2Vl6F/Anp4IKap5HczyzYH/vrvUcaZbWMeDq0vt5LeqFZeSTFn5kY68+bFoAiNOKaMJW7DdQz4Lv4V5TthCf/3jgZPjH2lVR/+EYFaD1rPWSom93A0jOF+Bi+NSKxHACqzT3OMJmT7uG9+aIi7LEe2+ef5q3ZsJNBc18CUk9ClG5NRN3BgteaU2hTckZBGI0Y0maDvF5SKNnZDFA2VENQ6T7BaOuX3uYQ/E0dH1a5GVYRUSjBIGCCHYifuAOxDwIV1JWrZBSY5pz4Un7fLWVmA1lUvLCJMGgKzw==
Received: from SJ0PR03CA0193.namprd03.prod.outlook.com (2603:10b6:a03:2ef::18)
 by SN7PR12MB7785.namprd12.prod.outlook.com (2603:10b6:806:346::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 04:00:00 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::94) by SJ0PR03CA0193.outlook.office365.com
 (2603:10b6:a03:2ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 04:00:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:00:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 19:59:43 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 19:59:38 -0800
From: <mhonap@nvidia.com>
To: <jic23@kernel.org>, <alwilliamson@nvidia.com>, <clg@redhat.com>,
 <xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
 <mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
 <junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
 <ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
 <mochs@nvidia.com>
CC: <cjia@nvidia.com>, <mhonap@nvidia.com>, <kjaju@nvidia.com>,
 <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: [RFC 02/18] hw/cxl: Factor out cxl_host_addr_to_dpa()
Date: Fri, 6 Nov 2026 09:28:55 +0530
Message-ID: <20261106035911.1280066-3-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|SN7PR12MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 762281f8-0558-414e-4062-08df3bba6dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|82310400026|36860700016|921020|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gScQgC+dM43WrDK0fjLk0+1i0WNmFDL27YHAfruYEDIXlNHpp36LkiYnpyG6YtxBOrBxkd+32lZaXAzwc4YWDuonDPWmtPK1A3e5Ylow5gDyGRrOHF/iGylF057+BpdaGyQKcmY2B9UPaoRofDGbLu8g4hUq1lLdnvDIApbBJDXPKyYTUi7GkYUWui0LbR26+J3E/GDfOY5IcEDs5bMItixMuCP1QJ8JNu2ilRphSWWw+J72/sWLUhbLFd0LJRguWXd/OZ0uWz5txhxBczQqxrT6wmQRFd0tH0+SYRqCWRmyRFax5lxIG1SU3vpx81ztnKBkIz9lIfLpNdQmzWVGYEAsNkROK1S7G3KLqKWO6WFMbjfBVoPzSj6xDAatF+u24qjg0fD80LWSW9dsgtp+egxyFfLgGvHj1JTDtB4Lda4f7gNG/IuJhEMYR1rGeVdd4ErVDUtwoTJq5GdLljEACn21pv1gGlS/PQxM9ZRjUQamCWFhBZS6CSsoXSQowLuzmG7wTHOSkDArwvrGhFsLLPVxp6+cbL+0puPkY8FIZerDBkBtx/n7+Zm4PpV0NUUmLmQC83xIGdvg0zggPdyTb/6+KygvtJd/FKXdSRz6jY0a1gzA/+iy9hAvIR61Hc8zB1JS8r7dAYhtV6QlD0JD4wkIIyXqcvTkuLCn4l2fSmsKXoMU6q9VudDRZpbKsjQNJnN8U4XgaRtJfGMg67qcPa1z5KhjekUekJUOpCZ4h6ved2K9FKJFaKVi4flmsMZt
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(82310400026)(36860700016)(921020)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Dbf+Dsios4omBWqE3+wPFU9XxEHg0NxWfSYiI0zTfU1hc4WzegxjhSX6COkwhnUcU10Y/tWmGLf1KM7F27C+yTd/kjxpTLMMvUUjLRnYAA+XY64ZIXXkjNVRuloZDcFPQ1t/4eUKxh+k+6wGagKus1lSacwbnMxz4hpJPd56cfzhclSmRd8sXHKWWlSPXWHebq5PZxIM45SVCKM3tN3hoW2FMW8HiXyz8j+Go+jLLbL09eEMe7nO22BWZcZ33kMQHfXF4GfMm1tAf05Iv/SvViB61gqIJABgRESiH4bQivY7/jcmeKt90FFIUQfxAELH9S2fUNGVMMBJyG4eZ+4J68YWOf3CbdiS2nWkP1swbbgAFyLWxiN2zf4I9MoTyRDIm/7rL2yyRywRGhiIiYU6t19ARIrC93j0sP7d8h3mIPcz9MDEC+uHQuokfOc36+l1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:00:00.3976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 762281f8-0558-414e-4062-08df3bba6dfb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7785
Received-SPF: pass client-ip=2a01:111:f403:c001::5;
 envelope-from=mhonap@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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

cxl_type3_dpa() translates a host address to a DPA when a guest accesses
a CXL region. The CXL Type-2 device needs the same translation, so move
it to cxl_host_addr_to_dpa().

No functional change.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
[ clg: - rebased on upstream (3-way interleave)
       - use NULL instead of &error_fatal in cxl_interleave_ways_dec()
         to match existing upstream callers ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
[ mhonap: commit message updates ]
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/cxl/cxl-component-utils.c   | 72 ++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c             | 68 +-------------------------------
 include/hw/cxl/cxl_component.h |  3 ++
 3 files changed, 76 insertions(+), 67 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index fc32be77a9..5db57f7394 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -656,3 +656,75 @@ uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp)
         return 0;
     }
 }
+
+bool cxl_host_addr_to_dpa(CXLComponentState *cxl_cstate, hwaddr host_addr,
+                          uint64_t *dpa)
+{
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
+    uint32_t *cache_mem = cxl_cstate->crb.cache_mem_registers;
+    unsigned int hdm_count;
+    uint32_t cap;
+    uint64_t dpa_base = 0;
+    int i;
+
+    cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
+    hdm_count = cxl_decoder_count_dec(FIELD_EX32(cap,
+                                                 CXL_HDM_DECODER_CAPABILITY,
+                                                 DECODER_COUNT));
+
+    for (i = 0; i < hdm_count; i++) {
+        uint64_t decoder_base, decoder_size, hpa_offset, skip;
+        uint32_t hdm_ctrl, low, high;
+        int ig, iw;
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc);
+        decoder_base = ((uint64_t)high << 32) | (low & 0xf0000000);
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc);
+        decoder_size = ((uint64_t)high << 32) | (low & 0xf0000000);
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_LO +
+                       i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_HI +
+                        i * hdm_inc);
+        skip = ((uint64_t)high << 32) | (low & 0xf0000000);
+        dpa_base += skip;
+
+        hpa_offset = (uint64_t)host_addr - decoder_base;
+
+        hdm_ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * hdm_inc);
+        iw = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IW);
+        ig = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IG);
+        if (!FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
+            return false;
+        }
+        if (((uint64_t)host_addr < decoder_base) ||
+            (hpa_offset >= decoder_size)) {
+            int decoded_iw = cxl_interleave_ways_dec(iw, NULL);
+
+            if (decoded_iw == 0) {
+                return false;
+            }
+
+            dpa_base += decoder_size / decoded_iw;
+            continue;
+        }
+
+        if (iw < 8) {
+            *dpa = dpa_base +
+                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
+                 ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset)
+                  >> iw));
+        } else {
+            *dpa = dpa_base +
+                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
+                 ((((MAKE_64BIT_MASK(ig + iw, 64 - ig - iw) & hpa_offset)
+                   >> (ig + iw)) / 3) << (ig + 8)));
+        }
+
+        return true;
+    }
+    return false;
+}
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 1ff01121f8..71fa85a366 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1164,73 +1164,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
 
 static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
 {
-    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
-    uint32_t *cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
-    unsigned int hdm_count;
-    uint32_t cap;
-    uint64_t dpa_base = 0;
-    int i;
-
-    cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
-    hdm_count = cxl_decoder_count_dec(FIELD_EX32(cap,
-                                                 CXL_HDM_DECODER_CAPABILITY,
-                                                 DECODER_COUNT));
-
-    for (i = 0; i < hdm_count; i++) {
-        uint64_t decoder_base, decoder_size, hpa_offset, skip;
-        uint32_t hdm_ctrl, low, high;
-        int ig, iw;
-
-        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc);
-        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc);
-        decoder_base = ((uint64_t)high << 32) | (low & 0xf0000000);
-
-        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc);
-        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc);
-        decoder_size = ((uint64_t)high << 32) | (low & 0xf0000000);
-
-        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_LO +
-                       i * hdm_inc);
-        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_HI +
-                        i * hdm_inc);
-        skip = ((uint64_t)high << 32) | (low & 0xf0000000);
-        dpa_base += skip;
-
-        hpa_offset = (uint64_t)host_addr - decoder_base;
-
-        hdm_ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * hdm_inc);
-        iw = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IW);
-        ig = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IG);
-        if (!FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
-            return false;
-        }
-        if (((uint64_t)host_addr < decoder_base) ||
-            (hpa_offset >= decoder_size)) {
-            int decoded_iw = cxl_interleave_ways_dec(iw, NULL);
-
-            if (decoded_iw == 0) {
-                return false;
-            }
-
-            dpa_base += decoder_size / decoded_iw;
-            continue;
-        }
-
-        if (iw < 8) {
-            *dpa = dpa_base +
-                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
-                 ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset)
-                  >> iw));
-        } else {
-            *dpa = dpa_base +
-                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
-                 ((((MAKE_64BIT_MASK(ig + iw, 64 - ig - iw) & hpa_offset)
-                   >> (ig + iw)) / 3) << (ig + 8)));
-        }
-
-        return true;
-    }
-    return false;
+    return cxl_host_addr_to_dpa(&ct3d->cxl_cstate, host_addr, dpa);
 }
 
 static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index ffc8220220..7929a39b73 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -327,6 +327,9 @@ uint8_t cxl_interleave_ways_enc(int iw, Error **errp);
 int cxl_interleave_ways_dec(uint8_t iw_enc, Error **errp);
 uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp);
 
+bool cxl_host_addr_to_dpa(CXLComponentState *cxl_cstate, hwaddr host_addr,
+                          uint64_t *dpa);
+
 hwaddr cxl_decode_ig(int ig);
 
 CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb);
-- 
2.53.0



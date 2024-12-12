Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFA6E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 13:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLisi-0006Qz-Hi; Thu, 12 Dec 2024 08:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiw@nvidia.com>) id 1tLisW-0006Ne-CJ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:05:16 -0500
Received: from mail-bn8nam12on2062c.outbound.protection.outlook.com
 ([2a01:111:f403:2418::62c]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiw@nvidia.com>) id 1tLisP-00087q-9y
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:05:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyxwhA8ysWo5eeWqI04nGbbcxF4Yy2Tf7Eu5+mUtYJmIUR6e9VXoJn8d6++0UfdxLRy5TaueWJQhp7KX1/EP4vhZi/qp7Ed5Qyc2/izbxqlt7NDZqHOxKVVFjYsTfLV8TxFKjKOSRJTLPqbC1siVewo3+puKFi04ATjf/P7UDAEEHaTNSZRVQNbg2KxWBH7v2QgZ8hlgwfQdAT1rD/8txyeyn/E8qAhJDZ1vguCFtv4/ba6DUdPA3PPc6Z+zV+ROHVT4NewOvQrC879ejuS3VfSAfUz2JCuCosU1G0v2BI01m6aGoXC8zLBJ0fmKTsZZRKHdNv8pg295qAzQAb6qPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0LBf0quhRM0Sm/fJqtjJJjJGBk1t5FnKCPb5PNQllM=;
 b=lgs7nOaR1EkLoz+Iygp1tFFaA7RPZIO/FCF9emHmT3ixZiKnJ3F49Y/ZGQaDIuvXripcDpRLq1Y5LZNKKMlW2cN+t8kAUgYsa6p0x/rf1pmTfOTOYVEd9y32k4W05RtN5MxseUsnzCaooOYoU9au5OwheqXxCoVsKkkX8HeCw8Jvhy5PKkVgwT/6cl75RYskCHSArNk1ECNEzRpIjNuLFBdmarVa3bmJdzsza7ZWaVYzPsfkIOAEwDC/95aLYEABsi6Tp/OJ6t8hBl/LsyhMUHiSkWykxDgPnY5Hzr9T8Pk5/ohu8WucffnIUBhfL8hfoaC4C9vytaTKqsgBDHuR9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0LBf0quhRM0Sm/fJqtjJJjJGBk1t5FnKCPb5PNQllM=;
 b=sc7udf9M8FhxCvs5XiFNh+ju8NSjI58lZNkISgBYqAU8zEZcz7FDYa6XrRtSFW18TfL8hUAVdSiRAUqfpDFQ+cK0cKXeYWXviGq6X1RbQDZaVmIJvgHzdkel3jR08IOpCc1tyj9K0hO1yQyzqusFC2GN1aAZVZZUZLwnga/T54VJakvokPH3rTPs57spZfpz6LmnRjnzMZBpK9ZtbNEexbIrdreFeRDbRlFvuEtlvPcedZSXGms48JKjQk3oe7a6hm4tdm7Pt+K4AN+R0quT4JFqrfV2iMkYhBQIWzJUfyewoNF8tXV9N43ckgagvc3TUdAFOaZlWR8erZjSS88PfQ==
Received: from CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21)
 by CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 13:05:03 +0000
Received: from CH5P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::23)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 13:04:58 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::13) by CH5P222CA0016.outlook.office365.com
 (2603:10b6:610:1ee::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 13:04:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 13:04:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 05:04:46 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Dec 2024 05:04:46 -0800
Received: from inno-linux.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 05:04:45 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
 <jonathan.cameron@huawei.com>, <ira.weiny@intel.com>, <fan.ni@samsung.com>,
 <alex.williamson@redhat.com>, <alucerop@amd.com>, <clg@redhat.com>,
 <acurrid@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiw@nvidia.com>, <zhiwang@kernel.org>
Subject: [PATCH 1/3] hw/cxl: factor out cxl_host_addr_to_dpa()
Date: Thu, 12 Dec 2024 05:04:20 -0800
Message-ID: <20241212130422.69380-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212130422.69380-1-zhiw@nvidia.com>
References: <20241212130422.69380-1-zhiw@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|CH2PR12MB9458:EE_|CYXPR12MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: 488be4c9-036a-4ae7-c1b4-08dd1aad94d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5d9gFmEfcyqFC2+UqeSeDYNj5OEjmtQcz/ELKrakIfuNIrsjNKbGx2UF0NwT?=
 =?us-ascii?Q?0bBNRt54Q374L9cxdV62z97u0WPkZKyXXac1+g5FInW/xyx/+OdqRMjxl6hf?=
 =?us-ascii?Q?PMBlKhH9rjoAEsF0CMk/y+t8bAN5ToxtU7S2MBMJPn5Fiz49M/Lm2gZWuk1o?=
 =?us-ascii?Q?nqFGk4ZAU24OfTA0XG6LZ/XUuAm3KBwRbj7P9xhT8DICumtD2so0Ktzq13LS?=
 =?us-ascii?Q?HlKwg6noU+UdOQFY34LsSjMBlYoNedDnEL3bMa9hG8y4aUenDSc4xaOSm9uw?=
 =?us-ascii?Q?1WYzPSMYWU0QTHC4qglCsA+BrMJKBoa3qKR1d3TVjzOkz1WG2N4sA1yUrhbs?=
 =?us-ascii?Q?lNtRQcrQ4c7JQYUFWIirP1nz6a+yJXVJTttpQFSGOMIM1X7kW2NUD3cucA4i?=
 =?us-ascii?Q?xevuM71NqMnBqQQevs/vm050KzUpTHPivw1BBEENQfeXk9MJyFDAR+9XfKnF?=
 =?us-ascii?Q?qIHreW9LBTGllABP1xjHMYsXwrmbHJyIW7tmsCz2jP59YEVYqKg/10j5sHKL?=
 =?us-ascii?Q?/314ujcFq/p7iaGlqMFF3gcmVUkAfv+uvtBDTzHCHzWl2ij9agGDEJuexrHP?=
 =?us-ascii?Q?x9Vse7o1jjr0etOGg6bywwr1ITqUA677DjCTuYjqd2hMi5HUk7blU15RnU7s?=
 =?us-ascii?Q?mJ6aJXb9EhFlvFvBy0KUKZO08elxtrrT/6d6S4FANYeAc6e5AcIfpf5TKlus?=
 =?us-ascii?Q?uvlyj+ef6DiH5ZCRRuqSd3YcbazmcG83+GnqL++sMk7WHFyPUoi8RSDvoj4q?=
 =?us-ascii?Q?Ir8CnjDwDMSlHX02sqvS/k/FZwBljWl3ybagdBUN3t4EMPKTLEI1Y/Ka1y3f?=
 =?us-ascii?Q?jrAQPLeO62ywbLlM2ezcrcwAjw3BgQEEqQiV29NygG+F/nMV13A5drMqO22U?=
 =?us-ascii?Q?uC0rk0NfbtsWkvxqrg6tjZXqAv1CFzV3gEOwULFSheb4PGco9kGCVD7WKZ/e?=
 =?us-ascii?Q?KfaF3CxzFW+REDR9qh91tVgdUGj9Hx1+4fiLjkGdXu1/tAVun9oEsICRH/wA?=
 =?us-ascii?Q?5c/ONpcZq6bMm/iw62tqhWfQ2WXwF805QKTnmoSGKDmfJXSTsckp/dh+SonD?=
 =?us-ascii?Q?t1VeCTgb51/DqEozm/jAu6gKRwUHRPIHnmImZHpzZ9pPZCDwL3xlUg/pKUbH?=
 =?us-ascii?Q?tTh/38jIQLssqs1IH7WEMBHv6mPGGKccxi98MbyTB7A54fKz63URmFYfsNzt?=
 =?us-ascii?Q?ia1jtmKhJT+AXqaLtml2Zuq81szsHK6sWQ3ARy1SIktPGKpAitlUCJVq9645?=
 =?us-ascii?Q?3knQS3uXaedmWBeCzfLM+6ArZMwaaa2hTGo3sawAgDIsllEMIBnKY+hjc0g3?=
 =?us-ascii?Q?NF5AG/i0FLVZs2gR0X/V33S+KZ8JhSI9ucfzPk8IDWn2vvGCwXpHlOl+koe+?=
 =?us-ascii?Q?oluelLAvAQY6qA0lUG348ndz/2VC3XaIJWeWt0Zo5KdmPOtDmnv9/HX/BIkQ?=
 =?us-ascii?Q?j6ENMA08H0nUgoohCexYfD0v/Dt4FThn?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 13:04:58.3879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 488be4c9-036a-4ae7-c1b4-08dd1aad94d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318
Received-SPF: softfail client-ip=2a01:111:f403:2418::62c;
 envelope-from=zhiw@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The emulated CXL type-3 device needs to translate the host_addr to the DPA
when a guest accessing a CXL region. It is implemented in cxl_type3_dpa().

However, other type of CXL devices requires the same routine. E.g. an
emulated CXL type-2 device.

Factor out the routine from the emulated CXL type-3 device.

No functional change is intended.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 hw/cxl/cxl-component-utils.c   | 65 ++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c             | 61 +------------------------------
 include/hw/cxl/cxl_component.h |  3 ++
 3 files changed, 69 insertions(+), 60 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index cd116c0401..aa5fb20d25 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -531,3 +531,68 @@ uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp)
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
+            int decoded_iw = cxl_interleave_ways_dec(iw, &error_fatal);
+
+            if (decoded_iw == 0) {
+                return false;
+            }
+
+            dpa_base += decoder_size / decoded_iw;
+            continue;
+        }
+
+        *dpa = dpa_base +
+            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
+             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset)
+              >> iw));
+
+        return true;
+    }
+    return false;
+}
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5cf754b38f..6a56b6de64 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1038,66 +1038,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
 
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
-            int decoded_iw = cxl_interleave_ways_dec(iw, &error_fatal);
-
-            if (decoded_iw == 0) {
-                return false;
-            }
-
-            dpa_base += decoder_size / decoded_iw;
-            continue;
-        }
-
-        *dpa = dpa_base +
-            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
-             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset)
-              >> iw));
-
-        return true;
-    }
-    return false;
+    return cxl_host_addr_to_dpa(&ct3d->cxl_cstate, host_addr, dpa);
 }
 
 static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 945ee6ffd0..abb2e874b2 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -268,6 +268,9 @@ uint8_t cxl_interleave_ways_enc(int iw, Error **errp);
 int cxl_interleave_ways_dec(uint8_t iw_enc, Error **errp);
 uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp);
 
+bool cxl_host_addr_to_dpa(CXLComponentState *cxl_cstate, hwaddr host_addr,
+                          uint64_t *dpa);
+
 hwaddr cxl_decode_ig(int ig);
 
 CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb);
-- 
2.43.5



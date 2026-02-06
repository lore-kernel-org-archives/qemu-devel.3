Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1DEEE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNBJ-0001sT-PY; Fri, 06 Feb 2026 09:51:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAC-0000iL-Ba; Fri, 06 Feb 2026 09:50:28 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNA9-0007PA-WF; Fri, 06 Feb 2026 09:50:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHqWTZwLJsf++U40EWGwOlPi0KM+L2k5nvXhv7G8ZnsjUHqCdQO5vBuJK3hR6CejPtCB6v3uLT7gPrmL8Qy6Lxu2l0OvFbv3DpUb6llhL5fkQfg3uUZSeORtGk0X1IKLfB+Q6Prj9bHs0LGbDvBb8agiZR/UqLgCmzFqFmInND//wUeEcyaFlCl1ut5CDq1f9SlzBfrGx+FMhoEu+VDO9xrUOBPWmnIJdzltsL8E0HCMesJeT4AR3qlqxnXVn/sXvcI31z/cezOedmGz7e03nZjmMtma6H2aUJ6h531oeTTKYe+DcEcsPw2wJuWSf1/9fA3jh9ZKbncmoyoYP9zHgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ra7EtRyEHCtXS1JlmFdVWx7oMg4XOpEvRxedBf6wbb0=;
 b=YohMwSwq94roYXj36JKFmm1IipQjBgeaUdXrRiqhKyQb4ELvSARwYMFkmkkvfvUZ8AuSrMv5sCF995R9AseJWg2sE5vrgfJaQdAZBxdH0RI49Axz6X65almE3WPZ/AIMh1vIXgFxGrM1wJbFRgjG63Y5z8eOsebZ5cW7NwIJCTKULKXcw1+2bG3X5dI5IbQ1ARnPSQYQWHgJVE4/Vhu2r9qBEdnSkbRgg43QFiiVTgqF4nktQZ5qN/UkEB5WG2XxAI/JATXPgFXGhqYCDk+Nqtb8eojjdwrez7SMyG0/b/r9N3Mkxd9HYdRJ5o0a90T+GFs1+F7a+TJz3GRdBSfnQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ra7EtRyEHCtXS1JlmFdVWx7oMg4XOpEvRxedBf6wbb0=;
 b=d8YMaD+aL0JMwWkPQ11GB3CQ3aXhT2dQVBLjZ2jS4nB7o9shkuTHtrsFzrPxmSL1RcI4oizjVlc4y/UadQv6WeCkfK9MNjsGaJ9ybdWdrNz2Pa/UfvDVizoKvUI0rONVvCRUrRMuWzxzzJpAG+LxPaMI1sxb0I3tPkAn9ciCaVXWntLSZo7TER+sI8CDiZpCcdpUaqX8jeue6zPvWLHA31xi9vzqcDFfTYzQ/FOBr7FXHvU2QxzIa/7dH0j2LPnuvS/DYtjX6KFuZcsUinXmdWLKUZ0+v8u34HngLgwwN9a6I28kM2GoAeTNJ6mQ0ho0nDK9ssfGAQs6BgOkX0+zmA==
Received: from PH7P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::19)
 by IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 14:50:11 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::cd) by PH7P223CA0010.outlook.office365.com
 (2603:10b6:510:338::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:50:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:50:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:49 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:46 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 11/24] hw/arm/tegra241-cmdqv: Emulate global and VINTF
 VCMDQ register reads
Date: Fri, 6 Feb 2026 14:48:10 +0000
Message-ID: <20260206144823.80655-12-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206144823.80655-1-skolothumtho@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|IA1PR12MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: e9edd581-e8d0-4e21-daaa-08de658f0701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JBiJgUu6eZ5brimSIshct6zwVj7nnEuuK0B0Ceyy7kFTREypix81P7k9i/XO?=
 =?us-ascii?Q?oWfahQZqPxr4/zDdQvcApUz8zfjJjMaBSMmtTVl1UckNlGL6gpwBv//QAIJO?=
 =?us-ascii?Q?KhgR/Hfpr1NDDMbVmgeUFnVlQCYZ3C3INw43jHke9BEd0uDGYiFzmx16860N?=
 =?us-ascii?Q?BOV5BAP8IeV6ely7rvIRABFo9JNI7c77+gUkImYLtbzHqokEepO76tBHDTcJ?=
 =?us-ascii?Q?y5JW++m3gqXpPQ01+v4ob+uN9eIJpbkqqZxcwY67Ut5DXfXUY2iM91xia6fP?=
 =?us-ascii?Q?Bdr4mgf/LXUJuyc+qoHnWfH6BvfOSq11BOKFHLV5U9Q+TxDnCyvsRPgzOsHh?=
 =?us-ascii?Q?g0rRcL9WTAyxYyQbg9D2yjO6XjUEgocY2FzLiTkwgJvbq7LmaE+ZWaQX8+mg?=
 =?us-ascii?Q?P/tsULhFVVu17jn2Y5v/NFEriVl8as1YWtymTUUZAxpFZhW4rpUM9q3UMJ2j?=
 =?us-ascii?Q?+tsooIpma19x8Ps/fM4Kb7xI3MyUoeMcpM+C3uxSNKFY1kLROzqyphOFivR+?=
 =?us-ascii?Q?KIyhCHT2gExCjeBgJW6BTOZuYyG37k5oiJFd+c8o1ooRgfNHNBkF/BZMv9Dq?=
 =?us-ascii?Q?L9rb3Y7mIosU00Zbp5JK3Hzoe8pZ1ceMgOWFPs7WvAIwWPG8bAmxkAVAFQGb?=
 =?us-ascii?Q?h+3nu4GXb5CToA5KkTGIol5/6rxZWI/LbCr+lBTspyl6p7y0XloPx9O6b9Kc?=
 =?us-ascii?Q?wZEO7unto8dt2oq0HNa4+VweHZf5x5B6I+SwT0XiFp+XFStzWDKbfhejTkJj?=
 =?us-ascii?Q?0ic/d/wXOZR7cv3Aw9aFprjsZi+ciE+E9hb+lkrd4p1b2JnLQv9FO2WxxQFN?=
 =?us-ascii?Q?QS+FH3dqPtZAwwblNvxaZPV09DPx4Xo1423MNViAE1pUl9UlN9vj/3BTtush?=
 =?us-ascii?Q?o48dqe+p04BXevbfvQu5H3MelcbCiSUt7Quzz3HuMdxBI/yxgTDoqwlwzpmt?=
 =?us-ascii?Q?n1l78zL3wZ74D0eyrU5cFgA3yQ/H4HdErRr6xEYsgJ1LT2H2NakPwqT26Pme?=
 =?us-ascii?Q?l4Sg3l96nMrNTATYoRAZM2eZT1l0B9seK5OgQXCw80btdvyoOKBWIqNKQmkS?=
 =?us-ascii?Q?D2+WUJB33coKW5+L0Ph6GlEQPxkZMwnP6sHBeyoWKR+q0Bx/FuFvg2xu/Bgd?=
 =?us-ascii?Q?e/7tFyhylTxyYxnwS1/u4CzYLNNnbMUbfKxTHIbcsvTFGDscVCUKr1ktvh//?=
 =?us-ascii?Q?Y/ryhRa537dEaHhtS66G5i7OtBQqWHX5Xm9D84gWxOivXhkKkJ8QSy/VRcDP?=
 =?us-ascii?Q?6N0RqLY8Sm6GNhyTBRSDeY+6EACIf4qUavAJlXWgltqy2tQ2BrONGdrVAxcM?=
 =?us-ascii?Q?GsmgLWSrl3UCdqYK///y90/MNw/GnjC15ZFRlCCYy8EcjK5Rw20aMCaeoZ03?=
 =?us-ascii?Q?Mx9NW7PpDTDhKynWVGchiRYzT3lzpZIbJplV4vZuS/jOKTdzMwFRiQXixHRR?=
 =?us-ascii?Q?iLbg979S7hOE9b7BfY66eklGOe8Vhdp8lyvI+NPVAc6KDXFP0+KAa8QrJl8H?=
 =?us-ascii?Q?5ClsZu8WFlUMw4GqW3lfWuUVHUrpmvZH5pEdN0aMRIv2VpoZTNJu74vIS8B5?=
 =?us-ascii?Q?Hlo7KhEUpiSRiSHF5LWEIKPhm2Wldli1scY0DBoerrQYXIidUSwLLa3gt5lw?=
 =?us-ascii?Q?uPzO43rq8Ai7BBui+dj8gd2QEyrsl7WbtvddOKOQaPhuBFx8TRbh8g6XY2XW?=
 =?us-ascii?Q?TwZbng=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iJejS8pHr6d4353DZQA/aR6jrUyeom+BOQZEQndGEqkjEZIB2bRYUz5YeFNY9DHSF/4iuKfPNRnKsk93DICUSqMWiJh39d9Vek1fmNxSMSmBVEzXUhxLpcMqYyBDOm6wCVWDgzarOo0wk22LfGadg0gPuUOiwgXB+Pejormfmo4yyFObPIwbpuE+XNQqTkC7OXBK//U3Pr4kDZBCi4Kr+WZPvK/OE9uSOmqxFK5Sv5Sl31bFEiLdTOsQgutIo6Qk6e1M52twl4lQI7jOXIDOo+pZYVCkraDM6shs6goHCwm3ft4WwOtjR9mqN3Ehmyo6XizpmXFS6HgoyLcxE+sLPYUdf6UCp2V12oq/J3qDU5sUkLtwXRUxKENVBjAA0n0lX9w070P4SPxITHz1u51BmdunjxM10Tjmjy/OyQikcWPUZcl52uf08+gy7kgdYsvL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:50:10.4394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9edd581-e8d0-4e21-daaa-08de658f0701
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Nicolin Chen <nicolinc@nvidia.com>

Tegra241 CMDQV exposes per-VCMDQ register windows through two MMIO views:

  -Global VCMDQ registers at 0x10000/0x20000
  -VINTF VCMDQ (VI_VCMDQ) registers at 0x30000/0x40000

The VI_VCMDQ register ranges are an alias of the global VCMDQ registers
and are only meaningful when a VCMDQ is mapped to a VINTF via ioctl
IOMMU_HW_QUEUE_ALLOC.

Add read side emulation for both global VCMDQ and VI_VCMDQ register
ranges. MMIO accesses are decoded to extract the VCMDQ instance index
and normalized to a VCMDQ0_* register offset, allowing a single helper
to service all VCMDQ instances.

VI_VCMDQ accesses are translated to their equivalent global VCMDQ
offsets and reuse the same decoding path. All VCMDQ reads are currently
served from cached register state.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c |  75 +++++++++++++++
 hw/arm/tegra241-cmdqv.h | 197 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 272 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 49fca9d536..4d447718d0 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -33,6 +33,46 @@ static bool tegra241_cmdqv_mmap_vintf_page0(Tegra241CMDQV *cmdqv, Error **errp)
     return true;
 }
 
+/*
+ * Read a VCMDQ register using VCMDQ0_* offsets.
+ *
+ * The caller normalizes the MMIO offset such that @offset0 always refers
+ * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
+ *
+ * All VCMDQ accesses are currently trapped. Use cached registers
+ */
+static uint64_t tegra241_cmdqv_read_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0,
+                                          int index)
+{
+    switch (offset0) {
+    case A_VCMDQ0_CONS_INDX:
+        return cmdqv->vcmdq_cons_indx[index];
+    case A_VCMDQ0_PROD_INDX:
+        return cmdqv->vcmdq_prod_indx[index];
+    case A_VCMDQ0_CONFIG:
+        return cmdqv->vcmdq_config[index];
+    case A_VCMDQ0_STATUS:
+        return cmdqv->vcmdq_status[index];
+    case A_VCMDQ0_GERROR:
+        return cmdqv->vcmdq_gerror[index];
+    case A_VCMDQ0_GERRORN:
+        return cmdqv->vcmdq_gerrorn[index];
+    case A_VCMDQ0_BASE_L:
+        return cmdqv->vcmdq_base[index];
+    case A_VCMDQ0_BASE_H:
+        return cmdqv->vcmdq_base[index] >> 32;
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
+        return cmdqv->vcmdq_cons_indx_base[index];
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_H:
+        return cmdqv->vcmdq_cons_indx_base[index] >> 32;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled read access at 0x%" PRIx64 "\n",
+                      __func__, offset0);
+        return 0;
+    }
+}
+
 static uint64_t tegra241_cmdqv_read_vintf(Tegra241CMDQV *cmdqv, hwaddr offset)
 {
     int i;
@@ -56,6 +96,7 @@ static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
 {
     Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
     Error *local_err = NULL;
+    int index;
 
     if (!cmdqv->vintf_page0) {
         if (!tegra241_cmdqv_mmap_vintf_page0(cmdqv, &local_err)) {
@@ -88,6 +129,40 @@ static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
         return cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4];
     case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
         return tegra241_cmdqv_read_vintf(cmdqv, offset);
+    case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ127_GERRORN:
+        /*
+         * VI_VCMDQ registers (VINTF logical view) have the same per-VCMDQ
+         * layout as the global VCMDQ registers, but are based at 0x30000
+         * instead of 0x10000.
+         *
+         * Subtract 0x20000 to translate a VI_VCMDQ offset into the equivalent
+         * global VCMDQ offset, then fall through to reuse the common VCMDQ
+         * decoding logic below.
+         */
+        offset -= 0x20000;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_CONS_INDX ... A_VCMDQ127_GERRORN:
+        /*
+         * Decode a per-VCMDQ register access.
+         *
+         * VCMDQs are 128 identical instances, each occupying a 0x80-byte window
+         * starting at 0x10000. The MMIO offset is decoded to extract the VCMDQ
+         * index, and the per-instance offset is normalized to a VCMDQ0_*
+         * register (@offset0 = offset - 0x80 * index).
+         *
+         * A single helper then services all VCMDQs, with @index selecting the
+         * instance.
+         */
+        index = (offset - 0x10000) / 0x80;
+        return tegra241_cmdqv_read_vcmdq(cmdqv, offset - 0x80 * index, index);
+    case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ127_CONS_INDX_BASE_DRAM_H:
+        /* Same as A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ127_GERRORN case above */
+        offset -= 0x20000;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_BASE_L ... A_VCMDQ127_CONS_INDX_BASE_DRAM_H:
+        /* Same as A_VCMDQ0_CONS_INDX ... A_VCMDQ127_GERRORN case above */
+        index = (offset - 0x20000) / 0x80;
+        return tegra241_cmdqv_read_vcmdq(cmdqv, offset - 0x80 * index, index);
     default:
         qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
                       __func__, offset);
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index f157c8fd24..1bc03c4f97 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -43,6 +43,14 @@ typedef struct Tegra241CMDQV {
     uint32_t vintf_config;
     uint32_t vintf_status;
     uint32_t vintf_cmdq_err_map[4];
+    uint32_t vcmdq_cons_indx[128];
+    uint32_t vcmdq_prod_indx[128];
+    uint32_t vcmdq_config[128];
+    uint32_t vcmdq_status[128];
+    uint32_t vcmdq_gerror[128];
+    uint32_t vcmdq_gerrorn[128];
+    uint64_t vcmdq_base[128];
+    uint64_t vcmdq_cons_indx_base[128];
 } Tegra241CMDQV;
 
 /* Global CMDQV MMIO registers (offset 0x00000) */
@@ -118,7 +126,196 @@ A_VINTFi_LVCMDQ_ERR_MAP_(0, 0)
 /* Omitting [0][1~2] as not being directly called */
 A_VINTFi_LVCMDQ_ERR_MAP_(0, 3)
 
+/*
+ * VCMDQ register windows.
+ *
+ * Page 0 @ 0x10000: VCMDQ control and status registers
+ * Page 1 @ 0x20000: VCMDQ base and DRAM address registers
+ */
+#define A_VCMDQi_CONS_INDX(i)                       \
+    REG32(VCMDQ##i##_CONS_INDX, 0x10000 + i * 0x80) \
+    FIELD(VCMDQ##i##_CONS_INDX, RD, 0, 20)          \
+    FIELD(VCMDQ##i##_CONS_INDX, ERR, 24, 7)
+
+A_VCMDQi_CONS_INDX(0)
+/* Omitting [1~126] as not being directly called */
+A_VCMDQi_CONS_INDX(127)
+
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_NONE 0
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_ILL_OPCODE 1
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_ABT 2
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_ATC_INV_SYNC 3
+#define V_VCMDQ_CONS_INDX_ERR_CERROR_ILL_ACCESS 4
+
+#define A_VCMDQi_PROD_INDX(i)                             \
+    REG32(VCMDQ##i##_PROD_INDX, 0x10000 + 0x4 + i * 0x80) \
+    FIELD(VCMDQ##i##_PROD_INDX, WR, 0, 20)
+
+A_VCMDQi_PROD_INDX(0)
+/* Omitting [1~126] as not being directly called */
+A_VCMDQi_PROD_INDX(127)
+
+#define A_VCMDQi_CONFIG(i)                             \
+    REG32(VCMDQ##i##_CONFIG, 0x10000 + 0x8 + i * 0x80) \
+    FIELD(VCMDQ##i##_CONFIG, CMDQ_EN, 0, 1)
+
+A_VCMDQi_CONFIG(0)
+/* Omitting [1~126] as not being directly called */
+A_VCMDQi_CONFIG(127)
+
+#define A_VCMDQi_STATUS(i)                             \
+    REG32(VCMDQ##i##_STATUS, 0x10000 + 0xc + i * 0x80) \
+    FIELD(VCMDQ##i##_STATUS, CMDQ_EN_OK, 0, 1)
+
+A_VCMDQi_STATUS(0)
+/* Omitting [1~126] as not being directly called */
+A_VCMDQi_STATUS(127)
+
+#define A_VCMDQi_GERROR(i)                               \
+    REG32(VCMDQ##i##_GERROR, 0x10000 + 0x10 + i * 0x80)  \
+    FIELD(VCMDQ##i##_GERROR, CMDQ_ERR, 0, 1)             \
+    FIELD(VCMDQ##i##_GERROR, CONS_DRAM_WR_ABT_ERR, 1, 1) \
+    FIELD(VCMDQ##i##_GERROR, CMDQ_INIT_ERR, 2, 1)
+
+A_VCMDQi_GERROR(0)
+/* Omitting [1~126] as not being directly called */
+A_VCMDQi_GERROR(127)
+
+#define A_VCMDQi_GERRORN(i)                               \
+    REG32(VCMDQ##i##_GERRORN, 0x10000 + 0x14 + i * 0x80)  \
+    FIELD(VCMDQ##i##_GERRORN, CMDQ_ERR, 0, 1)             \
+    FIELD(VCMDQ##i##_GERRORN, CONS_DRAM_WR_ABT_ERR, 1, 1) \
+    FIELD(VCMDQ##i##_GERRORN, CMDQ_INIT_ERR, 2, 1)
+
+A_VCMDQi_GERRORN(0)
+/* Omitting [1~126] as not being directly called */
+A_VCMDQi_GERRORN(127)
+
+#define A_VCMDQi_BASE_L(i)                       \
+    REG32(VCMDQ##i##_BASE_L, 0x20000 + i * 0x80) \
+    FIELD(VCMDQ##i##_BASE_L, LOG2SIZE, 0, 5)     \
+    FIELD(VCMDQ##i##_BASE_L, ADDR, 5, 27)
+
+A_VCMDQi_BASE_L(0)
+/* Omitting [1~126] as not being directly called */
+A_VCMDQi_BASE_L(127)
+
+#define A_VCMDQi_BASE_H(i)                             \
+    REG32(VCMDQ##i##_BASE_H, 0x20000 + 0x4 + i * 0x80) \
+    FIELD(VCMDQ##i##_BASE_H, ADDR, 0, 16)
+
+A_VCMDQi_BASE_H(0)
+/* Omitting [1~126] as not being directly called */
+A_VCMDQi_BASE_H(127)
+
+#define A_VCMDQi_CONS_INDX_BASE_DRAM_L(i)                             \
+    REG32(VCMDQ##i##_CONS_INDX_BASE_DRAM_L, 0x20000 + 0x8 + i * 0x80) \
+    FIELD(VCMDQ##i##_CONS_INDX_BASE_DRAM_L, ADDR, 0, 32)
+
+A_VCMDQi_CONS_INDX_BASE_DRAM_L(0)
+/* Omitting [1~126] as not being directly called */
+A_VCMDQi_CONS_INDX_BASE_DRAM_L(127)
+
+#define A_VCMDQi_CONS_INDX_BASE_DRAM_H(i)                             \
+    REG32(VCMDQ##i##_CONS_INDX_BASE_DRAM_H, 0x20000 + 0xc + i * 0x80) \
+    FIELD(VCMDQ##i##_CONS_INDX_BASE_DRAM_H, ADDR, 0, 16)
+
+A_VCMDQi_CONS_INDX_BASE_DRAM_H(0)
+/* Omitting [1~126] as not being directly called */
+A_VCMDQi_CONS_INDX_BASE_DRAM_H(127)
+
 #define VINTF_REG_PAGE_SIZE 0x10000
+/*
+ * VI_VCMDQ register windows (VCMDQs mapped via VINTF).
+ *
+ * Page 0 @ 0x30000: VI_VCMDQ control and status registers
+ * Page 1 @ 0x40000: VI_VCMDQ base and DRAM address registers
+ */
+#define A_VI_VCMDQi_CONS_INDX(i)                       \
+    REG32(VI_VCMDQ##i##_CONS_INDX, 0x30000 + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_CONS_INDX, RD, 0, 20)          \
+    FIELD(VI_VCMDQ##i##_CONS_INDX, ERR, 24, 7)
+
+A_VI_VCMDQi_CONS_INDX(0)
+/* Omitting [1~126] as not being directly called */
+A_VI_VCMDQi_CONS_INDX(127)
+
+#define A_VI_VCMDQi_PROD_INDX(i)                             \
+    REG32(VI_VCMDQ##i##_PROD_INDX, 0x30000 + 0x4 + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_PROD_INDX, WR, 0, 20)
+
+A_VI_VCMDQi_PROD_INDX(0)
+/* Omitting [1~126] as not being directly called */
+A_VI_VCMDQi_PROD_INDX(127)
+
+#define A_VI_VCMDQi_CONFIG(i)                             \
+    REG32(VI_VCMDQ##i##_CONFIG, 0x30000 + 0x8 + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_CONFIG, CMDQ_EN, 0, 1)
+
+A_VI_VCMDQi_CONFIG(0)
+/* Omitting [1~126] as not being directly called */
+A_VI_VCMDQi_CONFIG(127)
+
+#define A_VI_VCMDQi_STATUS(i)                             \
+    REG32(VI_VCMDQ##i##_STATUS, 0x30000 + 0xc + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_STATUS, CMDQ_EN_OK, 0, 1)
+
+A_VI_VCMDQi_STATUS(0)
+/* Omitting [1~126] as not being directly called */
+A_VI_VCMDQi_STATUS(127)
+
+#define A_VI_VCMDQi_GERROR(i)                               \
+    REG32(VI_VCMDQ##i##_GERROR, 0x30000 + 0x10 + i * 0x80)  \
+    FIELD(VI_VCMDQ##i##_GERROR, CMDQ_ERR, 0, 1)             \
+    FIELD(VI_VCMDQ##i##_GERROR, CONS_DRAM_WR_ABT_ERR, 1, 1) \
+    FIELD(VI_VCMDQ##i##_GERROR, CMDQ_INIT_ERR, 2, 1)
+
+A_VI_VCMDQi_GERROR(0)
+/* Omitting [1~126] as not being directly called */
+A_VI_VCMDQi_GERROR(127)
+
+#define A_VI_VCMDQi_GERRORN(i)                               \
+    REG32(VI_VCMDQ##i##_GERRORN, 0x30000 + 0x14 + i * 0x80)  \
+    FIELD(VI_VCMDQ##i##_GERRORN, CMDQ_ERR, 0, 1)             \
+    FIELD(VI_VCMDQ##i##_GERRORN, CONS_DRAM_WR_ABT_ERR, 1, 1) \
+    FIELD(VI_VCMDQ##i##_GERRORN, CMDQ_INIT_ERR, 2, 1)
+
+A_VI_VCMDQi_GERRORN(0)
+/* Omitting [1~126] as not being directly called */
+A_VI_VCMDQi_GERRORN(127)
+
+#define A_VI_VCMDQi_BASE_L(i)                       \
+    REG32(VI_VCMDQ##i##_BASE_L, 0x40000 + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_BASE_L, LOG2SIZE, 0, 5)     \
+    FIELD(VI_VCMDQ##i##_BASE_L, ADDR, 5, 27)
+
+A_VI_VCMDQi_BASE_L(0)
+/* Omitting [1~126] as not being directly called */
+A_VI_VCMDQi_BASE_L(127)
+
+#define A_VI_VCMDQi_BASE_H(i)                             \
+    REG32(VI_VCMDQ##i##_BASE_H, 0x40000 + 0x4 + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_BASE_H, ADDR, 0, 16)
+
+A_VI_VCMDQi_BASE_H(0)
+/* Omitting [1~126] as not being directly called */
+A_VI_VCMDQi_BASE_H(127)
+
+#define A_VI_VCMDQi_CONS_INDX_BASE_DRAM_L(i)                             \
+    REG32(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_L, 0x40000 + 0x8 + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_L, ADDR, 0, 32)
+
+A_VI_VCMDQi_CONS_INDX_BASE_DRAM_L(0)
+/* Omitting [1~126] as not being directly called */
+A_VI_VCMDQi_CONS_INDX_BASE_DRAM_L(127)
+
+#define A_VI_VCMDQi_CONS_INDX_BASE_DRAM_H(i)                             \
+    REG32(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_H, 0x40000 + 0xc + i * 0x80) \
+    FIELD(VI_VCMDQ##i##_CONS_INDX_BASE_DRAM_H, ADDR, 0, 16)
+
+A_VI_VCMDQi_CONS_INDX_BASE_DRAM_H(0)
+/* Omitting [1~126] as not being directly called */
+A_VI_VCMDQi_CONS_INDX_BASE_DRAM_H(127)
 
 #ifdef CONFIG_TEGRA241_CMDQV
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_ops(void);
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EA5CF8856
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 13:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM4fs-0003TV-G3; Thu, 20 Nov 2025 08:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4fg-00031H-Uq; Thu, 20 Nov 2025 08:26:01 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vM4ff-0002hQ-0s; Thu, 20 Nov 2025 08:26:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yt1lcM1X9+RQ9zp7dwzPGqO0+9TgkXJz1aiFon0RRS6jXQSREm9DNFNZnhnY25GTCqNsOmeVUMswCneIi7PTKsZwvpbU8a6b1BKFt7sbY3uU87GzDUPYg97xoILziS8pVrT2aupEG1KH5yPNt2Nsh1yKpCLy4mzDJJ0vnwgyQhZZWpwUBRf+L4v3Cp4TnleQ6bFk/O2mUqkoo/9Ph6LfIBTmiIXDBWsF/PuD0S/GQJzvmuH1JBmuXUVnbpXqz/a+WwXhFLWtTndFGcrxeoMJscluM301itDLut68JExuZsNWo+QvmI9fUXu0gZmp/D6Pm0BPz69YdcZJg4EJemEunw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JnvR5bBjD2DzmVS22P85Q35KXuUEW+WysfADjag8go=;
 b=kwv1YSnLZqjv0an7i/APP6jtWsw/taD37bfI1hhZ1KGup2ATNSlld4Bs0Zig8dM/QtYMupKsqb5dpu2QbJ3dbsiz/9VCCU+AOkEK6Quw5sVQQSV9dqCaJ1vOnZMVig/4giDMAiJurNO3thqSpAAhlhehuFjxWXXzxSYnXQOOHsF4BTzLnwOCqm/ecsQwN+/GaOHimPPMJR5Ri9CYEXj2GcE/XfK4q77ZhTBNtibWyMw0MHzapaNCjimSeHOZIIUBHMH7KwyBfwFFfW8jVDprMoCkarTTJ0b9auD47oBmA+jEpFSlj44QqWLVW3nkqm959HKOXfYr9Zn6NeYPVK2bkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JnvR5bBjD2DzmVS22P85Q35KXuUEW+WysfADjag8go=;
 b=iEU2DR/T3Hn/xupqOdhIi5uRXDfwbt27iNdSP/3mUsEDECZMSLWsQUa3o47fk/G1wtEYs20hcVnowzYeaBwPS9/vbNQ4ggBW7PDpFFACPixGyJCrBa0J9uaeaydl5I+3e8WJSjZuAMcHJOzROh1OQzObUmTBSAiQquu+WGArB1QUdvr9MY9Pv4G4uwmmfP26Xtr6SgmgFbVU1+6pRi5kh6pH0Kw28urjq9koDUhY+Qs3OsA7wym9mW+Z4cioViDgFlADGalSe30FoOoHYVE0T3emVd5spPqJtSHz3ahtgTEOMOIGmz1nKXLZcQyZEbWRnJ8ylaFEiIWHO4HZn5qMjg==
Received: from MW4PR04CA0087.namprd04.prod.outlook.com (2603:10b6:303:6b::32)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Thu, 20 Nov
 2025 13:25:41 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::19) by MW4PR04CA0087.outlook.office365.com
 (2603:10b6:303:6b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 13:25:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:25:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:25:23 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:25:19 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v6 29/33] hw/arm/smmuv3-accel: Add property to specify OAS bits
Date: Thu, 20 Nov 2025 13:22:09 +0000
Message-ID: <20251120132213.56581-30-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|IA0PR12MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a982b58-0d83-4db6-3a8d-08de28384d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnRtZmxGKytJRlpJVmZlQjRzQ0RKK0tjMG1VSUhZZWpFak43WUphSUVPRktu?=
 =?utf-8?B?ZzVNVFc5RWdVYnpVdFBaclFLeHBiL1hDZExjM0xZb2NGdUhMRDdKTE9NSUIw?=
 =?utf-8?B?dFlWd3phQkF0Z2F5UmZuTzgyckl0clZCYXZaRkYxTVhNdURTaXR3azNiWUZQ?=
 =?utf-8?B?MkZML0d3TDljSE8wT0t1ZDJxankyaHc2cE5QMXMyVHVEZzcvWFBIU0lJOHNy?=
 =?utf-8?B?R0RWdHU5TFM2cGtSblQ1RkR3U3JJcGdndDQvT3RKLzlZTExTekk1T0lmQXpO?=
 =?utf-8?B?SC9wTy82aVJoMHNxZjh3aWFjOXgycFUvVllxdFhWMm4rS1JhWDZpSUN0VzhI?=
 =?utf-8?B?U1ZnN3RoMXdzcmxFRkE1U0Qva2h0SWZncHJzWjJZbXBnTXd6Tnh6T0R3dm0w?=
 =?utf-8?B?dGVwanhQVkZCbjdlSHU5MjVHN3o4Q0VGeEJUSFlZVkNLa3NYRFNEVkZiU1BH?=
 =?utf-8?B?QnozelZXMTI2RDlTWER2TVFLZ3h0Wm5Od04yenNDdW5tdllCSzBLTm5XbWwy?=
 =?utf-8?B?UkdjdlFEdDVBQld4ZWI0QXNuV2RDRnFVNkdiYldtbnJtL3lZaHdNTkphWU5u?=
 =?utf-8?B?eUwxR1g3MmZqOHBXaCtPVkJEdkVLK1o3eW1wenU4b0RRQUpuV2RTRVNwYjBr?=
 =?utf-8?B?dzF4OXQwR2dwQkUxaFV3M3JiL2p1RHJ2NlV1dFBHbU5wU1hjMERNd0lTd2pZ?=
 =?utf-8?B?VUQrUHI0N2NyTzJuWTFhZkx5ZkxkeVRpdngrSVI0czRRRjR0YjUxcUFWVzYy?=
 =?utf-8?B?bG5kbHF1bUpBVlJaUWttclp0TGtzU2tMcG91Q2FDKzBVclJ6Q1dtNWZhMlVq?=
 =?utf-8?B?Y0RCZGltQjdHcUdLNDVaTllWOTlVYko2d2ZMd2pRMXhOTU9aakthOG5vUlBp?=
 =?utf-8?B?NjlqT21EZUcwZ1IxN2VrQ004SE4wOVJMS3B0VU9CVzRvUXBjMFFwaEhORkY0?=
 =?utf-8?B?TWlRYzNuS1FaaGszU3BDTHZSYjhhZ2htRDRsUFV3Y2tyT2Z6NlBNaHkwblZY?=
 =?utf-8?B?cWZuRGZNUUlDRk14cGN4bVNLMG1XUjhWQ09HMjNJY2t6ek0zSStFTnJaNWpF?=
 =?utf-8?B?VURaU29sVlN0NnVuYXNROUNMSGw5djJqelRVU0IxWHVrN3JsU3padEp6U0dN?=
 =?utf-8?B?WTcyQXNHS3ZjVlM1d0d4OGY5SlZnZ1RCaVcwK205VDZRUFZhN2ZQUmlxK3da?=
 =?utf-8?B?YVUrWmpES3lsWTFKWlM4UzZBZXNoNHZFaHNYUHlKNDJMK292bENnMVpSQjFR?=
 =?utf-8?B?TkM4WHZTaytpVmo1VHJkdERyTXVCSDFMSm84WW5HMmo5L25HcHgxc2d3cDRz?=
 =?utf-8?B?SzNpSmNaa3V3V21WMXVyRTBVd0lNdGRtbGJwTGI4TzlyVk52T2dCdU94V05E?=
 =?utf-8?B?QWt2Y0ltbisycEpTTGtRcVdxU1F1aDZ0RHZrYjYxOUkvOE5iNS9SSk1nNTR6?=
 =?utf-8?B?bXRzOWVMcVJ1WVlyZHI1THJQdUV3RlJHcDY1NFg1T0J2dlRFMGhtWTJ0alY3?=
 =?utf-8?B?SzVMYm1kVFJLODFHMVR0Tkw5UU15d2VKWDZEK3QrZVl1dFdZdVhDbXBPbUhp?=
 =?utf-8?B?OHZGbGM2UUU4aEF0QTBaT2IxcXlqSDYxUS9FWUVrbXpSS3J2dlBmNW5BY1Ax?=
 =?utf-8?B?a3hwcW5KQjRQWjY2Mkw0RGRYR3pKc3dyMUdjUUUyYXp6bG5FUzVEMXE5TlVi?=
 =?utf-8?B?Y1pLeXpqaVg5TDJQM2ZPK2FuL256djFSWVV0d3d6dnFYZ1BtN0hQRVBoN245?=
 =?utf-8?B?aFpPaEZkRmQxSG9jNFdVLytLU3dDc0R1UVcvS201bzRwQm9HSnJEVmdQY1Ay?=
 =?utf-8?B?RDJVQ2pkR3dqOHEzeFlMNnFyZXhLNmZneU1KNXorZ01idXprRExQdmdseWZQ?=
 =?utf-8?B?b3Bvb3NwSGN1SVBpckkxQjlwdkdqQ1ozRGdIbnlhOEpIcHpiZFFCNDhtWlBE?=
 =?utf-8?B?WC9wd1k4U1RqQTA1cGxEN1pkbHdSYmUxMnFhUWc4OSt0Vzk5RVNRbWZzR2l5?=
 =?utf-8?B?cUdPbjhJOVV5bE0wMzMwci9ydjZnVEUrejBpK09EM2VpR25pQS82WlhUSTlT?=
 =?utf-8?B?ZVNTWmdaTjJ1Q0FsSHV0dFZBSDJOWi83ZHJ4YTJPMU1wa1lVazBRZXpBRmdL?=
 =?utf-8?Q?ZdAI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:25:41.5566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a982b58-0d83-4db6-3a8d-08de28384d7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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

QEMU SMMUv3 currently sets the output address size (OAS) to 44 bits.
With accelerator mode enabled, a device may use SVA, where CPU page tables
are shared with the SMMU, requiring an OAS at least as large as the
CPU’s output address size. A user option is added to configure this.

However, the OAS value advertised by the virtual SMMU must remain
compatible with the capabilities of the host SMMUv3. In accelerated
mode, the host SMMU performs stage-2 translation and must be able to
consume the intermediate physical addresses (IPA) produced by stage-1.

The OAS exposed by the virtual SMMU defines the maximum IPA width that
stage-1 translations may generate. For AArch64 implementations, the
maximum usable IPA size on the host SMMU is determined by its own OAS.
Check that the configured OAS does not exceed what the host SMMU
can safely support.

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c    | 20 ++++++++++++++++++++
 hw/arm/smmuv3-internal.h |  3 ++-
 hw/arm/smmuv3.c          | 16 +++++++++++++++-
 include/hw/arm/smmuv3.h  |  1 +
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 73c7ce586a..35a94c720a 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -27,6 +27,12 @@
 static MemoryRegion root, sysmem;
 static AddressSpace *shared_as_sysmem;
 
+static int smmuv3_oas_bits(uint32_t oas)
+{
+    static const int map[] = { 32, 36, 40, 42, 44, 48, 52, 56 };
+    return (oas < ARRAY_SIZE(map)) ? map[oas] : -EINVAL;
+}
+
 static bool
 smmuv3_accel_check_hw_compatible(SMMUv3State *s,
                                  struct iommu_hw_info_arm_smmuv3 *info,
@@ -68,6 +74,15 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
         error_setg(errp, "Host SMMUv3 doesn't support Range Invalidation");
         return false;
     }
+    /* Check OAS value opted is compatible with Host SMMUv3 IPA */
+    if (FIELD_EX32(info->idr[5], IDR5, OAS) <
+                FIELD_EX32(s->idr[5], IDR5, OAS)) {
+        error_setg(errp, "Host SMMUv3 supports only %d-bit IPA, but the vSMMU "
+                   "OAS implies %d-bit IPA",
+                   smmuv3_oas_bits(FIELD_EX32(info->idr[5], IDR5, OAS)),
+                   smmuv3_oas_bits(FIELD_EX32(info->idr[5], IDR5, OAS)));
+        return false;
+    }
 
     /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
     if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
@@ -650,6 +665,11 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
 
     /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-on by property */
     s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
+
+    /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
+    if (s->oas == 48) {
+        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
+    }
 }
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index a76e4e2484..0f44a4e1d3 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -111,7 +111,8 @@ REG32(IDR5,                0x14)
      FIELD(IDR5, VAX,        10, 2);
      FIELD(IDR5, STALL_MAX,  16, 16);
 
-#define SMMU_IDR5_OAS 4
+#define SMMU_IDR5_OAS_44 4
+#define SMMU_IDR5_OAS_48 5
 
 REG32(IIDR,                0x18)
 REG32(AIDR,                0x1c)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ad476146f6..a7bd4eeb77 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -299,7 +299,8 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
 
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
+    /* OAS: 44 bits */
+    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_44);
     /* 4K, 16K and 64K granule support */
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
@@ -1945,8 +1946,17 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ats can only be enabled if accel=on");
             return false;
         }
+        if (s->oas != 44) {
+            error_setg(errp, "OAS can only be set to 44 bits if accel=off");
+            return false;
+        }
         return true;
     }
+
+    if (s->oas != 44 && s->oas != 48) {
+        error_setg(errp, "OAS can only be set to 44 or 48 bits");
+        return false;
+    }
     return true;
 }
 
@@ -2073,6 +2083,7 @@ static const Property smmuv3_properties[] = {
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
     DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
+    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2103,6 +2114,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). Please ensure host "
         "platform has ATS support before enabling this");
+    object_class_property_set_description(klass, "oas",
+        "Specify Output Address Size (for accel =on). Supported values "
+        "are 44 or 48 bits. Defaults to 44 bits");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 242d6429ed..d488a39cd0 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -71,6 +71,7 @@ struct SMMUv3State {
     Error *migration_blocker;
     bool ril;
     bool ats;
+    uint8_t oas;
 };
 
 typedef enum {
-- 
2.43.0



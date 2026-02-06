Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8053EE20A8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNCT-0003w9-CG; Fri, 06 Feb 2026 09:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAN-0000wL-RW; Fri, 06 Feb 2026 09:50:41 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAL-0007SN-BR; Fri, 06 Feb 2026 09:50:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlABgKGxVSSP+yOgpsKEaapTxAxgMJ/vjRxmTOyIvnvx11IuEZTCsIsqwzGAI6UKFxA5ZmO3tOCDvfoYsl1GylhZ2SWoqiy6ll1Ud0wGA66Bbglj8MBSQRbEt8vMfuo7AryX7aWX/l6sD9Eop+/DvRpH5xZW5hi4LNgen1D+XOtdUY0qkZixb47HtYsgxpo+B6uHdTLE7+G5VBEWaEeH855SXmxMIJYLgGw0IHAQpb+8culyZuisrO54eyKAlJIWAdTFi40u4+JEBBX+3bZ8yzgV/tCk0vN2OXMZRAzclWRwIlDfQhCGdVUy0eQMjpXMWVL+VI9H3qXAJl2WOYdP7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TjOR3CGrF7wZeOYNRPTyWWWV5H2uIQylLWwN+wHG9M=;
 b=tS1L3q8LZSMVijFavlktLVkNlDpuW9eTFW3tYDxP9bg9XMxspRviR2jGMk2iwdXKrsHwkBXQRdjt/mrTr+NqankpgWNC+I63/OfTTnUqNY1UqDKQlajOhG7YSNys1Iar/G0yX4C9/K2+JYr4dkpY/PxeHX14obdM6Y09Zd3c6mD4VxZXeCjl40R6hzBfN1WR5m9XTKzJFGTnjFKDXzw7/CmuUW4K9sHpmOWvyhsC8fpTZuhLnnhcpRmqFPkXhS8j1g4Y64iCGHehEEMvawfPf5QtN5GM1fUq3lXU9IC+f4rKa1V4RIBxw/15dgfKal31k6y5ZWQ7D06KBTMj6Pr17Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TjOR3CGrF7wZeOYNRPTyWWWV5H2uIQylLWwN+wHG9M=;
 b=DYFN4j5KEUmDiXGcigEyoGQkiu8vShkc1UA3PYYEOyLkix8J3dE/nHjLL03zUJO7DL6ITRloL/GMEyoUmymIEtszU4oTYystRk4eEurkMV2Baq4aFEAJWhZs0bOe4Ezock82oa6XS6F8f2jon5vLUVmnf1BRc3+JIwPPw0iMDrJI3B31zXzSKVloPFfKX0iA0kwHJCZkNFUZMvV14wYvFe7czsMu7zVMIjPemRAPfJLO6QqxPRWMydTDGNmI13isfynNjsi7R9z3XyotpNB7H3mJ0UU1clm3DX+HB9ChQwnIxltghdOd5litG5VsvqIp+93vCxQF2vaiFeL6Zd0Deg==
Received: from PH7P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::6)
 by BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 14:50:26 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::20) by PH7P223CA0008.outlook.office365.com
 (2603:10b6:510:338::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:50:21 +0000
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
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:50:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:05 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:02 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 15/24] hw/arm/tegra241-cmdqv: map VINTF page0 MMIO region
Date: Fri, 6 Feb 2026 14:48:14 +0000
Message-ID: <20260206144823.80655-16-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|BL4PR12MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e922e4e-7fb8-4cef-b839-08de658f1007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UdIduXL2C+/fKVR4C3Jop4p+XX0banc58/edr6IHLkwwmVTAWGfAXE8w0Kge?=
 =?us-ascii?Q?pDicVh8xzmX0n5t76X4yego1lNpy8ecUZlnEvWsXGHS8oPpaIHo4is/61cFn?=
 =?us-ascii?Q?2fvz1TuuzSlazDvxFtWCNZVmRoae4601pbseN/tWKU5HIbpLxSbQPOu4BLLF?=
 =?us-ascii?Q?STF4sOBDklqgctkk4LwMyCRXON+9QNL9Z4b6VvbfOhGQHxPnfpLIunYvP7AS?=
 =?us-ascii?Q?7Jw7Dkhy/CrqffDDYZfaj96OrrJTUErMi7+9QFaVIGo/HESFHByLGXiQZcDm?=
 =?us-ascii?Q?toepurxXSC++Vz92y+qW3ZbK9FPHoZPyVowoC0PnuYGwR3+7LT0dvDS+GPY/?=
 =?us-ascii?Q?l5nY9r1+Hrqm6VRnl/MnL+1hfUi/6H/m1ysDT/dytEnxoXQVYV6FBH4uw53u?=
 =?us-ascii?Q?HXEjSDVQ1XU2I2PzY8B0xLBKc6Mp5wV/yJ+Lr4yLAGHDERYLbroxfAmS+z/D?=
 =?us-ascii?Q?++7+JWkPBVs/xGVsdzIPPzftz1FYueTjZkRCC8f21cwKo44tQhxqgFHnBsfi?=
 =?us-ascii?Q?LY2E/mz/A7EAFJ7vDEt3lP3TTlmizOlOjg0icWPBsipyu0ywmsbo4F3l6nJH?=
 =?us-ascii?Q?RZIARqQUlF89DrSwiJnGVDcYasUzlor+EEGdvzlmgI2A4TyM48ftBKF1Oo/4?=
 =?us-ascii?Q?jS5v9Ro3UZllGBEVSZVRsakdsiVG031lMWH5ecpwGXxCq0KLA2rOyoFnmaC+?=
 =?us-ascii?Q?Q5yz+KZIXyABnCkj45z3Id9B4cXXQKTcvWIB+k/28McAX+jAMTes8Era5t9P?=
 =?us-ascii?Q?c2xhRa01ZggE8aiuoF439D6lDLhIe+CptJl/+qCthMRphYkZJiOMZGKA4q0s?=
 =?us-ascii?Q?9rAMVpAHiJZZVR2iMpQr7UJTaKUASj7QAiHJjUQVkh3oJjc4lUg3BIzyaYf3?=
 =?us-ascii?Q?krWSDrlSRAcGB4zlI4WsCRGlJKOXZ5TbIa0lyXO+K9gnGj3f2rGwK/RUFAUt?=
 =?us-ascii?Q?yh4PQTwGATrPJqngy+vIa368hWtVV4aWyIIGsfLVH5MuieyE0vGyij02DBJR?=
 =?us-ascii?Q?tDfazS9I6bfxgx1vr2j32NCWTVyOSHeSjYbipHhNScdghAbnJ1vRWxgjt5xH?=
 =?us-ascii?Q?u5eB1JsnlSK/iMeTr8gZKVqc63Tzd+f9+CZSwZWdxxQzXUSQC0L2i6x4tlpn?=
 =?us-ascii?Q?Cy9DGcJnbcefAmCelWv7yOMEBST9RKDbHrEeBsSi4K8JcwIzPy3gqaX34w+M?=
 =?us-ascii?Q?bZROaDd+dQnozej+ZYHGp/koRcC36tMi1/aY0ppwg90sZQcO/HcC2N3LPKnO?=
 =?us-ascii?Q?Ec9X/NyI3Vl0iOsgQN3HWwNpCX2lL7vI70PuJQY45NZ5CGr7BaNSaUOV0ke3?=
 =?us-ascii?Q?hX0RdXonLbrFD+so3tsKhuC/EBYCcvJof1khcK0qSu3oUJqf1M4V6/Iu898X?=
 =?us-ascii?Q?lu1ZZaUweGlNuuLhFhIKt4vCkZFMg/fGr/prN4B0VghEJEDqtPxMZ+lBT+Qg?=
 =?us-ascii?Q?47N3pNetE5SPFxTf1tVtY3JLLM0+P3i67nCbhCSp0wbiQgrSnDef1Tsj2u6/?=
 =?us-ascii?Q?0jND7Vua9ABhCD9vshWhpwRFXYPmvSsFme3zmzq/t136AdOEWqNEjzxjfzKy?=
 =?us-ascii?Q?IHory13zPrHaDKSo2xMNetJK/PfW7h3RTji+xX099oeg6dnZOUsNp1zrhMq7?=
 =?us-ascii?Q?4xrUHsfeTRX2vgE0a9cOJrxtuxe7eM7k+VEV3GxkigxFkGy79Y0E0a3A/Tko?=
 =?us-ascii?Q?VhbM1Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6SvDyfpMNEsE6NbYHM9P/t0CL8l+yuDndBm3WQhY1F6vWwGZhjjDgmi6yPvnWBK9re1/hSDI7Ov+vJayWoRx4bGlPla1RCgC54NlI2EdYikAgeO1lZlbh5m5WG9ZLUW4pDvirpG83SsaZVdd9qCSRpCvpBWo2yTayE+QuIacf+hcj4rcLDcJSrHTwTch/rVsUkmDl/9svtuRFPGG+gJK3b8xwNKWr0397VOpT4fIykFtF+2EVN9TzeMuHrbLkd3KaS2hM7PVoc3sz0krRZ0k8JWrVzdkU3czdqkHGW8s5KxGnRmXQKbReA1K087FOU4VjGv2FeWOWHv6YxL2nrcUHm1z/5tRXzNGKTxIhQAYJSJmcoiJQopHTgMA+8A/Y1qCNmby5iF3fKBLwYEp3dZZDYNKyYZXutdXLc0HwCVAKDVgFPuzERbEXhThxZufd0/S
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:50:25.5735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e922e4e-7fb8-4cef-b839-08de658f1007
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9505
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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

VINTF page0 is guest accessible and backed by host memory, so it can be
mapped directly instead of being trapped and emulated. Map the VINTF0
page0 MMIO region lazily on first vCMDQ setup.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 21 +++++++++++++++++++++
 hw/arm/tegra241-cmdqv.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 57f47a4997..153fd70edb 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -170,6 +170,26 @@ static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
     }
 }
 
+static void tegra241_cmdqv_map_vintf_page0(Tegra241CMDQV *cmdqv)
+{
+    char *name;
+
+    if (cmdqv->vintf_page0_mapped) {
+        return;
+    }
+
+    name = g_strdup_printf("%s vintf-page0",
+                           memory_region_name(&cmdqv->mmio_cmdqv));
+    memory_region_init_ram_device_ptr(&cmdqv->mmio_vintf_page0,
+                                      memory_region_owner(&cmdqv->mmio_cmdqv),
+                                      name, VINTF_REG_PAGE_SIZE,
+                                      cmdqv->vintf_page0);
+    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv, 0x30000,
+                                        &cmdqv->mmio_vintf_page0, 1);
+    g_free(name);
+    cmdqv->vintf_page0_mapped = true;
+}
+
 static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
                                        Error **errp)
 {
@@ -206,6 +226,7 @@ static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
     hw_queue->viommu = viommu;
     cmdqv->vcmdq[index] = hw_queue;
 
+    tegra241_cmdqv_map_vintf_page0(cmdqv);
     return true;
 }
 
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 2f4a8ab35f..b92c34e1d7 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -31,6 +31,8 @@ typedef struct Tegra241CMDQV {
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
     void *vintf_page0;
+    MemoryRegion mmio_vintf_page0;
+    bool vintf_page0_mapped;
     IOMMUFDHWqueue *vcmdq[128];
 
     /* Register Cache */
-- 
2.43.0



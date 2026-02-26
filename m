Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2334EFC592C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYyx-0004Xa-ON; Thu, 26 Feb 2026 05:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyv-0004TO-Np; Thu, 26 Feb 2026 05:52:33 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYyu-0000lg-BZ; Thu, 26 Feb 2026 05:52:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhqxeZz1PSxg8q78YS5I+oz5km355qIQWoj0/MSrl316GSpvSMZmYfb2pPaM769i9XlMrrO7vfMCKd02u8nEaLJS7lTKKQbeKcMYsoIzom5dtjQajZhdJy9pKPNO7qWF1M0lnZmmnlfE9mismLhpXlb6XuZZL/yNkAIOxQ8f3HdptUrKQS//7bfkX3ir7kJ75gpfB8WVl4GUo89K1XmMKHS1cyXCQNgPdTvlidQ9M9WmOt0eLBeYZ0JobXilyoFC1iYvAGJypndh/HZcMPkkSE1XJrsrYXF53c1DxCSYRE8efzRUY0puoWFTqzRJdVUEEaFwcb5NGfCFYdiDoOFaYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Nhpj8HDxl0SQlqEKRkF71GPgaU8fFmL1l2Bj5a7IwM=;
 b=nb0f6FiGwsghANy3BvgUjbgFa0MREN5tneDA4IZh9KT5o8NSYwbERqX1l4/vcpJtV0jcDTOwUGhbJDWX2CFvnLeGZWVu2zNcMSHO7DHK/b3rOdmBaTa0rF/O90u52IM3au1Vo6T2MBrX3tvUxVoHMud5CKpj1gdLY9mPOlRRKOhDpnyzArcUq6YtN4iyHCylCp3mh3cmSCIkDx3TAnMdPKWCrXT4Z6hX9rxTCQJ451oMQPv8cBvMBVzSPAUtPkm5H4mzEbJN9Dn0hMBSKW8bvakzKbiEOm9kxWkzGumQcyKQnXCFVw0JsyOxcb2k3j/WUD5aP5fhl1Nud3YmwjHJBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Nhpj8HDxl0SQlqEKRkF71GPgaU8fFmL1l2Bj5a7IwM=;
 b=CMrtZd3ZSlgLjvHekhdOrhOszIkRcXHj4mYYCV/rXdR9CbtwU7Lowe0hex5a1XUn0LzL6wFzT8Dw1YC24WFL6c27omtzWHK6E62xyKnhHF+xYUXIXfasmYqDsAG/WuGRSenBIFuag8/D2OwgoC8zrYQzwTkZZ0JCanOW314UBwIYpE3gOtODd6uCzkH47LEL+RgjxXX5NqW68a7CfYSTvySdJxdAlF7TDBersngzrNbBlYiSAfI4U3cUy9w7P8JIdFplKCE59WfX1cPmPJpw6tg9vPkkK3FhtkZKdRkVrWpAeCspBZvnHqf19FlLUx43MHLRtsFWvoWSita959JTSg==
Received: from SA1P222CA0103.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::7)
 by SJ2PR12MB9139.namprd12.prod.outlook.com (2603:10b6:a03:564::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 10:52:24 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::5d) by SA1P222CA0103.outlook.office365.com
 (2603:10b6:806:3c5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 10:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:52:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:03 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:00 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 10/32] hw/arm/tegra241-cmdqv: Probe host Tegra241 CMDQV
 support
Date: Thu, 26 Feb 2026 10:50:34 +0000
Message-ID: <20260226105056.897-11-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226105056.897-1-skolothumtho@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|SJ2PR12MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa59e04-2e9c-48ba-af2b-08de75251f55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: jMkwLw/2egt03tLKmnMytsVjfnssOsO2HalCAzi2ItspQKZCEVjvYCZt8yrA+XmWISVg9tokj9xTX8WpcYPl5Sy4Ytoi/fhLAcR9J8SK39jLmbts9arOf+jl6BMlFz5zKgbQzwVENxF7Wa+V5wkbb86sTQDbofnm1gceYSSAupftVUygs1DTcYFesyzjRzMofH5lXY4kxauHz6YC8f1pyx2jjv6QQSu9Y4i732ceb0KKwLiwyJINTgF+6y6UQfeLe5/6KAsSOO5YnN/nlBCt6MG1tqXoCrbO2A2KY8n8qCIgLPcvQpuZhl3M6u/4Tmct/5Mqks6pMmO2+40SMhu/qShrzT9waQI7pvmJ4gIP90AbWE0Eh5a7azml3Zsjc+vdjwDvj6DUXs5ssED5ZBjOZqb2N7suZUESHRpXdXVHcyY9pvCR8fxMTXLJiuYBnj9+BI3Ax0BUAgFlANfoh7MoE8ft3KBVk0w2U5F3JMJ7SaOhG2RrazcjGduP4ZEEgJPGWH2IKRE52RSYF379WlG4JCseFu3zzoBPNUfwau2pXmQSilNaN0E1BVltI7Xw7cSpKl3e/Nnyr2nmCjOra6AA5UevLheG1JfA/Ev80FzfyZp6y5WTWtGKKtDveTe5TS8cbSeQq4i3sa/osKCQfY5y9MdZUdwc8IefzmKLfq0kqemTYD8CDYYrE5ZwPsht55lZNTcQkQqRJzHAG+Nr5ke3P5nYJY3LSQWZnrGQOhSRuGIalQA/CJ9bGALYYS5qE/5ow5aBeeaXbKhGRlLzlNqmsxOw5pIOeV134CadBsvBzqDDsTdNBhr+6ffF9bOylsVWwysAh0+0754Yg3PciVCRPg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DQcgROlUIz+zU85Ujl00olsaR34WQyILtFru6sOgrPd53iSect6mGBbyLk254ran6wdEnpgWUJJLkwXH4BpQAI2yI0eKdpPGhfkvcYrU2TTMhAX2xhvxpQvn4aWrZyVqZwLcPLjnhvBpcmL9W6gYHvi/AwB4s4k+pA+yR0AixJeT7vK3OKUm/IEmEre78tez9E6hmeEI3OxENskmKFrE1qv1HyddrVlfGLCWjket1qFxLIL/OVrhQ6+xgzdTCjSTSOqogXnOSA34t3d+JGmmZ1Xa55dc9OqvhKyQPpF85RZUa1DOHDt/zp4z1gW9s67mBaAP7OUVoh0/GaR55EygqqxBBQAW/0J+Fvpx1CmXiB48ZkneLzCfdoDLDB5WWVa7yp2iBrhuW0BOsdyondzreQw49kcNwU/WSTzBQ1a3aA2rKt3DykzzEMkv1e/rmZjT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:52:23.0313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa59e04-2e9c-48ba-af2b-08de75251f55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9139
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use IOMMU_GET_HW_INFO to check whether the host supports Tegra241 CMDQV.

Validate the returned data type, version, number of vCMDQs and SIDs per
VM. Fail the probe if the host does not meet the expected requirements.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  5 +++++
 hw/arm/tegra241-cmdqv.c | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 07e10e86ee..312064a081 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -10,6 +10,11 @@
 #ifndef HW_ARM_TEGRA241_CMDQV_H
 #define HW_ARM_TEGRA241_CMDQV_H
 
+#define TEGRA241_CMDQV_VERSION             1
+#define TEGRA241_CMDQV_NUM_CMDQ_LOG2       1
+#define TEGRA241_CMDQV_MAX_CMDQ            (1U << TEGRA241_CMDQV_NUM_CMDQ_LOG2)
+#define TEGRA241_CMDQV_NUM_SID_PER_VM_LOG2 4
+
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
 
 #endif /* HW_ARM_TEGRA241_CMDQV_H */
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index ad5a0d4611..a270fa7ce4 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -38,8 +38,36 @@ static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
 static bool tegra241_cmdqv_probe(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                                  Error **errp)
 {
-    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
-    return false;
+    uint32_t data_type = IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV;
+    struct iommu_hw_info_tegra241_cmdqv cmdqv_info;
+    uint64_t caps;
+
+    if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
+                                         &cmdqv_info, sizeof(cmdqv_info), &caps,
+                                         NULL, errp)) {
+        return false;
+    }
+    if (data_type != IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV) {
+        error_setg(errp, "Host CMDQV: unexpected data type %u (expected %u)",
+                   data_type, IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV);
+        return false;
+    }
+    if (cmdqv_info.version != TEGRA241_CMDQV_VERSION) {
+        error_setg(errp, "Host CMDQV: unsupported version %u (expected %u)",
+                   cmdqv_info.version, TEGRA241_CMDQV_VERSION);
+        return false;
+    }
+    if (cmdqv_info.log2vcmdqs < TEGRA241_CMDQV_NUM_CMDQ_LOG2) {
+        error_setg(errp, "Host CMDQV: insufficient vCMDQs log2=%u (need >= %u)",
+                   cmdqv_info.log2vcmdqs, TEGRA241_CMDQV_NUM_CMDQ_LOG2);
+        return false;
+    }
+    if (cmdqv_info.log2vsids < TEGRA241_CMDQV_NUM_SID_PER_VM_LOG2) {
+        error_setg(errp, "Host CMDQV: insufficient SIDs log2=%u (need >= %u)",
+                   cmdqv_info.log2vsids, TEGRA241_CMDQV_NUM_SID_PER_VM_LOG2);
+        return false;
+    }
+    return true;
 }
 
 static const SMMUv3AccelCmdqvOps tegra241_cmdqv_ops = {
-- 
2.43.0



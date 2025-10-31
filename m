Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C06DCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmki-0002y1-8W; Fri, 31 Oct 2025 06:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmkd-0002wq-26; Fri, 31 Oct 2025 06:52:59 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmkU-0002uA-Cz; Fri, 31 Oct 2025 06:52:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uepwMEqLxyLiceQ8mn04AOogCaGyWdg8R7VnCo8vqjJQcWggvllq8s/ZQtyhNY3HhYCaG3lQWYZWbOpGY1Lm3O7K0oZF0PdwRB5EtKuL5OL/cuEM6mFsewGhVX61o+mEKgnHmDyo22HKpzKwwrRQhhf34RzL87sHLeGuCNohJJf1k+9vx/5JqUsHLqFHB6HcF0FUm4VHxX/i5JDsy88N9C3hc/1jqjzpnjig2PRMoQZB5a6sTjm9jd4bEurXZy9Ka2jSm2HEcZlTk5PilGqxO4Cih+yjK/2L7ByFXgX89NJiOujkrgfEquljBO/rA76kiIjWvFAvmMgjtDF7bWio8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NT2g5vF/5YuZRHXOXTenTet+4i7aaZUUGfb5MRXLka8=;
 b=TkVraJq0A/2JZyNf7TXhkv/E2A4FgCQu69kqxVRcmy4Ghs/WF2UO3AsW8mkLXJ9cOpG673vMnVjp5dCE/sQoSbk7lOeJdVYGRGXrP7neN/WNwqiGg3SL6c9g9fwu/yjpNchx/VhZ/Qa7YvW9fgCnL3NUUaaQ7p/UgXJC+kX1qIKEvLBUhGfItWnUy0VWy0Q1QvNiXYQoqyaz4FWEw+B07FR7KR4B3ecZHJdw0Uh63HZDv5O8Y0dkdtcCec2NuNXpHapOQaQiMkwwXRF08sTwZ6Hou8evK6IRi2R/Pw8ozYilaEN+NPV8//UMR4LjZZO8DkJVMpLV064Suzi1OwDrdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NT2g5vF/5YuZRHXOXTenTet+4i7aaZUUGfb5MRXLka8=;
 b=fjOZIUcJkQbuEeFDNFylHyawBSqot+T2ObCT1488OD4KfP6/Sh/rzBehKaeXbzAaIxVwoDdZ44fWTRBKXKudmSqrBERdvnLytZiBap+W++5KXZnCtr9+QaFOPYjUrDFDJ5paRFNtnSXSAFBM0N7bGv/EFHFgq36NuKTbS6MN0HKXCvnKIqaEFpjVjlWgzesivIlevpTcDFj2X08Ekbs4rK5UU6JgjrmZ1q1F/a4F/ezQGEv3tA30OaCSrExbq/GFVyCgjY4iLHRzroCxC3D3OEQEjIs1pEmdJUbZ+VNaOHz4Suv+Ke0m3CREEEJqY7R1C97k7RGn24/MaocyvGGerg==
Received: from CYZPR12CA0023.namprd12.prod.outlook.com (2603:10b6:930:8b::19)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 10:52:42 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:8b:cafe::30) by CYZPR12CA0023.outlook.office365.com
 (2603:10b6:930:8b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:52:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:52:34 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:52:30 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 04/32] hw/arm/smmu-common: Make iommu ops part of SMMUState
Date: Fri, 31 Oct 2025 10:49:37 +0000
Message-ID: <20251031105005.24618-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: e8348f6a-9e1c-43b5-3986-08de186b9d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3UrVFJVMEVzM0wyQ2RNNG1FRzBzRXQzS2VYRlozcTFNbVVCR2lTT3NFYVkx?=
 =?utf-8?B?aVhzQmsvWTZPS216WjB4M3l5UXRnZGJDakRRcDNta0d0OG5Uck9RZ2ZuWjFv?=
 =?utf-8?B?RktnMXR6RHgvaGljUEdWdk9TcWtsejZMWEg2VUdIZENXNnFqZXlJUUxNbkcv?=
 =?utf-8?B?Ny9JVStLTjF5cXhmNGhBMHJ5WkpsSytydFhrVm56K0dZSWorbkgyZ0paOUhJ?=
 =?utf-8?B?OG9VNzBvdHFHZlF1RStpN3VleFZGZVc5Q1JRQ2drTEJYcDZ6RWFxMVpmT24r?=
 =?utf-8?B?RWZ2VW1WODBDZzBPZE1TL3JhZHdpeTNTbGxiK2tMYXZhS0dyZG1WNDdvWjVx?=
 =?utf-8?B?cXpZSGlvd0Q4LzVGcEU2cXBmbEpvYkRPY2F4MjgydlpIWk9QbG8rMVFTUTFE?=
 =?utf-8?B?Vk9UTjFiNlE5Sm5zdnU5WTF2MlBmVHRxVmttNFBqN241dkp6VG5EbjRiRzZt?=
 =?utf-8?B?M2lCa210N2pId1RBYnh3TWk3azRiRkd3WjJZdnVsWXQ0aXVXSFZYQlNrYzBM?=
 =?utf-8?B?bXZYQ2kyV3k2YnF5cUJsb0tJMDZtSmNQbEdHNXJHUkJHQW5TTEgvd213QWIr?=
 =?utf-8?B?WWhjbVdyTmI3ZVRaMDNucGlTdDNHakZNTGFLYmoyMnY3a3NGNVhTeEZvRDV2?=
 =?utf-8?B?cVZKQm90SGFUdUJBaVFReVJZems0WW9HVllwWEVYQmcyUjZZUWhhcDF4L3o2?=
 =?utf-8?B?aHU3OWlwVElkWEw1SUV4VUpEMWVSajEvamw1YTd0V1JFNnR0VUVnK29FcC9k?=
 =?utf-8?B?VGVDVHYwTFpVTDRQamNwMlVWMXQ5RkdvZ2RXQVNKUFl6MS95Wld3K1B3M2VG?=
 =?utf-8?B?ajcrUitnZWJKazdmeVd4K0ZQZ3FObWREUng5N1BaMWVKSUZ6K0R6WGhRa3R1?=
 =?utf-8?B?UG5RaVpydW9Ra2RINVhYeDVncjBraG90SUgyTHZJOElJSHQxRElITTY1SXZk?=
 =?utf-8?B?MzBNNVdMaVg5RDV1MzlEN2pKMmpRWHpSeStYVnZTbzBobXBNRHM5bThlRlIy?=
 =?utf-8?B?ZEtCZFlsY3JNbFJMbWJNTWJ1Qkx0SVFpUVNhT2VQaVZ3M3RPeHZ4aFY1RFZl?=
 =?utf-8?B?eEZpMXNuV0YvbEZ1bGltQ1dudk05SlRyTUlLQzJQMDNqd0J5aE1lVlhkbkxU?=
 =?utf-8?B?MW1tWWJWeGRseFZFUUY5LzNOcFFtNHhJdDJldmRiN08vT0RGWGo3d0pjVXVh?=
 =?utf-8?B?M0VDanMvM1JnclpxN0tXZTNLZGV0SVZpNmd1OUdlaE4rRlE5ZmRRdklSQ2ZU?=
 =?utf-8?B?WGVMc1RmUHlrUEtveGRybHlPYkVlTWJKeDRWOUp1TW5VSDlaeVE2UzJBQUJh?=
 =?utf-8?B?MUZ5RHFtVFZieHRhaVBWY01GN0pNcXdEVWNCaTIybzZRSzVSUW56dllBWnV5?=
 =?utf-8?B?cmwyVTJpWGtFUTRQSm85M1FzOGFwYysvMiszZjNhOFZyaEM4U2liQjhHLzRU?=
 =?utf-8?B?WGg2ZXAzOEpOZDJINEdBV0tZd3loSGhabUxySzgvMktWY25hQU9sb2YxdTNl?=
 =?utf-8?B?ZTFDVE03dzB0em40NFhTekNRVTJXMFl4bVNmN2xTRGFzWkU0VGswc0txc1hP?=
 =?utf-8?B?TVA5NlQ1WDFWRFRhdncxSCtxZElLamZmM3hITThOdGRMbzlQZUc2eER5WlAx?=
 =?utf-8?B?eXBYRnFCVTh1N2YwNWJ5ZEVxSldIZUxJeDJtb2tEdWlxZnlrVE9GSFJ5MGFE?=
 =?utf-8?B?SHRLYVA1YS9tTW9tUDQ2aEc0Z21EZnovL2w3SktWT1BIQStkdjlEZWR2M0h6?=
 =?utf-8?B?RHFKOUE5cVlhbGUzMml0d1hxUjBHSlJKbFF0YWJXb01wQ0RSYk8wUkpMR09n?=
 =?utf-8?B?Q2JBMlRzVUM4cWpObU50emVXRmg4czFKYzF6RlJPa09DdCtWaFBFQ09UcTJn?=
 =?utf-8?B?NWpncC9iaVdJS040UEFhUHROWmdxR1ZwdTJzWVZzbUY4NWhwRnRDQ1czczZS?=
 =?utf-8?B?SStpdVprc0NPWi9waGlJbWJnVlJFQ2VIUWdXQ3FrYUxPa2syZjkxNDdOWndI?=
 =?utf-8?B?d3YyNzQrbFFDM2d0MFpkMVgwNVZNNitjMjBRU0Zidnp1dEpmMzJPTmUwZU5F?=
 =?utf-8?B?QWNPTzVuSWtiWmFuOGtESXh3YU5Yc0RrcWJJTkhpSytkS05YWENWVmMvZWph?=
 =?utf-8?Q?OSuM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:52:41.3990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8348f6a-9e1c-43b5-3986-08de186b9d77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

Make iommu ops part of SMMUState and set to the current default smmu_ops.
No functional change intended. This will allow SMMUv3 accel implementation
to set a different iommu ops later.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmu-common.c         | 7 +++++--
 include/hw/arm/smmu-common.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 59d6147ec9..4d6516443e 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -952,6 +952,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!s->iommu_ops) {
+        s->iommu_ops = &smmu_ops;
+    }
     /*
      * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
      * root complexes to be associated with SMMU.
@@ -971,9 +974,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         }
 
         if (s->smmu_per_bus) {
-            pci_setup_iommu_per_bus(pci_bus, &smmu_ops, s);
+            pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s);
         } else {
-            pci_setup_iommu(pci_bus, &smmu_ops, s);
+            pci_setup_iommu(pci_bus, s->iommu_ops, s);
         }
         return;
     }
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index d307ddd952..eebf2f49e2 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -162,6 +162,7 @@ struct SMMUState {
     uint8_t bus_num;
     PCIBus *primary_bus;
     bool smmu_per_bus; /* SMMU is specific to the primary_bus */
+    const PCIIOMMUOps *iommu_ops;
 };
 
 struct SMMUBaseClass {
-- 
2.43.0


